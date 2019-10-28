Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647FBCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E0321835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiGKojzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbfJ1V73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:59:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35256 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389881AbfJ1V7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:59:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id d13so6833525pfq.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GYRc8Evk3wu8EUiuELp77RSTyUut+SJabJSgyybQCKc=;
        b=aiGKojzfX0avTva88b+Xf7Ycb1D84K+JUiiDZe8pxySNsgiNblOjP/0rEBus9uVwFy
         ry7jgeDbO5rYlhDY3nigJVxjosnZT+JsbJwQQMwTADrRUPh1W6luNUOyK/bKwsZop+V0
         tv4rLM+oQ4ikK7IlwEgNicJh1z7AL3q/L+EPrECleyeatF29bxEdswku9u4yzoZ5Aexs
         ULxCVuo4HEcivtAM8axTxG7Dx6uqJKmuwi48dMUCXUdQF0n/EcPJlK/HDz9pYQ9UH0Vx
         6BPRmIG4CPgtqSxeBpJc0cZx/KCEIewJ4TbVg8G0KbGRGmaEZcHxjTLjezesX65OejFs
         FLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GYRc8Evk3wu8EUiuELp77RSTyUut+SJabJSgyybQCKc=;
        b=l8o4ojwybvONVCJHO3v4X0pHEBUjZVQD8cHuHk0A4d+9nFkyF7wHhZZjL/Oy5Kh8vf
         9wE88LBM9pQv3Lf17TnS8xZhPrcVswqgeW6doz7l0fEgojLvkp6IKTtJpxH7HA1UVQNO
         6ne99cvPt1zYcpFTTcfJ3ISimFGTMboEn+FZLb1WRYsgKHYdh77KSL9LXeOyhuESBqwA
         Cyv92h20Tyyl8SGOvSr7Cxsb8PTLKHyhB88WJoCgW3Uyvy9kkMBTnUrXLFyLOoaXJNLU
         cL/EtNTO3PRAjhROj+ssse8fPLxX+oU0EithW53XNx4hHPF6HURPykfJ5z8qFLY9o1gC
         rR1Q==
X-Gm-Message-State: APjAAAWKCgZyUbxXy7a/Ei7JVvW/uFKi0SpwtJzmGXTK038UIW6XcfXI
        7tnr2HXMQWTe8HL/8xG+X9ifcZcpwNc=
X-Google-Smtp-Source: APXvYqyBQEq+GyX9s9DcVAsO/5XEDStC7aBeHJL3KSIfp2K/5xIaHqQr6/nGowmVcOrYfSGZ5tHZhA==
X-Received: by 2002:a65:4bcd:: with SMTP id p13mr23366871pgr.80.1572299964451;
        Mon, 28 Oct 2019 14:59:24 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-172-113.hsd1.or.comcast.net. [67.170.172.113])
        by smtp.gmail.com with ESMTPSA id f12sm10880612pfn.152.2019.10.28.14.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:59:23 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 1/9] dt-bindings: usb: rt1711h: Add connector bindings
Date:   Mon, 28 Oct 2019 21:59:11 +0000
Message-Id: <20191028215919.83697-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028215919.83697-1-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add connector binding documentation for Richtek RT1711H Type-C
chip driver

It was noted by Rob Herring that the rt1711h binding docs
doesn't include the connector binding.

Thus this patch adds such documentation following the details
in Documentation/devicetree/bindings/usb/typec-tcpci.txt

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../bindings/usb/richtek,rt1711h.txt          | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
index d4cf53c071d9..e3fc57e605ed 100644
--- a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
@@ -6,10 +6,39 @@ Required properties:
  - interrupts : <a b> where a is the interrupt number and b represents an
    encoding of the sense and level information for the interrupt.
 
+Required sub-node:
+- connector: The "usb-c-connector" attached to the tcpci chip, the bindings
+  of connector node are specified in
+  Documentation/devicetree/bindings/connector/usb-connector.txt
+
 Example :
 rt1711h@4e {
 	compatible = "richtek,rt1711h";
 	reg = <0x4e>;
 	interrupt-parent = <&gpio26>;
 	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+	usb_con: connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		data-role = "dual";
+		power-role = "dual";
+		try-power-role = "sink";
+		source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
+		sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
+			     PDO_VAR(5000, 12000, 2000)>;
+		op-sink-microwatt = <10000000>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <1>;
+				usb_con_ss: endpoint {
+					remote-endpoint = <&usb3_data_ss>;
+				};
+			};
+		};
+	};
 };
-- 
2.17.1

