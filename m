Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09ECCA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94245208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPcVFzqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfKBAQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:16:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45992 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfKBAQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:16:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id z4so2055482pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 17:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vwfNasNmk/zaE6boGrbx1PqkuEi6mq3j6Mt8dGLE6Ps=;
        b=EPcVFzqSL64s0YIj+h3PJq7y8bYRW20pfznj3BLHp+oQLsCu3Ta+Q7gXLFv4bwQ0w+
         hl2erg4NmbjRIS+aGigEMfaHHtBJW3JgeboPhNoQlrj2wFQ0EQ7/g8rwaxWbzge6K1CT
         ZH4cBy3Yc8PzgTHrPI2MHY2vk8cvgpFjyMLd59iAze207ykg0bFbbRVErSC/wKaQEmrn
         BVhgmbzSLluEpgOJyFg4wrRyVgj/FB9cJrjeajfNHqFTIZrSqHGOYi+XMfSGXiNYTlpo
         QpcwmubIccH28bOHvX+fUEee08/bNfwv1MPWtIWp7+7eQSBA8bSTycr4yA4cqGoulglR
         MoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwfNasNmk/zaE6boGrbx1PqkuEi6mq3j6Mt8dGLE6Ps=;
        b=dWDpj5wKltNUZa0eh61ryQnylfESEjHoN7puj/D4se+3bJY7Kg4p54+r9eBinP/tgd
         +v3ejHoN5eKDH85ubjsWMsWjEQ44oWKQRWZP1lphH8FHnFkfdCJsu3vEG8nsGbR4yybg
         B2YOBWi2nuT3+pSDknhYRDHJPdTLw2/YHgH2s6l3chuW3Tm4JTSpEz5w290rEq+UJFfk
         k+p+5TmMm7u8pSIFuUpwX7SbTGLvx8+i2dTmW3//8rYFyKSqNYAtORgVhB/rr9epdhtT
         BtEAL9y8OE510mYZh/LXyz0k8udlSJDxt24j8VSOnonCDAKo/mmCJnjkLRnLblUJqJ4G
         ia3g==
X-Gm-Message-State: APjAAAXXWfLJX3PxddkJ4D3UXO7fBExqcc9dXpGzSC4JtyRsWJX+MTE7
        5+eh+dIdWMGZPDpYXl+qEm7lIQ==
X-Google-Smtp-Source: APXvYqySSoNenfb7Gm7zScZPIqQugNGFW6uy/GggRVKYyC4nFsrgeNA8bJ/glcvhuN4MFJwUGGOp1w==
X-Received: by 2002:a17:90a:3ac8:: with SMTP id b66mr19246861pjc.9.1572653796381;
        Fri, 01 Nov 2019 17:16:36 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j11sm7876250pgk.3.2019.11.01.17.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 17:16:35 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] phy: qcom: qmp: Use power_on/off ops for PCIe
Date:   Fri,  1 Nov 2019 17:16:26 -0700
Message-Id: <20191102001628.4090861-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191102001628.4090861-1-bjorn.andersson@linaro.org>
References: <20191102001628.4090861-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe PHY initialization requires the attached device to be present,
which is primarily achieved by the PCI controller driver.  So move the
logic from init/exit to power_on/power_off.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- New patch

 drivers/phy/qualcomm/phy-qcom-qmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 66f91726b8b2..b9f849d86795 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1968,7 +1968,7 @@ static const struct phy_ops qcom_qmp_phy_gen_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static const struct phy_ops qcom_qmp_ufs_ops = {
+static const struct phy_ops qcom_qmp_pcie_ufs_ops = {
 	.power_on	= qcom_qmp_phy_enable,
 	.power_off	= qcom_qmp_phy_disable,
 	.set_mode	= qcom_qmp_phy_set_mode,
@@ -2068,8 +2068,8 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 		}
 	}
 
-	if (qmp->cfg->type == PHY_TYPE_UFS)
-		ops = &qcom_qmp_ufs_ops;
+	if (qmp->cfg->type == PHY_TYPE_UFS || qmp->cfg->type == PHY_TYPE_PCIE)
+		ops = &qcom_qmp_pcie_ufs_ops;
 
 	generic_phy = devm_phy_create(dev, np, ops);
 	if (IS_ERR(generic_phy)) {
-- 
2.23.0

