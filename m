Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C89C468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E8B214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QZjMrwAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfFHTEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:04:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37097 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfFHTEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:04:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id 22so4740543wmg.2;
        Sat, 08 Jun 2019 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hdxuEQn0STw1aQ9FCTiwldIwv18/WN0vzmjlgvEyWyw=;
        b=QZjMrwAW7hCZwc6hnQh84HpuiO6yrbow8vNYRKpEE9KI7iw2G+ykJX1PMWWU+N9jI9
         a00fgOVApYpMeyzxjRQa51vXYSakp8nSwddIhyGxS9Vne08/vL9jAlDJWGXOi5Mdrnaz
         fiIoCgRYSEHi7JkMwRRHlpIenmBp+axyv7i4vXoE+0hs9gW6n9jrQuppbmxf0I+83jLm
         p0u/IAtMr+I/DrmRLl6hIp3Vu4xIAjEAMzt2XVFtFmYNZxr/HoeZ4eQYx/fnpNd1DTRr
         yfy/5vG9azl+hA701qnzFjRvnShlwivzTzzKbEKkFNf82stauX/Q57AqkWLbWavRxlxN
         oMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hdxuEQn0STw1aQ9FCTiwldIwv18/WN0vzmjlgvEyWyw=;
        b=W8FeeIfXxLGauvFycZJQHDHfkA/TekAYg/+t3BrvPUhardzcnMIXxAdqPTCrV08ylO
         uix49ywTXG6sVEXw1RGDXKf8d8Gyv60VkcQRlgQV/C4pLtz5a5j9fLXnQTv/MXMIvebN
         p474TRWiXsABb20YcWSexDhbXvSTaw6njIK/wKFX0I1vGqMRrY9UvlIeOFuDRAr5z6Vb
         EzEiFmwG9dL968Nm1ZhMjrvWoO/sCzeC0vZw+d9wUjINzBdHrHDdg2o/Gz0Ny/M8VUPf
         poBGMwOAmieMeBDf2iTBA7RXhRvaZbw62THJYX3mNAe5mzBcpu4r8WNnZSkDDChsNjp8
         gpsA==
X-Gm-Message-State: APjAAAUTdeBXWwElifFVDIN4pr0AjDCd2Bpl2YQNgsgmEGopCu7hmaxi
        x9VKQgGJO4Z4dKiCHsuzJz82nZ+Y
X-Google-Smtp-Source: APXvYqyk9WF0R161lhx1mz1DHCVnXYdH0tEiA9AwdCPfVQqF2JAODnTvW3Gp+I/yuDzam//4iu5drw==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr8372277wml.124.1560020658223;
        Sat, 08 Jun 2019 12:04:18 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id t6sm5655062wmb.29.2019.06.08.12.04.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 12:04:17 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/3] dt-bindings: interrupt-controller: New binding for Meson-G12A SoC
Date:   Sat,  8 Jun 2019 21:04:09 +0200
Message-Id: <20190608190411.14018-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608190411.14018-1-martin.blumenstingl@googlemail.com>
References: <20190608190411.14018-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Update the dt-binding document to support new compatible string for the
GPIO interrupt controller which found in Amlogic's Meson-G12A SoC.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index 1502a51548bb..7d531d5fff29 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -15,6 +15,7 @@ Required properties:
     "amlogic,meson-gxbb-gpio-intc" for GXBB SoCs (S905) or
     "amlogic,meson-gxl-gpio-intc" for GXL SoCs (S905X, S912)
     "amlogic,meson-axg-gpio-intc" for AXG SoCs (A113D, A113X)
+    "amlogic,meson-g12a-gpio-intc" for G12A SoCs (S905D2, S905X2, S905Y2)
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.21.0

