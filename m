Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E0AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33FA20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R9/XG+Xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfEHHdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:33:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36607 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfEHHdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:33:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so418293pgb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYFoR4O/xJAOVdtzf1KO84jqKZdhkztW34riW/9p2p8=;
        b=R9/XG+XeN3PX0hPVPayizUpipfNj3Nty3nKih/eJLptpZmg0sKXL/78jJxpaObgd4F
         gn31yG/jV8baGAHB2a71oLwUehdb5yWcz53evRbE3koaBHGOpYv3IYon7P8OT+kqhsBi
         YwJBUX6kOHsrqeLts1KKXgIQaJksLkTxDe6lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYFoR4O/xJAOVdtzf1KO84jqKZdhkztW34riW/9p2p8=;
        b=BBmCs9qejVhmRyxcJRD96XWGXrwv7ptTyXiK/r79VlJ6dT7HErsm+2+SpzvQl28vd+
         R/8dUahZCHj56I66vyp59xdCOdYy7XQdOwXCwe2m5Yq+ybbDOJB4n8dxIGnZvgb+6U89
         RPsZHsEBZzDu4JsojOZXS1G5RaKcYmc9ncwOaSm7rVkV00EN/HdVgi9IUK1U5a9vyP4X
         /xVGIAxRZnVVNyh2QcJHmJyKIL9gHYDCubLlaz2zJSffSEJ72HyVcGADS6tno7TUW6nU
         7EtX4+Vea3mNAesd0Lr1CqEYx5Dse7MhcSbpS4m7ED6xTeEQAUni7GRssZXW1ZkP/Lgs
         hJQw==
X-Gm-Message-State: APjAAAVgE8aqiG/lvNBo72KMp0GxaO9QB+MmStUJh0wson0ky1+1jQ6g
        zFfS0zLNfs5F/c9HKTehHKXDfg==
X-Google-Smtp-Source: APXvYqwYR+C8pIy/mW/ntjAU5hcB/QYRY8s1HZ9+YEZj2WlaNk6OmhMsHTxoUDB0Wpphy383/FAE0g==
X-Received: by 2002:aa7:980e:: with SMTP id e14mr46827749pfl.142.1557300819483;
        Wed, 08 May 2019 00:33:39 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id n26sm29539047pfi.165.2019.05.08.00.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 00:33:38 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>, evgreen@chromium.org,
        swboyd@chromium.org
Subject: [PATCH v2 1/2] pinctrl: mediatek: Add pm_ops to pinctrl-paris
Date:   Wed,  8 May 2019 15:33:30 +0800
Message-Id: <20190508073331.27475-2-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190508073331.27475-1-drinkcat@chromium.org>
References: <20190508073331.27475-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pinctrl variants that include pinctrl-paris.h (and not
pinctrl-mtk-common.h) also need to use pm_ops to setup
wake mask properly, so copy over the pm_ops from common
to paris variant.

It is not easy to merge the 2 copies (or move
mtk_eint_suspend/resume to mtk-eint.c), as we need to
dereference pctrl->eint, and struct mtk_pinctrl *pctl has a
different structure definition for v1 and v2 (which is
what paris variant uses).

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 19 +++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-paris.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index d3b34e9a7507ec6..923264d0e9ef2c5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -926,3 +926,22 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 
 	return 0;
 }
+
+static int mtk_paris_pinctrl_suspend(struct device *device)
+{
+	struct mtk_pinctrl *pctl = dev_get_drvdata(device);
+
+	return mtk_eint_do_suspend(pctl->eint);
+}
+
+static int mtk_paris_pinctrl_resume(struct device *device)
+{
+	struct mtk_pinctrl *pctl = dev_get_drvdata(device);
+
+	return mtk_eint_do_resume(pctl->eint);
+}
+
+const struct dev_pm_ops mtk_paris_pinctrl_pm_ops = {
+	.suspend_noirq = mtk_paris_pinctrl_suspend,
+	.resume_noirq = mtk_paris_pinctrl_resume,
+};
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.h b/drivers/pinctrl/mediatek/pinctrl-paris.h
index 37146caa667d8c8..3d43771074e6de0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.h
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.h
@@ -60,4 +60,6 @@
 int mtk_paris_pinctrl_probe(struct platform_device *pdev,
 			    const struct mtk_pin_soc *soc);
 
+extern const struct dev_pm_ops mtk_paris_pinctrl_pm_ops;
+
 #endif /* __PINCTRL_PARIS_H */
-- 
2.21.0.1020.gf2820cf01a-goog

