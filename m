Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98007C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680802171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yybSd720"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfB1M1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:27:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35698 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731300AbfB1M1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:27:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so21748704wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7ih+SAWN2J6Z2DTnoiDcjijOHCsTs+vEB5wC/EgIIos=;
        b=yybSd7203embm0NYsxNwm95uzUGP+CtRXYUpVnrMV6voOiY0xfoVISdxp0yynAcVRu
         fU8UD2J9H9uI8m9klpBCGZeuPKToibFTit6Ls+IqvKCb8jcD5aog+tR08vxrABM+yuoU
         alVSOh33ZYgI4kcRsijx0VcuUUh4gD3ooInN9ourrBZgcUBSPNIas/0IhpyXlMsSawjc
         QhO8bpQluxVBmpPmWJU56c0r0samQcP0PpnsPeCmiNT+cNuijKMi8mvZKhCFEWCMSbT0
         mjWaz8mvy05xGERmuwrFCmiAY0ZHAWi7Cma1D2QSbi9YQsRaszDiKRPQCkNhnTvHJffW
         ohGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7ih+SAWN2J6Z2DTnoiDcjijOHCsTs+vEB5wC/EgIIos=;
        b=kClQrzTh8RNlS1a9CZQLOaCmyJH0PP6pQ+c3FY8MH6wWVTAtV/Rj4JuT5U0e9iW68z
         QIjWBw+pwsfzbeZMjY8bcni2AcjrEbiL3v50zVUD2KSkZlVlaw1q4+uKqmCNthX5M92a
         3wpTRZZV0nCq9DV0lmT3NVWPgrCzg04Ytok839dNxMuP2awVskhw0JpCPxCsA5ct4JwJ
         KCGaff6TcXhMMotQbJolqyK7EElGx8Fk9s9IIhClID73Jk6wDTMR+UMN7M4hwkAbtjrB
         rt5FXcizyPIJDOuTqhYgmd3ZEYbO3e9WR/FsPgSwXOl8nFPAv58Lig9GWPfBYx8V3iBC
         85XQ==
X-Gm-Message-State: APjAAAV/zIK1MiXraHsn2RLrTHNXQEewAXFzn8YRz9ldhEyaKnQ94+I0
        04L2KPstOGCO6gUBdlQ87SVZ7wbvy8Q=
X-Google-Smtp-Source: APXvYqwujA7oAdE6q3TmNimn7Z4qELztQdvrFMN03TllecrimoBEVCMihZBIz1SK8eRmXXa3uY9B8w==
X-Received: by 2002:a5d:4412:: with SMTP id z18mr6125270wrq.111.1551356834053;
        Thu, 28 Feb 2019 04:27:14 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id d206sm7905080wmc.11.2019.02.28.04.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:27:13 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 13/24] drivers: thermal: tsens: Track IP version
Date:   Thu, 28 Feb 2019 17:51:03 +0530
Message-Id: <4a91bf86d985129397312c25dec1f1f559c1ab53.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version information is available on some TSENS IP. Allow reading it by
allocating memory for the regmap_field.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index aae3d71d7eed..8d632de2c7f8 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -155,6 +155,16 @@ int __init init_common(struct tsens_priv *priv)
 	if (IS_ERR(priv->tm_map))
 		return PTR_ERR(priv->tm_map);
 
+	/* alloc regmap_fields in srot_map */
+	if (priv->feat->ver_info) {
+		for (i = 0, j = VER_MAJOR; i < 2; i++, j++) {
+			priv->rf[j] = devm_regmap_field_alloc(dev, priv->srot_map,
+							      priv->fields[j]);
+			if (IS_ERR(priv->rf[j]))
+				return PTR_ERR(priv->rf[j]);
+		}
+	}
+
 	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						     priv->fields[TSENS_EN]);
 	if (IS_ERR(priv->rf[TSENS_EN]))
-- 
2.17.1

