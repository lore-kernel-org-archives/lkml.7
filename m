Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A77CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E76321925
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 18:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMN1/u7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfJSSNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 14:13:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40464 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfJSSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 14:13:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id e13so5161777pga.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THRrp/Ex+10EZKFSZ17SjdGISreGoqTYFjW18IRfuUo=;
        b=mMN1/u7x9RFPXYmLVW92jcxFJNIhr4sXnEADaI/y3eaKvRTqNna3yPXsemg9R37y/f
         xIa3nhuX6wbU93aIXH1Nd1VRmqaxYR310LrIW7p8ieeQ0TLNchb5dePN01iRdzz/8P3k
         0Wbsp7pabKG52FeCh/Kip/yOcrKIRl756owv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THRrp/Ex+10EZKFSZ17SjdGISreGoqTYFjW18IRfuUo=;
        b=lscqG+sOUTJuRahvA9YkWyiBaf2LMaCUirwRmzhDCu44sTjCsYr/oD4fNksaGvY0eZ
         53sV0D6ifvCRKu42Qe2D+DWdi0J6Mc/zJma0IKoKcw5L2Av8ubvxukDwQCYoRuqlnS4O
         wf41PKxF6iw1MJXGqQBtSXkKbaQsyhQdB3a8c6Wp05IdYBVkSWiGr0t1Gc2lb9cPqp+Y
         MY5QdOFqIh2c1Sx9zSrMMhDsoJ/glFbUWBpmskuNfhxJHDEmVP5toEblYJgzq2nvEqsn
         8Ga+i5JD6Z9VBJvZJXyI4fUeeh+ZT29NmWqrVs79DUXksTYMuUl0HHgM42oLXjruM7ZJ
         JpbQ==
X-Gm-Message-State: APjAAAVsLG63ObxllUq/heJC748m+R2qLl6q0cW3e5OS6pCiwcFmlkQW
        PNvYHZJWKGMiNMY4zHOEjoiiyA==
X-Google-Smtp-Source: APXvYqyqjdiEpPjvVxGmB8CeGzQy1F+O/Zu+CxdB3XQj32hzbbujF1/jQA0q3pytSyak+G1ZcJ4iJw==
X-Received: by 2002:a17:90a:f495:: with SMTP id bx21mr17765653pjb.84.1571508788795;
        Sat, 19 Oct 2019 11:13:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id m2sm14567461pff.154.2019.10.19.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 11:13:08 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Pavel Labath <labath@google.com>,
        Pratyush Anand <panand@redhat.com>, mka@chromium.org,
        kinaba@google.com, Douglas Anderson <dianders@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: hw_breakpoint: Handle inexact watchpoint addresses
Date:   Sat, 19 Oct 2019 11:12:26 -0700
Message-Id: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is commit fdfeff0f9e3d ("arm64: hw_breakpoint: Handle inexact
watchpoint addresses") but ported to arm32, which has the same
problem.

This problem was found by Android CTS tests, notably the
"watchpoint_imprecise" test [1].  I tested locally against a copycat
(simplified) version of the test though.

[1] https://android.googlesource.com/platform/bionic/+/master/tests/sys_ptrace_test.cpp

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/kernel/hw_breakpoint.c | 96 ++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 26 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index b0c195e3a06d..d394878409db 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -680,26 +680,62 @@ static void disable_single_step(struct perf_event *bp)
 	arch_install_hw_breakpoint(bp);
 }
 
