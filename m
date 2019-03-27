Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EAFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B98206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713166;
	bh=cAJdoIJ7dipTvZE6+8mq730rVFGEq5TSR6itAyzIt2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jiPelC+U7ywTIz8gwW0b+CB7D5GHC9R/UjBu/FOhoqmOwv5fys1lYRmq+gf2Ahy7j
	 bRA1oFVvZAW4bVU1gT+iRiu9lNm0XRIiABeINlXJPrKYO204LKFPGuAYZU19Lbiy+P
	 8IroVyaBY+F8NolMMU1kCxRfLM4pZ5rkE/NMzNTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbfC0SPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389482AbfC0SPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77A782147C;
        Wed, 27 Mar 2019 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710503;
        bh=cAJdoIJ7dipTvZE6+8mq730rVFGEq5TSR6itAyzIt2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xy9Q82GWkRVDwozBpHaRBlrp81sTli58xKUKe/HZ+PohvDfSCG6sRkqWnNnUhwirt
         4wCLGK9ieN3eup9xqPgQcTTh/xfNzHbL7H1Ng43QidWEgh72Q0qFkOnzHdMs2r9Q51
         xb4SlXnyQPAKZblD1aq4ZQhzH6K4pAqw8vlZjfNs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolai Stange <nstange@suse.de>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 148/192] powerpc/64s: Clear on-stack exception marker upon exception return
Date:   Wed, 27 Mar 2019 14:09:40 -0400
Message-Id: <20190327181025.13507-148-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolai Stange <nstange@suse.de>

[ Upstream commit eddd0b332304d554ad6243942f87c2fcea98c56b ]

The ppc64 specific implementation of the reliable stacktracer,
save_stack_trace_tsk_reliable(), bails out and reports an "unreliable
trace" whenever it finds an exception frame on the stack. Stack frames
are classified as exception frames if the STACK_FRAME_REGS_MARKER
magic, as written by exception prologues, is found at a particular
location.

However, as observed by Joe Lawrence, it is possible in practice that
non-exception stack frames can alias with prior exception frames and
thus, that the reliable stacktracer can find a stale
STACK_FRAME_REGS_MARKER on the stack. It in turn falsely reports an
unreliable stacktrace and blocks any live patching transition to
finish. Said condition lasts until the stack frame is
overwritten/initialized by function call or other means.

In principle, we could mitigate this by making the exception frame
classification condition in save_stack_trace_tsk_reliable() stronger:
in addition to testing for STACK_FRAME_REGS_MARKER, we could also take
into account that for all exceptions executing on the kernel stack
  - their stack frames's backlink pointers always match what is saved
    in their pt_regs instance's ->gpr[1] slot and that
  - their exception frame size equals STACK_INT_FRAME_SIZE, a value
    uncommonly large for non-exception frames.

However, while these are currently true, relying on them would make
the reliable stacktrace implementation more sensitive towards future
changes in the exception entry code. Note that false negatives, i.e.
not detecting exception frames, would silently break the live patching
consistency model.

Furthermore, certain other places (diagnostic stacktraces, perf, xmon)
rely on STACK_FRAME_REGS_MARKER as well.

Make the exception exit code clear the on-stack
STACK_FRAME_REGS_MARKER for those exceptions running on the "normal"
kernel stack and returning to kernelspace: because the topmost frame
is ignored by the reliable stack tracer anyway, returns to userspace
don't need to take care of clearing the marker.

Furthermore, as I don't have the ability to test this on Book 3E or 32
bits, limit the change to Book 3S and 64 bits.

Fixes: df78d3f61480 ("powerpc/livepatch: Implement reliable stack tracing for the consistency model")
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/entry_64.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2206912ea4f0..1f39ce40ae11 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -989,6 +989,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r2,_NIP(r1)
 	mtspr	SPRN_SRR0,r2
 
+	/*
+	 * Leaving a stale exception_marker on the stack can confuse
+	 * the reliable stack unwinder later on. Clear it.
+	 */
+	li	r2,0
+	std	r2,STACK_FRAME_OVERHEAD-16(r1)
+
 	ld	r0,GPR0(r1)
 	ld	r2,GPR2(r1)
 	ld	r3,GPR3(r1)
-- 
2.19.1

