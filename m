Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB2BC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B9F21848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ma2szWh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbfISF3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 01:29:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43082 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388120AbfISF3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:29:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id u72so1178775pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjzjQZaNXsKJUrobfVyNEoaPXPZ7j/Y7jZihfDcfLTc=;
        b=ma2szWh3fZ0CthnlLq01YhUIhLic/fGiuCo9bW1ntc7zj8RhLiStft18NL8DLCIKhD
         xol1qetrlBNmmOldxCqP5M1RBVdgatiqw+pXn6vDzbf9GnHsMTuvjPKDbxRhYt7WVTXo
         yU1N7/WQtkp69Zn2xKy4/PwlAlrecXGJsszkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjzjQZaNXsKJUrobfVyNEoaPXPZ7j/Y7jZihfDcfLTc=;
        b=V97tWs9ZOydjYe1TECIs4RYcQ8mnVWvMmvlNtemmbi6Z5GvmMbbv1GZ3+PyfvIDwaC
         CS3NmxHNkGU/iX6b4h2/tNQQiLLL50MCM8dnhGrJZnJVkPSLz9VDqBkDHE5pNbtCLT2j
         ix/n/KnsPcG87/BvUuKo9L1NwzVU7xWZiwDCCPOS1GMQgPdh0KkyK2wLd8K8SJINM7vD
         hO+lgigPI86rLX5G91VS/i+genX2f075CizctfhsfBg+LAQt4SJDBoGfuXqVrnOf22QN
         kgVFJFF/bu9nPYRITsQWS5qs5isLH8MjB4Dt4/s5rS0PQX6jYjlsKAoKbWoE/UP2ozSF
         33wA==
X-Gm-Message-State: APjAAAUwymB3HGVG/mzH+k+JJjqdpwq8MO0/my56lyxtzrc2uBH4jVKm
        pZ8+0ty0v6pS/CyShXwTM1e/NA==
X-Google-Smtp-Source: APXvYqwMn2793F7u+gsqgIZ7WKzwlSoslHkIYECsncXAbvmDGov1nn2gfmltxgWM2us7xFP2Cmf6JA==
X-Received: by 2002:a63:1c22:: with SMTP id c34mr7195695pgc.435.1568870940513;
        Wed, 18 Sep 2019 22:29:00 -0700 (PDT)
Received: from localhost.localdomain ([49.206.200.127])
        by smtp.gmail.com with ESMTPSA id z20sm5051930pjn.12.2019.09.18.22.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 22:29:00 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Levin Du <djw@t-chip.com.cn>,
        Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 4/6] arm64: dts: rockchip: Rename roc-pc with libretech notation
Date:   Thu, 19 Sep 2019 10:58:20 +0530
Message-Id: <20190919052822.10403-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190919052822.10403-1-jagan@amarulasolutions.com>
References: <20190919052822.10403-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though the ROC-PC is manufactured by firefly, it is co-designed
by libretch like other Libretech computer boards from allwinner,
amlogic does.

So, it is always meaningful to keep maintain those vendors who
are part of design participation so-that the linux mainline
code will expose outside world who are the makers of such
hardware prototypes.

So, rename the existing rk3399-roc-pc.dts with libretch notation,
rk3399-libretech-roc-rk3399-pc.dts

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/rockchip/Makefile                           | 2 +-
 .../{rk3399-roc-pc.dts => rk3399-libretech-roc-rk3399-pc.dts}   | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm64/boot/dts/rockchip/{rk3399-roc-pc.dts => rk3399-libretech-roc-rk3399-pc.dts} (100%)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 1f18a9392d15..73c10ddb4300 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -21,12 +21,12 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge-captain.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge-v.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-leez-p710.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-libretech-roc-rk3399-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
-dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts
similarity index 100%
rename from arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
rename to arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts
-- 
2.18.0.321.gffc6fa0e3

