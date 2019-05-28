Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD38EC04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3BB2081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M4H52I7z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OwgSTmba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfE1DFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 23:05:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfE1DFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 23:05:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4DB8660303; Tue, 28 May 2019 03:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559012715;
        bh=pCWoAy0zRZdueQVmj/01RMPmGNpZBLScCaYw6mirwDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4H52I7zD5ZWUcrkJtfNTu0lN1O+3b5vuUmMbWxq6MLspjbI0RG+1I+PTaBucYBGp
         fz5jzzP78+2xFfjEKoyIbm3Tsr9xyBrwCasISrGesaPwZRbo5A2TrcWqAqX/A4JnzG
         R0KeeCsx0nJ6X9nnFAOQCGzvHO1hR0mZmATOrhR4=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 078F660303;
        Tue, 28 May 2019 03:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559012714;
        bh=pCWoAy0zRZdueQVmj/01RMPmGNpZBLScCaYw6mirwDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwgSTmba7aMPQ3+ETwAqSFHkhClCKaV0TeVd5Vpw3y3rYkgAIccDDC3MdjUqdtkTN
         0IaLuyCEC6xZ8EzT9OTtf5rgkGj3/O/u/rKK6muMpjgcmDjyf5CtnLuLjAG/6MMoc+
         uOcqYwg/RvSzWL5wyS2NdimHSJeHAn3I0bm+yvKQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 078F660303
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Tue, 28 May 2019 08:35:09 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: ratelimit recovery messages
Message-ID: <20190528030509.GE10043@codeaurora.org>
References: <1558962655-25994-1-git-send-email-stummala@codeaurora.org>
 <94025a6d-f485-3811-5521-ed5c9b4d1d77@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94025a6d-f485-3811-5521-ed5c9b4d1d77@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Tue, May 28, 2019 at 09:23:15AM +0800, Chao Yu wrote:
> Hi Sahitya,
> 
> On 2019/5/27 21:10, Sahitya Tummala wrote:
> > Ratelimit the recovery logs, which are expected in case
> > of sudden power down and which could result into too
> > many prints.
> 
> FYI
> 
> https://lore.kernel.org/patchwork/patch/973837/
> 
> IMO, we need those logs to provide evidence during trouble-shooting of file data
> corruption or file missing problem...
> 
In one of the logs, I have noticed there were ~400 recovery prints in the
kernel bootup. I noticed your patch above and with that now we can always get
the error returned by f2fs_recover_fsync_data(), which should be good enough
for knowing the status of recovered files I thought. Do you think we need
individually each file status as well?

Thanks,

> So I suggest we can keep log as it is in recover_dentry/recover_inode, and for
> the log in do_recover_data, we can record recovery info [isize_kept,
> recovered_count, err ...] into struct fsync_inode_entry, and print them in
> batch, how do you think?
> 
> Thanks,
> 
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> > v2:
> >  - fix minor formatting and add new line for printk
> > 
> >  fs/f2fs/recovery.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index e04f82b..60d7652 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -188,8 +188,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
> >  		name = "<encrypted>";
> >  	else
> >  		name = raw_inode->i_name;
> > -	f2fs_msg(inode->i_sb, KERN_NOTICE,
> > -			"%s: ino = %x, name = %s, dir = %lx, err = %d",
> > +	printk_ratelimited(KERN_NOTICE
> > +			"%s: ino = %x, name = %s, dir = %lx, err = %d\n",
> >  			__func__, ino_of_node(ipage), name,
> >  			IS_ERR(dir) ? 0 : dir->i_ino, err);
> >  	return err;
> > @@ -292,8 +292,8 @@ static int recover_inode(struct inode *inode, struct page *page)
> >  	else
> >  		name = F2FS_INODE(page)->i_name;
> >  
> > -	f2fs_msg(inode->i_sb, KERN_NOTICE,
> > -		"recover_inode: ino = %x, name = %s, inline = %x",
> > +	printk_ratelimited(KERN_NOTICE
> > +			"recover_inode: ino = %x, name = %s, inline = %x\n",
> >  			ino_of_node(page), name, raw->i_inline);
> >  	return 0;
> >  }
> > @@ -642,11 +642,11 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
> >  err:
> >  	f2fs_put_dnode(&dn);
> >  out:
> > -	f2fs_msg(sbi->sb, KERN_NOTICE,
> > -		"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d",
> > -		inode->i_ino,
> > -		file_keep_isize(inode) ? "keep" : "recover",
> > -		recovered, err);
> > +	printk_ratelimited(KERN_NOTICE
> > +			"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d\n",
> > +			inode->i_ino,
> > +			file_keep_isize(inode) ? "keep" : "recover",
> > +			recovered, err);
> >  	return err;
> >  }
> >  
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
