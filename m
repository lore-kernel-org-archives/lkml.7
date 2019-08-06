Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F08C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D874F21872
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDoIiBko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfHFWH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:07:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44624 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfHFWHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:07:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so38384511plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pbLJacb6MCh29sDmogMC5h9hCymvEateyvCVNbUfmp0=;
        b=YDoIiBkou3pIhFNxBZpj0J83UtcpbrvdPUfIEHIJdhP8SlF5ssVac7LzF+ibBYWH5U
         wiEkdRC6X4/LBGjrSEDSe1FoPUzZQZ0oOVE44aAVabHsFrZMvqrb5hOgrULJb0iQ9hKK
         +CvYjb0K4E4ld/5eUKf4zNddqy++fMK7t/WuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbLJacb6MCh29sDmogMC5h9hCymvEateyvCVNbUfmp0=;
        b=p4P2IPt2UibqK+90ssM84kfnCScmrYZRyAkjUxQEQrjz1fEDPUAuPZaG1gPxhJMnLE
         D+sXQ1wjeJ0+DrimysSJGxScbaL8bmVMIDCpE7p1hHOpDtxWTr2O61IPk1QEs9zCMZsJ
         +HjHz1L5EJZHyoPHLVsOJYSLgf29a2GQWvd1TJFnrXIUZUp+crWwGvUmhomkeR467Uug
         +WhKLQqvffUzE9yZKcYIDyqeLaHzXtxAmHKruP6v/isx0Q166Vp7W1+wQ71PtWFLnOWW
         e75r2VItRTxUqcCThaz+7aZEhe3EtLEcMHC01Px2rLszeryJSHLaIye6k10Lf0qFEJ9B
         FQzA==
X-Gm-Message-State: APjAAAXOCoRP2XBUcDPN/ZEoDJFWUs5z6VdSAT/+sz/puA7L79bT9l00
        skDBdoPRSpc3Yw7IuWyFmWMf9A==
X-Google-Smtp-Source: APXvYqxPGQX5rSvQMu77o3qqkAW7npZloPdgkKNzcWKS4m1GnUr7uro7fEp/tJsmJ3LNl3LVL22idA==
X-Received: by 2002:a17:902:e613:: with SMTP id cm19mr4814750plb.299.1565129274668;
        Tue, 06 Aug 2019 15:07:54 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p7sm98982509pfp.131.2019.08.06.15.07.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 15:07:54 -0700 (PDT)
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
Subject: [PATCH v3 3/4] dt-bindings: tpm: document properties for cr50
Date:   Tue,  6 Aug 2019 15:07:49 -0700
Message-Id: <20190806220750.86597-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190806220750.86597-1-swboyd@chromium.org>
References: <20190806220750.86597-1-swboyd@chromium.org>
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

