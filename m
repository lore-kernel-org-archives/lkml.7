Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0775BC47404
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D1C222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vA9rJV6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfJCDWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 23:22:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46464 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfJCDWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 23:22:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so747307pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 20:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Qcbatkrbyyrp3eBE32fuNXC7/HcaftiTNzoulB+n+F0=;
        b=vA9rJV6W6StGzq8ac3QtjivxEU9aoBXxLYIHjyDMcFzWXLUuKJR6aLVf8SrVkfbmGx
         1alqxZaX/KTfcm2X/rJpq3MCA3BbDSQgyrtWgtMk2BvtyLbzuVkey5qqOIDMdbNb+5zL
         0QSW2Umv2uJ12YiDOQ73F2ufn8fUJgbKxNCV7AvBHGVIH72OVQCoGMT8+p35apaUVLye
         7obZ3IabS34qjjCLeP0XLoP2vUDuVIs2qejPcLp9tDZ/Jr4xk0b0lKfMylA73QHevBE8
         OzpwUj3WJ248qonmDXzkU8aTrKDi5bxHfWdb2MQbg1BW/6Mv4yEtgtNmuVwbIgMZVY0w
         YWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qcbatkrbyyrp3eBE32fuNXC7/HcaftiTNzoulB+n+F0=;
        b=uENhOSKbw1K67Jg7ZEgtjt30PmgMByV+cMpk+gk+ZvWsyIZSZurqNtzaYuwR3nNIet
         CzHeq37nw6Zzf3TdsnHn0zlJqdNI1/H/9Jm9WEj04ABzdH9h8EFhTPCLNw1trpp4FDqs
         jsExLS339u+zpTOEsjS6T636g7OKY74/YJrCYaUWeVEAlL8F9BlNkanjfJTZyc0K9iZT
         qY3d6Z34AH7SqxqAmeuHocCvtZoWOmsaVvz2ZkLa4Ct7L1gMD+tyKHMLzADxTk5oigTG
         yGeZyg29BUskj/NNQRIwNo7XfwUQeJDEHu4gvJP5Jc6vI7l/bNpXxd5oFgkODGweRKmE
         qyTQ==
X-Gm-Message-State: APjAAAWPru5mpfb9K7LtIGNKWn9DFqNWhdpg6m+PnybtXFD+yY7yoh0n
        kSOSjvWAiMBsYti7476D6r3uxoKj77s=
X-Google-Smtp-Source: APXvYqx2lOV0eh+Ow8KeLKSt9Zas93Pb/ThAgFgUhO+p+JCOUsHOJLJdQpDh8zxXHDvsj/W+AjVgAw==
X-Received: by 2002:a63:5005:: with SMTP id e5mr7521362pgb.442.1570072957845;
        Wed, 02 Oct 2019 20:22:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d76sm801914pga.80.2019.10.02.20.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 20:22:36 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC][PATCH] dt-bindings: usb: rt1711h: Add connector bindings
Date:   Thu,  3 Oct 2019 03:22:32 +0000
Message-Id: <20191003032232.115832-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
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

CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
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

