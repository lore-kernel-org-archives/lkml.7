Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AB0C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2638620657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922016;
	bh=JRiFLGUDlOHBiYVdynxL8b5VOINOVKM0yrdxUPsmGjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bJfJD3CyFGqZSRUAl/mQTCqbPfthkJLhcMnat9wFMErVy6VcNx/0hmJjoO3affmL4
	 qqw8u4+2s/XiBnsTU8o3U7MyD3H389I31RrCqiVvNDVYVLEnfV1Kwk3q71pfLTFpx9
	 ppee6etVBS9F2TyulS5jw8TdiF+fmYi2gkXBGoFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfEOLJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfEOLJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:09:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 928A721473;
        Wed, 15 May 2019 11:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918582;
        bh=JRiFLGUDlOHBiYVdynxL8b5VOINOVKM0yrdxUPsmGjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19jrQTD3+oly45DCQNOzRfFp8cEvAOOs/6SiHewaVTIzVqBr6EaCnirYzaRWsltQs
         tK95hQcUbt6WP2Ea8FSY7pPQUACuW+hBtknxvYNVPYyc9UMLYZE6jdyvfSKlo3/E6y
         sNhFaC7CeaFXji+SUrNLpOcND7T8Oc/EcAZyg/1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        kvm@vger.kernel.org, andrew.cooper3@citrix.com,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 187/266] x86/bugs: Add AMDs variant of SSB_NO
Date:   Wed, 15 May 2019 12:54:54 +0200
Message-Id: <20190515090729.256903616@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 24809860012e0130fbafe536709e08a22b3e959e upstream.

The AMD document outlining the SSBD handling
124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
mentions that the CPUID 8000_0008.EBX[26] will mean that the
speculative store bypass disable is no longer needed.

A copy of this document is available at:
    https://bugzilla.kernel.org/show_bug.cgi?id=199889

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: kvm@vger.kernel.org
Cc: andrew.cooper3@citrix.com
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180601145921.9500-2-konrad.wilk@oracle.com
[bwh: Backported to 4.4: adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/kernel/cpu/common.c       |    3 ++-
 arch/x86/kvm/cpuid.c               |    2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -270,6 +270,7 @@
 #define X86_FEATURE_AMD_IBRS	(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP	(13*32+15) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_VIRT_SSBD	(13*32+25) /* Virtualized Speculative Store Bypass Disable */
+#define X86_FEATURE_AMD_SSB_NO	(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (eax), word 14 */
 #define X86_FEATURE_DTHERM	(14*32+ 0) /* Digital Thermal Sensor */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -904,7 +904,8 @@ static void __init cpu_set_bug_bits(stru
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
 
 	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
-	   !(ia32_cap & ARCH_CAP_SSB_NO))
+	   !(ia32_cap & ARCH_CAP_SSB_NO) &&
+	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
 	if (ia32_cap & ARCH_CAP_IBRS_ALL)
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -343,7 +343,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(AMD_IBPB) | F(AMD_IBRS) | F(VIRT_SSBD);
+		F(AMD_IBPB) | F(AMD_IBRS) | F(VIRT_SSBD) | F(AMD_SSB_NO);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_supported_word5_x86_features =


