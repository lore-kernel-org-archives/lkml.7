Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B91C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7E021707
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354977;
	bh=s1AmIjUuHttMtGumDw8a0cBTSEY0tPGQ3gjnVenLO6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=furyfVwlLVlNlDh3XRB/qrDO1k6ZQpwCHynPvKbeNziHWn98MbvOwRhtT2tj/yNeP
	 ZALfGRd3/8uNwCoEMMwF4/brxUTxfbA/WClPwjuKiP33GupPc7xWFiodF3kZR05eXC
	 8rXdbogQbFupTidPcNkVMdgTPB2pfMLDRmgQRAcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbfETMWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388504AbfETMWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:22:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F53220645;
        Mon, 20 May 2019 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354969;
        bh=s1AmIjUuHttMtGumDw8a0cBTSEY0tPGQ3gjnVenLO6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HkaxxxM1GmBhAr4XiAh+pGKs7OIx6y71HuD6iuQMjGy+LPpV9xa9iBtcvtA0awXQP
         XT2QbQdCG6j0fhbUXiQS3zv7n7Qt5mghwIu4219fT3aOQ+EVqkExgN+8vnHw1Jjk3e
         idcPLRHzbzqfhIZ+v0WwcJCpJRm259i0YujWVmTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.19 009/105] ARM: exynos: Fix a leaked reference by adding missing of_node_put
Date:   Mon, 20 May 2019 14:13:15 +0200
Message-Id: <20190520115247.693573799@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115247.060821231@linuxfoundation.org>
References: <20190520115247.060821231@linuxfoundation.org>
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
@@ -196,6 +196,7 @@ void __init exynos_firmware_init(void)
 		return;
 
 	addr = of_get_address(nd, 0, NULL, NULL);
+	of_node_put(nd);
 	if (!addr) {
 		pr_err("%s: No address specified.\n", __func__);
 		return;
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -639,8 +639,10 @@ void __init exynos_pm_init(void)
 
 	if (WARN_ON(!of_find_property(np, "interrupt-controller", NULL))) {
 		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
+		of_node_put(np);
 		return;
 	}
+	of_node_put(np);
 
 	pm_data = (const struct exynos_pm_data *) match->data;
 


