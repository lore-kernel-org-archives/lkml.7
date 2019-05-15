Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE556C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E62220675
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922504;
	bh=9sZHOoo7sRNA+1UkLGRPCFjmCMP9jWigUjeOILBXPb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pje6z9KQmoRZrsiF8HKrRNFpIDWx4x+BRRjLNEohZjRGcfD9wBORo9Fr216Gp9yyf
	 Qdy1XqbIwuSN0y3Liai76zY50VhVB573/QVnOaSKWRamtk2lm3NCLRdpjT2iua17e4
	 mBiOco1v3NnqbYsvWCIoNLyosI0b0bFSOlZFkGsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfEOLD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbfEOLDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:03:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7771F20881;
        Wed, 15 May 2019 11:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918232;
        bh=9sZHOoo7sRNA+1UkLGRPCFjmCMP9jWigUjeOILBXPb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qM5ouuEHRqhFsATZYPhzVodImZdguSm/8iumydgSVS08lLsPsZoQOPc1TgFZIy9PH
         I3uWyC+ZcSBR8LbbRDooUNqo6BrvGgNgJI5zRO68yRA2xGndzAM/N4bVOkhGw4+plS
         IYoEGjYeyb9yZ2r0eVzNrDEF1J9sBC9rh/p4pJ9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 054/266] powerpc/pseries: Query hypervisor for count cache flush settings
Date:   Wed, 15 May 2019 12:52:41 +0200
Message-Id: <20190515090724.272291792@linuxfoundation.org>
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
@@ -295,10 +295,12 @@
 #define H_CPU_CHAR_BRANCH_HINTS_HONORED	(1ull << 58) // IBM bit 5
 #define H_CPU_CHAR_THREAD_RECONFIG_CTRL	(1ull << 57) // IBM bit 6
 #define H_CPU_CHAR_COUNT_CACHE_DISABLED	(1ull << 56) // IBM bit 7
+#define H_CPU_CHAR_BCCTR_FLUSH_ASSIST	(1ull << 54) // IBM bit 9
 
 #define H_CPU_BEHAV_FAVOUR_SECURITY	(1ull << 63) // IBM bit 0
 #define H_CPU_BEHAV_L1D_FLUSH_PR	(1ull << 62) // IBM bit 1
 #define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ull << 61) // IBM bit 2
+#define H_CPU_BEHAV_FLUSH_COUNT_CACHE	(1ull << 58) // IBM bit 5
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -524,6 +524,12 @@ static void init_cpu_char_feature_flags(
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
@@ -574,6 +580,7 @@ void pseries_setup_rfi_flush(void)
 		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
 
 	setup_rfi_flush(types, enable);
+	setup_count_cache_flush();
 }
 
 static void __init pSeries_setup_arch(void)


