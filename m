Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37564C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0B92082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfFRHkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:40:42 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2238 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRHkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:40:42 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75d08954ca60-767e3; Tue, 18 Jun 2019 15:39:57 +0800 (CST)
X-RM-TRANSID: 2ee75d08954ca60-767e3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65d08954cd03-60fee;
        Tue, 18 Jun 2019 15:39:57 +0800 (CST)
X-RM-TRANSID: 2ee65d08954cd03-60fee
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     jun.nie@linaro.org, shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Arm: zx: remove redundant dev_err message
Date:   Tue, 18 Jun 2019 15:39:01 +0800
Message-Id: <1560843541-11611-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 arch/arm/mach-zx/zx296702-pm-domain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
index 7a08bf9d..ac44ea8 100644
--- a/arch/arm/mach-zx/zx296702-pm-domain.c
+++ b/arch/arm/mach-zx/zx296702-pm-domain.c
@@ -169,10 +169,8 @@ static int zx296702_pd_probe(struct platform_device *pdev)
 	}
 
 	pcubase = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pcubase)) {
-		dev_err(&pdev->dev, "ioremap fail.\n");
+	if (IS_ERR(pcubase))
 		return -EIO;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(zx296702_pm_domains); ++i)
 		pm_genpd_init(zx296702_pm_domains[i], NULL, false);
-- 
1.9.1



