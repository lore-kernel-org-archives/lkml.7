Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2BCC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F3E20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9BjbFdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfCDTtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:49:25 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:36353 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfCDTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:49:25 -0500
Received: by mail-qk1-f201.google.com with SMTP id b11so5265163qka.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 11:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8rvlUdhhv3UHhai+Db4tryy7bWvH2Jv34DWT5pApELc=;
        b=R9BjbFdgYUIDl02s0jz8fdfnMcRetOdrHmCM9QqAh1f/SVQ5SsaAJW4oYDVTytc5ig
         XhI1ej7U6W7NYTbweZeaX8W+Ct6UY254PMOdx+lyVTF1uhbvSiXapOSKTAtYvBTLPp1d
         nbOVOu06LjK1i6t3MQ2gO2VD+0p1YOuaAzf4MfyWbnCcdlU3Y0W16yCAoIIRw/dnEVTC
         a16C+k2ngb8NI0olwTRWW+F8wDPugphEAow2KiNMoV6kDO+jqdBJhbnAcHV8SSpC6BtB
         fAJYe29Nbc5VIehoMgWO3EbaMCSFS187OQWOuX8edf3TVCIeErx4X1J5nlKO9f5f4RAo
         MQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8rvlUdhhv3UHhai+Db4tryy7bWvH2Jv34DWT5pApELc=;
        b=NT+ptwczddVUqrcyTMK5C22dyoGVmJbnb9YZxWFvL533GjL3857XDaSUgUY4xVLom2
         ErRqNpSnv6oToAFOmhQpuoV5Z3Px0fg45XoNaYN68Y+nemddQXB1VoZ6pfGvhQIBchQz
         aIGc4hTQxxO1qDrFJVaA6a02XT1ONS8qpXAAWxycB7yYXNlIGFe3p9t4HtsDNHwA+WJ2
         1IAgco5CNFccdf2nWEUfeibZomS86H95s6nFQwt3LKndtpZeSBxMa+OHfmKh2y9i/YXK
         z63smGxKWnN0sykn0mH9wIZXRu5Vq91oq5Wt3ksp6cs9SapsxRRfyF+KieF/8M6Y/vzR
         1TkA==
X-Gm-Message-State: APjAAAWu2HVywHF6ugalcuYJoi0HTkKD3qxjhhdUI0uW7TeVoSeVyBps
        Z6QH/4rIiTEjGHHthy5Hyzl0x6bmiQ==
X-Google-Smtp-Source: APXvYqzbERh7J/dU5FGk8igrgs7I0cwYhGZx07TvQAnx+6d2Pd7mUEzBELReWrU3h6cTtRNmI05perpysQ==
X-Received: by 2002:a0c:d486:: with SMTP id u6mr12060456qvh.56.1551728963951;
 Mon, 04 Mar 2019 11:49:23 -0800 (PST)
Date:   Mon,  4 Mar 2019 11:48:59 -0800
In-Reply-To: <CAKUOC8Xvda0KPkck3Tunksm8gg2aCi8Zf1EWb7VVa_y9rv6j3g@mail.gmail.com>
Message-Id: <20190304194859.229604-1-sqazi@google.com>
Mime-Version: 1.0
References: <CAKUOC8Xvda0KPkck3Tunksm8gg2aCi8Zf1EWb7VVa_y9rv6j3g@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH RESENT] fs, ipc: Use an asynchronous version of kern_unmount
 in IPC
From:   Salman Qazi <sqazi@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Salman Qazi <sqazi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this patch, the kernel can spend a lot of time with
this stack trace:

[<ffffffffbe5491e3>] __wait_rcu_gp+0x93/0xe0
[<ffffffffbe549418>] synchronize_sched+0x48/0x60
[<ffffffffbe7ae5b3>] kern_unmount+0x3a/0x46
[<ffffffffbe847c02>] mq_put_mnt+0x15/0x17
[<ffffffffbe8481af>] put_ipc_ns+0x36/0x8b

