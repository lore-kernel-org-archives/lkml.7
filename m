Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732C6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4362D20873
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210691;
	bh=wvwR0NhNnoQB47Ji28buIEL2m27xAvBrs6GV1oWgXy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0aeLdIvYMlLkwmORniEePT3s8eG5AuR0G/etoZc7yfZ0FULgpK3GpM0CBavjVLbcD
	 471HN1IH5lHuGwh9E6UsWw7C7NjZ+5bPd/NXnUd6yn1mtDKtRmHUE10nbpj0x50NUi
	 liwx6s2Rp8GLm+xTitQfHBzzCAyol8j052EpRPN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfJ0VL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbfJ0VL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:11:27 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D29F2064A;
        Sun, 27 Oct 2019 21:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210686;
        bh=wvwR0NhNnoQB47Ji28buIEL2m27xAvBrs6GV1oWgXy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8MoZOYgd8Fsa+idIEFXa51Ed3kpmmYHjoul4zUou6r9eJIva+crWGsEvPZTi4QLz
         FbmCILJGPdwHanGKG37uByz38VnequSMqAybcnOHo/XDekb1OtVETSorFVNOzQdbxC
         CH2Fb42+nxXsRcw6mg+T3hKjj79CuEJX3leGbHnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 057/119] arm64: capabilities: Introduce weak features based on local CPU
Date:   Sun, 27 Oct 2019 22:00:34 +0100
Message-Id: <20191027203325.354084991@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 5c137714dd8cae464dbd5f028c07af149e6d09fc ]

Now that we have the flexibility of defining system features based
on individual CPUs, introduce CPU feature type that can be detected
on a local SCOPE and ignores the conflict on late CPUs. This is
applicable for ARM64_HAS_NO_HW_PREFETCH, where it is fine for
the system to have CPUs without hardware prefetch turning up
later. We only suffer a performance penalty, nothing fatal.

Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cpufeature.h |    8 ++++++++
 arch/arm64/kernel/cpufeature.c      |    2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -235,6 +235,14 @@ extern struct arm64_ftr_reg arm64_ftr_re
  */
 #define ARM64_CPUCAP_SYSTEM_FEATURE	\
 	(ARM64_CPUCAP_SCOPE_SYSTEM | ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
+/*
+ * CPU feature detected at boot time based on feature of one or more CPUs.
+ * All possible conflicts for a late CPU are ignored.
+ */
+#define ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE		\
+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
+	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	|	\
+	 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
 
 struct arm64_cpu_capabilities {
 	const char *desc;
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -959,7 +959,7 @@ static const struct arm64_cpu_capabiliti
 	{
 		.desc = "Software prefetching using PRFM",
 		.capability = ARM64_HAS_NO_HW_PREFETCH,
-		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
 		.matches = has_no_hw_prefetch,
 	},
 #ifdef CONFIG_ARM64_UAO


