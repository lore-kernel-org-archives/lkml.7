Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E8FC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0242133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbfJNQVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:21:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388054AbfJNQVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:21:35 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1805661D25
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 16:21:35 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id o92so10515798edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxJEiUicI74qFOY0JqtAedGKYBHKAdl/AbcmF2fazs4=;
        b=tBux/4PxfTJi6kaez8Ug0aRed1pQFUbU0upxtBf4oOHRJS3weQ2l8rrDVEBWHPue7e
         41kWdCh5JaepRHKxjhbTO23aal1LfJyiIfy2/lqWlYbGV7UYlQJM5OLl1btmIAEZSleC
         pgG1urPXxzcGf7adauFsty0B3anekBiaZ8HCE/CdQ8XkMQ0V9Xvk70YsQ89QrVnlMuXS
         TJKaFrwdYeS+m8dQYFgl9bLOENmA9Brubaq3s3mpDZHEfPfav6hq73d7eFDuBr5hFF81
         t3U3I/MUg7J4CQ4aAOiclcUhMskDuKODmpFk840Y2k5AlIlgpe2c/zFVUwRu7tbldkgT
         kwRA==
X-Gm-Message-State: APjAAAVwG2r8di6GWqlURB7UQ7sH2Qv4Wr3sCG1jRPnhFG3tuowjXZXR
        gOqWGnfpfTb7wfxFhN/9NBWNaeQ4rDygkYGvxQNwAo1b+1wGthaR5o3A5gvq52OkdGTMHDujC6Z
        27p9q0ZmGdJlgbwKoWUJ4Z7Ui
X-Received: by 2002:a50:9fcd:: with SMTP id c71mr28967496edf.139.1571070093513;
        Mon, 14 Oct 2019 09:21:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyS0BF2XOi6OkeE1vgAAFwd+MqDj2BjN62Hn0mRr5YldhvLlYO8SB+mZW2bhY6FBZyMdUT7hQ==
X-Received: by 2002:a50:9fcd:: with SMTP id c71mr28967464edf.139.1571070093258;
        Mon, 14 Oct 2019 09:21:33 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id u11sm202672ejz.48.2019.10.14.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 09:21:32 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
        Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH v4 1/2] pidfd: add NSpid entries to fdinfo
Date:   Mon, 14 Oct 2019 18:20:32 +0200
Message-Id: <20191014162034.2185-1-ckellner@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011122323.7770-1-ckellner@redhat.com>
References: <20191011122323.7770-1-ckellner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Kellner <christian@kellner.me>

Currently, the fdinfo file contains the Pid field which shows the
pid a given pidfd refers to in the pid namespace of the procfs
instance. If pid namespaces are configured, also show an NSpid field
for easy retrieval of the pid in all descendant pid namespaces. If
the pid namespace of the process is not a descendant of the pid
namespace of the procfs instance 0 will be shown as its first NSpid
entry and no other entries will be shown. Add a block comment to
pidfd_show_fdinfo with a detailed explanation of Pid and NSpid fields.

Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Christian Kellner <christian@kellner.me>
---
Changes in v4:
- Reworked to properly handle the case where the pidfd is from a
  different branch in the pid namespace hierarchy; also add block
  comment with an in-depth explanation (Christian Brauner)

 kernel/fork.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index bcdf53125210..782986962d47 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1695,12 +1695,63 @@ static int pidfd_release(struct inode *inode, struct file *file)
 }
 
 #ifdef CONFIG_PROC_FS
+/**
+ * pidfd_show_fdinfo - print information about a pidfd
+ * @m: proc fdinfo file
+ * @f: file referencing a pidfd
+ *
+ * Pid:
+ * This function will print the pid that a given pidfd refers to in the
+ * pid namespace of the procfs instance.
+ * If the pid namespace of the process is not a descendant of the pid
+ * namespace of the procfs instance 0 will be shown as its pid. This is
+ * similar to calling getppid() on a process whose parent is outside of
+ * its pid namespace.
+ *
+ * NSpid:
+ * If pid namespaces are supported then this function will also print
+ * the pid of a given pidfd refers to for all descendant pid namespaces
+ * starting from the current pid namespace of the instance, i.e. the
+ * Pid field and the first entry in the NSpid field will be identical.
+ * If the pid namespace of the process is not a descendant of the pid
+ * namespace of the procfs instance 0 will be shown as its first NSpid
+ * entry and no others will be shown.
+ * Note that this differs from the Pid and NSpid fields in
+ * /proc/<pid>/status where Pid and NSpid are always shown relative to
+ * the  pid namespace of the procfs instance. The difference becomes
+ * obvious when sending around a pidfd between pid namespaces from a
+ * different branch of the tree, i.e. where no ancestoral relation is
+ * present between the pid namespaces:
+ * - create two new pid namespaces ns1 and ns2 in the initial pid
+ *   namespace (also take care to create new mount namespaces in the
+ *   new pid namespace and mount procfs)
+ * - create a process with a pidfd in ns1
+ * - send pidfd from ns1 to ns2
+ * - read /proc/self/fdinfo/<pidfd> and observe that both Pid and NSpid
+ *   have exactly one entry, which is 0
+ */
 static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
 	struct pid *pid = f->private_data;
+	pid_t nr = pid_nr_ns(pid, ns);
+
+	seq_put_decimal_ull(m, "Pid:\t", nr);
 
-	seq_put_decimal_ull(m, "Pid:\t", pid_nr_ns(pid, ns));
+#ifdef CONFIG_PID_NS
+	seq_put_decimal_ull(m, "\nNSpid:\t", nr);
+	if (nr) {
+		int i;
+
+		/* If nr is non-zero it means that 'pid' is valid and that
+		 * ns, i.e. the pid namespace associated with the procfs
+		 * instance, is in the pid namespace hierarchy of pid.
+		 * Start at one below the already printed level.
+		 */
+		for (i = ns->level + 1; i <= pid->level; i++)
+			seq_put_decimal_ull(m, "\t", pid->numbers[i].nr);
+	}
+#endif
 	seq_putc(m, '\n');
 }
 #endif
-- 
2.21.0

