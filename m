Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D21ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D56F21D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328227;
	bh=UgBo+k0IM9TBMm5Hw8ZURPX5jKy7vKxolbjd/G2xXGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j3y9gmuAZcYIhRIVCxlvFavdVI2DcbJbE6E2nopUh4kxo4lCRLMFCEGo/tbHYth0N
	 4hyuFct9lmISpNLIWR0Ea6PAK/40vsCZsW349JcoF9zNp4/+1+6g1K6G3mkTnSRW57
	 OA9XALVJgbqGNpvwRux62x8eqWtypJGUsO+FRAD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440411AbfJQQDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440379AbfJQQDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:03:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6775B222C4;
        Thu, 17 Oct 2019 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328220;
        bh=UgBo+k0IM9TBMm5Hw8ZURPX5jKy7vKxolbjd/G2xXGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ML3QsrEWdMUo82F6/tfsZTj3B6v2SqiOo4r8iTLoRd53GrgwtO9ENPDVlxwt2mBu6
         F4Kj1kYoGc9iL4cW9alIhlqzTS2qDWy46qbj+v1Fc4rFkzqSZNeLt4m/sqeEr+xYcJ
         I4qGHtZ/RW6RVo5UtSUwat/o79FpLamBlPq86rYU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 10/11] tools headers UAPI: Sync sched.h with the kernel
Date:   Thu, 17 Oct 2019 13:03:00 -0300
Message-Id: <20191017160301.20888-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  78f6face5af3 ("sched: add kernel-doc for struct clone_args")
  f14c234b4bc5 ("clone3: switch to copy_struct_from_user()")

This file gets rebuilt, but no changes ensues:

   CC       /tmp/build/perf/trace/beauty/clone.o

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xqruu8wohwlbc57udg1g0xzx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index b3105ac1381a..99335e1f4a27 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -33,8 +33,31 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
-/*
- * Arguments for the clone3 syscall
+#ifndef __ASSEMBLY__
+/**
+ * struct clone_args - arguments for the clone3 syscall
+ * @flags:       Flags for the new process as listed above.
+ *               All flags are valid except for CSIGNAL and
+ *               CLONE_DETACHED.
+ * @pidfd:       If CLONE_PIDFD is set, a pidfd will be
+ *               returned in this argument.
+ * @child_tid:   If CLONE_CHILD_SETTID is set, the TID of the
+ *               child process will be returned in the child's
+ *               memory.
+ * @parent_tid:  If CLONE_PARENT_SETTID is set, the TID of
+ *               the child process will be returned in the
+ *               parent's memory.
+ * @exit_signal: The exit_signal the parent process will be
+ *               sent when the child exits.
+ * @stack:       Specify the location of the stack for the
+ *               child process.
+ * @stack_size:  The size of the stack for the child process.
+ * @tls:         If CLONE_SETTLS is set, the tls descriptor
+ *               is set to tls.
+ *
+ * The structure is versioned by size and thus extensible.
+ * New struct members must go at the end of the struct and
+ * must be properly 64bit aligned.
  */
 struct clone_args {
 	__aligned_u64 flags;
@@ -46,6 +69,9 @@ struct clone_args {
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
 };
+#endif
+
+#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 
 /*
  * Scheduling policies
-- 
2.21.0

