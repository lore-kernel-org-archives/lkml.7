Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028D4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DE820693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mtoQdtYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfDKXXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:23:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44455 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfDKXWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:22:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id g12so4115122pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFRL7YQcOP+54+XtyuurGi/h9kYH21q/4YonKxFfN48=;
        b=mtoQdtYdv/A6dVYfHotuBCeIUtbyDJ8QnSoJHmF2egOvgYBi2quA5A2rqVHRmLi+q6
         ooffBxjq9ebY6p5spGRew+2qrtZvsCRwsRFUDZhgFYTRWVfBDpmirEnzdGSyZbjwSRpw
         jPd3gVaKf/sAQMJEA6kzSp0779qcfGB2pQJ7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFRL7YQcOP+54+XtyuurGi/h9kYH21q/4YonKxFfN48=;
        b=F6YBY5Sru9xks4jLzwY8n83zHRZg7NUXAtxSGhmaDDGwRRzAcvun1CfYcrITNEsZ8t
         RLoBWcLxR1x/vBA3ig3P2qV2fHTkoilNQNCuJCfqwm8dNWsEaMgabVDML+UUO8+4Nrqn
         Ldin3+NhBE/b5I/VlOiGT1+Ziuoozl4l9yuEftkM9FBGuNDJpqpdDDlM3QQF0bBeeoMF
         0qjgcsqJilwU8C9DKZtk2CQ9FEsKj3XbuV+Rn93v6eJjztTFDtVNRW62uLQ2tGnMut90
         EC5pSaaXf/P49YeMTwVYwGH0GtZ307SwzRAFLQwiA9qj0D8/RmHL3Kcdpr966R/TwG06
         FuLg==
X-Gm-Message-State: APjAAAVoF+gz014NjJQSC8MX/VuwbukFlMbrkXwzHxkA6pCfi8sgkg4+
        kTe1epHHp2U52hTIuR2GcBT8fg==
X-Google-Smtp-Source: APXvYqw7aAMpX9Ku6JhGdnv7ENn2RP8AbEIfD/ZttHWgz8+ulfZ4g1HN8piQntu0ujz0VpdwcKBY/w==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr51217464plp.74.1555024970982;
        Thu, 11 Apr 2019 16:22:50 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y20sm37288903pfe.188.2019.04.11.16.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 16:22:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     dbasehore@chromium.org, amstan@chromium.org,
        linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        mka@chromium.org, ryandcase@chromium.org,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] ARM: dts: rockchip: Add DDR retention/poweroff to rk3288-veyron hogs
Date:   Thu, 11 Apr 2019 16:21:55 -0700
Message-Id: <20190411232157.55125-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190411232157.55125-1-dianders@chromium.org>
References: <20190411232157.55125-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though upstream Linux doesn't yet go into deep enough suspend to
get DDR into self refresh, there is no harm in setting these pins up.
They'll only actually do something if we go into a deeper suspend but
leaving them configed always is fine.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 4 ++++
 arch/arm/boot/dts/rk3288-veyron.dtsi            | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index 72c4754032e9..b9cc90f0f25c 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -229,6 +229,8 @@
 &pinctrl {
 	pinctrl-0 = <
 		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
 		&global_pwroff
 
 		/* Wake only */
@@ -236,6 +238,8 @@
 	>;
 	pinctrl-1 = <
 		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
 		&global_pwroff
 
 		/* Sleep only */
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 5c67acc3e6d8..279d7f4ecce0 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -451,10 +451,14 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <
 		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
 		&global_pwroff
 	>;
 	pinctrl-1 = <
 		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
 		&global_pwroff
 	>;
 
-- 
2.21.0.392.gf8f6787159e-goog

