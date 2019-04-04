Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A467C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A3F20657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369716;
	bh=s6eXzHXf1Gb/WWIJ21y16FBgIVn0UoVG9Mj8WD0eQII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CO2DuaQYJ0C9fOOr6i3JZxZnTDP/0C91GTMQtXRegpxP8j/leP25Tzo3fKRqrdjWZ
	 UKDCwWA+7nm1jqlcQFn95SWpNB6b45I+kH03FCQD5/ZFpdp9BxZAD6qdGa+5uKjo/2
	 UWnA36159cAM4NYgt1FbomYdlSoj/lIFN6+daV8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfDDJVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387837AbfDDJQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E4F02075E;
        Thu,  4 Apr 2019 09:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369390;
        bh=s6eXzHXf1Gb/WWIJ21y16FBgIVn0UoVG9Mj8WD0eQII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z19kwOAvzrgpa1SnRwr7DdGXiJwOOnFYWBSzkBuYZFWNYT0DQHTesHiVY0fPFJvyB
         FmbnIPw/1MvKbN2ItWLL+wkfqDDvANNlfmmkoV8QSTH9t6+FHUPdTIZrAWiq+IMek7
         1Ishygm5QJjCeNSt8fsCeVGTwOPN9pQu7ZbvQQiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Lawrence <joe.lawrence@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 190/246] powerpc/64s: Clear on-stack exception marker upon exception return
Date:   Thu,  4 Apr 2019 10:48:10 +0200
Message-Id: <20190404084625.838266088@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 435927f549c4..a2c168b395d2 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1002,6 +1002,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
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



