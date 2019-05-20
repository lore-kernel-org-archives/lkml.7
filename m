Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E57C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAE2216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354711;
	bh=fVRF+z9eHZvFLa3JaWu/hPJmz6sXeV2/0oh0lbOT2OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UKLZRmoghNrQ7yyUSNvju+wigEauzsCj45Nb9DaM9hkHipR9HfC6aoY/mvtEfyPZ8
	 BLB8P33fqFQ/ZPvmpAJkIx59xjvOAb5kt+bC5lE5ofS0RtnvgLfxRZS7U0nyKw4bb4
	 iVZxpVByRg+LlTEMiXVKvo/vbh5xT7oRe9FXGZG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbfETMSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733232AbfETMSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:18:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6232214AE;
        Mon, 20 May 2019 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354703;
        bh=fVRF+z9eHZvFLa3JaWu/hPJmz6sXeV2/0oh0lbOT2OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2keHMWxTwTpkFUE6EZxA+mTakniZF/Uq1PCOFZ+nYUaMHKwfmfzIlVz4oKJJHNbr
         e+n38Qc5ZX2sX0BQ5T7WhRF3m8rgmQoKHj/tr65ij9r/9wemiLOHtYO2MiGn2UaDYh
         50+GiUw3xNqpTfVgD52qasZQS5AWvlqg1mAkqjX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.14 11/63] ARM: exynos: Fix a leaked reference by adding missing of_node_put
Date:   Mon, 20 May 2019 14:13:50 +0200
Message-Id: <20190520115232.460580977@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
References: <20190520115231.137981521@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

commit 629266bf7229cd6a550075f5961f95607b823b59 upstream.

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with warnings like:
    arch/arm/mach-exynos/firmware.c:201:2-8: ERROR: missing of_node_put;
        acquired a node pointer with refcount incremented on line 193,
        but without a corresponding object release within this function.

Cc: stable@vger.kernel.org
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-exynos/firmware.c |    1 +
 arch/arm/mach-exynos/suspend.c  |    2 ++
 2 files changed, 3 insertions(+)

--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -205,6 +205,7 @@ void __init exynos_firmware_init(void)
 		return;
 
 	addr = of_get_address(nd, 0, NULL, NULL);
+	of_node_put(nd);
 	if (!addr) {
 		pr_err("%s: No address specified.\n", __func__);
 		return;
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -649,8 +649,10 @@ void __init exynos_pm_init(void)
 
 	if (WARN_ON(!of_find_property(np, "interrupt-controller", NULL))) {
 		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
+		of_node_put(np);
 		return;
 	}
+	of_node_put(np);
 
 	pm_data = (const struct exynos_pm_data *) match->data;
 


