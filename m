Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B258C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009F5206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVj20/v8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgAIH4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:56:45 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43083 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgAIH4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:56:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so6122191ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 23:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=av7HcYUDPVtq744dD/jQrW74iw2JEPAQcG8TalAj878=;
        b=PVj20/v8nJEgW8x/2ffVvBamuKf2e+R62LDvNuEA454AhRrfVxNT28PWF8j2eQFFY3
         wJ8tb2Hs7uEgaYoY4eAJsTmm4YmKiPqlLdmp6NB+kXVzgV/eqpsWGNL0Isg0RISvjH5T
         ly3S+sjE4shGQ1/XEy8Xyp69P2w+g857mH7FKOg6LyVltln+Zd3YI3H/gnHpM76KzYqK
         feM4TmqZc2L6BKecEskzhScWfisE6zCR5roB7Bt3C1vl922bUsPdmJxniwmpHHQkaqp/
         lSgwHCFFgC4qzCrogLsAURnjxaAXsc5DkPpX6Ljioxkslb8zVny8T67CtgG6NXSJSkKH
         Zmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=av7HcYUDPVtq744dD/jQrW74iw2JEPAQcG8TalAj878=;
        b=Bzjln5IWbfy5Ygj5Iqw/J9CPdUuqEp8Fd3zYxd3PVKY5xqshTct2jNMqDIu/yQtCFH
         MlvYmCakCdia4iikQEO+8+MTjOB78YsBoFUfBx1s02G1G7e/aiE67QKLtRPoVdr6NsiD
         HzqXaOYOW4zzhUSBkjgS8wH7e4U18qOdk6h1eJyieWSLWJvnpQpEuX8SflgQlh2oVV54
         MjeWPs/BTCCVw4vHmbMjtS91xw02qMlEN+kIHbHnvfz7ooPeveL8OXdyNaZX6rfnzrv9
         xbFX7y+SPphk73qddVK5Um7BeCJdzS2R/QPats4PEMM6X45UbUrOjBL2IuU29/Urq0wl
         Mnbw==
X-Gm-Message-State: APjAAAVmeBpxUxE2gDblmlo0ek8uhz0o/N5rZAdwMyeX+dZ1+jkjmu1n
        iCFRmObxdzgJ/G6JjQkUWsJ9PFBd/cvB6Q==
X-Google-Smtp-Source: APXvYqym0Tv71bG9Gm071smIw2DYk3olyayzv//M2eg9LEq/S8Kd10Rbhgbgeqz0ZdYKOuQLGwmx+A==
X-Received: by 2002:a2e:8942:: with SMTP id b2mr5478293ljk.162.1578556599344;
        Wed, 08 Jan 2020 23:56:39 -0800 (PST)
Received: from localhost.localdomain (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id d9sm2452745lja.73.2020.01.08.23.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 23:56:38 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] pinctrl: intel: Pass irqchip when adding gpiochip
Date:   Thu,  9 Jan 2020 08:53:29 +0100
Message-Id: <20200109075329.398347-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200109075329.398347-1-linus.walleij@linaro.org>
References: <20200109075329.398347-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to convert all old gpio irqchips to pass the irqchip
setup along when adding the gpio_chip. For more info see
drivers/gpio/TODO.

For chained irqchips this is a pretty straight-forward conversion.

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Please apply this to the Intel pinctrl tree when you are
happy with the result!
---
 drivers/pinctrl/intel/pinctrl-intel.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index b479bcf1e246..ffacd77861f7 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1224,6 +1224,7 @@ static unsigned int intel_gpio_ngpio(const struct intel_pinctrl *pctrl)
 static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
 {
 	int ret;
+	struct gpio_irq_chip *girq;
 
 	pctrl->chip = intel_gpio_chip;
 
@@ -1244,16 +1245,9 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
 	pctrl->irqchip.irq_set_wake = intel_gpio_irq_wake;
 	pctrl->irqchip.flags = IRQCHIP_MASK_ON_SUSPEND;
 
-	ret = devm_gpiochip_add_data(pctrl->dev, &pctrl->chip, pctrl);
-	if (ret) {
-		dev_err(pctrl->dev, "failed to register gpiochip\n");
-		return ret;
-	}
-
 	/*
-	 * We need to request the interrupt here (instead of providing chip
-	 * to the irq directly) because on some platforms several GPIO
-	 * controllers share the same interrupt line.
+	 * On some platforms several GPIO controllers share the same interrupt
+	 * line.
 	 */
 	ret = devm_request_irq(pctrl->dev, irq, intel_gpio_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
@@ -1263,14 +1257,20 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
 		return ret;
 	}
 
-	ret = gpiochip_irqchip_add(&pctrl->chip, &pctrl->irqchip, 0,
-				   handle_bad_irq, IRQ_TYPE_NONE);
+	girq = &pctrl->chip.irq;
+	girq->chip = &pctrl->irqchip;
+	/* This will let us handle the IRQ in the driver */
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_bad_irq;
+
+	ret = devm_gpiochip_add_data(pctrl->dev, &pctrl->chip, pctrl);
 	if (ret) {
-		dev_err(pctrl->dev, "failed to add irqchip\n");
+		dev_err(pctrl->dev, "failed to register gpiochip\n");
 		return ret;
 	}
 
-	gpiochip_set_chained_irqchip(&pctrl->chip, &pctrl->irqchip, irq, NULL);
 	return 0;
 }
 
-- 
2.23.0

