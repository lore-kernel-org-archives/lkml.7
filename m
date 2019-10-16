Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AB6FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC3D218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263355;
	bh=HdPM/9FoLj8uItAc5KmRuQ+e5lvgdJjgzjajg0U+Q1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NvpXXvKoF8IAypHO8ff8W6vkOtcJiSqLypSJjfrTA4voNLGxI0xJ/zCXdx+RFkx7C
	 V4BtTGoF5uXByuy55NSZyVVM4/n1DI5Ur5jjLZO5aMWuagrKpYDCha+sWJtJe72j0m
	 5FVyIIt0zGkA8lQSmaxZaLqLNZyimBm9cJxXSeyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbfJPWCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438600AbfJPV7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:59:42 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3438D222BE;
        Wed, 16 Oct 2019 21:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263182;
        bh=HdPM/9FoLj8uItAc5KmRuQ+e5lvgdJjgzjajg0U+Q1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s6O2b8dem6S8ehLrOLrCQDZko2gP1gW/pDUFfwmzraaZwKh/sDr92zdzJLLiWVenA
         azdb4N5UwMqJ9NGLQyZJO5ddPyyF1TDWIS8j65eLCZ1xerKVO/5lu7GoIZTUtIjdYG
         rDFuiAngEEFN6LCs2H8jAiOk+XvdeMGeFi/+gnTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.3 109/112] x86/asm: Fix MWAITX C-state hint value
Date:   Wed, 16 Oct 2019 14:51:41 -0700
Message-Id: <20191016214907.369372961@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>

commit 454de1e7d970d6bc567686052329e4814842867c upstream.

As per "AMD64 Architecture Programmer's Manual Volume 3: General-Purpose
and System Instructions", MWAITX EAX[7:4]+1 specifies the optional hint
of the optimized C-state. For C0 state, EAX[7:4] should be set to 0xf.

Currently, a value of 0xf is set for EAX[3:0] instead of EAX[7:4]. Fix
this by changing MWAITX_DISABLE_CSTATES from 0xf to 0xf0.

This hasn't had any implications so far because setting reserved bits in
EAX is simply ignored by the CPU.

 [ bp: Fixup comment in delay_mwaitx() and massage. ]

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>
Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20191007190011.4859-1-Janakarajan.Natarajan@amd.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/mwait.h |    2 +-
 arch/x86/lib/delay.c         |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -21,7 +21,7 @@
 #define MWAIT_ECX_INTERRUPT_BREAK	0x1
 #define MWAITX_ECX_TIMER_ENABLE		BIT(1)
 #define MWAITX_MAX_LOOPS		((u32)-1)
-#define MWAITX_DISABLE_CSTATES		0xf
+#define MWAITX_DISABLE_CSTATES		0xf0
 
 static inline void __monitor(const void *eax, unsigned long ecx,
 			     unsigned long edx)
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -113,8 +113,8 @@ static void delay_mwaitx(unsigned long _
 		__monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
 
 		/*
-		 * AMD, like Intel, supports the EAX hint and EAX=0xf
-		 * means, do not enter any deep C-state and we use it
+		 * AMD, like Intel's MWAIT version, supports the EAX hint and
+		 * EAX=0xf0 means, do not enter any deep C-state and we use it
 		 * here in delay() to minimize wakeup latency.
 		 */
 		__mwaitx(MWAITX_DISABLE_CSTATES, delay, MWAITX_ECX_TIMER_ENABLE);


