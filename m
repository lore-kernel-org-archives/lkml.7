Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4283CC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C482067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AEbhrZIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfHLWgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:36:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35395 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfHLWg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:36:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so8464996pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pbLJacb6MCh29sDmogMC5h9hCymvEateyvCVNbUfmp0=;
        b=AEbhrZIj9L570kQMqoryJFGF2aST4nMckbDoihfMAMRyTUCHFi6Ut0bR+e+RXtYm/U
         MXuKioSk/vI5utYPt24IRcbOVwc0DCsUn2PZKC7Ms5olCCzRtnYK5HcSKaVz06P1uSWr
         bZusf6mtHlyCAET4JMEufjD6pmZJ6MqwUKup8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbLJacb6MCh29sDmogMC5h9hCymvEateyvCVNbUfmp0=;
        b=HmSaKu4tAyZ8kmOYPa9JHm/HjyYZqwlaP6C6URnBFAuAlXb1SsNouewftdfXhBM9M3
         MfiOblcAsr9EfHNY4EIGkoOh/96o84KaAC2OAChltZE4gcI7Chh2G+TusNdYjstakRWf
         tHKUvY1rSGgreH6QCJDqicJY8Mb1XBv/DEr39EUWLHK+EhJVEVoMO7E+lpoPJt39b0Nc
         rmv7wVyc77FNjbhR2f9swcY+aOgaCh8V++Wqwjp/MVWosPdMa4dyI9IC0g7Tprki9lqY
         dG25VJ6xKtEpG9vM+bp/JcnYZintb1EwYiOYNwPrsBaekVr00E5LvQJQDMzqMNpID5rW
         XONw==
X-Gm-Message-State: APjAAAUkMRvRo0mw8Alg+zpbFEo0aQpfRZwwciFuE6ZXqSIjqEjl6ugz
        SgEeHxYu9MtaS0IrHRkDMx19vw==
X-Google-Smtp-Source: APXvYqzmmF4BEegcpnS/e+KMA+yvCSfeLCUG6UJMXyZthuybe6012WcUe4Lc93X5m141O03baC5izQ==
X-Received: by 2002:a17:90a:c596:: with SMTP id l22mr1444056pjt.46.1565649388818;
        Mon, 12 Aug 2019 15:36:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b6sm93911594pgq.26.2019.08.12.15.36.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:36:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 5/6] dt-bindings: tpm: document properties for cr50
Date:   Mon, 12 Aug 2019 15:36:21 -0700
Message-Id: <20190812223622.73297-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190812223622.73297-1-swboyd@chromium.org>
References: <20190812223622.73297-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
firmware.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Andrey Pronin <apronin@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/security/tpm/google,cr50.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
new file mode 100644
index 000000000000..7aa65224c8b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
@@ -0,0 +1,19 @@
+* H1 Secure Microcontroller with Cr50 Firmware on SPI Bus.
+
+H1 Secure Microcontroller running Cr50 firmware provides several
+functions, including TPM-like functionality. It communicates over
+SPI using the FIFO protocol described in the PTP Spec, section 6.
+
+Required properties:
+- compatible: Should be "google,cr50".
+- spi-max-frequency: Maximum SPI frequency.
+
+Example:
+
+&spi0 {
+        tpm@0 {
+                compatible = "google,cr50";
+                reg = <0>;
+                spi-max-frequency = <800000>;
+        };
+};
-- 
Sent by a computer through tubes

