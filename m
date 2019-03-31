Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249B8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E939221841
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2rICJ7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbfCaRzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:35 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:39011 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731499AbfCaRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:31 -0400
Received: by mail-wr1-f51.google.com with SMTP id j9so8910818wrn.6;
        Sun, 31 Mar 2019 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U2dPQ5PqeJUS3vRQT+iVuB+v/Ht4lgydviD9qFBU8yo=;
        b=q2rICJ7hZHTQ5thvD1hL2DgoRea+UOvEZyVJkMaFfMqXY9o7WZc7FQOLhBikVI3/QM
         TfK51nMQHibO4UFJvLP67B1xK4qPV1CbY4vN0llaOsHcEoem0JM5X4HewH2lddRKYMML
         zj5rEAX12ntdteWWORhgM16bdNfQQIEJSqmN8K3unJfwED2IoPxpfmYDy1qW9ZJvI//a
         J2wKuSylsni/NG2FfRwfzK1gZZukRLPKeUIfxTiWxfF4AYEb+YQRFrNuUHYOiDurH7yI
         QosjjdtoCfGLpWiqL2arubgXWZWdANe+D1Eoi5+3l2gv8yN9s8l3qFz1RuNcbf14ftSB
         x39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U2dPQ5PqeJUS3vRQT+iVuB+v/Ht4lgydviD9qFBU8yo=;
        b=lLODDkWe9XSvP0bE1DzYs19gus4J6AhVPLnawP00f0VRQYO0bF75/nwt+zwWdbjIyI
         4wC6KAJEqc5VNbcpEjUfQoeygrGEenLSG/U1iRiVfhSKARhalB6dlLLjLB6jgjA+qoXb
         AJ/aODZCo9fmkCrggkDj0envbNjNMLYxUWV9BEBv9H3DkJavRRPqsqtX93xuoMtqAMtk
         +oOv/AjG3h2v/iSPuQjY17VBTzuJJNysGGj11P5z/CoJZB9ZMrCsD9zVofSPKZazyDb6
         HaO7JY9Y3/luuxakuRvcO0vljU7cgwjgnvvekmMJTTx2YAs5gdmqxsF9216Z0MFrukqi
         N7mw==
X-Gm-Message-State: APjAAAU1WUGn9z8Ut45dqt6t5QjZB9JY+jSDilrfE5Fbc5UU45GC4dB4
        Qi0rgaYT6SkQiy2rXizP11yqlmf+dlU=
X-Google-Smtp-Source: APXvYqyh2kou939BJEJI+yoQqLhOZXidRm44T2glryY4CKnHxL/burqjIl3Ysouoo7wo5GIwuzgv2A==
X-Received: by 2002:a05:6000:1111:: with SMTP id z17mr28084808wrw.103.1554054929439;
        Sun, 31 Mar 2019 10:55:29 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:28 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 10/25] dt-bindings: lp8860: Add function and color properties
Date:   Sun, 31 Mar 2019 19:54:46 +0200
Message-Id: <20190331175501.23471-11-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/leds/leds-lp8860.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp8860.txt b/Documentation/devicetree/bindings/leds/leds-lp8860.txt
index 5f0e892ad759..9863220db4ba 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp8860.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lp8860.txt
@@ -20,12 +20,16 @@ Required child properties:
 	- reg : 0
 
 Optional child properties:
-	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- function : see Documentation/devicetree/bindings/leds/common.txt
+	- color : see Documentation/devicetree/bindings/leds/common.txt
+	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 	- linux,default-trigger :
 	   see Documentation/devicetree/bindings/leds/common.txt
 
 Example:
 
+#include <dt-bindings/leds/common.h>
+
 led-controller@2d {
 	compatible = "ti,lp8860";
 	#address-cells = <1>;
@@ -36,7 +40,8 @@ led-controller@2d {
 
 	led@0 {
 		reg = <0>;
-		label = "white:backlight";
+		function = LED_FUNCTION_BACKLIGHT;
+		color = <LED_COLOR_ID_WHITE>;
 		linux,default-trigger = "backlight";
 	};
 }
-- 
2.11.0

