Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F05EC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0EC2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfDDTFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:05:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52520 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfDDTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:05:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hC7ff-0004e3-3u; Thu, 04 Apr 2019 19:05:07 +0000
Date:   Thu, 4 Apr 2019 20:05:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] acct: fix possible deadlock in acct_pin_kill
Message-ID: <20190404190506.GE2217@ZenIV.linux.org.uk>
References: <20190404105255.12189-1-amir73il@gmail.com>
 <20190404184448.GC2217@ZenIV.linux.org.uk>
 <20190404184944.GD2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404184944.GD2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 07:49:44PM +0100, Al Viro wrote:
> On Thu, Apr 04, 2019 at 07:44:48PM +0100, Al Viro wrote:
> 
> > Huh?  sb_writers is taken when we *open* the new file.  Then we replace
> > its ->path.mnt with a clone and transfer the write count from the original
> > to new one.  And close the old file while we are at it.
> > 
> > >From sb_writers POV mainline has
> > 	sb_start_write(new_sb)	// in open
> > 	sb_start_write(new_sb)	// mnt_want_write() on clone
> > 	last write to old_sb, then sb_end_write(old_sb) // acct_pin_kill()
> > 	sb_end_write(new_sb)	// mnt_drop_write(mnt)
> > and you flip the order of the last two lines.
> > 
> > Could you explain how exactly does your patch help whatever
> > problem overlayfs has?
> 
> Ow...  Sorry, -ENOCOFFEE...
> 
> Let me wake up properly and look at that thing again.

OK, so...  My first reaction had been complete BS.  However, the
same goes for your analysis - it's not an ordering problem at all.
What happens is that we are replacing file->path.mnt with a clone
and we want the write count contribution (file is opened for write)
to be transferred.  That's it.  We do *NOT* want any kind of
freeze protection for the duration of switchover.

IOW, the solution is to switch to __mnt_{want,drop}_write() for that
switchover; we don't want to mess with freeze protection at all.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/internal.h b/fs/internal.h
index 6a8b71643af4..2e7362837a6e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -89,9 +89,7 @@ extern int sb_prepare_remount_readonly(struct super_block *);
 
 extern void __init mnt_init(void);
 
-extern int __mnt_want_write(struct vfsmount *);
 extern int __mnt_want_write_file(struct file *);
-extern void __mnt_drop_write(struct vfsmount *);
 extern void __mnt_drop_write_file(struct file *);
 
 /*
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 9197ddbf35fb..bf8cc4108b8f 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -87,6 +87,8 @@ extern bool mnt_may_suid(struct vfsmount *mnt);
 
 struct path;
 extern struct vfsmount *clone_private_mount(const struct path *path);
+extern int __mnt_want_write(struct vfsmount *);
+extern void __mnt_drop_write(struct vfsmount *);
 
 struct file_system_type;
 extern struct vfsmount *fc_mount(struct fs_context *fc);
diff --git a/kernel/acct.c b/kernel/acct.c
index addf7732fb56..81f9831a7859 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -227,7 +227,7 @@ static int acct_on(struct filename *pathname)
 		filp_close(file, NULL);
 		return PTR_ERR(internal);
 	}
-	err = mnt_want_write(internal);
+	err = __mnt_want_write(internal);
 	if (err) {
 		mntput(internal);
 		kfree(acct);
@@ -252,7 +252,7 @@ static int acct_on(struct filename *pathname)
 	old = xchg(&ns->bacct, &acct->pin);
 	mutex_unlock(&acct->lock);
 	pin_kill(old);
-	mnt_drop_write(mnt);
+	__mnt_drop_write(mnt);
 	mntput(mnt);
 	return 0;
 }
