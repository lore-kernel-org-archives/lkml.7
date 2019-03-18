Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2049D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="as+FwM3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfCRRoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:44:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37517 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfCRRmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:42:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15so18062301wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T1F7KCZQllI8gey25Uaoq9o2WFLfikAjSL+Gi1a9B5o=;
        b=as+FwM3NclTMg0ti7KgUVA8YrK/OcOoh71jbc4FS2InDj0neFED5LpL4MGQbmcDxSd
         G1hSkhDNrZT/AQnntR7L+LxiQueX5RA5fBqivak0EWUM4vr6NxVIh9p2p8szzPv3ZwGm
         /yICN9KIXGY1KEP0VMco7gqYEnNfghkni323NetdJC0McsWcE9CKUDDMBrmW1yoJmlj5
         cXacJRa5c5kNHPm0ySpJRqJCDWkBuRyoZaSW8r0gmE7ZkpKy8P2WrVSrhqlrkss53Otf
         WYSlYUei7UOGm45v0irycGR13WToxYi2DVypMhKObJ+z8PtBeosE5fwvcEpyQRFGcr+/
         Cu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T1F7KCZQllI8gey25Uaoq9o2WFLfikAjSL+Gi1a9B5o=;
        b=EopmoJATOppN4rN3jQ+wMbJVm9448ywzXKfdmulGjay4T1C32QNSTGsYzEU7StBY/I
         DZII52S5weCRj5f1Pj75ZEc6j84VRkPPaJzMvSyUqYE6V6EAqaFtdmlSjpzN5sm8i98O
         ynSFB/JLnxWAgHDjSgecpaccun5XFKpxfFjDl5sZiPLk99gPo0a/DDhqq1kNdWBwTdWh
         CL0fCCEjHK9M8iCiHDsRBYzpEZdcWADOy5mp2cZQWm52b1AAJ2ZyiIsdD2+DzGtulRJH
         gASzP6fsopwNODgO/tqOM5fxybCEa9iq09rxzDq/9XPhqJzPbpEjdDFdiLTKnPSX3epm
         gg8A==
X-Gm-Message-State: APjAAAWykCx2OwW8yJbmUgOCDJK0vZACAm5zlQDEpKxcUIRcaR5T3N47
        JmCj/McTLVnWG1UszYgcHUXUnQ==
X-Google-Smtp-Source: APXvYqy+BN83qwW98sqRIkGD5QpMnKkNN+5YK3bO30qa29nIj6o9/vAnm5eo6Z5o98+qusLGSoTTPg==
X-Received: by 2002:adf:ba84:: with SMTP id p4mr13254916wrg.156.1552930958302;
        Mon, 18 Mar 2019 10:42:38 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g24sm14873909wmh.45.2019.03.18.10.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:42:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v6 04/11] dt-bindings: input: add DT bindings for max77650
Date:   Mon, 18 Mar 2019 18:42:21 +0100
Message-Id: <20190318174228.18194-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318174228.18194-1-brgl@bgdev.pl>
References: <20190318174228.18194-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the onkey module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/max77650-onkey.txt         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.txt b/Documentation/devicetree/bindings/input/max77650-onkey.txt
new file mode 100644
index 000000000000..477dc74f452a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/max77650-onkey.txt
@@ -0,0 +1,26 @@
+Onkey driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The onkey controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-onkey".
+
+Optional properties:
+- linux,code:		The key-code to be reported when the key is pressed.
+			Defaults to KEY_POWER.
+- maxim,onkey-slide:	The system's button is a slide switch, not the default
+			push button.
+
+Example:
+--------
+
+	onkey {
+		compatible = "maxim,max77650-onkey";
+		linux,code = <KEY_END>;
+		maxim,onkey-slide;
+	};
-- 
2.20.1

