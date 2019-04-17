Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2E2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1E120821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SOx6tx0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbfDQP1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:27:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35503 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732660AbfDQP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:27:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so4132669wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omOq/JzjjXBt1z2M772CdUZvGc6HDPhhwS/eGDptw3A=;
        b=SOx6tx0xvPTcONKo3ivG/hRw+D+5+CgNurzTgUKK7+I+Bf+OJe1OXWh57JVR5hhFri
         KSUJRIACaLMZMwxhPLu0cSX93VaxlOM7DGy0zyB82P1tDBVdXP/IxOlm+Noro4zlX8MI
         NuJg/5zd+HHF3KSL4lN6c68AxGjYxNhKfNXKAEtBsXpC7GdrlXzRsyKRuBlVYPjjWh39
         bCvxGQ/X/MOhRE52QoQhD4Nh8dl+ZSvwjgHgvOPiT37fKZwxvFsRPI4VjI6ch+/jr7Z0
         +u0EvhiSepxjKBs7tjhs/vKy638CaJp9lmsLjYgxI9Esbjsc70IYU7zU+S6ciWguhVZ4
         WBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omOq/JzjjXBt1z2M772CdUZvGc6HDPhhwS/eGDptw3A=;
        b=MmyGh08D7hWaZpngwTlM3iYqgJUJEMaYF4rvG2pApDIMPypOPSphrXnSWIuyqtbXcc
         I2B/aBOtd3RmcKMZVRCairAI9oPYtrtVm/dE20MK4Ag8unyvMxuBUIxlXXR3Xo9MrhIf
         b1qydq5MBdnfFdOhHgGPVWRF3CGYWC9oW4fKy3iv+AYOL/vwb3U67X47j4/9YWpyyr+g
         S2oiiuJwW+4aWDkbAY1nmtj5Mz8ca8bSS1rt4oe9WTc55ugDjbOIM/uv087+TNT/aCZj
         Pz/zgaMmirI8aMOc5wCtZgcPJmDwzSagS8dpEvlB5K10O4BL7NeWOExIireY1agBnPgI
         /c5g==
X-Gm-Message-State: APjAAAV2vaDEu80YbEStHLLKuC1cUq265t4BvfNozi3Nrzqte0p6ZOtZ
        C/ydu5FvRpsQvzX6Athbunk4Yw==
X-Google-Smtp-Source: APXvYqy20bg9MGWIF3CtkRrLsL1fDJkr3whb1usZVIbA5Z5xQir7vAAydCVo+9BugfPA0hOYryePmw==
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr30792463wmg.79.1555514831614;
        Wed, 17 Apr 2019 08:27:11 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-15-216.w90-86.abo.wanadoo.fr. [90.86.218.216])
        by smtp.gmail.com with ESMTPSA id v16sm75478817wru.76.2019.04.17.08.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 08:27:10 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 4/5] ARM: dts: da850-evm: enable cpufreq
Date:   Wed, 17 Apr 2019 17:27:00 +0200
Message-Id: <20190417152701.23391-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417152701.23391-1-brgl@bgdev.pl>
References: <20190417152701.23391-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
tps65070 pmic with configurable output voltage. By default da850-evm
boards support frequencies up to 375MHz so enable this operating
point.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/boot/dts/da850-evm.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f04bc3e15332..f94bb38fdad9 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -191,6 +191,19 @@
 	};
 };
 
+&cpu {
+	cpu-supply = <&vdcdc3_reg>;
+};
+
+/*
+ * The standard da850-evm kits and SOM's are 375MHz so enable this operating
+ * point by default. Higher frequencies must be enabled for custom boards with
+ * other variants of the SoC.
+ */
+&opp_375 {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.21.0

