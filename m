Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4E0C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2AD217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555596067;
	bh=4MSMXVlMy3d/KTM9zAJR1ZTNqhibyGK4+ViNeR6HU7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p+hZtVJNQRgqKQur1TNkUfKtwaDyfHWacC+3r37GlozU0LCs1CVQ1SbL+S9sracPf
	 oSCRnwn/tv8/xTwc5QkWw9/ZRiude1S5KLQuK4L1eTPqqdx8cuw209YxYcMdwXVjK9
	 XtLBXuiKvuItDxFGjRQqILaratKawUkMNCtk53w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389230AbfDROBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbfDROBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:01:05 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B4972083D;
        Thu, 18 Apr 2019 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555596065;
        bh=4MSMXVlMy3d/KTM9zAJR1ZTNqhibyGK4+ViNeR6HU7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLP7SbW1CpL3DQVRkjgyfmiQeIrhyc+yvyPE3I8OT5liP7qrMAPkr+1rjfaRztVlR
         bve3cwq/gjBu9F8osJXg+zYtJKR1GIKGrHLYbPV0+yQsLOVLwHnq7m9x4/5GDJYSf2
         OhD16MAOVzo3SArjbBVrIeHeXTZjCTbBAjPR7zeE=
Date:   Thu, 18 Apr 2019 07:01:04 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build warning after merge of the block tree
Message-ID: <20190418140104.GA52314@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190417123125.3de22f73@canb.auug.org.au>
 <0879e11b-c84c-65b8-581f-bf7adcb5e231@huawei.com>
 <20190417140305.GB23731@jaegeuk-macbookpro.roam.corp.google.com>
 <b1fcb057-6d89-9846-766b-dd1b710f7654@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1fcb057-6d89-9846-766b-dd1b710f7654@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18, Chao Yu wrote:
> On 2019/4/17 22:03, Jaegeuk Kim wrote:
> > On 04/17, Chao Yu wrote:
> >> Hi Jaegeuk,
> >>
> >> On 2019/4/17 10:31, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> After merging the block tree, today's linux-next build (x86_64
> >>> allmodconfig) produced this warning:
> >>>
> >>> fs/f2fs/node.c: In function 'f2fs_remove_inode_page':
> >>> fs/f2fs/node.c:1193:47: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'blkcnt_t' {aka 'long long unsigned int'} [-Wformat=]
> >>>     "Inconsistent i_blocks, ino:%lu, iblocks:%zu",
> >>>                                              ~~^
> >>>                                              %llu
> >>>     inode->i_ino, inode->i_blocks);
> >>>                   ~~~~~~~~~~~~~~~       
> >>
> >> Could you please help to fix that as below in your dev branch directly?
> >>
> >> "Inconsistent i_blocks, ino:%lu, iblocks:%llu",
> > 
> > We can just use "%lu"?
> 
> We'd better follow sample in Documentation/core-api/printk-formats.rst:
> 
> If <type> is dependent on a config option for its size (e.g., sector_t,
> blkcnt_t) or is architecture-dependent for its size (e.g., tcflag_t), use a
> format specifier of its largest possible type and explicitly cast to it.

Great, done. :)

Thanks,

> 
> Example::
> 
>         printk("test: sector number/total blocks: %llu/%llu\n",
>                 (unsigned long long)sector, (unsigned long long)blockcount);
> 
> Thanks,
> 
> > 
> >> inode->i_ino, (unsigned long long)inode->i_blocks)
> >>
> >>
> >> It looks that we need to fix below commits as well:
> >>
> >> f2fs: fix to avoid panic in dec_valid_block_count()
> >> f2fs: fix to avoid panic in dec_valid_node_count()
> >>
> >> Thanks,
> >>
> >>>
> >>> Introduced by commit
> >>>
> >>>   90ae238d9dac ("f2fs: fix to avoid panic in f2fs_remove_inode_page()")
> >>>
> >>> from the f2fs tree interacting with commit
> >>>
> >>>   72deb455b5ec ("block: remove CONFIG_LBDAF")
> >>>
> > .
> > 
