Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8B8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E852075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfDBTIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:08:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46910 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBTIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:08:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hBOlY-0007GR-23; Tue, 02 Apr 2019 19:08:12 +0000
Date:   Tue, 2 Apr 2019 20:08:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
Message-ID: <20190402190811.GM2217@ZenIV.linux.org.uk>
References: <20190327051717.23225-1-tobin@kernel.org>
 <20190402094934.5b242dc0@lwn.net>
 <20190402164824.GK2217@ZenIV.linux.org.uk>
 <20190402175401.GL2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402175401.GL2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:54:01PM +0100, Al Viro wrote:
> static void autofs_dentry_release(struct dentry *de)
> {
>         struct autofs_info *ino = autofs_dentry_ino(de);
>         struct autofs_sb_info *sbi = autofs_sbi(de->d_sb);
> 
>         pr_debug("releasing %p\n", de);
> 
>         if (!ino)
>                 return;
> ...
>         autofs_free_ino(ino);
> }
> with autofs_free_ino() being straight kfree().  Which means
> that the lockless case of autofs_d_manage() can run into
> autofs_dentry_ino(dentry) getting freed right under it.
> 
> And there we do have this reachable:
> int autofs_expire_wait(const struct path *path, int rcu_walk)
> {
>         struct dentry *dentry = path->dentry;
>         struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
>         struct autofs_info *ino = autofs_dentry_ino(dentry);
>         int status;
>         int state;
> 
>         /* Block on any pending expire */
>         if (!(ino->flags & AUTOFS_INF_WANT_EXPIRE))
>                 return 0;
>         if (rcu_walk)
>                 return -ECHILD;
> 
> the second check buggers off in lockless mode; the first one
> can be done in lockless mode just fine, so AFAICS we do have
> a problem there.  Smells like we ought to make that kfree
> in autofs_free_ino() RCU-delayed...  Ian, have you, by any
> chance, run into reports like that?  Use-after-free or
> oopsen in autofs_expire_wait() and friends, that is...

Alternatively, we could clear ->d_fsdata in autofs_d_release()
under ->d_lock and have all potentially lockless users of
autofs_dentry_ino() take ->d_lock around messing with that.
I'd still prefer to do it as below, though.  Ian, do you have
any objections against the following and, if you are OK with
it, which tree would you prefer it to go through?

autofs: fix use-after-free in lockless ->d_manage()

autofs_d_release() can overlap with lockless ->d_manage(),
ending up with autofs_dentry_ino() freed under the latter.
Make freeing autofs_info instances RCU-delayed...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 70c132acdab1..e1091312abe1 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -71,6 +71,7 @@ struct autofs_info {
 
 	kuid_t uid;
 	kgid_t gid;
+	struct rcu_head rcu;
 };
 
 #define AUTOFS_INF_EXPIRING	(1<<0) /* dentry in the process of expiring */
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 80597b88718b..fb0225f21c12 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -36,7 +36,7 @@ void autofs_clean_ino(struct autofs_info *ino)
 
 void autofs_free_ino(struct autofs_info *ino)
 {
-	kfree(ino);
+	kfree_rcu(ino, rcu);
 }
 
 void autofs_kill_sb(struct super_block *sb)
