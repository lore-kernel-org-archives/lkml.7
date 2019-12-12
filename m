Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23027222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADWf++LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLLBmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:42:45 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37513 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbfLLBml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:42:41 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep17so322303pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 17:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jz3XZ9gPuD/g+1P6LY7Aq8wTOFKwQIrTyqi7Mx3AGIU=;
        b=ADWf++LNikL2sGcTcPh38acVlVtjYE212k4TEnvD+Rlztp08dFU+PiVdolU95yghh6
         if+zoAeLlhz35y8sJOpcVWTpgCkbiTRdT7UVFZ8NunPzp3KQLHiuLU72mrPDlXlgSFzF
         Qg76tZUqRmSr54W87h1n0CZgA6NFZHf0PBE/vqGlb5jKzdYrpuWrOVyOJEBBJG/+wKbG
         AjkTYbw+imyPgYY5IOoJieUH9yT/QpO6cub+CG/cQiNynfS9eC9OgqL54UdE51EvzMYi
         I1BjdPjZYGckxWevF0rkr1EtzpTBv6ZZjAcidkSpzf8uiRC9c/6TSiuLBHGL6on42fkM
         pptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jz3XZ9gPuD/g+1P6LY7Aq8wTOFKwQIrTyqi7Mx3AGIU=;
        b=B7VZhXhu1L5/j4YTbug0+xCESFYQAnkli/2xrWen5Mp8Yjx6rg0SPLeH291lY+t63O
         K+JAZObF2hQBz6ag3WBK2t8oMLP97ea/dIe5hyh6MvcSmSDvhBmvBwLZgMzT/r8FhDQD
         bmGS4lJS++7aALiing14qIS7crUnicdOxueP1eYK1bq1DmqRXXum92LjoJ3N6VDdudGZ
         x9v1VpBRQbq2Wg3y6Iv0nAaf31bXeNYF2U6TCOctJUBW0VeQ+7odRTNVd7fI0LiPtqvl
         dEl592M1cndJhWBd6VJ6LxRHdexhi8EW13tED89wiZdi+GWg/oPmTaehWbRf1JEum8cK
         rxFA==
X-Gm-Message-State: APjAAAXijDSr8hb/lVOn0iXYmvNlXt2PAbreYbOU0ZRkAf8kHnyxornw
        9NMma3Blg8qL0VXZW22hKHJmlgFBJ3g=
X-Google-Smtp-Source: APXvYqz745Iom7BCnhPJbNjWnLV0N315h5uwmC47BUMzZV6zx6EdHy7BP/H0GGZcWSHDGlWW5rf7jA==
X-Received: by 2002:a17:902:8608:: with SMTP id f8mr6851979plo.106.1576114960549;
        Wed, 11 Dec 2019 17:42:40 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id p16sm4217996pgi.50.2019.12.11.17.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 17:42:39 -0800 (PST)
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
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 4/8] dt-bindings: usb: dwc3: Allow clock list & resets to be more flexible
Date:   Thu, 12 Dec 2019 01:42:29 +0000
Message-Id: <20191212014233.32799-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212014233.32799-1-john.stultz@linaro.org>
References: <20191212014233.32799-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather then adding another device specific binding to support
hikey960, Rob Herring suggested we expand the current dwc3
binding to allow for variable numbers of clocks and resets.

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
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 66780a47ad85..29768b0ca923 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -7,7 +7,8 @@ Required properties:
  - compatible: must be "snps,dwc3"
  - reg : Address and length of the register set for the device
  - interrupts: Interrupts used by the dwc3 controller.
- - clock-names: should contain "ref", "bus_early", "suspend"
+ - clock-names: list of clock names. Ideally should be "ref",
+                "bus_early", "suspend" but may be less or more.
  - clocks: list of phandle and clock specifier pairs corresponding to
            entries in the clock-names property.
 
@@ -36,7 +37,7 @@ Optional properties:
  - phys: from the *Generic PHY* bindings
  - phy-names: from the *Generic PHY* bindings; supported names are "usb2-phy"
 	or "usb3-phy".
- - resets: a single pair of phandle and reset specifier
+ - resets: set of phandle and reset specifier pairs
  - snps,usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
  - snps,usb3_lpm_capable: determines if platform is USB3 LPM capable
  - snps,dis-start-transfer-quirk: when set, disable isoc START TRANSFER command
-- 
2.17.1

