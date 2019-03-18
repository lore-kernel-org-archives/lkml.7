Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715CCC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED7C20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2D8qlI7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfCRN1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:27:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40255 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfCRN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:27:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id t5so17049476wri.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVuAZg4+nnaFhkjixBpLWEg1hgwoQXD2AQa4Piwf/Kk=;
        b=2D8qlI7f79/MVw+hlxaF5mONg2uk9MdinehuNtVFprAGhs+ynKpSDMkU8THSwM/1/v
         NoJCx+nQ05/nqA8m0xGGaSnemepMzqpfYIuaR/Qaxe3akjzhg5JPj0SoStNITQZaMWhx
         1OkZTIIP8ZhX/TeEQUfNNS9EFOtFLTH0Ckg/5oJO0drjEjI0qkv60oBKuW86/LMZfLBh
         o8QCJDXEmUSC7sbjpkhENzMAmxm4XPQ2vU8C3rxv0vKdwUlXr5h4Nsdjs4IVgB2FdjRe
         tjFOaGdoY+cFTbc7iSY9I50xcJptE8AdY7vgzubHfhD6iVDZ8qT4h2Lonqly90j7NWOI
         MCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVuAZg4+nnaFhkjixBpLWEg1hgwoQXD2AQa4Piwf/Kk=;
        b=enQAtz16UUE9X9dJQphXKLHfcqbcU7l78fckckpgPEjzrMSh6V+X0S6huxFxZFfeyd
         JHvQndX5O9F5plc6xiGg+js7WK7gegskp8UC/sYrVtSVn3Kf2SciegFCMEYeQGVve42a
         HrW3U/RB3K/1+LPVyUQqoZavauxu6p6jphr2I7j4OYXHVZv7++AaqxQxeSumAVhxrQ68
         yqvziWtUG5ng8HmGvcOt9aoC5LQaswNmneZgKK1OgqEXytcwZ25ovh2xFAbWrTa4R+9a
         e/AVIuDTTopRi+gblcsizSzqrCOvzorMwk/IK6mT+AFIwONVyoQHZfJ/kRIlISdlQJDk
         /k+w==
X-Gm-Message-State: APjAAAXPAn8yCSiTQkp36Pekp8AMeZdQdfGvFjm5EiqZFjrQYp9ttOz/
        xx/6z8gFt9TyfvIrTaJ+G0A2b+DSq44sMg==
X-Google-Smtp-Source: APXvYqyLtQkuzW97RpQE00rRUzBTzXwi9bR/lCEI7La/HEHYxNxhFFyTQxSEg9aIyCYPqotePmQNMg==
X-Received: by 2002:a5d:4606:: with SMTP id t6mr3596175wrq.43.1552915625855;
        Mon, 18 Mar 2019 06:27:05 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j128sm10421601wmb.43.2019.03.18.06.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 06:27:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] usb: dwc2: Add Amlogic G12A DWC2 Params
Date:   Mon, 18 Mar 2019 14:26:54 +0100
Message-Id: <20190318132655.30040-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318132655.30040-1-narmstrong@baylibre.com>
References: <20190318132655.30040-1-narmstrong@baylibre.com>
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

