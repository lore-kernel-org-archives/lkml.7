Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF4ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B0321848
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211483;
	bh=eZoloxqdOk1QAe0B1QKXUmeKMwxEs0Risk93QpxCdxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gGxBALyyTn0YtJRUEIu7wxQCKYtATjQzTsqKyQGuirMBqAzJ9qVCdGopOlGV5Deu6
	 H10ZK8vmfYzaJ7qPT0Au3iyKP+k8+rIliyWFL9sl+al0prhgaFeHpBWRbXAGskUh55
	 dtG51Sq3ELEF2uI9j2Y+1tTyhI/S277PRKau6Q8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbfJ0VYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732551AbfJ0VYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:24:37 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46F7421726;
        Sun, 27 Oct 2019 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211476;
        bh=eZoloxqdOk1QAe0B1QKXUmeKMwxEs0Risk93QpxCdxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDDWs4cfB/oAxFCL1ivWbpOzN8ebQ6LbAhl9bqRqVbnALplVLmHJuEInjUkvvKPv+
         hskdKBBuZTnMczxjdkp9e9L2ehibEXX6ifMtsX9MqTsC7QMthKXrZUQ/MpZg6zXeBj
         wCk2TFuxyMx94nN+8WDyLeTj5QdVmwuHOHd6cdic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.3 164/197] arm64: Avoid Cavium TX2 erratum 219 when switching TTBR
Date:   Sun, 27 Oct 2019 22:01:22 +0100
Message-Id: <20191027203402.902355511@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

commit 9405447ef79bc93101373e130f72e9e6cbf17dbb upstream.

As a PRFM instruction racing against a TTBR update can have undesirable
effects on TX2, NOP-out such PRFM on cores that are affected by
the TX2-219 erratum.

Cc: <stable@vger.kernel.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/cpucaps.h |    3 ++-
 arch/arm64/kernel/cpu_errata.c   |    5 +++++
 arch/arm64/kernel/entry.S        |    2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -53,7 +53,8 @@
 #define ARM64_HAS_DCPODP			43
 #define ARM64_WORKAROUND_1463225		44
 #define ARM64_WORKAROUND_CAVIUM_TX2_219_TVM	45
+#define ARM64_WORKAROUND_CAVIUM_TX2_219_PRFM	46
 
-#define ARM64_NCAPS				46
+#define ARM64_NCAPS				47
 
 #endif /* __ASM_CPUCAPS_H */
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -851,6 +851,11 @@ const struct arm64_cpu_capabilities arm6
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.matches = has_cortex_a76_erratum_1463225,
 	},
+	{
+		.desc = "Cavium ThunderX2 erratum 219 (PRFM removal)",
+		.capability = ARM64_WORKAROUND_CAVIUM_TX2_219_PRFM,
+		ERRATA_MIDR_RANGE_LIST(tx2_family_cpus),
+	},
 #endif
 	{
 	}
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1070,7 +1070,9 @@ alternative_insn isb, nop, ARM64_WORKARO
 #else
 	ldr	x30, =vectors
 #endif
+alternative_if_not ARM64_WORKAROUND_CAVIUM_TX2_219_PRFM
 	prfm	plil1strm, [x30, #(1b - tramp_vectors)]
+alternative_else_nop_endif
 	msr	vbar_el1, x30
 	add	x30, x30, #(1b - tramp_vectors)
 	isb


