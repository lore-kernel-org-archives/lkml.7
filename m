Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E091C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5799F214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="H3vQt5PJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDYQOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:14:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35884 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbfDYQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id u57so413118edm.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnqzLoZLF9xq2SDetGPpceHwTDm+1OVzbOaBoo+761Y=;
        b=H3vQt5PJPyUJofid0rMtdpiD19JUkEEuCp9ASRu1bBf3F5KUcTUOh1BdKQRUxboZvE
         FaryllK7cxKthnnjrHGXJszaXIylz6SGCEAPUdZs4u1HM+PhFgRNA70uoFr+EgNNIpEW
         iAhuuqneQZhLql3BU0MIJuhEMC1NtvPFPCJxTh0rKOGUtJBuwCdNbkHhhFe4b04uZXSq
         V9OrkGXJts6H+KM50RBCifht9kMQNBIVzh3QLD6Qb5tg6lDkWhDsx+pd0slk7J9gw/PC
         yyWs2QQ7d0Lv9ewLjEhiAV1LfeRMf+yo0ApzcW2lCbX67FDo5RAAJhAkaeYZizP9ZV5P
         r2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnqzLoZLF9xq2SDetGPpceHwTDm+1OVzbOaBoo+761Y=;
        b=eRryzrJV2FmIiKZBcyHc9//QpGbouS9W1tSY/YhFqOXaAqTQo98wt9OOJhP6v9Cizl
         UbTdYGR2kA4A0Ego955KEk7SiKnFXQCSU1iPsAimCIO/n1ABiGLiALRPSgzFULS2/c5Q
         Atm/upsQk4w9Azm0EDuPxgjDO15veFPHf6f1Ec31Jv1NRsEltqoIViA4wweal6n1YLeN
         nfxrC/12CfjvwGbOytsrEFC5z63zvRIbD6I8NHbH1kormblHT6gfwRnHWGeyGfC2Kku3
         AzYJQeUSS861QsdDu54lJZnLZF7VlUKZTCnUNi/CJ64uifkE5SUfJNeI+3m2KZbA08gg
         tmlw==
X-Gm-Message-State: APjAAAXiIfDXDwb7qgp23YMwxLky4Ri9fJMVCY24YkaycnuhXEh4rBAj
        O0+mQnNBH5tGJNKzP/gdGYNHF1oVhdg=
X-Google-Smtp-Source: APXvYqxSj8ic/159CcLooJXCz5R6oBd6eQxbVwAPgMiaJXsJfFeCb756/jMcbrCzLo2+Re9SKMWxXw==
X-Received: by 2002:a17:906:7c12:: with SMTP id t18mr17087548ejo.59.1556208890146;
        Thu, 25 Apr 2019 09:14:50 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:49 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 19/27] timens/fs/proc: Introduce /proc/pid/timens_offsets
Date:   Thu, 25 Apr 2019 17:14:08 +0100
Message-Id: <20190425161416.26600-20-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

API to set time namespace offsets for children processes, i.e.:
echo "clockid off_ses off_nsec" > /proc/self/timens_offsets

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/proc/base.c                 | 101 +++++++++++++++++++++++++++++++++
 include/linux/time_namespace.h |  10 ++++
 kernel/time_namespace.c        |  82 ++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6a803a0b75df..76d58e9b5178 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
+#include <linux/time_namespace.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -1521,6 +1522,103 @@ static const struct file_operations proc_pid_sched_autogroup_operations = {
 
 #endif /* CONFIG_SCHED_AUTOGROUP */
 