+/*
+ * Arm32 hardware does not always report a watchpoint hit address that matches
+ * one of the watchpoints set. It can also report an address "near" the
+ * watchpoint if a single instruction access both watched and unwatched
+ * addresses. There is no straight-forward way, short of disassembling the
+ * offending instruction, to map that address back to the watchpoint. This
+ * function computes the distance of the memory access from the watchpoint as a
+ * heuristic for the likelyhood that a given access triggered the watchpoint.
+ *
+ * See this same function in the arm64 platform code, which has the same
+ * problem.
+ *
+ * The function returns the distance of the address from the bytes watched by
+ * the watchpoint. In case of an exact match, it returns 0.
+ */
+static u32 get_distance_from_watchpoint(unsigned long addr, u32 val,
+					struct arch_hw_breakpoint_ctrl *ctrl)
+{
+	u32 wp_low, wp_high;
+	u32 lens, lene;
+
+	lens = __ffs(ctrl->len);
+	lene = __fls(ctrl->len);
+
+	wp_low = val + lens;
+	wp_high = val + lene;
+	if (addr < wp_low)
+		return wp_low - addr;
+	else if (addr > wp_high)
+		return addr - wp_high;
+	else
+		return 0;
+}
+
 static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 			       struct pt_regs *regs)
 {
-	int i, access;
-	u32 val, ctrl_reg, alignment_mask;
+	int i, access, closest_match = 0;
+	u32 min_dist = -1, dist;
+	u32 val, ctrl_reg;
 	struct perf_event *wp, **slots;
 	struct arch_hw_breakpoint *info;
 	struct arch_hw_breakpoint_ctrl ctrl;
 
 	slots = this_cpu_ptr(wp_on_reg);
 
+	/*
+	 * Find all watchpoints that match the reported address. If no exact
+	 * match is found. Attribute the hit to the closest watchpoint.
+	 */
+	rcu_read_lock();
 	for (i = 0; i < core_num_wrps; ++i) {
-		rcu_read_lock();
-
 		wp = slots[i];
-
 		if (wp == NULL)
-			goto unlock;
+			continue;
 
-		info = counter_arch_bp(wp);
 		/*
 		 * The DFAR is an unknown value on debug architectures prior
 		 * to 7.1. Since we only allow a single watchpoint on these
@@ -708,33 +744,31 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		 */
 		if (debug_arch < ARM_DEBUG_ARCH_V7_1) {
 			BUG_ON(i > 0);
+			info = counter_arch_bp(wp);
 			info->trigger = wp->attr.bp_addr;
 		} else {
-			if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
-				alignment_mask = 0x7;
-			else
-				alignment_mask = 0x3;
-
-			/* Check if the watchpoint value matches. */
-			val = read_wb_reg(ARM_BASE_WVR + i);
-			if (val != (addr & ~alignment_mask))
-				goto unlock;
-
-			/* Possible match, check the byte address select. */
-			ctrl_reg = read_wb_reg(ARM_BASE_WCR + i);
-			decode_ctrl_reg(ctrl_reg, &ctrl);
-			if (!((1 << (addr & alignment_mask)) & ctrl.len))
-				goto unlock;
-
 			/* Check that the access type matches. */
 			if (debug_exception_updates_fsr()) {
 				access = (fsr & ARM_FSR_ACCESS_MASK) ?
 					  HW_BREAKPOINT_W : HW_BREAKPOINT_R;
 				if (!(access & hw_breakpoint_type(wp)))
-					goto unlock;
+					continue;
 			}
 
+			val = read_wb_reg(ARM_BASE_WVR + i);
+			ctrl_reg = read_wb_reg(ARM_BASE_WCR + i);
+			decode_ctrl_reg(ctrl_reg, &ctrl);
+			dist = get_distance_from_watchpoint(addr, val, &ctrl);
+			if (dist < min_dist) {
+				min_dist = dist;
+				closest_match = i;
+			}
+			/* Is this an exact match? */
+			if (dist != 0)
+				continue;
+
 			/* We have a winner. */
+			info = counter_arch_bp(wp);
 			info->trigger = addr;
 		}
 
@@ -748,10 +782,20 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		 */
 		if (is_default_overflow_handler(wp))
 			enable_single_step(wp, instruction_pointer(regs));
+	}
 
-unlock:
-		rcu_read_unlock();
+	if (min_dist > 0 && min_dist != -1) {
+		/* No exact match found. */
+		wp = slots[closest_match];
+		info = counter_arch_bp(wp);
+		info->trigger = addr;
+		pr_debug("watchpoint fired: address = 0x%x\n", info->trigger);
+		perf_bp_event(wp, regs);
+		if (is_default_overflow_handler(wp))
+			enable_single_step(wp, instruction_pointer(regs));
 	}
+
+	rcu_read_unlock();
 }
 
 static void watchpoint_single_step_handler(unsigned long pc)
-- 
2.23.0.866.gb869b98d4c-goog

