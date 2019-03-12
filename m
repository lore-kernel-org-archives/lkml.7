Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6915C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6923321734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413777;
	bh=KCBNltvUR5gxcB83fD6EQRRCTNan/iQUoJH6SQIri8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yXoCc3pWHXfM93/lCPp70hv7A81TpszcPcdrvpPjJd33tvcPD9V2X+jNhpXcQsZex
	 cYwW5awC2xSu+5SY4afvlJqJHIHPyZg9AHBIFTB7iRQjr0ONLVEQnJ/NrFYByLGKrs
	 2SanVpc+QJfw03c8XU+v8TrDSZdHVIH61QSM7y3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfCLRM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfCLRMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:33 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B8C21841;
        Tue, 12 Mar 2019 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410752;
        bh=KCBNltvUR5gxcB83fD6EQRRCTNan/iQUoJH6SQIri8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0VlHxefB7VzZqV7Jv57LXd5E58Hmxh4rKBbWwMPduqJ8THmERYTAPCdUNpThrNkT
         Atps4rwL/VOqdJiO6uIUOsk8XQxeopFfCuBVwRcHy273lvkO18fb7OO64+zYETJ8h2
         9qPkYj9wqTNQbwv16mE1EF/G9F6fe2Rsh81nbhBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?q?Mateusz=20St=C4=99pie=C5=84?= 
        <mateusz.stepien@netrounds.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 061/171] proc: fix /proc/net/* after setns(2)
Date:   Tue, 12 Mar 2019 10:07:21 -0700
Message-Id: <20190312170353.446467549@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1fde6f21d90f8ba5da3cb9c54ca991ed72696c43 ]

/proc entries under /proc/net/* can't be cached into dcache because
setns(2) can change current net namespace.

[akpm@linux-foundation.org: coding-style fixes]
[akpm@linux-foundation.org: avoid vim miscolorization]
[adobriyan@gmail.com: write test, add dummy ->d_revalidate hook: necessary if /proc/net/* is pinned at setns time]
  Link: http://lkml.kernel.org/r/20190108192350.GA12034@avx2
Link: http://lkml.kernel.org/r/20190107162336.GA9239@avx2
Fixes: 1da4d377f943fe4194ffb9fb9c26cc58fad4dd24 ("proc: revalidate misc dentries")
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Reported-by: Mateusz Stępień <mateusz.stepien@netrounds.com>
Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/generic.c                           |   4 +-
 fs/proc/internal.h                          |   1 +
 fs/proc/proc_net.c                          |  20 +++
 tools/testing/selftests/proc/.gitignore     |   1 +
 tools/testing/selftests/proc/Makefile       |   1 +
 tools/testing/selftests/proc/setns-dcache.c | 129 ++++++++++++++++++++
 6 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/proc/setns-dcache.c

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 8ae109429a88..e39bac94dead 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -256,7 +256,7 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		inode = proc_get_inode(dir->i_sb, de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
-		d_set_d_op(dentry, &proc_misc_dentry_ops);
+		d_set_d_op(dentry, de->proc_dops);
 		return d_splice_alias(inode, dentry);
 	}
 	read_unlock(&proc_subdir_lock);
@@ -429,6 +429,8 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	INIT_LIST_HEAD(&ent->pde_openers);
 	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
 
+	ent->proc_dops = &proc_misc_dentry_ops;
+
 out:
 	return ent;
 }
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 5185d7f6a51e..95b14196f284 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -44,6 +44,7 @@ struct proc_dir_entry {
 	struct completion *pde_unload_completion;
 	const struct inode_operations *proc_iops;
 	const struct file_operations *proc_fops;
+	const struct dentry_operations *proc_dops;
 	union {
 		const struct seq_operations *seq_ops;
 		int (*single_show)(struct seq_file *, void *);
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index d5e0fcb3439e..a7b12435519e 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -38,6 +38,22 @@ static struct net *get_proc_net(const struct inode *inode)
 	return maybe_get_net(PDE_NET(PDE(inode)));
 }
 
+static int proc_net_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	return 0;
+}
+
+static const struct dentry_operations proc_net_dentry_ops = {
+	.d_revalidate	= proc_net_d_revalidate,
+	.d_delete	= always_delete_dentry,
+};
+
+static void pde_force_lookup(struct proc_dir_entry *pde)
+{
+	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
+	pde->proc_dops = &proc_net_dentry_ops;
+}
+
 static int seq_open_net(struct inode *inode, struct file *file)
 {
 	unsigned int state_size = PDE(inode)->state_size;
@@ -90,6 +106,7 @@ struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_seq_fops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
@@ -133,6 +150,7 @@ struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_seq_fops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
@@ -181,6 +199,7 @@ struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_single_fops;
 	p->single_show = show;
 	return proc_register(parent, p);
@@ -223,6 +242,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_single_fops;
 	p->single_show = show;
 	p->write = write;
diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 82121a81681f..29bac5ef9a93 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -10,4 +10,5 @@
 /proc-uptime-002
 /read
 /self
+/setns-dcache
 /thread-self
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index 1c12c34cf85d..434d033ee067 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -14,6 +14,7 @@ TEST_GEN_PROGS += proc-uptime-001
 TEST_GEN_PROGS += proc-uptime-002
 TEST_GEN_PROGS += read
 TEST_GEN_PROGS += self
+TEST_GEN_PROGS += setns-dcache
 TEST_GEN_PROGS += thread-self
 
 include ../lib.mk
diff --git a/tools/testing/selftests/proc/setns-dcache.c b/tools/testing/selftests/proc/setns-dcache.c
new file mode 100644
index 000000000000..60ab197a73fc
--- /dev/null
+++ b/tools/testing/selftests/proc/setns-dcache.c
@@ -0,0 +1,129 @@
+/*
+ * Copyright © 2019 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/*
+ * Test that setns(CLONE_NEWNET) points to new /proc/net content even
+ * if old one is in dcache.
+ *
+ * FIXME /proc/net/unix is under CONFIG_UNIX which can be disabled.
+ */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+
+static pid_t pid = -1;
+
+static void f(void)
+{
+	if (pid > 0) {
+		kill(pid, SIGTERM);
+	}
+}
+
+int main(void)
+{
+	int fd[2];
+	char _ = 0;
+	int nsfd;
+
+	atexit(f);
+
+	/* Check for priviledges and syscall availability straight away. */
+	if (unshare(CLONE_NEWNET) == -1) {
+		if (errno == ENOSYS || errno == EPERM) {
+			return 4;
+		}
+		return 1;
+	}
+	/* Distinguisher between two otherwise empty net namespaces. */
+	if (socket(AF_UNIX, SOCK_STREAM, 0) == -1) {
+		return 1;
+	}
+
+	if (pipe(fd) == -1) {
+		return 1;
+	}
+
+	pid = fork();
+	if (pid == -1) {
+		return 1;
+	}
+
+	if (pid == 0) {
+		if (unshare(CLONE_NEWNET) == -1) {
+			return 1;
+		}
+
+		if (write(fd[1], &_, 1) != 1) {
+			return 1;
+		}
+
+		pause();
+
+		return 0;
+	}
+
+	if (read(fd[0], &_, 1) != 1) {
+		return 1;
+	}
+
+	{
+		char buf[64];
+		snprintf(buf, sizeof(buf), "/proc/%u/ns/net", pid);
+		nsfd = open(buf, O_RDONLY);
+		if (nsfd == -1) {
+			return 1;
+		}
+	}
+
+	/* Reliably pin dentry into dcache. */
+	(void)open("/proc/net/unix", O_RDONLY);
+
+	if (setns(nsfd, CLONE_NEWNET) == -1) {
+		return 1;
+	}
+
+	kill(pid, SIGTERM);
+	pid = 0;
+
+	{
+		char buf[4096];
+		ssize_t rv;
+		int fd;
+
+		fd = open("/proc/net/unix", O_RDONLY);
+		if (fd == -1) {
+			return 1;
+		}
+
+#define S "Num       RefCount Protocol Flags    Type St Inode Path\n"
+		rv = read(fd, buf, sizeof(buf));
+
+		assert(rv == strlen(S));
+		assert(memcmp(buf, S, strlen(S)) == 0);
+	}
+
+	return 0;
+}
-- 
2.19.1



