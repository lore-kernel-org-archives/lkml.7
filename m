Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371CB2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qHjosz7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfCRKMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:12:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34832 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbfCRKMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:12:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so10373492wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVuAZg4+nnaFhkjixBpLWEg1hgwoQXD2AQa4Piwf/Kk=;
        b=qHjosz7nh2j+dMBu80K1XPaRgqm0A5/M+a5n9uihayXEXKc/QNfTjov7Sz+9koNvTS
         tET6ztF83yOXyj2DIR8LzbedHeLIyk0wz1+/rMGu0uZDI7FhKV3sKe9UQu9LONom/x2h
         DC2KVEFnOUBVLAWzOdDxPXZRGwXOuy2b7/Uh3vaa3pCaLw25kYlEETxClAIy0gEtRXIE
         +YMGgi/ypXqUTw8y/cgecXEipylY2tXvdlPxOziroAOxymRqPikwz0WcZ08sNZNVrrH7
         cSFbI9DcU2gw+GC9cGhCvg5rC/L2SaDRYnY959pxrfyUAoIvbPbRozKv/Z7waUdEbDTA
         PcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVuAZg4+nnaFhkjixBpLWEg1hgwoQXD2AQa4Piwf/Kk=;
        b=or7JIJJYJyFz9TUUkIVtwQ4hzHgg6qImsQ5szPdXKB0kLdAMhLKM+3MOEajFVeHCC+
         wjiNR9rIuVYWlXPmemaQj3eG/J6Nwz+S+cFk5YzGg8YjOMhPO+qUxNUL+UqbrvLxXZOs
         +dGGHlTjauOBs/CVqWprsWC4u0gza90wfOI7XeQCFog2l6Jnhs/wZGM7gxiiKIqDZebg
         twNyyFJosvfJtx3+mDVE2SrS+4a8x60HPy1SU7kzid9DX1vHRrPRQ2uG9+9POt0yR4qX
         9SFCshatJHnpoeSaaNPTPxvxxPg16C30erqlYajA7th7jSMwXkKYloODm7xDej/uuKWP
         XOgA==
X-Gm-Message-State: APjAAAXvdi4Tchg4z7FiKV42o+/yh+UVwTUChHISlMXUNnMp0uL58SYV
        QZHcbWhFMQwVwk6KVyozTtSgxw==
X-Google-Smtp-Source: APXvYqzXqrUa0MrlgNlwt2Yb3Fmya+DOxwcORC4NOV0VdzK8HERfTf6+aiyj6X42OwzfFNoCHdmV+g==
X-Received: by 2002:a5d:62c4:: with SMTP id o4mr6285715wrv.282.1552903923978;
        Mon, 18 Mar 2019 03:12:03 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z8sm6697855wrl.59.2019.03.18.03.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:12:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] usb: dwc2: Add Amlogic G12A DWC2 Params
Date:   Mon, 18 Mar 2019 11:11:52 +0100
Message-Id: <20190318101153.7531-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318101153.7531-1-narmstrong@baylibre.com>
References: <20190318101153.7531-1-narmstrong@baylibre.com>
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

