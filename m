Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E8DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0DE21873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qG+OQFZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfCaR4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:56:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51783 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbfCaRzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so7810367wmf.1;
        Sun, 31 Mar 2019 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yuBb3NfQYhODXKKaYg/6vTGzYilmvoaMj8YJO6znSoQ=;
        b=qG+OQFZ4+v/YsKAy2ZWTdXcwgRS4sWlsyTsdKz+NJNZrSq6FWefWPdMhD76p18GbQ0
         I3NSFwdxB6/M9YtciD/cZH/DiDs3erVYcF3+ED61o0q2IngXbzkA/Sp+fDTmuU5T1T63
         5mTO0UVmap8ut5TlcFqHsXlciMnD/7MR5PEuMmb9pHm1NbJDAD2sL2suK6QLwsWQfP0f
         ljUqbDxHtuHDPTStPEtgoTK+t0PAHco/siGSdc71RgdevhFFMvvRSOZs9PjI4/Xmq1oG
         +gK4MBiTwr88ix16iihjM1EA35pNVGln3/ByoHHBtNpfekFXCbjV5+IoRJON+4zCVStK
         8ypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yuBb3NfQYhODXKKaYg/6vTGzYilmvoaMj8YJO6znSoQ=;
        b=h8AX0CdFSSCY8WkXxIEDs8tb7PdSIEMEdKx9SgCnfl3eLHwsWlARVlNomC0ey/cxZl
         4bwz+RkcnNHSxZ9IhUpxd91EZaCvDgyiQw1mb+Ajbi34sTjzmWqJmGWBwWgRnQWqVYVu
         JgFXaQvgIls+cpiViUn14mq1OvdwHtXVBtZmlOacbb/P1/jb9KDok6TNXP93H/Lo94VP
         0VJVZ9FUxygQOKQlwxR4HVcKDnQDdGZQnU/pTXJ73lNmIFv4CVxB2TX9DVqp9j4u+o6e
         IUmob0FSNPOSRHAYunmbCPse5SDufkLBzsctCaxsbh2Hc2HSHSD5K60kLRwBYHvmSAEA
         vzGw==
X-Gm-Message-State: APjAAAU92dmYmAsUQFxZ4MP0tjVm6ORf4wJl2IyYwTwvU4ohkjK1W6uv
        bYlUGXuDHFtunll/Em5MekVN3Pwrljg=
X-Google-Smtp-Source: APXvYqyMA6GsfqukTk9oLBrVC0X1r0fD8fJrBiqBKgEkh3zbzWBR6eXJLVrD5wTe5fZWSkojEqyOXQ==
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr9839959wmi.138.1554054945815;
        Sun, 31 Mar 2019 10:55:45 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:45 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 20/25] dt-bindings: as3645a: Add function and color properties
Date:   Sun, 31 Mar 2019 19:54:56 +0200
Message-Id: <20190331175501.23471-21-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Also, fix malformed syntax of address-cells and size-cells
in the example.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../devicetree/bindings/leds/ams,as3645a.txt       | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/ams,as3645a.txt b/Documentation/devicetree/bindings/leds/ams,as3645a.txt
index fdc40e354a64..4af2987b25e9 100644
--- a/Documentation/devicetree/bindings/leds/ams,as3645a.txt
+++ b/Documentation/devicetree/bindings/leds/ams,as3645a.txt
@@ -39,7 +39,9 @@ ams,input-max-microamp: Maximum flash controller input current. The
 Optional properties of the flash child node
 ===========================================
 
-label		: The label of the flash LED.
+function	:  See Documentation/devicetree/bindings/leds/common.txt.
+color		:  See Documentation/devicetree/bindings/leds/common.txt.
+label		:  See Documentation/devicetree/bindings/leds/common.txt (deprecated).
 
 
 Required properties of the indicator child node (1)
@@ -52,28 +54,32 @@ led-max-microamp: Maximum indicator current. The allowed values are
 Optional properties of the indicator child node
 ===============================================
 
-label		: The label of the indicator LED.
+function	:  See Documentation/devicetree/bindings/leds/common.txt.
+color		:  See Documentation/devicetree/bindings/leds/common.txt.
+label		:  See Documentation/devicetree/bindings/leds/common.txt (deprecated).
 
 
 Example
 =======
 
+#include <dt-bindings/leds/common.h>
+
 	as3645a@30 {
-		#address-cells: 1
-		#size-cells: 0
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x30>;
 		compatible = "ams,as3645a";
-		flash@0 {
+		led@0 {
 			reg = <0x0>;
 			flash-timeout-us = <150000>;
 			flash-max-microamp = <320000>;
 			led-max-microamp = <60000>;
 			ams,input-max-microamp = <1750000>;
-			label = "as3645a:flash";
+			function = LED_FUNCTION_FLASH;
 		};
-		indicator@1 {
+		led@1 {
 			reg = <0x1>;
 			led-max-microamp = <10000>;
-			label = "as3645a:indicator";
+			function = LED_FUNCTION_INDICATOR;
 		};
 	};
-- 
2.11.0

