Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10E2C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7B72073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353996;
	bh=svgbZyd4KKPtAEu+HzB0yfh9kV61lpOF209ffXUf9Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zSjKQJawlR067622lejH6pYJm5UlwaqcCVoazHw5sxyJ+jpcVxpZFsmKIIwK5ufit
	 ev6abeSICiu42n+zwH4w+H17aSgUYS18yat2kmS2mJM4exzJ33EHqcAyrDj2VWtZTC
	 3HLJKzPhFw/22YtwzRsah4e3JGilSztClMsQ3tWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfDOSqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbfDOSqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C9492073F;
        Mon, 15 Apr 2019 18:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353992;
        bh=svgbZyd4KKPtAEu+HzB0yfh9kV61lpOF209ffXUf9Tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itTw4g2Bk+xQSb3eqJyqq3+HouVYYia5GqLrU6ybs1IuRsiOZUdZT66IBEtg9xolZ
         AlIRisyehBPSEmhQOkOejM7prO2Dg+HczWKfTwcvebsQ6grsgERa/uCAXxRcdTjOY9
         N3ZYw44Af5d8+kt4UNvRaJ5fFD0XNmEd8Y3mt3ZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 31/76] powerpc/powernv: Query firmware for count cache flush settings
Date:   Mon, 15 Apr 2019 20:43:55 +0200
Message-Id: <20190415183715.823452676@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 99d54754d3d5f896a8f616b0b6520662bc99d66b upstream.

Look for fw-features properties to determine the appropriate settings
for the count cache flush, and then call the generic powerpc code to
set it up based on the security feature flags.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/setup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 17203abf38e8..365e2b620201 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -77,6 +77,12 @@ static void init_fw_feat_flags(struct device_node *np)
 	if (fw_feature_is("enabled", "fw-count-cache-disabled", np))
 		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
 
+	if (fw_feature_is("enabled", "fw-count-cache-flush-bcctr2,0,0", np))
+		security_ftr_set(SEC_FTR_BCCTR_FLUSH_ASSIST);
+
+	if (fw_feature_is("enabled", "needs-count-cache-flush-on-context-switch", np))
+		security_ftr_set(SEC_FTR_FLUSH_COUNT_CACHE);
+
 	/*
 	 * The features below are enabled by default, so we instead look to see
 	 * if firmware has *disabled* them, and clear them if so.
@@ -123,6 +129,7 @@ static void pnv_setup_rfi_flush(void)
 		  security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV));
 
 	setup_rfi_flush(type, enable);
+	setup_count_cache_flush();
 }
 
 static void __init pnv_setup_arch(void)
-- 
2.19.1



