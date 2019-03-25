Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2A2C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F283B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GT8Z5s7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfCYJkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:40:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33082 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbfCYJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:40:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so9281447wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouVo67fVk3QedxIRwGF/kjxfvmda4Yy6wL8QXTMaaKc=;
        b=GT8Z5s7lYBa1EBeX52auKvVxftdxxS7Kzyd4hkYTjL56/7CQuuuHB2U850cnZeGNZE
         b7+M+5kkVYc0xc3mXM+bxSik2EcJ/fcpX9TQfgX6S29zc4VdN9q1CulG0TlDrYGe2sP0
         y7FQIyL2jHmPwUCH1tlFAU4vezxgiVf00qwDFp1OqU68zaeUYoJbvQmvmPuNUR8M49NG
         8PQ3R+upSJGvOMMGlUuezqnFbC9eSjkg8cC2iBGIR/WodyMAtnPfGqd+d3V/QiXCnkDT
         HehjxUZm/t6u80ytrr8SlLeEdfvPDJf64lsMySr31WRavtfKDy1WlbNLytDeyRRYioNb
         WAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouVo67fVk3QedxIRwGF/kjxfvmda4Yy6wL8QXTMaaKc=;
        b=NUQ0GTydlcNXoZRoCiuVYZApV/Wnve3Yykaih/nQI+wxQ7YDjRYaDSeso8k/xobyet
         35Rl275xt3nb2dWS/xYevpr8M6kSJwY6FRZu9RSIyLi+Vvhy8laWCa48QHBjLbyjIYV9
         84SHHJgGHbwYJhIxwQl+2PW0GX6wfb5eV9iiy++vJm1uPd/W/XkEdCJfzELCKJD5nrJo
         ctQSc9kvex2svoJmqWJ28yDpm+POKQQczk2X776QeYaqTF4hoyxFtX3Eexel+tVCsAle
         Zsvm8d5Ag+m6b73iT1XHKuywfEsFkrdoEJLDIToEw80MV+1l7vSgF0QCMxByNcKuNhwn
         uNRA==
X-Gm-Message-State: APjAAAXw4grR6Haq8gigAvB0TQWQpw4FZiDPbgHzf0QnA2w+c/x+Ke/Q
        k0QJLO9j1Ki/qDnhSPvri37o7Q==
X-Google-Smtp-Source: APXvYqywrTLZVJoEHk6DuHBmvgag1GM7Xz/V3FgCfJSGwTvqnInqzLpRSfgIeA870Did+w4iN9vaOw==
X-Received: by 2002:a5d:5287:: with SMTP id c7mr15704405wrv.127.1553506798997;
        Mon, 25 Mar 2019 02:39:58 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k14sm13044652wmj.26.2019.03.25.02.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 02:39:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/8] usb: dwc2: Add Amlogic G12A DWC2 Params
Date:   Mon, 25 Mar 2019 10:39:42 +0100
Message-Id: <20190325093943.29138-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325093943.29138-1-narmstrong@baylibre.com>
References: <20190325093943.29138-1-narmstrong@baylibre.com>
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
2.21.0

