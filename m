Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30524C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BD720811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJrIgwMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbfC0FPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:15:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33886 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbfC0FP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:15:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so9396006pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 22:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IoVcyXfmR/y3HcuCjCl+S5Md4DPWVSOGvb700zi+Nbc=;
        b=UJrIgwMFmx9A7dl0T8GLp24XPjmugSMyKkLTSbAMlKkQW2Fhs/bru/Lb4390TeULNv
         BLXBGvDFzAbSjhOlxCI/S8V/avzCZA4SBagzKdDYj8Ml+JCqHUoJfcx3QjqSVG+LUS8B
         /Xci6cSLLg52x1byWvgPU9lRlR4LLa7EqMukQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IoVcyXfmR/y3HcuCjCl+S5Md4DPWVSOGvb700zi+Nbc=;
        b=soZGIm+c0wi/9rzwCVAR8nerm1tYk8j1piqId6AoIPbxeG34CGwMgccb0Odu2BXWsV
         1LZoyRpdxEGgN805JW8rV2vakwkEAIq+LDQSoi6D6SAr8s1ZDWsHzgRjv9aQsjVAKp6U
         leiqk/0p6wNoQTn7w05MXUxtMbu9toSU15FbTrPartsTGC9w0HWASnh5y5SnSJEaVQvG
         6zertFUljTndjFAEmmFq5nfLuMZs1bhEU03DJQbuVoatAT2QF8IeozqIy1onNixtQFhx
         9wgo2rmb4BWZD8KeBD6DtAT5XrUJGcNNGaz5tI8q6KPUO8lSW43KFyZ2zzAaNP1s0+nB
         9SRA==
X-Gm-Message-State: APjAAAWdehZxlkKAIFPsiEDyCs1jxB65WXfTH/1Lv26aqZCy/Cwxorq2
        zWBUrelaII+6fAXMYY+UnqSH+w==
X-Google-Smtp-Source: APXvYqxcj8N0iyNPf20mIA028gviqLQytwiELynCc6fyh4I6gwOz3dpjCT/KNAYw+Th8z8WfL41dkA==
X-Received: by 2002:aa7:8518:: with SMTP id v24mr33273921pfn.219.1553663727609;
        Tue, 26 Mar 2019 22:15:27 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id k72sm58622609pfb.122.2019.03.26.22.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 22:15:27 -0700 (PDT)
From:   Peter Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 5/7] dt-bindings: Add binding for cros-ec-rpmsg.
Date:   Wed, 27 Mar 2019 13:14:47 +0800
Message-Id: <20190327051450.16222-6-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190327051450.16222-1-pihsun@chromium.org>
References: <20190327051450.16222-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pi-Hsun Shih <pihsun@chromium.org>

Add a DT binding documentation for ChromeOS EC driver over rpmsg.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v6:
 - No change.

Changes from v5:
 - New patch.
---
 Documentation/devicetree/bindings/mfd/cros-ec.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documentation/devicetree/bindings/mfd/cros-ec.txt
index 6245c9b1a68b..4860eabd0f72 100644
--- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
+++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
@@ -3,7 +3,7 @@ ChromeOS Embedded Controller
 Google's ChromeOS EC is a Cortex-M device which talks to the AP and
 implements various function such as keyboard and battery charging.
 
-The EC can be connect through various means (I2C, SPI, LPC) and the
+The EC can be connect through various means (I2C, SPI, LPC, RPMSG) and the
 compatible string used depends on the interface. Each connection method has
 its own driver which connects to the top level interface-agnostic EC driver.
 Other Linux driver (such as cros-ec-keyb for the matrix keyboard) connect to
@@ -17,6 +17,9 @@ Required properties (SPI):
 - compatible: "google,cros-ec-spi"
 - reg: SPI chip select
 
+Required properties (RPMSG):
+- compatible: "google,cros-ec-rpmsg"
+
 Optional properties (SPI):
 - google,cros-ec-spi-pre-delay: Some implementations of the EC need a little
   time to wake up from sleep before they can receive SPI transfers at a high
-- 
2.21.0.392.gf8f6787159e-goog

