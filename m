Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC5DECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D359B20663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYd2AltO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403938AbfJPDeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:34:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35463 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403900AbfJPDeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:34:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so13800891pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 20:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g5sQMXSMdWuSqvmdQD58X3h1zk5SjaH8Y+Tanu+qv7s=;
        b=xYd2AltOxj3y/Ve5vEQPkHNfpCqVzUI4h1Hkf4GwUtrRjBAR3I8+P5vvRXlAMF+VIj
         lOAoFNsMsXMtTUfsDZmToG3ETzPD4KKFUT+JgO5tIITA5efcDQc7e5ADqNqyf7OnBFo7
         8Trebi8naNe9Hrv3Wf8lzKTYnqJv/rBY0PwLAhpC6iOmx5HUgiovPLa/tEUg7wBG1iiu
         Q4aJv6u02XbtnyN0bEGS6bXVcn/wWy9ewpbWtyWcud7BrGvhVM2CKEdrJqo9/fTpDlwd
         D7Bhmm6SQvPwc6Wi0UibcLOg/tqbRtIh9CqaWfWS63sbVEk2I4v0MryE86bkFYVz1Ud6
         CcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g5sQMXSMdWuSqvmdQD58X3h1zk5SjaH8Y+Tanu+qv7s=;
        b=bbjQfaSAKK/ScuDTRatig9cpck5hXPjlsrXRHGXR51lWrtL6uowel2B6SGyYOlC72G
         svyXPLd86SNlSw+JJQrqvNS7XbXOGtw7z+aOqkBPLU8QXofhM6NZ/bQNiqo4PZgyNBjf
         oOyZN3V85LSs4+mPSPWAJPDNq8pcPUwSsp9odag8ty9Q6n5io5PCB/cbV6tPyZ8JEfji
         xbyBg+maNogZF9JvYPLOyxgR8TdVlMahdiEiJjrmFucTT1Y3ZHMJcH454URGgZvYJZ/q
         epNFbkPhCK6lHvbPsfow11z21WGmnEnxRq9ybFiWCvKj+NPfgaobr3P61g2FVMSOJNXN
         pHEA==
X-Gm-Message-State: APjAAAVla7lvfGO6JrM7o7wkETNoysauIogU/P9wW6LhOdy4iUEU3r5Z
        wf+hR5hjxbkjPmmJlRTguu8VEmE5n6U=
X-Google-Smtp-Source: APXvYqxdFeMofjrhcmy13r5JUspDNYDwqOMXH2WgRGuNbN+bj9FrOOgg9uXV3EB0TMfrXMdil541Aw==
X-Received: by 2002:aa7:908b:: with SMTP id i11mr42817988pfa.186.1571196839121;
        Tue, 15 Oct 2019 20:33:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l23sm748356pjy.12.2019.10.15.20.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 20:33:58 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH v3 10/11] dt-bindings: misc: Add bindings for HiSilicon usb hub and data role switch functionality on HiKey960
Date:   Wed, 16 Oct 2019 03:33:39 +0000
Message-Id: <20191016033340.1288-11-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016033340.1288-1-john.stultz@linaro.org>
References: <20191016033340.1288-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

This patch adds binding documentation to support usb hub and usb
data role switch of Hisilicon HiKey960 Board.

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
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Reworked as usb-role-switch intermediary
---
 .../bindings/misc/hisilicon-hikey-usb.txt     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt

diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
new file mode 100644
index 000000000000..1e131b38230d
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
@@ -0,0 +1,40 @@
+Support usb hub and usb data role switch of Hisilicon HiKey960 Board.
+
+-----------------------------
+
+Required properties:
+- compatible: "hisilicon,gpio_hubv1"
+- typec-vbus-gpios: gpio to control the vbus of typeC port
+- otg-switch-gpios: gpio to switch DP & DM between the hub and typeC port
+- hub-vdd33-en-gpios: gpio to enable the power of hub
+- pinctrl-names: pin configuration state name ("default")
+- pinctrl-0: pinctrl config
+- usb-role-switch: flags the driver as a role switch provider
+- ports: two endpoints to connect the usb core role switch provider
+	 to the usb-c tcpm driver.
+
+Example
+-----
+	hisi_hikey_usb: hisi_hikey_usb {
+		compatible = "hisilicon,gpio_hubv1";
+		typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
+		otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
+		hub-vdd33-en-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbhub5734_pmx_func>;
+		usb-role-switch;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hikey_usb_ep0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dwc3_role_switch>;
+			};
+			hikey_usb_ep1: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&rt1711h_ep>;
+			};
+		};
+	};
-- 
2.17.1

