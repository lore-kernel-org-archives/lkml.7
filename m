Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC409C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878AE2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141329;
	bh=EXPwvG1/DGUUIe8hO9rA7NJxurXZkDEN7lRszkkCclk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c6GiKcRsUMTI2Br82JosIf8tGcwUTpMKGORvQPwCfVNeFtPHVQ7W+T0cAEPHBsz05
	 Xbu6vIilIQZrtRzUZxZ3nKIMysaC9oq3twJG4kX/8SOp7VcDNtc5odZVu4x+yP5cE9
	 tV92Nv+N5/zidRR4NIbadu2U9WV7elRiF1wLdN/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbfDARz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731424AbfDARXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:23:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC52206C0;
        Mon,  1 Apr 2019 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139381;
        bh=EXPwvG1/DGUUIe8hO9rA7NJxurXZkDEN7lRszkkCclk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zv+VI6VFEeexuayXcooGl1FoAcinQ8022y2AUqN/6w3iKj+1g/LkBKaTtlnOZDoo6
         rBaYb8nbEuphljkOLh5I6mZvhYB5Km/t6kZSutJYYrpONjaAuiAUcYMtPhZXAPZhkO
         7eraHoCtmYGWB64aQPxImNwZcUIWYcuPcqq2UAb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 042/107] powerpc/powernv: Query firmware for count cache flush settings
Date:   Mon,  1 Apr 2019 19:01:57 +0200
Message-Id: <20190401170049.452794815@linuxfoundation.org>
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

commit 99d54754d3d5f896a8f616b0b6520662bc99d66b upstream.

Look for fw-features properties to determine the appropriate settings
for the count cache flush, and then call the generic powerpc code to
set it up based on the security feature flags.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/setup.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -77,6 +77,12 @@ static void init_fw_feat_flags(struct de
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


