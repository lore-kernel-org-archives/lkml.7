Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E79C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9292420828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014115;
	bh=qoWIB+0WSAHa/3SwzS6I1z52KR/Wh/ZPFYeXYzN9PqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sqFe+aurQ+elPlyZJi+K7qqS4UjHJ/tX/Z5LSb0m48K/N0yWVBQSp1WZxa77/lVve
	 LnfmNJSLHvy/KsilJ8HrgcioD6OBBvzwTXNmS7jwGFNVBA6j/9+BCUh2vSyAtc7WIL
	 H7/f3dkN9HWUlMGNkU2/4Ij/KylUKHEMe+Aw9WeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfLJVly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:41:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729947AbfLJVeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:34:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 758592465C;
        Tue, 10 Dec 2019 21:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013649;
        bh=qoWIB+0WSAHa/3SwzS6I1z52KR/Wh/ZPFYeXYzN9PqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLL1mPeBAoXoI926gXMbkYvbOWv2jUF5xsLpodLPJ0MlveYWb58Fl6BEAljXq4ay6
         9Eduj++BiYLMcnNYlPWOvbpAeWyHoBwj5oAtVWLB/yvrMVOyo+D1cnbNKYD4i0bsgJ
         Knqyk+e+w3iU49kGUs9r7c5phhsNl+p0M+mBdNws=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 088/177] s390/time: ensure get_clock_monotonic() returns monotonic values
Date:   Tue, 10 Dec 2019 16:30:52 -0500
Message-Id: <20191210213221.11921-88-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit 011620688a71f2f1fe9901dbc2479a7c01053196 ]

The current implementation of get_clock_monotonic() leaves it up to
the caller to call the function with preemption disabled. The only
core kernel caller (sched_clock) however does not disable preemption.

In order to make sure that all callers of this function see monotonic
values handle disabling preemption within the function itself.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/timex.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 64539c221672b..0f12a3f912820 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -10,8 +10,9 @@
 #ifndef _ASM_S390_TIMEX_H
 #define _ASM_S390_TIMEX_H
 
-#include <asm/lowcore.h>
+#include <linux/preempt.h>
 #include <linux/time64.h>
+#include <asm/lowcore.h>
 
 /* The value of the TOD clock for 1.1.1970. */
 #define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
@@ -186,15 +187,18 @@ extern unsigned char tod_clock_base[16] __aligned(8);
 /**
  * get_clock_monotonic - returns current time in clock rate units
  *
- * The caller must ensure that preemption is disabled.
  * The clock and tod_clock_base get changed via stop_machine.
- * Therefore preemption must be disabled when calling this
- * function, otherwise the returned value is not guaranteed to
- * be monotonic.
+ * Therefore preemption must be disabled, otherwise the returned
+ * value is not guaranteed to be monotonic.
  */
 static inline unsigned long long get_tod_clock_monotonic(void)
 {
-	return get_tod_clock() - *(unsigned long long *) &tod_clock_base[1];
+	unsigned long long tod;
+
+	preempt_disable();
+	tod = get_tod_clock() - *(unsigned long long *) &tod_clock_base[1];
+	preempt_enable();
+	return tod;
 }
 
 /**
-- 
2.20.1

