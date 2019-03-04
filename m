Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E89C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DD720663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kiJMJGxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCDKjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:39:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36140 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfCDKi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:38:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so4159997wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVuAZg4+nnaFhkjixBpLWEg1hgwoQXD2AQa4Piwf/Kk=;
        b=kiJMJGxn+O1rgglhFjxDpHzLiD6t0lxdtM+QbSFWRXex6U6ZCjDiJuixhpi8cqacdj
         yy5reYe9GyHYRM3tt2vjZMYWNsGeHlKeP3f/3CG4/jWLbBNgTQAgW8uwVSslfncuxkFq
         wX+3kuXvIvN5fFBFyOF+0s67RXuyh8UWHNuc1xK2WxNRJtDSHIv1M8qMWfRaMNL9IwWB
         f1pfZJZnazBIFnneJC2BRwofD1JRBCjzyNWjwGDoTQpVI5v1JNnocKeLFi3LAra4GDC6
         6PTsgspe9O67F3BjEvJv1U6i4mtU7nj/by59KqHwBCz+ojy5zSFlPHuRt90wexPPXho2
         FXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVuAZg4+nnaFhkjixBpLWEg1hgwoQXD2AQa4Piwf/Kk=;
        b=EnDKo90cb8hGkCyleaTp6l1OkE0wg49dWxRECbt8r+LaHjAFDG53EkoZ61iLLgLhI1
         zxWo1Nt0WZlEIJ6JXTxfPlnJULViYkTyhT/iqC62sGEbx51lDZ+pLT+rqdy6Xipojwyg
         rs3F4SlAweuUTRtugxjS8N5tD1WyPb2xRby3Ijk90esQhdUJC0kegZkbuLtE/vClwcTT
         pnBFyltwe59JeJB2jvnXc2JQ2BY9m4IkIlLGOM8vh2ibRJ/u4MCvUREjNbflderEeaKX
         szL6fp0xPzidzIxtdA4kGF6KGYG07GOmphu0xg0BNVrlVzMM8G/ouhGqUveLYbTsJjU8
         3nVA==
X-Gm-Message-State: APjAAAUQzuZhJ0q9sxYlvd0EXinhgVVOv/XRnJoy24HQijcxp7pl69IC
        t+wsTZZeXu0OxiGU8m5G+Z9wSg==
X-Google-Smtp-Source: APXvYqwCUU1Jrg5AzhTra9qP0/c+iULEuHGaC/nSSlbzT84OBH/i/BFlPTH8M4TvVZV/a5VVbYTM2A==
X-Received: by 2002:a1c:9ed5:: with SMTP id h204mr10124385wme.140.1551695937814;
        Mon, 04 Mar 2019 02:38:57 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g24sm5505676wmh.45.2019.03.04.02.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 02:38:56 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] usb: dwc2: Add Amlogic G12A DWC2 Params
Date:   Mon,  4 Mar 2019 11:38:45 +0100
Message-Id: <20190304103846.2060-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304103846.2060-1-narmstrong@baylibre.com>
References: <20190304103846.2060-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs sets the params for the DWC2 Controller found in the
Amlogic G12A SoC family.

It mainly sets the settings reported incorrect by the driver,
leaving the remaining detected automatically by the driver and
provided by the DT node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc2/params.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 24ff5f21cb25..442113246cba 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -121,6 +121,16 @@ static void dwc2_set_amlogic_params(struct dwc2_hsotg *hsotg)
 	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
 }
 
+static void dwc2_set_amlogic_g12a_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->lpm = false;
+	p->lpm_clock_gating = false;
+	p->besl = false;
+	p->hird_threshold_en = false;
+}
+
 static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
@@ -167,6 +177,8 @@ const struct of_device_id dwc2_of_match_table[] = {
 	  .data = dwc2_set_amlogic_params },
 	{ .compatible = "amlogic,meson-gxbb-usb",
 	  .data = dwc2_set_amlogic_params },
+	{ .compatible = "amlogic,meson-g12a-usb",
+	  .data = dwc2_set_amlogic_g12a_params },
 	{ .compatible = "amcc,dwc-otg", .data = dwc2_set_amcc_params },
 	{ .compatible = "st,stm32f4x9-fsotg",
 	  .data = dwc2_set_stm32f4x9_fsotg_params },
-- 
2.20.1

