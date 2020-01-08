Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB4C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE2920705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578485086;
	bh=8Ibxjwt6kC+hGFr1IDrRoG3a1vKrpplBnsa/l24ADGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pEIr6dGicj02tHVos0NburcGFaWOMrtweW2WSiIolexiyTe/MRKkAIdhjBWErxXPy
	 nI5UBs4KqdDeCwQ9yPwcIlMtruzKTxQpR7cH0CMbMLcIHGo82eksZGwGqgNqgwEhjd
	 cSOCHCHFe/yhYCrLSH94Y/wf3wDlvd2iqDnWQZ4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgAHMEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:04:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgAHMEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:04:45 -0500
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0270C206DA;
        Wed,  8 Jan 2020 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578485085;
        bh=8Ibxjwt6kC+hGFr1IDrRoG3a1vKrpplBnsa/l24ADGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqe7RbJUrhsfFDWUr1VAjV9s+B+nCgyhyRUUxC3WVvcThiR+pl5QeR+MkEMuYDolu
         NdYxE5lfSt6NpK3W8TY3uKgGk2GxMNbf9s7SBlfxye4Qhy9ijEnjMaXdkFxMI6EOdK
         gK9SGEFaHxbXxvyd0XTkOZyI8j3pFaBXLm6oCSc0=
Date:   Wed, 8 Jan 2020 04:04:44 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: add a way to turn off ipu bio cache
Message-ID: <20200108120444.GC28331@jaegeuk-macbookpro.roam.corp.google.com>
References: <20200107020709.73568-1-jaegeuk@kernel.org>
 <afddac87-b7c5-f68c-4e55-3705be311cf6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afddac87-b7c5-f68c-4e55-3705be311cf6@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08, Chao Yu wrote:
> On 2020/1/7 10:07, Jaegeuk Kim wrote:
> > Setting 0x40 in /sys/fs/f2fs/dev/ipu_policy gives a way to turn off
> > bio cache, which is useufl to check whether block layer using hardware
> > encryption engine merges IOs correctly.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  Documentation/filesystems/f2fs.txt | 1 +
> >  fs/f2fs/segment.c                  | 2 +-
> >  fs/f2fs/segment.h                  | 1 +
> >  3 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> > index 41b5aa94b30f..cd93bcc34726 100644
> > --- a/Documentation/filesystems/f2fs.txt
> > +++ b/Documentation/filesystems/f2fs.txt
> > @@ -335,6 +335,7 @@ Files in /sys/fs/f2fs/<devname>
> >                                 0x01: F2FS_IPU_FORCE, 0x02: F2FS_IPU_SSR,
> >                                 0x04: F2FS_IPU_UTIL,  0x08: F2FS_IPU_SSR_UTIL,
> >                                 0x10: F2FS_IPU_FSYNC.
> 
> . -> ,

Actually, we can't do it. I revised it a bit instead.

> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> > +			       0x40: F2FS_IPU_NOCACHE disables bio caches.
> >  
> >   min_ipu_util                 This parameter controls the threshold to trigger
> >                                in-place-updates. The number indicates percentage
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index a9519532c029..311fe4937f6a 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3289,7 +3289,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
> >  
> >  	stat_inc_inplace_blocks(fio->sbi);
> >  
> > -	if (fio->bio)
> > +	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 << F2FS_IPU_NOCACHE)))
> >  		err = f2fs_merge_page_bio(fio);
> >  	else
> >  		err = f2fs_submit_page_bio(fio);
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index a1b3951367cd..02e620470eef 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -623,6 +623,7 @@ enum {
> >  	F2FS_IPU_SSR_UTIL,
> >  	F2FS_IPU_FSYNC,
> >  	F2FS_IPU_ASYNC,
> > +	F2FS_IPU_NOCACHE,
> >  };
> >  
> >  static inline unsigned int curseg_segno(struct f2fs_sb_info *sbi,
> > 
