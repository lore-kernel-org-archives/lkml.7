Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3961C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B884C22CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gO/FwIoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfIEAxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 20:53:23 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:37261 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfIEAxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:53:23 -0400
Received: by mail-qk1-f201.google.com with SMTP id o133so577166qke.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=IvnDskQJANuLQ1Pn7l1TmXAAMajXPjDT8vWcyh/XpmU=;
        b=gO/FwIoDdL9taG9VUeNXZQNCiJk0A/0oE9ucXBj7+Xx9splScPhCR2nWU47O6fXBx6
         C582CQtLKNx7/QnibdqXHNUq+BPpBYj+kMNkM9hCWE/sifAGYQWwwIrbl9B1O5kPARX7
         Sk4hrqBRBNpFc/8eVaoaA6S+6GlbrF2jju0VJIEFnkoaqkZ14HUTE16i1g/8La34blCa
         IispT1OWkLNGFO6BPlxSHoYEyubgQpgLwXCQHVVRyOawRWNAFt1M5zVim5CbTtmwNXX7
         1nb+q+6Wam20ESgKQsDee+IilAawZft+oZApLZcpSy8fKCBxrNB/ubshRRDlxLzMKGmO
         FD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=IvnDskQJANuLQ1Pn7l1TmXAAMajXPjDT8vWcyh/XpmU=;
        b=HimHHUb25vIpx24acV/A3g90FsVd1FQxrpIFIkDzCPp63dWNtMHV/gIUvg0XGhG/p+
         kM6pzscFI97pzKOd3389lcRtU+ScLQbqHLjDSxMlBUPFrdLm40S4diDCjw5dfXEg0c1C
         TnbqzIm4tXdv4kPBXahwPrf/CDE/il9XT2aQ7T2W0Cq/zVnCC+FHDkRszmcVHoJAN0xV
         SWZSn/eja/+9gPzjHTTbN++jxhLzaOoszcJmuomLnCkgAMIzWqi0qBrApaqxN66C77+R
         JFG9H9eIi1fHyLEheAGHaDo1J6shp4TfnAuzzxkA28Al3jRctNn6fKQSwIDvyCG4IXvY
         ZW5g==
X-Gm-Message-State: APjAAAXlkBJl1h1J4F9e9rPlH0b48sVc5eQOItgPG0hopGwyilAKNiJN
        LQOLZ6cX3G8Dv4jmtt8l+Vf5s1KwHTA=
X-Google-Smtp-Source: APXvYqzu1B6DaFQ6YtDFilNWzwU62bbldfumKwkDWypKJe0Vvy6rAikoX2mOx7QuRd6Xew1uSVd9kV0JRLw=
X-Received: by 2002:a0c:9289:: with SMTP id b9mr155958qvb.211.1567644802199;
 Wed, 04 Sep 2019 17:53:22 -0700 (PDT)
Date:   Wed,  4 Sep 2019 17:53:13 -0700
Message-Id: <20190905005313.126823-1-dancol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [RFC] Add critical process prctl
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A task with CAP_SYS_ADMIN can mark itself PR_SET_TASK_CRITICAL,
meaning that if the task ever exits, the kernel panics. This facility
is intended for use by low-level core system processes that cannot
gracefully restart without a reboot. This prctl allows these processes
to ensure that the system restarts when they die regardless of whether
the rest of userspace is operational.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 include/linux/sched.h      |  5 +++++
 include/uapi/linux/prctl.h |  5 +++++
 kernel/exit.c              |  2 ++
 kernel/sys.c               | 19 +++++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f51932bd543..29420b9ebb63 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1526,6 +1526,7 @@ static inline bool is_percpu_thread(void)
 #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
 #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
 #define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
+#define PFA_CRITICAL                    8       /* Panic system if process exits */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1568,6 +1569,10 @@ TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
 TASK_PFA_TEST(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
 TASK_PFA_SET(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
 
+TASK_PFA_TEST(CRITICAL, critical)
+TASK_PFA_SET(CRITICAL, critical)
+TASK_PFA_CLEAR(CRITICAL, critical)
+
 static inline void
 current_restore_flags(unsigned long orig_flags, unsigned long flags)
 {
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 094bb03b9cc2..4964723bbd47 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -229,4 +229,9 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
 
+/* Per-task criticality control */
+#define PR_SET_TASK_CRITICAL 55
+#define PR_CRITICAL_NOT_CRITICAL 0
+#define PR_CRITICAL_CRITICAL 1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 5b4a5dcce8f8..9b3d3411d935 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -788,6 +788,8 @@ void __noreturn do_exit(long code)
 		panic("Aiee, killing interrupt handler!");
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");
+	if (unlikely(task_critical(tsk)))
+		panic("Critical task died!");
 
 	/*
 	 * If do_exit is called because this processes oopsed, it's possible
diff --git a/kernel/sys.c b/kernel/sys.c
index 2969304c29fe..097e05ebaf94 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2269,6 +2269,20 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 	return -EINVAL;
 }
 
+int task_do_set_critical(struct task_struct *t, unsigned long opt)
+{
+	if (opt != PR_CRITICAL_NOT_CRITICAL &&
+	    opt != PR_CRITICAL_CRITICAL)
+		return -EINVAL;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (opt == PR_CRITICAL_NOT_CRITICAL)
+		task_clear_critical(t);
+	else
+		task_set_critical(t);
+	return 0;
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2492,6 +2506,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = PAC_RESET_KEYS(me, arg2);
 		break;
+	case PR_SET_TASK_CRITICAL:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = task_do_set_critical(me, arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.23.0.187.g17f5b7556c-goog

