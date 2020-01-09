Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF91AC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A6A206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="XOd9sP1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbgAIOCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:02:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52779 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731415AbgAIOCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:02:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so3055164wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4WlGl2APfpv2lRrFN39WYIWl+QrT3wDSJtharCyfCg=;
        b=XOd9sP1TVktE8HKqQnu820uW9CLDKpXDc2oLvP44cMRM1nVI9dp/EfqStuDVL0IaOK
         2GUgfxZa7fXsM7IVB86GRA6c41WAZMuz110w9wE5mJyVcPgPp+LJjM5ljrczxbmqSqGF
         wLmAQsZvC1Cfihj7Sl8c8yBFck1sfS1QNIZgw3x5VWZtRGy1dLctuWBu0RcXMFmyHSE3
         8WrSmubYKBptazOrGeObwN71AAJURhXhKaf+13ZyoIfKI8/EdQENUhpU2gTej7A1gGDv
         wCEr5rPovhdtEomoiruOvOlacyPmscFE39UEnRJMsVv+HOb/AKi8jrk+fuKxaB7ITv/5
         i6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=i4WlGl2APfpv2lRrFN39WYIWl+QrT3wDSJtharCyfCg=;
        b=hP3ew8Txkn7lwD6JdPDLj5wt37vYWjZUY4bQIfaT5rJKUOiVH42B9Af2uDnrY8bzhL
         4zhmotJTFfad9TXE7jO9mg/zl2PD0Znas3Gvykc515R4Fu+IxHSHQafjiCLr9yJev1Vk
         MXLAEFu8faJVUbSZkYTOTHbpfRKUlDyiklgGVm9BrjaleGWCMjJkq4+NxZQMyTMJhFht
         7uvT9azsTvUs3AGkik4+OJ7jrsLVELQU+pgimHivq8mMPoRIC6wrzEk68P8bMx9vUonV
         MeuDP+JbCgSjPinZiG+YthM8qCHRxVaRlCVFA4rdFLr6GJDvxDzvd3rV3hZz2Mp2f8b+
         0gMw==
X-Gm-Message-State: APjAAAVbUOhXk3MqcwmeKNj+XYc/nQclNOG6JUJlS8HLiCuxCN+xa6w1
        2CS/3T5stzEyb4Izt77THTShJg==
X-Google-Smtp-Source: APXvYqz3DqsI5MGZY3ATZ/jamxaASkH6cwXd4RR901fnZTW0429qYhylN5IHhyTmlow651Pues0jVQ==
X-Received: by 2002:a1c:1bc3:: with SMTP id b186mr5092722wmb.79.1578578545543;
        Thu, 09 Jan 2020 06:02:25 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x17sm7971846wrt.74.2020.01.09.06.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 06:02:24 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] arm64: zynqmp: Enable iio-hwmon for ina226 on zcu100
Date:   Thu,  9 Jan 2020 15:02:15 +0100
Message-Id: <3697b726f12df89d6fc222b64672f8fc3779ec3c.1578578535.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578578535.git.michal.simek@xilinx.com>
References: <cover.1578578535.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ina226 hwmon driver is deprecated and it is recommended to use new iio
based driver. The patch is enabling iio-hwmon driver to export
functionality from IIO to hwmon interface to be able to use lm-sensors
package.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index a109e82982ae..d60110ad8367 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -103,6 +103,11 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
 		post-power-on-delay-ms = <10>;
 	};
+
+	ina226 {
+		compatible = "iio-hwmon";
+		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
+	};
 };
 
 &dcc {
@@ -191,8 +196,9 @@ i2csw_5: i2c@5 {
 			#size-cells = <0>;
 			reg = <5>;
 			/* PS_PMBUS */
-			ina226@40 { /* u35 */
+			u35: ina226@40 { /* u35 */
 				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
 				reg = <0x40>;
 				shunt-resistor = <10000>;
 				/* MIO31 is alert which should be routed to PMUFW */
-- 
2.24.0

