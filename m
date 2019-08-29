Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DBFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AAF21874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iUy5GOB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfH2QQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:16:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51840 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfH2QQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:16:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id k1so4349958wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRSXXM/9Hjh3g9tVzGv7Uh9K2mMpn/F7sp2YRf04TcA=;
        b=iUy5GOB3ydrfuUnBvxT0tgXebasbWCSqGhJqfY56RSa1bYiL6CrKIwTIGnjL9N+9V0
         xNWVb1yd8ku2sgZdEh4+UVeKVpLO6IebJPqa1VdcThqBj76hW2CO5SGwA1TSWiOLUKfc
         2I9J80oDABJi/ub5Ee9F1swJWC6OJMeCGJppcKQDkzN1oxu0XlWjkqsAJouNwC3eSaOq
         uXzxgM/xeh9F1v610PmBCiyn2ERPOM4eaJpGNByq/I6o5SERnIHEYHH/eqqNBqmVcklC
         FRcXpd2ZBj6QQg7btuMBudGmHlgZdZgfM0So3yd+rHTqnTHb3hNk42jdUpNsL7/wzwix
         Umng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRSXXM/9Hjh3g9tVzGv7Uh9K2mMpn/F7sp2YRf04TcA=;
        b=Oho6yXBEfq+zNst7R1TsWLgIQjh9VzLns7XLpnMQB0AZIgLRF8Yx1oVRpZiqwSF4/z
         XJ9V/GMGMoKN154rTq0oNAiHzYb7Yf/86cubOTGge6PoI5SxKK0OJmNDVVw1O9ohhR98
         1lsQNLORPMO927k843tg/xuQZP6xuVaTpmmmZBksi8fj+2loDBDC5xt/nC2zi51s8SOV
         BsYGkw9f5AuMyRrpwFwOZIXzzvrKN3wUhq/ggyrFFuW+eTERKkGPkWuiGMriNNXBEGOg
         cUjKodRiu1r1/SaGvDDl2FeMqCtCx1Nb6ABCQ7zLXvsJgm5+Omt/X4PYnzBbhPvzWCBy
         XF5Q==
X-Gm-Message-State: APjAAAVD1ibjPqjYBHJ3HsWbWj3gFXh/djzQPdmUacYNer/j0SIa2EVC
        EFugsVk/kMXrJFqHOTD0EDWSFZu/GTI=
X-Google-Smtp-Source: APXvYqy5A2xGzz3+Z5BYXuI0TCEvUQNi8cgwHdW5HQMj/N9nGUuBDXTkjcWNpsSQK93sO6clm8gUMw==
X-Received: by 2002:a7b:c013:: with SMTP id c19mr5053414wmb.118.1567095400557;
        Thu, 29 Aug 2019 09:16:40 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q13sm3915424wmq.30.2019.08.29.09.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:16:40 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: interrupt-controller: new binding for the meson sm1 SoCs
Date:   Thu, 29 Aug 2019 18:16:34 +0200
Message-Id: <20190829161635.25067-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829161635.25067-1-jbrunet@baylibre.com>
References: <20190829161635.25067-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the dt-binding to add support for the sm1 SoC family in the
amlogic GPIO interrupt controller driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index 7d531d5fff29..684bb1cd75ec 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -16,6 +16,7 @@ Required properties:
     "amlogic,meson-gxl-gpio-intc" for GXL SoCs (S905X, S912)
     "amlogic,meson-axg-gpio-intc" for AXG SoCs (A113D, A113X)
     "amlogic,meson-g12a-gpio-intc" for G12A SoCs (S905D2, S905X2, S905Y2)
+    "amlogic,meson-sm1-gpio-intc" for SM1 SoCs (S905D3, S905X3, S905Y3)
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.21.0

