Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CABC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FB620883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201313;
	bh=VkbNACm/8od0be0SyULl7JcTxUCS+//sRbl2F+o4Iog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TPsdNmr/wCffROCJKzuEqUlc7AtnQwwOs86igQfu9rHYXKH3nocpdd85ZjvZkzSrI
	 fnOl0kNvgKJdmqEJ8A8In4YCOL6gWW/uVOJIH2ijRE8J0REQqO6w6gVLAR1pZzwDFI
	 Z/e/gS6ejOK0U5y4xGW004SgkWHTajKJCWU8cdsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfDBKfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfDBKfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:35:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB272084C;
        Tue,  2 Apr 2019 10:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201309;
        bh=VkbNACm/8od0be0SyULl7JcTxUCS+//sRbl2F+o4Iog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ycdDV7k8M8Y14E0mQ3iNCIPeUgG/S+/kLIJZ0N/a8lvLVi3632jrAzzeTHZD1C4K0
         O2ugQj3umNpssjD9/xyRYNSqPg3LGzdOTBvxzCvp6ZSkASRB7akXcmyby+A9MZLsKQ
         OrLh1w4pW/Rkt5E3RbKjsNqFP0NzA5u+GnNDtBG4=
Date:   Tue, 2 Apr 2019 12:35:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jari Ruusu <jari.ruusu@gmail.com>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ext3 file system livelock and file system corruption, 4.9.166
 stable kernel
Message-ID: <20190402103507.GA15511@kroah.com>
References: <CACMCwJ+qLHV+cjQC2kAnLQP6qVz1bJ75V8BqQBV5HE1edRC-AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMCwJ+qLHV+cjQC2kAnLQP6qVz1bJ75V8BqQBV5HE1edRC-AQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 01:08:45PM +0300, Jari Ruusu wrote:
> To trigger this ext4 file system bug, you need a sparse file with
> correct sparse pattern on old-school ext3 file system. I tried
> more simpler ways to trigger this but those attempts did not
> trigger the bug. I have provided compressed sparse file that
> reliably triggers the bug. Size of compressed sparse file 1667256
> bytes. Size of uncompressed sparse file 7369850880 bytes.
> Following commands will demo the problem.
> 
>   wget http://www.elisanet.fi/jariruusu/123/sparse-demo.data.xz
>   xz -d sparse-demo.data.xz
>   mkfs -t ext3 -b 4096 -e remount-ro -O "^dir_index" /dev/sdc1
>   mount -t ext3 /dev/sdc1 /mnt
>   cp -v --sparse=always sparse-demo.data /mnt/aa
>   cp -v --sparse=always sparse-demo.data /mnt/bb
>   umount /mnt
>   mount -t ext3 /dev/sdc1 /mnt
>   cp -v --sparse=always /mnt/bb /mnt/aa
> 
> That last cp command reliably triggers the bug that livelocks and
> after reset you have file system corruption to deal with. Deeply
> unfunny.
> 
> The bug is caused by
> "ext4: brelse all indirect buffer in ext4_ind_remove_space()"
> upstream commit 674a2b27234d1b7afcb0a9162e81b2e53aeef217, from
> <yi.zhang@huawei.com>, who provided a follow-up patch
> "ext4: cleanup bh release code in ext4_ind_remove_space()"
> upstream commit 5e86bdda41534e17621d5a071b294943cae4376e. The
> problem with that follow-up patch is that it is almost criminally
> mislabeled. It should have said "fixes ext3 livelock and file
> system corrupting bug" or something like that, so that Greg KH &
> Co would have understood that it must be backported to stable
> kernels too. Now the bug appears to be in all/most stable kernels
> already.
> 
> Below is the buggy patch that causes the problem. Look at those
> new while loops. Once the while condition is true once, it is
> ALWAYS true, so it livelocks.
> 
> > --- a/fs/ext4/indirect.c
> > +++ b/fs/ext4/indirect.c
> > @@ -1385,10 +1385,14 @@ end_range:
> >  					   partial->p + 1,
> >  					   partial2->p,
> >  					   (chain+n-1) - partial);
> > -			BUFFER_TRACE(partial->bh, "call brelse");
> > -			brelse(partial->bh);
> > -			BUFFER_TRACE(partial2->bh, "call brelse");
> > -			brelse(partial2->bh);
> > +			while (partial > chain) {
> > +				BUFFER_TRACE(partial->bh, "call brelse");
> > +				brelse(partial->bh);
> > +			}
> > +			while (partial2 > chain2) {
> > +				BUFFER_TRACE(partial2->bh, "call brelse");
> > +				brelse(partial2->bh);
> > +			}
> >  			return 0;
> >  		}
> >
> 
> Greg & Co,
> Please revert that above patch from stable kernels or backport the
> follow-up patch that fixes the problem.

So you need 5e86bdda4153 ("ext4: cleanup bh release code in
ext4_ind_remove_space()") applied to all of the stable and LTS kernels
at the moment (as that patch only showed up in 5.1-rc1)?

If so, I need an ack from the ext4 developers/maintainer to do so.

thanks,

greg k-h
