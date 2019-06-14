Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA13FC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8122082C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eLvXe+Pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfFNLCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:02:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46311 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfFNLCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:02:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5EB1BBD1657710
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 04:01:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5EB1BBD1657710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560510072;
        bh=x0cXCmUFuM2h7v4oF2ZtrncWStikgbMTiu71XOS4KCw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eLvXe+PjFntEonx7xs74baoJa7HVrx1dGLqyal3ANKgyn2/J2v/vMNRb2IiVEcr+r
         KvXY0nDhi84Vm9kV3ln3UQBXGqU/rlIbZ7inqZWwWIDCHiCXU456nF0mYwOnWmT9t4
         YzdqUIj/DnCEc90EBawEoPDKmNEDBNNNccapbCLE0M5JjvpXXa5VBJ6WXA9HbZqYeL
         Wk5uZnrFyumkUEdjRm9dzFSwRVRprQ2E5OVxeY7/oBxgGJWGTVPlDcip8yrLmzWrf4
         u14y9jdK4S0yFs8H7Gz1yoyKtGy5gwb17/6mpsj21+d7vMpimXRW9ar7tcqlUDVAgf
         ZROyXR7JM4W4Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5EB1Ahp1657705;
        Fri, 14 Jun 2019 04:01:10 -0700
Date:   Fri, 14 Jun 2019 04:01:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Aaron Lewis <tipbot@zytor.com>
Message-ID: <tip-cbb99c0f588737ec98c333558922ce47e9a95827@git.kernel.org>
Cc:     frederic@kernel.org, mingo@redhat.com, bp@suse.de,
        jmattson@google.com, mingo@kernel.org, konrad.wilk@oracle.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas.Lendacky@amd.com, pfeiner@google.com, tglx@linutronix.de,
        hpa@zytor.com, aaronlewis@google.com, robert.hu@linux.intel.com,
        fenghua.yu@intel.com
Reply-To: aaronlewis@google.com, hpa@zytor.com, fenghua.yu@intel.com,
          robert.hu@linux.intel.com, Thomas.Lendacky@amd.com,
          tglx@linutronix.de, pfeiner@google.com, mingo@kernel.org,
          konrad.wilk@oracle.com, jmattson@google.com, bp@suse.de,
          linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
          frederic@kernel.org
In-Reply-To: <20190605220252.103406-1-aaronlewis@google.com>
References: <20190605220252.103406-1-aaronlewis@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpufeatures: Add FDP_EXCPTN_ONLY and ZERO_FCS_FDS
Git-Commit-ID: cbb99c0f588737ec98c333558922ce47e9a95827
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

Commit-ID:  cbb99c0f588737ec98c333558922ce47e9a95827
Gitweb:     https://git.kernel.org/tip/cbb99c0f588737ec98c333558922ce47e9a95827
Author:     Aaron Lewis <aaronlewis@google.com>
AuthorDate: Wed, 5 Jun 2019 15:02:52 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 14 Jun 2019 12:26:22 +0200

x86/cpufeatures: Add FDP_EXCPTN_ONLY and ZERO_FCS_FDS

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
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 75f27ee2c263..1017b9c7dfe0 100644
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
