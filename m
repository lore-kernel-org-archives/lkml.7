Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35732C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03905217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PgFRHz9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfEUXuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 19:50:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41487 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEUXuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:50:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so299280pgp.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 16:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7q0PelwL9bKMV8j6fotAmIIGWuu5yPxHabkyZucfWSs=;
        b=PgFRHz9LTKAW06xheSlCgmaBYlHudfTzK+hJD9m+hf4w8jZW0zxEWlzYfdhjW8BoOz
         sDx93ktSy6nK4r9e0Z/eFmV3NlH0dxZppw28/hubD1RTw5WFELEY0B28z0t71MVdkawX
         tofgt+pzOVwVuSxr4zX7Kr3vgG7xf/Uf45AW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7q0PelwL9bKMV8j6fotAmIIGWuu5yPxHabkyZucfWSs=;
        b=G/a8kkYDJmj3Nj9Oxy5hnUHrcx8Gco8kqtBYKofBQz9Hi9xenFEHW8Hi0qY4Gnil7Z
         sAN9tE4BPj/LGCSoANxHlB6RCDXQhQtPZ0bkIEanygBT8juHC0j0bY7TnCvz4reyUfiC
         vzuX9WuueOxk5z2wU/MusiHudQYJCRttk/sP1OqVyCiHFXl2+9u5e6ciC7xvbnrIfCjY
         WMAIE2faBSGD5b48DznrWP6NNTfwaxRfBidld2AH9kOiKrEUiT4k3PxHeu5rvQ5Bj6f+
         ZBUcZJNpXDqlovb1LHiDYPQjby3aVL7MauzixFG1NUuqpBxqQNfzFDK5DbxZ2nR3yQZX
         +Tvw==
X-Gm-Message-State: APjAAAVQ80ftJS2JfZXKrzOdIF2qoRPSb8thEXjLiqrojz4Oa3vm3wSR
        rFDnfuOD2J9HMU6FBrytMLL5kw==
X-Google-Smtp-Source: APXvYqyw8kaeTYK/TiQMeIZGSd18nYuR1FaVotEhqU23R+CYW+qg0qbUu1Ce2nBjA7PX/xVkt40Fqw==
X-Received: by 2002:a65:64c9:: with SMTP id t9mr85741782pgv.221.1558482608692;
        Tue, 21 May 2019 16:50:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 194sm19955605pgd.33.2019.05.21.16.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 16:50:08 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     briannorris@chromium.org, ryandcase@chromium.org, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: rockchip: Mark that the rk3288 timer might stop in suspend
Date:   Tue, 21 May 2019 16:49:33 -0700
Message-Id: <20190521234933.153953-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is similar to commit e6186820a745 ("arm64: dts: rockchip: Arch
counter doesn't tick in system suspend").  Specifically on the rk3288
it can be seen that the timer stops ticking in suspend if we end up
running through the "osc_disable" path in rk3288_slp_mode_set().  In
that path the 24 MHz clock will turn off and the timer stops.

To test this, I ran this on a Chrome OS filesystem:
  before=$(date); \
  suspend_stress_test -c1 --suspend_min=30 --suspend_max=31; \
  echo ${before}; date

...and I found that unless I plug in a device that requests USB wakeup
to be active that the two calls to "date" would show that fewer than
30 seconds passed.

NOTE: deep suspend (where the 24 MHz clock gets disabled) isn't
supported yet on upstream Linux so this was tested on a downstream
kernel.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 171231a0cd9b..1e5260b556b7 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -231,6 +231,7 @@
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		clock-frequency = <24000000>;
+		arm,no-tick-in-suspend;
 	};
 
 	timer: timer@ff810000 {
-- 
2.21.0.1020.gf2820cf01a-goog

