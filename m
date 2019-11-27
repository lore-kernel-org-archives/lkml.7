Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE151C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D782158A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888460;
	bh=ZD3H0fXdo26K8Pbl93wipiv94kNC0IMytMi0VTXQIIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a9AR6AT6u9OTh8ycgrrd9kBLEOZMKfA8xgAKcq/E2pl8fSOLQqo7EsXTyqK8pVFSp
	 SEJXQQJaqdK2+VGo8vvkG9kpGsahfvj40xJ1PVBdJjPLDXO7PGIwH0Ma+8ptqXM6NS
	 yLnKjGI2HYKiVnW7O62x7C90SHVjWHRGRSuLIUnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfK0VA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731342AbfK0VA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:00:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91394215B2;
        Wed, 27 Nov 2019 21:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888456;
        bh=ZD3H0fXdo26K8Pbl93wipiv94kNC0IMytMi0VTXQIIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SceNPP63+HVYP7KivwCRrmircUckduSb/UUw9BAzbAeuKQ/HwH1v5eDiycg1sDHSw
         56UiadNhmgVlXlY7/1qTFn3Amjfufnm3lv0wxcVgEKHHLH1r6xrMUSd6kz5AcWNu9z
         QP4DvhxXNydxWIM7v8LaWObY3yDCP7YVeEw+yf7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 139/306] thermal: rcar_thermal: fix duplicate IRQ request
Date:   Wed, 27 Nov 2019 21:29:49 +0100
Message-Id: <20191127203125.271605886@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[ Upstream commit df016bbba63743bbef9ff5c6c282561211dd72cc ]

The driver on R8A77995 requests the same IRQ twice since
platform_get_resource() is always called for the 1st IRQ resource.

Fixes: 1969d9dc2079 ("thermal: rcar_thermal: add r8a77995 support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/rcar_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8df2ce94c28d8..edaa4058686b7 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -493,7 +493,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	for (i = 0; i < chip->nirqs; i++) {
-		irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+		irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
 		if (!irq)
 			continue;
 		if (!common->base) {
-- 
2.20.1