This patch solves the issue by removing synchronize_rcu from mq_put_mnt.
This is done by implementing an asynchronous version of kern_unmount.

Since mntput() sleeps, it needs to be deferred to a work queue.

Additionally, the callers of mq_put_mnt appear to be safe having
it behave asynchronously.  In particular, put_ipc_ns calls
mq_clear_sbinfo which renders the inode inaccessible for the purposes of
mqueue_create by making s_fs_info NULL.  This appears
to be the thing that prevents access while free_ipc_ns is taking place.
So, the unmount should be able to proceed lazily.

Tested: Ran the following program:

    int main(void)
    {
            int pid;
            int status;
            int i;

            for (i = 0; i < 1000; i++) {
                    pid = fork();
                    if (!pid) {
                            assert(!unshare(CLONE_NEWUSER|
                                      CLONE_NEWIPC|CLONE_NEWNS));
                            return 0;
                    }

                    assert(waitpid(pid, &status, 0) == pid);
            }
    }

Before:

$ time ./unshare2

real    0m9.784s
user    0m0.428s
sys     0m0.000s

After:

$ time ./unshare2

real    0m0.368s
user    0m0.226s
sys     0m0.122s

Signed-off-by: Salman Qazi <sqazi@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 fs/namespace.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 ipc/mqueue.c       |  2 +-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 678ef175d63a..e60b473c3bbc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3321,6 +3321,47 @@ void kern_unmount(struct vfsmount *mnt)
 }
 EXPORT_SYMBOL(kern_unmount);
 
+struct async_unmount_cb {
+	struct vfsmount *mnt;
+	struct work_struct work;
+	struct rcu_head rcu_head;
+};
+
+static void kern_unmount_work(struct work_struct *work)
+{
+	struct async_unmount_cb *cb = container_of(work,
+			struct async_unmount_cb, work);
+
+	mntput(cb->mnt);
+	kfree(cb);
+}
+
+static void kern_unmount_rcu_cb(struct rcu_head *rcu_head)
+{
+	struct async_unmount_cb *cb = container_of(rcu_head,
+			struct async_unmount_cb, rcu_head);
+
+	INIT_WORK(&cb->work, kern_unmount_work);
+	schedule_work(&cb->work);
+
+}
+
+void kern_unmount_async(struct vfsmount *mnt)
+{
+	/* release long term mount so mount point can be released */
+	if (!IS_ERR_OR_NULL(mnt)) {
+		struct async_unmount_cb *cb = kmalloc(sizeof(*cb), GFP_KERNEL);
+
+		if (cb) {
+			real_mount(mnt)->mnt_ns = NULL;
+			cb->mnt = mnt;
+			call_rcu(&cb->rcu_head, kern_unmount_rcu_cb);
+		} else {
+			kern_unmount(mnt);
+		}
+	}
+}
+
 bool our_mnt(struct vfsmount *mnt)
 {
 	return check_mnt(real_mount(mnt));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 29d8e2cfed0e..8865997a8722 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2274,6 +2274,7 @@ extern int register_filesystem(struct file_system_type *);
 extern int unregister_filesystem(struct file_system_type *);
 extern struct vfsmount *kern_mount_data(struct file_system_type *, void *data);
 #define kern_mount(type) kern_mount_data(type, NULL)
+extern void kern_unmount_async(struct vfsmount *mnt);
 extern void kern_unmount(struct vfsmount *mnt);
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index c595bed7bfcb..a8c2465ac0cb 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1554,7 +1554,7 @@ void mq_clear_sbinfo(struct ipc_namespace *ns)
 
 void mq_put_mnt(struct ipc_namespace *ns)
 {
-	kern_unmount(ns->mq_mnt);
+	kern_unmount_async(ns->mq_mnt);
 }
 
 static int __init init_mqueue_fs(void)
-- 
2.21.0.352.gf09ad66450-goog

