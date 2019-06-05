Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F2C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C25A206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uX9rhdUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFEWDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:03:13 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:52367 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEWDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:03:12 -0400
Received: by mail-qk1-f201.google.com with SMTP id v80so174928qkb.19
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iwmBhUa5WSXX0qIKsKTL2qaaeq1JQm6e9fhmm73gTh8=;
        b=uX9rhdUkU1DBI9Qoo16DYTrWJOEmFGmW7kbsetIHI1qK6ABs7PoUDd74754nqH2gNW
         eQYluT9dtCyZW3M9/y5R+6pNE5+ZtNNplxBfYw7cuDlAmWXc3LjDBXKl0Vh2x7n8y80C
         7VYXBJ/04X8yCeazZPGgyZ4osetvWLun1XtHXI0lxftxxc6d/k7RDcI7mBghZ3yBONBy
         9mmAbNa2AHYfJVjlhaxXYkZoGQjmtMR9fu7QZW5m/juFIXtO2l5Bb7C/69PgJrhF4idC
         zzcYx0+VWuZsG7pgBL6z1dGyKFoYYRbmt0VYtutS46tOb96b3aecbb6AM/qO31LB+Y0M
         z3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iwmBhUa5WSXX0qIKsKTL2qaaeq1JQm6e9fhmm73gTh8=;
        b=DKFjkBvUZuTOVK5VlrWnnh3qAbtxCtS83fH+ClCpeybH9WxtSQoHAWNH/k9KP0oaT6
         BAoyNL/BIGlYhvnV1Q8JfbSMFQNTLZ8BbURX5Oki9m2gHo8v7XqjV57tfuyNbL+gyjUh
         8CN40vfUEFXgLJF7ojJ7UiSOsyqfrc1axfnmN18uMyI5h+dPdWwpxIR6Yjf3bAeA9GVx
         /nPyrZ6LQ/EEE1h1ivYFnY1tHdGKcOMlzGghlhRfkL4Fr0/PbIkFXbOPB226FONurGnv
         3BGoCBb+NWrz4IO/1LLOKLUFiL8JjSq5g9zXCXNzgR5q3zVOKX5pnSv/CdIuPNbVUZCe
         OhOw==
X-Gm-Message-State: APjAAAVSaSdz5HG7dXWOkrqeBnEavYoJ40YFp4hvyl063xYFVxQesZxY
        wHYohgRgG7TcgXnrS/vxqvAGyS5y7hbUvGN9fuZJRsJL4WwcIhxGCh+Ax5V/9RqJ35WsV7CJLGK
        g+U8nSuI3cZGWPbpko9yexhKdTQyZtQe+Fwc4OKiCDNyM1PXl2CcuVDRPegyRFTUzPvqafucSKF
        Z1g2VP
X-Google-Smtp-Source: APXvYqxed3qPOdbyp33WpmWmd7NMV71bQ3G05MF2M+kx/HFq9gazvMlPyKJw/XVpvHNv0I/SBtEKyZP6U5mFC5zA
X-Received: by 2002:a0c:95b3:: with SMTP id s48mr18981747qvs.84.1559772191395;
 Wed, 05 Jun 2019 15:03:11 -0700 (PDT)
Date:   Wed,  5 Jun 2019 15:02:52 -0700
Message-Id: <20190605220252.103406-1-aaronlewis@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH] x86/cpufeature: Add negative features
From:   Aaron Lewis <aaronlewis@google.com>
To:     linux-kernel@vger.kernel.org, jmattson@google.com,
        pshier@google.com, marcorr@google.com
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CPUID enumeration for Intel's de-feature bits to accommodate
passing these de-features through to kvm guests.

These de-features are:
 - X86_FEATURE_FDP_EXCPTN_ONLY: If CPUID.(EAX=07H,ECX=0H):EBX[bit 6] = 1, the
   data pointer (FDP) is updated only for the x87 non-control instructions that
   incur unmasked x87 exceptions (from SDM vol 1, section 8.1.8).
 - X86_FEATURE_ZERO_FCS_FDS: If CPUID.(EAX=07H,ECX=0H):EBX[bit 13] = 1, the
   processor deprecates FCS and FDS; it saves each as 0000H (from SDM vol 1,
   section 8.1.8).

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Aaron Lewis <aaronlewis@google.com>
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
-- 
2.22.0.rc1.311.g5d7573a151-goog

