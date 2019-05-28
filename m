Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0CFC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49DA20883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE1LF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:05:28 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:52691 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbfE1LF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:05:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 022CA182CED34;
        Tue, 28 May 2019 11:05:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: legs83_4c81ae6e44a07
X-Filterd-Recvd-Size: 2509
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 May 2019 11:05:25 +0000 (UTC)
Message-ID: <6cc73c5454785faec229c8b78e63170e021a7c0d.camel@perches.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: ratelimit recovery messages
From:   Joe Perches <joe@perches.com>
To:     Chao Yu <yuchao0@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Date:   Tue, 28 May 2019 04:05:24 -0700
In-Reply-To: <0341eb2c-6788-1c85-2036-ed57b7f99dab@huawei.com>
References: <1558962655-25994-1-git-send-email-stummala@codeaurora.org>
         <94025a6d-f485-3811-5521-ed5c9b4d1d77@huawei.com>
         <20190528030509.GE10043@codeaurora.org>
         <2575bd54-d67c-6b26-ebf7-d6adb2e193a7@huawei.com>
         <b5665201-d13d-5fcb-100d-21630960e5f1@huawei.com>
         <0341eb2c-6788-1c85-2036-ed57b7f99dab@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-28 at 15:37 +0800, Chao Yu wrote:
[]
> > > > > > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
[]
> > > > > > @@ -188,8 +188,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
> > > > > >  		name = "<encrypted>";
> > > > > >  	else
> > > > > >  		name = raw_inode->i_name;
> > > > > > -	f2fs_msg(inode->i_sb, KERN_NOTICE,
> > > > > > -			"%s: ino = %x, name = %s, dir = %lx, err = %d",
> > > > > > +	printk_ratelimited(KERN_NOTICE
> > > > > > +			"%s: ino = %x, name = %s, dir = %lx, err = %d\n",
> > > > > >  			__func__, ino_of_node(ipage), name,
> > > > > >  			IS_ERR(dir) ? 0 : dir->i_ino, err);

Probably better to add and use a f2fs_msg_ratelimited macro.

And the generic f2fs_msg should add printf
format and argument verification.
---
 fs/f2fs/f2fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9b3d9977cd1e..2373bc3cb267 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1798,6 +1798,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	return -ENOSPC;
 }
 
+__printf(3, 4)
 void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...);
 static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 						struct inode *inode,


