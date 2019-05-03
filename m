Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8858C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 18:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85523204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 18:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfECSMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 14:12:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfECSMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 14:12:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFCDC58E3E;
        Fri,  3 May 2019 18:12:16 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA7AB60BFB;
        Fri,  3 May 2019 18:12:14 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        David Laight <David.Laight@aculab.com>
Subject: [PATCH v3 1/2] kernel/sys: add PR_GET_TASK_SIZE option to prctl(2)
Date:   Fri,  3 May 2019 14:10:20 -0400
Message-Id: <1556907021-29730-2-git-send-email-jsavitz@redhat.com>
In-Reply-To: <1556907021-29730-1-git-send-email-jsavitz@redhat.com>
References: <1556907021-29730-1-git-send-email-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 03 May 2019 18:12:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PR_GET_TASK_SIZE is passed to prctl, the kernel will attempt to
copy the value of TASK_SIZE to the userspace address in arg2.

It is important that we account for the case of the userspace task
running in 32-bit compat mode on a 64-bit kernel. As such, we must be
careful to copy the correct number of bytes to userspace to avoid stack
corruption.

Suggested-by: Yuri Norov <yury.norov@gmail.com>
Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 include/uapi/linux/prctl.h |  3 +++
 kernel/sys.c               | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 094bb03b9cc2..2c261c461952 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -229,4 +229,7 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY                        (1UL << 3)
 # define PR_PAC_APGAKEY                        (1UL << 4)

+/* Get the process virtual memory size (i.e. the highest usable VM address) */
+#define PR_GET_TASK_SIZE               55
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 12df0e5434b8..709584400070 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2252,6 +2252,26 @@ static int propagate_has_child_subreaper(struct task_struct *p, void *data)
        return 1;
 }

+static int prctl_get_tasksize(void __user *uaddr)
+{
+	unsigned long current_task_size, current_word_size;
+
+	current_task_size = TASK_SIZE;
+	current_word_size = sizeof(unsigned long);
+
+#ifdef CONFIG_64BIT
+	/* On 64-bit architecture, we must check whether the current thread
+	 * is running in 32-bit compat mode. If it is, we can simply cut
+	 * the size in half. This avoids corruption of the userspace stack.
+	 */
+	if (test_thread_flag(TIF_ADDR32))
+		current_word_size >>= 1;
+#endif
+
+	return copy_to_user(uaddr, &current_task_size, current_word_size) ? -EFAULT : 0;
+}
+
 int __weak arch_prctl_spec_ctrl_get(struct task_struct *t, unsigned long which)
 {
        return -EINVAL;
@@ -2486,6 +2506,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
                        return -EINVAL;
                error = PAC_RESET_KEYS(me, arg2);
                break;
+	case PR_GET_TASK_SIZE:
+		error = prctl_get_tasksize((void *)arg2);
+		break;
        default:
                error = -EINVAL;
                break;
--
2.18.1

