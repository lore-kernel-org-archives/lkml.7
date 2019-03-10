Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F152C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CB420657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qny5aidH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCJS3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:29:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39526 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfCJS3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id p8so1063339wrq.6;
        Sun, 10 Mar 2019 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ojf4eD+Nyi/DfhSMD+eChVEw+ZJVNLivMY5RzI5tymw=;
        b=Qny5aidHe1dp6sQ7onNla9KaW3pMoozL6TDszqezGQ6s/GwAipsIJF8kfvN0Do03C+
         Wt0ou/bNEtQCIaVfuuDX/Hhdqxvw9F6N0HgxGUncKz08YbEU7/sNH6y5qZPUeC+kryn8
         4DugIilNIPvtjvyruRYLt6Y+vx3K8R/HQzipSR8Nj9WODTpbix7vOK4oRCsBawZKU4jY
         NHdH9NjKmbAmyVbw45M1RIfvL2hX3cnvxld2T+OzZQlWhnufavkLbqzPirXSydrQASFP
         voar1/8ocelNNFD+a22mxb7HatngkVGwWaHrP1Xg7BbM3ZaNFxoI7XUTKHoIYRVNpd37
         IYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ojf4eD+Nyi/DfhSMD+eChVEw+ZJVNLivMY5RzI5tymw=;
        b=UBYLrt6QGpiIB0sL0yJ0hAg7dDDGhKzau8WeqTNT/990Lxa9GkUcQSnAlV6+NfBHpm
         zEDBu/jOumWQgY8KRfr01yHSJXtvW59IqxN1GorItABvEGnGIGyxoNDV0InvigQR6SoQ
         IRn1c886/EZu0KcfsAEzNH7IhbyZ8kZmuE2VTJaFc6OjdCtFFJkrVYGNVHJQAruYftko
         2qkCuB7auJvIEQ+5X5s3PiPdftvEVh4G1jtDZw6/5AM7VwCFFLSgplud2h7pRjtUTG6M
         8cRo/Pe4ibyRADzgujtnUiq7/Oo+aRjegOjF7gVlcm8r5iqzI7HZnP6n9wkF+kgaF1Yj
         GFAw==
X-Gm-Message-State: APjAAAXiWgy4vOVCTKX2vRXhMsNCpUZ0WZKh6LeCiPVIHWeTRWbZifTp
        iHJ58bsJR8y2OgbOPBslWAtYNAGy
X-Google-Smtp-Source: APXvYqyKtLWiHo55GFJj+SM4A1GWZ8UIbZINKt1AYUTR7nZnqz8iO777isUfUK/rE1OCfHzQW4WsRg==
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr7915844wrs.84.1552242542263;
        Sun, 10 Mar 2019 11:29:02 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:01 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH 04/25] dt-bindings: leds: Add LED_COLOR_NAME definitions
Date:   Sun, 10 Mar 2019 19:28:15 +0100
Message-Id: <20190310182836.20841-5-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common LED color name definitions for use in Device Tree.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
---
 include/dt-bindings/leds/common.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index ffcd46317307..0e986bb59391 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -57,4 +57,13 @@
 #define LED_FUNCTION_WLAN "wlan"
 #define LED_FUNCTION_WPS "wps"
 
+/* Standard LED colors */
+#define LED_COLOR_NAME_WHITE    "white"
+#define LED_COLOR_NAME_RED      "red"
+#define LED_COLOR_NAME_GREEN    "green"
+#define LED_COLOR_NAME_BLUE     "blue"
+#define LED_COLOR_NAME_AMBER    "amber"
+#define LED_COLOR_NAME_VIOLET   "violet"
+#define LED_COLOR_NAME_YELLOW   "yellow"
+
 #endif /* __DT_BINDINGS_LEDS_H */
-- 
2.11.0

