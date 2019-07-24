Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E573C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D985220665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998668;
	bh=H9u1xa7YsbUe3hWwnVKvACBm9t0wPTbDfkTZCV9QaKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gEGk7XNFbxq8+s29mPCPrN9MQFG/fYKBcrqmFU3PStbE8S6trNDOjAK8Xw3Weh3qT
	 wAvCxqda94YcfzCFN/icznhaQZ/Y0K8GPdBYueQzOr9gdJ00zWHwdB3vmoa7lVSCO7
	 XLe5GOPpj5Eal6oOb+YHyrJ0BtfJAeMyyWxHX1nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392522AbfGXUE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392481AbfGXUEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:04:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D428205C9;
        Wed, 24 Jul 2019 20:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998663;
        bh=H9u1xa7YsbUe3hWwnVKvACBm9t0wPTbDfkTZCV9QaKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asQD8dH1y+D/4VkCYe59OFf9Ha/qUpuQ3APtGYgILTkXGWomTo2tBRp1JqHNCnihL
         u8QcU2kZBdN8yoW2pyFiRODqBm0MF+m6MROCvAD2Qax43b4a8m4K6zJb2aRnGfFZD9
         1MZWZhzXmmmBkpQ3E6t5Muvmgg7QEb1t5s6IFmGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Lewis <aaronlewis@google.com>,
        Borislav Petkov <bp@suse.de>,
        Jim Mattson <jmattson@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        marcorr@google.com, Peter Feiner <pfeiner@google.com>,
        pshier@google.com, Robert Hoo <robert.hu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        x86-ml <x86@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/271] x86/cpufeatures: Add FDP_EXCPTN_ONLY and ZERO_FCS_FDS
Date:   Wed, 24 Jul 2019 21:18:59 +0200
Message-Id: <20190724191701.195708124@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cbb99c0f588737ec98c333558922ce47e9a95827 ]

Add the CPUID enumeration for Intel's de-feature bits to accommodate
passing these de-features through to kvm guests.

These de-features are (from SDM vol 1, section 8.1.8):
 - X86_FEATURE_FDP_EXCPTN_ONLY: If CPUID.(EAX=07H,ECX=0H):EBX[bit 6] = 1, the
   data pointer (FDP) is updated only for the x87 non-control instructions that
   incur unmasked x87 exceptions.
 - X86_FEATURE_ZERO_FCS_FDS: If CPUID.(EAX=07H,ECX=0H):EBX[bit 13] = 1, the
   processor deprecates FCS and FDS; it saves each as 0000H.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: marcorr@google.com
Cc: Peter Feiner <pfeiner@google.com>
Cc: pshier@google.com
Cc: Robert Hoo <robert.hu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190605220252.103406-1-aaronlewis@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 69037da75ea0..0cf704933f23 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -239,12 +239,14 @@
 #define X86_FEATURE_BMI1		( 9*32+ 3) /* 1st group bit manipulation extensions */
 #define X86_FEATURE_HLE			( 9*32+ 4) /* Hardware Lock Elision */
 #define X86_FEATURE_AVX2		( 9*32+ 5) /* AVX2 instructions */
+#define X86_FEATURE_FDP_EXCPTN_ONLY	( 9*32+ 6) /* "" FPU data pointer updated only on x87 exceptions */
 #define X86_FEATURE_SMEP		( 9*32+ 7) /* Supervisor Mode Execution Protection */
 #define X86_FEATURE_BMI2		( 9*32+ 8) /* 2nd group bit manipulation extensions */
 #define X86_FEATURE_ERMS		( 9*32+ 9) /* Enhanced REP MOVSB/STOSB instructions */
 #define X86_FEATURE_INVPCID		( 9*32+10) /* Invalidate Processor Context ID */
 #define X86_FEATURE_RTM			( 9*32+11) /* Restricted Transactional Memory */
 #define X86_FEATURE_CQM			( 9*32+12) /* Cache QoS Monitoring */
+#define X86_FEATURE_ZERO_FCS_FDS	( 9*32+13) /* "" Zero out FPU CS and FPU DS */
 #define X86_FEATURE_MPX			( 9*32+14) /* Memory Protection Extension */
 #define X86_FEATURE_RDT_A		( 9*32+15) /* Resource Director Technology Allocation */
 #define X86_FEATURE_AVX512F		( 9*32+16) /* AVX-512 Foundation */
-- 
2.20.1



