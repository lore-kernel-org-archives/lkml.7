Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27052C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F117320717
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqj8P8lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfFDQ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:58:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46842 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfFDQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:58:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so11355538wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nf3jJrNk6C76DJ8y1UTRXRubP+zTDL/JpeAicSCnsJM=;
        b=kqj8P8lxcUc0L8j5tOPPGZ4yyb6M3wmSSOxouSv0loFpvmYHZzWhuVjN2R8JtNK3J6
         jL/vgM1d2yIWkuOyvL8G8D1rzqKASY0EQZOuTRCuQX5ZTda1jH4wqHL7ifC7Wf9r9Gm8
         QLrLFFkDAXx2ymTAn9h5lFpY95u7vQMZBvBwmvo8MOkRNAN44sihGto76GpHK5fdQSyB
         ctKzuQ66jaoP+z4Vx4fzDYUPtMN6A7A+cDQgXSuaNIp6FvxZZKOUGvu56BiLrZo36Q09
         5tYIgdqHNhZCaZitnRU1D/JdWtz1PL0eCmXI/JOgF1dcYXcbd6sjNCRh14ozlcZ9vOAY
         NaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nf3jJrNk6C76DJ8y1UTRXRubP+zTDL/JpeAicSCnsJM=;
        b=uOvIrCcwydrkAW1SGsKhL38rIrlCzinNP20fja6FbjvoK2Vwu1B8d0x+/+eIA9M28Q
         BgVLBDbonIOpBIA08ncYwqPAlS6V/34zZi8JjG18yk1WRILJfTLaIo03E3du8P8vUT1h
         pSIfd32qUxK0sU6/KlTOjmswM/5kkwxBwxzoc8Esg5jFRsarmIO9Rqa/kx3sDr2UmGrt
         4hO+gur2++j9cfxbhaVSUDZyt7mqRUrLtWtYweKe+HlBgGBbIh/wB1U0ucxMEwI+uOV2
         ubhZc8Cud2LpgTA2l45IEOX6HG2JIIszV/X74ytYdd0XzuSJYck4FTJNn/N+k8Hr0lau
         c3UQ==
X-Gm-Message-State: APjAAAWY8kHi6cg3nHaSJvtklZ+/aaC0TTvm9ttVjP0iT1WYcXUy+Wc6
        1kzPCfWto5WqWgfmh5RjX/BLcQ==
X-Google-Smtp-Source: APXvYqxZD1Us/ThhsKGk1nm85wHyP2HqX/Fn7dakkR4+Pd7zhA4BqXTk6Tkmc8vjuYmZTcfBiptgjA==
X-Received: by 2002:adf:e2cb:: with SMTP id d11mr11255906wrj.66.1559667494840;
        Tue, 04 Jun 2019 09:58:14 -0700 (PDT)
Received: from clegane.local (20.119.129.77.rev.sfr.net. [77.129.119.20])
        by smtp.gmail.com with ESMTPSA id t13sm25524979wra.81.2019.06.04.09.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 09:58:14 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     heiko@sntech.de
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        manivannan.sadhasivam@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH 1/2] arm64: dts: rockchip: Fix multiple thermal zones conflict in rk3399.dtsi
Date:   Tue,  4 Jun 2019 18:57:57 +0200
Message-Id: <20190604165802.7338-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the common thermal zones definitions for the rk3399 assumes
multiple thermal zones are supported by the governors. This is not the
case and each thermal zone has its own governor instance acting
individually without collaboration with other governors.

As the cooling device for the CPU and the GPU thermal zones is the
same, each governors take different decisions for the same cooling
device leading to conflicting instructions and an erratic behavior.

As the cooling-maps is about to become an optional property, let's
remove the cpu cooling device map from the GPU thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 196ac9b78076..e1357e0f60f7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -821,15 +821,6 @@
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&gpu_alert0>;
-					cooling-device =
-						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
 		};
 	};
 
-- 
2.17.1

