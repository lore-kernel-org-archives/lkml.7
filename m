Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0CAC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BE521E6B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="h2ul/eMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfGVIoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:44:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfGVIn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:43:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8hr5X3745124
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:43:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8hr5X3745124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563785034;
        bh=CS1azoszph5hEAVXSC7iyTdwY2pVw8kAHb+rJAfhovw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=h2ul/eMbOwgT/QTtyeMCLgQGyEZLBPLI793O2tLGn7dr13QZw/ZaT7oBLCSjc821C
         9rJPxtLs4UDzR1r65XeF3b9mdJ4YA5fsxqLxiwA3WLJVZUV9EftDLJQL6Ou/lV9gqJ
         YHricN8LAjqt1OT1t52BCRzPh/b3hftnnSIxsANhGRhCeYS0EQsQBT+cuPgUuGlcxE
         Nf12Oi6bQoi14+keG6ZFR7RJFoCD9S4zzRUG73JYHR2GaNY0WZPa3cXlVw22JeoO25
         wyFebkHQHj3zs9+cxmeVKlxHxa1gHcEiXV3RLAJI0OXvtvEZmhK7PlY7RE6r8yv5Ol
         nrqx6gtsiwHAA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8hqN23745120;
        Mon, 22 Jul 2019 01:43:52 -0700
Date:   Mon, 22 Jul 2019 01:43:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Gayatri Kammela <tipbot@zytor.com>
Message-ID: <tip-018ebca8bd704f18d56f8fff38e2c3d76d7d39fb@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, gayatri.kammela@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          gayatri.kammela@intel.com, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190717234632.32673-3-gayatri.kammela@intel.com>
References: <20190717234632.32673-3-gayatri.kammela@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpufeatures: Enable a new AVX512 CPU feature
Git-Commit-ID: 018ebca8bd704f18d56f8fff38e2c3d76d7d39fb
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

Commit-ID:  018ebca8bd704f18d56f8fff38e2c3d76d7d39fb
Gitweb:     https://git.kernel.org/tip/018ebca8bd704f18d56f8fff38e2c3d76d7d39fb
Author:     Gayatri Kammela <gayatri.kammela@intel.com>
AuthorDate: Wed, 17 Jul 2019 16:46:32 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:38:25 +0200

x86/cpufeatures: Enable a new AVX512 CPU feature

Add a new AVX512 instruction group/feature for enumeration in
/proc/cpuinfo: AVX512_VP2INTERSECT.

CPUID.(EAX=7,ECX=0):EDX[bit 8]  AVX512_VP2INTERSECT

Detailed information of CPUID bits for this feature can be found in
the Intel Architecture Intsruction Set Extensions Programming Reference
document (refer to Table 1-2). A copy of this document is available at
https://bugzilla.kernel.org/show_bug.cgi?id=204215.

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190717234632.32673-3-gayatri.kammela@intel.com

---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 998c2cc08363..56f53bf3bbbf 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -353,6 +353,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 630a9f77fb6b..3cbe24ca80ab 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -64,6 +64,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_4VNNIW,		X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_4FMAPS,		X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_VPOPCNTDQ,		X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_AVX512_VP2INTERSECT,	X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_CQM_OCCUP_LLC,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
