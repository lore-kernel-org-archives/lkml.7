Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053C520883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139356;
	bh=a19DV6B3xr8MLPS2LQHifZEvKQehcrVz7y4TPAYYeSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OGywCYPhOpz/Ro29w6Xoem0+z6dy0ggeu54EoDhvsbxWPBhHmAyfEuKn032OeQNWW
	 R9BgRSwdXO8h6R4DtMiZ8kBtb5VRoGAUSnmkAcWHG9STDdSn3HtvMP3p7XkMu1HW37
	 XlV7VS1Qmwc1YGhrGzFoBBZvK7KCD+lfZm2CRDH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbfDARWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731558AbfDARWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:22:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F261220883;
        Mon,  1 Apr 2019 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139344;
        bh=a19DV6B3xr8MLPS2LQHifZEvKQehcrVz7y4TPAYYeSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S418lrOc1cWxIoq/ZpSCP1beDvF10vx1eAlX/zvA7C+rcshSUuzpxxvTQ8vYsbIL6
         reyBn5qY2mewtN0GWlKaxUV5UKuHfryVa9mSlW5wlTC+8rgvsyobZ8haCqNLbub4Pl
         1Q0clJZfi33mzn8vJgnRG1InxioMIpMPHNeYMuS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 041/107] powerpc/pseries: Query hypervisor for count cache flush settings
Date:   Mon,  1 Apr 2019 19:01:56 +0200
Message-Id: <20190401170049.365466377@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit ba72dc171954b782a79d25e0f4b3ed91090c3b1e upstream.

Use the existing hypercall to determine the appropriate settings for
the count cache flush, and then call the generic powerpc code to set
it up based on the security feature flags.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/hvcall.h      |    2 ++
 arch/powerpc/platforms/pseries/setup.c |    7 +++++++
 2 files changed, 9 insertions(+)

--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -340,10 +340,12 @@
 #define H_CPU_CHAR_BRANCH_HINTS_HONORED	(1ull << 58) // IBM bit 5
 #define H_CPU_CHAR_THREAD_RECONFIG_CTRL	(1ull << 57) // IBM bit 6
 #define H_CPU_CHAR_COUNT_CACHE_DISABLED	(1ull << 56) // IBM bit 7
+#define H_CPU_CHAR_BCCTR_FLUSH_ASSIST	(1ull << 54) // IBM bit 9
 
 #define H_CPU_BEHAV_FAVOUR_SECURITY	(1ull << 63) // IBM bit 0
 #define H_CPU_BEHAV_L1D_FLUSH_PR	(1ull << 62) // IBM bit 1
 #define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ull << 61) // IBM bit 2
+#define H_CPU_BEHAV_FLUSH_COUNT_CACHE	(1ull << 58) // IBM bit 5
 
 /* Flag values used in H_REGISTER_PROC_TBL hcall */
 #define PROC_TABLE_OP_MASK	0x18
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -484,6 +484,12 @@ static void init_cpu_char_feature_flags(
 	if (result->character & H_CPU_CHAR_COUNT_CACHE_DISABLED)
 		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
 
+	if (result->character & H_CPU_CHAR_BCCTR_FLUSH_ASSIST)
+		security_ftr_set(SEC_FTR_BCCTR_FLUSH_ASSIST);
+
+	if (result->behaviour & H_CPU_BEHAV_FLUSH_COUNT_CACHE)
+		security_ftr_set(SEC_FTR_FLUSH_COUNT_CACHE);
+
 	/*
 	 * The features below are enabled by default, so we instead look to see
 	 * if firmware has *disabled* them, and clear them if so.
@@ -534,6 +540,7 @@ void pseries_setup_rfi_flush(void)
 		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
 
 	setup_rfi_flush(types, enable);
+	setup_count_cache_flush();
 }
 
 static void __init pSeries_setup_arch(void)