+#ifdef CONFIG_TIME_NS
+static int timens_offsets_show(struct seq_file *m, void *v)
+{
+	struct inode *inode = m->private;
+	struct task_struct *p;
+
+	p = get_proc_task(inode);
+	if (!p)
+		return -ESRCH;
+	proc_timens_show_offsets(p, m);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
+static ssize_t
+timens_offsets_write(struct file *file, const char __user *buf,
+	    size_t count, loff_t *ppos)
+{
+	struct inode *inode = file_inode(file);
+	struct proc_timens_offset offsets[2];
+	char *kbuf = NULL, *pos, *next_line;
+	struct task_struct *p;
+	int ret, noffsets;
+
+	/* Only allow < page size writes at the beginning of the file */
+	if ((*ppos != 0) || (count >= PAGE_SIZE))
+		return -EINVAL;
+
+	/* Slurp in the user data */
+	kbuf = memdup_user_nul(buf, count);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	/* Parse the user data */
+	ret = -EINVAL;
+	noffsets = 0;
+	pos = kbuf;
+	for (; pos; pos = next_line) {
+		struct proc_timens_offset *off = &offsets[noffsets];
+		int err;
+
+		/* Find the end of line and ensure I don't look past it */
+		next_line = strchr(pos, '\n');
+		if (next_line) {
+			*next_line = '\0';
+			next_line++;
+			if (*next_line == '\0')
+				next_line = NULL;
+		}
+
+		err = sscanf(pos, "%u %lld %lu", &off->clockid,
+				&off->val.tv_sec, &off->val.tv_nsec);
+		if (err != 3 || off->val.tv_nsec >= NSEC_PER_SEC)
+			goto out;
+		if (noffsets++ == ARRAY_SIZE(offsets))
+			break;
+	}
+
+	ret = -ESRCH;
+	p = get_proc_task(inode);
+	if (!p)
+		goto out;
+	ret = proc_timens_set_offset(p, offsets, noffsets);
+	put_task_struct(p);
+	if (ret)
+		goto out;
+
+	ret = count;
+out:
+	kfree(kbuf);
+	return ret;
+}
+
+static int timens_offsets_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+
+	ret = single_open(filp, timens_offsets_show, NULL);
+	if (!ret) {
+		struct seq_file *m = filp->private_data;
+
+		m->private = inode;
+	}
+	return ret;
+}
+
+static const struct file_operations proc_timens_offsets_operations = {
+	.open		= timens_offsets_open,
+	.read		= seq_read,
+	.write		= timens_offsets_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_TIME_NS */
+
 static ssize_t comm_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *offset)
 {
@@ -2982,6 +3080,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	REG("autogroup",  S_IRUGO|S_IWUSR, proc_pid_sched_autogroup_operations),
+#endif
+#ifdef CONFIG_TIME_NS
+	REG("timens_offsets",  S_IRUGO|S_IWUSR, proc_timens_offsets_operations),
 #endif
 	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 988414f7f791..1434b5664673 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -40,6 +40,16 @@ static inline void put_time_ns(struct time_namespace *ns)
 	kref_put(&ns->kref, free_time_ns);
 }
 
+extern void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m);
+
+struct proc_timens_offset {
+	int clockid;
+	struct timespec64 val;
+};
+
+extern int proc_timens_set_offset(struct task_struct *p,
+				struct proc_timens_offset *offsets, int n);
+
 static inline void timens_add_monotonic(struct timespec64 *ts)
 {
         struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index e806accc4eaf..9ad4b63c4ed2 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -13,6 +13,7 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
+#include <linux/seq_file.h>
 #include <linux/mm.h>
 #include <asm/vdso.h>
 
@@ -202,6 +203,87 @@ static struct user_namespace *timens_owner(struct ns_common *ns)
 	return to_time_ns(ns)->user_ns;
 }
 
+static void show_offset(struct seq_file *m, int clockid, struct timespec64 *ts)
+{
+	seq_printf(m, "%d %lld %ld\n", clockid, ts->tv_sec, ts->tv_nsec);
+}
+
+void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m)
+{
+	struct ns_common *ns;
+	struct time_namespace *time_ns;
+	struct timens_offsets *ns_offsets;
+
+	ns = timens_for_children_get(p);
+	if (!ns)
+		return;
+	time_ns = to_time_ns(ns);
+
+	if (!time_ns->offsets) {
+		put_time_ns(time_ns);
+		return;
+	}
+	ns_offsets = time_ns->offsets;
+
+	show_offset(m, CLOCK_MONOTONIC, &ns_offsets->monotonic_time_offset);
+	show_offset(m, CLOCK_BOOTTIME, &ns_offsets->monotonic_boottime_offset);
+	put_time_ns(time_ns);
+}
+
+int proc_timens_set_offset(struct task_struct *p,
+			   struct proc_timens_offset *offsets, int noffsets)
+{
+	struct ns_common *ns;
+	struct time_namespace *time_ns;
+	struct timens_offsets *ns_offsets;
+	struct timespec64 *offset;
+	struct timespec64 tp;
+	int i, err;
+
+	ns = timens_for_children_get(p);
+	if (!ns)
+		return -ESRCH;
+	time_ns = to_time_ns(ns);
+
+	if (!time_ns->offsets || time_ns->initialized ||
+	    !ns_capable(time_ns->user_ns, CAP_SYS_TIME)) {
+		put_time_ns(time_ns);
+		return -EPERM;
+	}
+	ns_offsets = time_ns->offsets;
+
+	err = -EINVAL;
+	for (i = 0; i < noffsets; i++) {
+		struct proc_timens_offset *off = &offsets[i];
+
+		switch (off->clockid) {
+		case CLOCK_MONOTONIC:
+			ktime_get_ts64(&tp);
+			offset = &ns_offsets->monotonic_time_offset;
+			break;
+		case CLOCK_BOOTTIME:
+			ktime_get_boottime_ts64(&tp);
+			offset = &ns_offsets->monotonic_boottime_offset;
+			break;
+		default:
+			goto out;
+		}
+
+		err = -ERANGE;
+		tp = timespec64_add(tp, off->val);
+		if (tp.tv_sec < 0 || tp.tv_sec > KTIME_SEC_MAX / 2)
+			goto out;
+		*offset = off->val;
+
+	}
+
+	err = 0;
+out:
+	put_time_ns(time_ns);
+
+	return err;
+}
+
 const struct proc_ns_operations timens_operations = {
 	.name		= "time",
 	.type		= CLONE_NEWTIME,
-- 
2.21.0

