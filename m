Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7857FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 07:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DEF21744
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 07:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567322762;
	bh=cm4J3Txz1wJoL1V/R9digMSLTBIHeY5HU+E85oT1cXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vVzmYWptEW/z6grySVZdwMvnBZIVDSbCyjrx7TNKtdRlUgkMdqDvM6htDI76JumIj
	 mRhOHoYvzHh7kRMxz9Iqms6vy+xmBGW/KFzzb2dNQrMr0X8vTG6obPFy278FOvaJnR
	 6hgx0Lis5fOtKvZMi6TrHmyyrUFtp6cu1AWBzPDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfIAHZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 03:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfIAHZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 03:25:31 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71AD622CF7;
        Sun,  1 Sep 2019 07:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567322730;
        bh=cm4J3Txz1wJoL1V/R9digMSLTBIHeY5HU+E85oT1cXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PnOnzioMXr9bRcZkt35UW6xoku0LD/+H5RRe3qTS4nB9q+FrOv6S6lv5T85pl6FmD
         WSCCOcHfPbOITEyH+68cBXrj/Ho7A97CRimNPHEftus684OX5ArKp0umGZJnxg5P1I
         +xYlQqsAF5kBHTFMCwOMp+SZ1OiQg75tmZghd9Pc=
Date:   Sun, 1 Sep 2019 00:25:29 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: convert inline_data in prior to
 i_size_write
Message-ID: <20190901072529.GB49907@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190830153453.24684-1-jaegeuk@kernel.org>
 <d441bdaa-5155-3144-cdfe-01e8dcc7eff2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d441bdaa-5155-3144-cdfe-01e8dcc7eff2@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31, Chao Yu wrote:
> On 2019/8/30 23:34, Jaegeuk Kim wrote:
> > This can guarantee inline_data has smaller i_size.
> 
> So I guess "f2fs: fix to avoid corruption during inline conversion" didn't fix
> such corruption right, I guess checkpoint & SPO before i_size recovery will
> cause this issue?
> 
> 	err = f2fs_convert_inline_inode(inode);
> 	if (err) {
> 
> -->

Yup, I think so.

> 
> 		/* recover old i_size */
> 		i_size_write(inode, old_size);
> 		return err;
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> > ---
> >  fs/f2fs/file.c | 25 +++++++++----------------
> >  1 file changed, 9 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 08caaead6f16..a43193dd27cb 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -815,14 +815,20 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
> >  
> >  	if (attr->ia_valid & ATTR_SIZE) {
> >  		loff_t old_size = i_size_read(inode);
> > -		bool to_smaller = (attr->ia_size <= old_size);
> > +
> > +		if (attr->ia_size > MAX_INLINE_DATA(inode)) {
> > +			/* should convert inline inode here */
> 
> Would it be better:
> 
> /* should convert inline inode here in piror to i_size_write to avoid
> inconsistent status in between inline flag and i_size */

Put like this.

+                       /*
+                        * should convert inline inode before i_size_write to
+                        * keep smaller than inline_data size with inline flag.
+                        */

> 
> Thanks,
> 
> > +			err = f2fs_convert_inline_inode(inode);
> > +			if (err)
> > +				return err;
> > +		}
> >  
> >  		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  		down_write(&F2FS_I(inode)->i_mmap_sem);
> >  
> >  		truncate_setsize(inode, attr->ia_size);
> >  
> > -		if (to_smaller)
> > +		if (attr->ia_size <= old_size)
> >  			err = f2fs_truncate(inode);
> >  		/*
> >  		 * do not trim all blocks after i_size if target size is
> > @@ -830,24 +836,11 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
> >  		 */
> >  		up_write(&F2FS_I(inode)->i_mmap_sem);
> >  		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > -
> >  		if (err)
> >  			return err;
> >  
> > -		if (!to_smaller) {
> > -			/* should convert inline inode here */
> > -			if (!f2fs_may_inline_data(inode)) {
> > -				err = f2fs_convert_inline_inode(inode);
> > -				if (err) {
> > -					/* recover old i_size */
> > -					i_size_write(inode, old_size);
> > -					return err;
> > -				}
> > -			}
> > -			inode->i_mtime = inode->i_ctime = current_time(inode);
> > -		}
> > -
> >  		down_write(&F2FS_I(inode)->i_sem);
> > +		inode->i_mtime = inode->i_ctime = current_time(inode);
> >  		F2FS_I(inode)->last_disk_size = i_size_read(inode);
> >  		up_write(&F2FS_I(inode)->i_sem);
> >  	}
> > 
