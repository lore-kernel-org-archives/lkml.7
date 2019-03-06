Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEEEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF8C20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="B2QkguN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfCFLMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:12:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37343 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfCFLMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:12:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id m12so10001158edv.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 03:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fBsJhgoGrFCnj+gqRWXLatgkoJvBbncuK8fMCwiAQ1o=;
        b=B2QkguN+LbzrcAwzI7m0frGmtI8TB6PVamnZR6METHHol5sq0ydKlyInzcbgJv/MrG
         fg2lt2msy/ap/hiVbl/VNkID3cTlvpPPoaLf6jWe0Dd+Sk2gynMYZTrU6bZr11A+pT+j
         OUtC0FcvP9iiqbwOS22aN5fn8PxXuJEBJrj0JMamWLZM3O2w0gfkb5Rz4QLgyMq8B6/S
         CKTCO/xiihyvUTE4ppXewgh+525H/1il+IeFz/+P1dE84S0vwXbgY2tp4VKZTmyyB9eE
         7CyQ/W2x9+ecIJ8J9MJ7nI7dB7CL/OWLHvx+F8ymntH7WxN0nEJztamnumjRGLcGnlyn
         ldlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fBsJhgoGrFCnj+gqRWXLatgkoJvBbncuK8fMCwiAQ1o=;
        b=A/47yNH0+YBe0qw7/PwdHQvcoFjpfXn60zq3rdmMS3Y8LhLz/BiFuhM8yW2esWlMqA
         0jnhd95rCt4zhXSOQ+8P/UubOsJFOsuqj9yjxnEeYLBnwUH6HFpTcypyo3Eq0eDgL40v
         WODRSF5H8aonIoJwBMI97iYIhc9Y+1K7YzNejqNX2OsxrAkVtMflZNiTureP662FkfIj
         LHYvZtteLIeyMtFicrglekMDF/aGwiIDOdeDqqK94IDeEq3U+Vmg3xO0i0thy3c3gI2m
         kUZ2VMTS6gFudgWdbnfNu/96X/4MAke/AJRrhNZ24wqXame1M5i5ljWX4F7ArwMKFiNc
         oxig==
X-Gm-Message-State: APjAAAUva0p1rJDba7jNtfLkJVVEBBj3mu3VWJOjonWyuMMSirtF/f6T
        L7qhvsQKF48bMqiLGpGeNzaEmA==
X-Google-Smtp-Source: APXvYqyFXAXiCVWXtNAgaIj9RlYtrBEiJ3my+vfuQMRu/79RRgCn9B5KvgVZYlKL83oTfcThvrzD7g==
X-Received: by 2002:a50:ed8c:: with SMTP id h12mr22261726edr.128.1551870755623;
        Wed, 06 Mar 2019 03:12:35 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 03:12:35 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v2 7/7] LS1021A: dtsi: add ftm quad decoder entries
Date:   Wed,  6 Mar 2019 12:12:08 +0100
Message-Id: <20190306111208.7454-8-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 4 Quadrature counters for this board.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
Changes v2
 - None
---
 arch/arm/boot/dts/ls1021a.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index ed0941292172..0168fb62590a 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -433,6 +433,34 @@
 			status = "disabled";
 		};
 
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter1: counter@29e0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29e0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter2: counter@29f0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29f0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter3: counter@2a00000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x2a00000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
 		gpio0: gpio@2300000 {
 			compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-- 
2.19.1

