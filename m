Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA75C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8344920657
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbfDBPKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:10:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:40888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729532AbfDBPKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:10:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3927AEFE;
        Tue,  2 Apr 2019 15:10:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7CA6A1E3FD4; Tue,  2 Apr 2019 17:10:29 +0200 (CEST)
Date:   Tue, 2 Apr 2019 17:10:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jari Ruusu <jari.ruusu@gmail.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ext3 file system livelock and file system corruption, 4.9.166
 stable kernel
Message-ID: <20190402151029.GA25668@quack2.suse.cz>
References: <CACMCwJ+qLHV+cjQC2kAnLQP6qVz1bJ75V8BqQBV5HE1edRC-AQ@mail.gmail.com>
 <20190402103507.GA15511@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402103507.GA15511@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-04-19 12:35:07, Greg Kroah-Hartman wrote:
> On Tue, Apr 02, 2019 at 01:08:45PM +0300, Jari Ruusu wrote:
> > To trigger this ext4 file system bug, you need a sparse file with
> > correct sparse pattern on old-school ext3 file system. I tried
> > more simpler ways to trigger this but those attempts did not
> > trigger the bug. I have provided compressed sparse file that
> > reliably triggers the bug. Size of compressed sparse file 1667256
> > bytes. Size of uncompressed sparse file 7369850880 bytes.
> > Following commands will demo the problem.
> > 
> >   wget http://www.elisanet.fi/jariruusu/123/sparse-demo.data.xz
> >   xz -d sparse-demo.data.xz
> >   mkfs -t ext3 -b 4096 -e remount-ro -O "^dir_index" /dev/sdc1
> >   mount -t ext3 /dev/sdc1 /mnt
> >   cp -v --sparse=always sparse-demo.data /mnt/aa
> >   cp -v --sparse=always sparse-demo.data /mnt/bb
> >   umount /mnt
> >   mount -t ext3 /dev/sdc1 /mnt
> >   cp -v --sparse=always /mnt/bb /mnt/aa
> > 
> > That last cp command reliably triggers the bug that livelocks and
> > after reset you have file system corruption to deal with. Deeply
> > unfunny.
> > 
> > The bug is caused by
> > "ext4: brelse all indirect buffer in ext4_ind_remove_space()"
> > upstream commit 674a2b27234d1b7afcb0a9162e81b2e53aeef217, from
> > <yi.zhang@huawei.com>, who provided a follow-up patch
> > "ext4: cleanup bh release code in ext4_ind_remove_space()"
> > upstream commit 5e86bdda41534e17621d5a071b294943cae4376e. The
> > problem with that follow-up patch is that it is almost criminally
> > mislabeled. It should have said "fixes ext3 livelock and file
> > system corrupting bug" or something like that, so that Greg KH &
> > Co would have understood that it must be backported to stable
> > kernels too. Now the bug appears to be in all/most stable kernels
> > already.
> > 
> > Below is the buggy patch that causes the problem. Look at those
> > new while loops. Once the while condition is true once, it is
> > ALWAYS true, so it livelocks.
> > 
> > > --- a/fs/ext4/indirect.c
> > > +++ b/fs/ext4/indirect.c
> > > @@ -1385,10 +1385,14 @@ end_range:
> > >  					   partial->p + 1,
> > >  					   partial2->p,
> > >  					   (chain+n-1) - partial);
> > > -			BUFFER_TRACE(partial->bh, "call brelse");
> > > -			brelse(partial->bh);
> > > -			BUFFER_TRACE(partial2->bh, "call brelse");
> > > -			brelse(partial2->bh);
> > > +			while (partial > chain) {
> > > +				BUFFER_TRACE(partial->bh, "call brelse");
> > > +				brelse(partial->bh);
> > > +			}
> > > +			while (partial2 > chain2) {
> > > +				BUFFER_TRACE(partial2->bh, "call brelse");
> > > +				brelse(partial2->bh);
> > > +			}
> > >  			return 0;
> > >  		}
> > >
> > 
> > Greg & Co,
> > Please revert that above patch from stable kernels or backport the
> > follow-up patch that fixes the problem.
> 
> So you need 5e86bdda4153 ("ext4: cleanup bh release code in
> ext4_ind_remove_space()") applied to all of the stable and LTS kernels
> at the moment (as that patch only showed up in 5.1-rc1)?
> 
> If so, I need an ack from the ext4 developers/maintainer to do so.

Ack from me, and sorry for missing this brown paper bag bug during
review...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
