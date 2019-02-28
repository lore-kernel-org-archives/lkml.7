Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B259C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C4A218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366982;
	bh=K/d3FheziLK/V2zp+t1N3kyeIvkPghGLD/RSwmU7qNk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VKoeKniidKB1ayWlZclUPjwIIcwse/tmtZST1kHy7iLt1l6MnuoB1avKsWU0hDCdb
	 vCvB3tTAZKZ9HIhX3zr/00zRcAXJKbyxO+tHKJRT0Gwi6195hEg1HA5sm590V+z/4e
	 mceAwMY8tLu5deWs5IPBDRD2dnx0GNsdPAerrzFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389009AbfB1PQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:16:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388974AbfB1PQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:16:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B62220C01;
        Thu, 28 Feb 2019 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366975;
        bh=K/d3FheziLK/V2zp+t1N3kyeIvkPghGLD/RSwmU7qNk=;
        h=From:To:Cc:Subject:Date:From;
        b=B9G7PICdBlaqJ6/1w/o/rBG8s838FzI8GqF2k9w4Pnfri+dt76aGGVJw/VNSnR0Gt
         mT6KPK/Cn3qldG26kZWdkPLPANNVV7DoavxEhszIOvEKqqezVecTjgY+VkwlcxZBWM
         RKzGsUl9vLLutZZt+0flKru6/aBVODf6972tCB/o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Hao <peng.hao2@zte.com.cn>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 1/8] ARM: pxa: ssp: unneeded to free devm_ allocated data
Date:   Thu, 28 Feb 2019 10:16:05 -0500
Message-Id: <20190228151614.13022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>

[ Upstream commit ba16adeb346387eb2d1ada69003588be96f098fa ]

devm_ allocated data will be automatically freed. The free
of devm_ allocated data is invalid.

Fixes: 1c459de1e645 ("ARM: pxa: ssp: use devm_ functions")
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
[title's prefix changed]
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/plat-pxa/ssp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index daa1a65f2eb79..6748827c2ec8b 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -238,8 +238,6 @@ static int pxa_ssp_remove(struct platform_device *pdev)
 	if (ssp == NULL)
 		return -ENODEV;
 
-	iounmap(ssp->mmio_base);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
@@ -249,7 +247,6 @@ static int pxa_ssp_remove(struct platform_device *pdev)
 	list_del(&ssp->node);
 	mutex_unlock(&ssp_lock);
 
-	kfree(ssp);
 	return 0;
 }
 
-- 
2.19.1

