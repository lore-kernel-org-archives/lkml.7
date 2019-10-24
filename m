Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A501CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF49420663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbeaOY0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfJXWSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:18:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34813 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730801AbfJXWR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:17:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id 139so176571ljf.1;
        Thu, 24 Oct 2019 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLnPwIcCcepxh+b7YPRNDobkVHJOYTd9LBCVyPpFgVU=;
        b=cbeaOY0oaLsDTVIZ/6C+RqIgv0/rE7X29KAeqc+sVWXkqs+vr5A/WoKunP6zj98qXk
         Djnfa5/OA9RLLNsSbesPu2Au+fya/SWTIqW5TDVGLKcA5vz+P7Atdzv0FrZbQ4OP2JLl
         qCUartiLSG0HhyZW1MreztG2mvf6KAGgYkw+5nOSqqGJQxKdCMgCGx5CZODgCzrNLH5S
         UhNfLGntbAu2k7dyWclaIbSKxBJCmUcPp9HnyC8QRrz3t6rWKVgN6+hcwIQWdGG8gUDo
         6F019JvKYP/RSQDYlf0WSo2NJB+99J9szcnqAw86lrg4/PIXH9kd08o4zyZ0n/0yeoot
         MHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLnPwIcCcepxh+b7YPRNDobkVHJOYTd9LBCVyPpFgVU=;
        b=oz+CmfVxTA24XkLLQXABVEiOpnDRjRkW/twXxSSGJ4Le0BrRD21JqKZgEpJwNjwzRg
         0TpWFs7sCnTj/A7tmM5Q4OK87Qn+EVJp7NDn1aoVPUH09bQgY1Yox+eAx657wPJbWJiB
         CBhk2igEvd2xxuBgUMHBYXJcEUt+oleVAWX4D9i4vH1wKYkRkgqx/SEWjjLKKr7wVu8l
         oSRh5QLUalpsko+1nnhDm4Mz/w0GhhmQToPs/xfc8qU9tgfI/YcGQgm2FVpTqEqKoZCs
         54KRy2rkUBQhCwM93EqpYl6Ihl7fb0E7zqUOBiPt7o225npBaTla4l0c5I7RxmbznSQc
         a3PA==
X-Gm-Message-State: APjAAAWPDWKw7dOjrAMrkvOXOsH9V4b96+xTgMxespSWRbKEhs2qJhD8
        NGlgSFMyBoBOkimCXpOKiAU=
X-Google-Smtp-Source: APXvYqwGW8i4xEA9dfVPi6DpqEFEKcLGsmKJ5pShWapvEkEy57MedrNQSM5pZR7hSo4iOtEexpluFg==
X-Received: by 2002:a2e:9655:: with SMTP id z21mr43753ljh.252.1571955474929;
        Thu, 24 Oct 2019 15:17:54 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/17] ARM: dts: tegra30: cardhu-a04: Set up voltage regulators for DVFS
Date:   Fri, 25 Oct 2019 01:14:15 +0300
Message-Id: <20191024221416.14197-17-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set min/max voltage and couple CPU/CORE regulators.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-cardhu-a04.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
index 4dbd4af679f0..0d71925d4f0b 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
@@ -103,4 +103,28 @@
 			gpio = <&gpio TEGRA_GPIO(DD, 0) GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	i2c@7000d000 {
+		pmic: tps65911@2d {
+			regulators {
+				vddctrl_reg: vddctrl {
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <1125000>;
+					regulator-coupled-with = <&vddcore_reg>;
+					regulator-coupled-max-spread = <300000>;
+					regulator-max-step-microvolt = <100000>;
+
+					nvidia,tegra-cpu-regulator;
+				};
+			};
+		};
+
+		vddcore_reg: tps62361@60 {
+			regulator-coupled-with = <&vddctrl_reg>;
+			regulator-coupled-max-spread = <300000>;
+			regulator-max-step-microvolt = <100000>;
+
+			nvidia,tegra-core-regulator;
+		};
+	};
 };
-- 
2.23.0

