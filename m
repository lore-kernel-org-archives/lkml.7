Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E953C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC35218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZlR8OqoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfCUOKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:10:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55796 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfCUOKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:10:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so2508445wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AS+LsqYxTTffpazQ8LaxjksLVMmWsfzAl8CHMIyU3HU=;
        b=ZlR8OqoHNR0x1Abt30mc0mzQAi2kRqUjEs+YgVsZblSata6Mcro9/DGFyf9A8zvtqn
         OtFfK0XyCOUh+gF1PA5ks7oxPtdLTHL5YW/2ec9T7QCJOQFvwxUI16Yw+L4VOnZSkXUZ
         f89HAHdOxIzDv4Kxr7PNTNzhnZjKPbWmKQUbuZM4GgsrOI53NPxPbiLDigxE0XJrhsot
         f5xTlY3zUdlh1jSGOAY9CDB61zhveALRP3tolPpesKN0FQeTQgrTBGBwBlUUQe/1vtCd
         36XKyieFZfbOB/Mj31LE9y4yxJMmKI6Lf/JJDOQKO6PUk0pptI+jDirQrHkYKTv2sIGi
         MN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AS+LsqYxTTffpazQ8LaxjksLVMmWsfzAl8CHMIyU3HU=;
        b=Xwfry+Wu64+Ydgyb4nvFyLdy34otpWfqlZBkqnJi87TVHzC1lsBW3s5BM+ABpWuhaO
         kXbku7Pfabfyvx760puysKiyVfxbr+CDDPRAhwHcg7jLbmWQ9COPOKRRxM5j/q4LfDQG
         zzbjuCd5ovpT7YLDBBBnSfYXde8gxTkWGsmwG0hpP5etRBd2s7EogOwLJQikmXpWZrNW
         ceEjLxKOZ+EM5ZgBe10jMvXg4Ddpm/LzKPPxIM9KC6BrSBcBfEPepSGB4pKRhCUnGBZ5
         UJNmKQ37ESbGL7BvIgvHENDfFY5fhiLsONxCjbWBVQCaeOzFH48iWkk1i740R59/gyHX
         NcYA==
X-Gm-Message-State: APjAAAXQ2q0g5sRmWibHECQcsN0x2wBMlTH9gtvKWDb/CHtlrLdidfh6
        r0kfhvTpW4LS6y3Yi2cu2qYSxQ==
X-Google-Smtp-Source: APXvYqyuDsugwPcRH0paSyLqbUONdNxGcyCG0X5Z+Vh/5LArwZDqLTlfDItkNRJbGvVmbf24h5jX4Q==
X-Received: by 2002:a1c:e185:: with SMTP id y127mr2867510wmg.76.1553177419157;
        Thu, 21 Mar 2019 07:10:19 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-20-74.w90-86.abo.wanadoo.fr. [90.86.223.74])
        by smtp.gmail.com with ESMTPSA id z14sm7513921wrv.78.2019.03.21.07.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:10:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/4] ARM: dts: da850-evm: enable cpufreq
Date:   Thu, 21 Mar 2019 15:10:09 +0100
Message-Id: <20190321141010.19612-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321141010.19612-1-brgl@bgdev.pl>
References: <20190321141010.19612-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Enable cpufreq-dt support for da850-evm. The cvdd regulator is fixed
at 1.2V on this board so disable the lower operating points and enable
the 375MHz opp.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f04bc3e15332..f63867692da4 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -151,6 +151,15 @@
 			system-clock-frequency = <24576000>;
 		};
 	};
+
+	cvdd: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "cvdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &ecap2 {
@@ -191,6 +200,27 @@
 	};
 };
 
+&cpu {
+	cpu-supply = <&cvdd>;
+};
+
+/*
+ * DA850-EVM has a fixed CVDD of 1.2V - we cannot go below 300MHz or
+ * above 375MHz.
+ */
+
+&opp_100 {
+	status = "disabled";
+};
+
+&opp_200 {
+	status = "disabled";
+};
+
+&opp_375 {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.20.1

