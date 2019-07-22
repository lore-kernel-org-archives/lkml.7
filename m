Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862D0C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA2F21E6B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rUfzbbSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfGVIqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:46:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39529 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGVIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:46:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8k4xL3747427
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:46:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8k4xL3747427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563785165;
        bh=52RxQEACFNHpKKDiBYwtFQzgC/9MJCvBPNDWb/0PFbA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rUfzbbSQzojaElFWJESDMaJyHPDRPPmHOgtbySaG7PUoipYSzYsHcPmx+5zDnEfbo
         G9c7mRfa0mf5jKO6oI1tOXKZj21aP0BLh93kkeQO7SlhA8jqQIgJyJO9qKSSSVnp3Z
         kGlbWWA0BTNFHcRxjmK+qqYeoO0BTc+NYGjIQVI4hyXF9KXEnI4zEwhp2lvFvQj+8u
         7oDd3Hw+lJo2lQGuTLTwlyiyEqp8BM4nDQG5OHnTT8mgaMu1jDvakJPg1lg8tRkxlO
         P2H6KKWNXCF2ryXEQIp/Zb5QfjC20lwDenVQR6CeH+QOArDKM8f9L1FDmOmPTzsNki
         Iy5gt77hhwEFA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8k4OZ3747424;
        Mon, 22 Jul 2019 01:46:04 -0700
Date:   Mon, 22 Jul 2019 01:46:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eiichi Tsukata <tipbot@zytor.com>
Message-ID: <tip-2af7c85714d8cafadf925d55441458eae312cd6b@git.kernel.org>
Cc:     hpa@zytor.com, juri.lelli@gmail.com, mingo@kernel.org,
        tglx@linutronix.de, devel@etsukata.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, juri.lelli@gmail.com, devel@etsukata.com,
          tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190722083216.16192-2-devel@etsukata.com>
References: <20190722083216.16192-2-devel@etsukata.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/stacktrace: Prevent access_ok() warnings in
 arch_stack_walk_user()
Git-Commit-ID: 2af7c85714d8cafadf925d55441458eae312cd6b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2af7c85714d8cafadf925d55441458eae312cd6b
Gitweb:     https://git.kernel.org/tip/2af7c85714d8cafadf925d55441458eae312cd6b
Author:     Eiichi Tsukata <devel@etsukata.com>
AuthorDate: Mon, 22 Jul 2019 17:32:16 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:42:36 +0200

x86/stacktrace: Prevent access_ok() warnings in arch_stack_walk_user()

When arch_stack_walk_user() is called from atomic contexts, access_ok() can
trigger the following warning if compiled with CONFIG_DEBUG_ATOMIC_SLEEP=y.

Reproducer:

  // CONFIG_DEBUG_ATOMIC_SLEEP=y
  # cd /sys/kernel/debug/tracing
  # echo 1 > options/userstacktrace
  # echo 1 > events/irq/irq_handler_entry/enable

  WARNING: CPU: 0 PID: 2649 at arch/x86/kernel/stacktrace.c:103 arch_stack_walk_user+0x6e/0xf6
  CPU: 0 PID: 2649 Comm: bash Not tainted 5.3.0-rc1+ #99
  RIP: 0010:arch_stack_walk_user+0x6e/0xf6
  Call Trace:
   <IRQ>
   stack_trace_save_user+0x10a/0x16d
   trace_buffer_unlock_commit_regs+0x185/0x240
   trace_event_buffer_commit+0xec/0x330
   trace_event_raw_event_irq_handler_entry+0x159/0x1e0
   __handle_irq_event_percpu+0x22d/0x440
   handle_irq_event_percpu+0x70/0x100
   handle_irq_event+0x5a/0x8b
   handle_edge_irq+0x12f/0x3f0
   handle_irq+0x34/0x40
   do_IRQ+0xa6/0x1f0
   common_interrupt+0xf/0xf
   </IRQ>

Fix it by calling __range_not_ok() directly instead of access_ok() as
copy_from_user_nmi() does. This is fine here because the actual copy is
inside a pagefault disabled region.

Reported-by: Juri Lelli <juri.lelli@gmail.com>
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190722083216.16192-2-devel@etsukata.com

---
 arch/x86/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 4f36d3241faf..2d6898c2cb64 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -100,7 +100,7 @@ copy_stack_frame(const void __user *fp, struct stack_frame_user *frame)
 {
 	int ret;
 
-	if (!access_ok(fp, sizeof(*frame)))
+	if (__range_not_ok(fp, sizeof(*frame), TASK_SIZE))
 		return 0;
 
 	ret = 1;
