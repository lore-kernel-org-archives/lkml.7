Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F5CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9592420820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ0Z3Nmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfDJXPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:15:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46935 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfDJXPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:15:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so4786977wrw.13;
        Wed, 10 Apr 2019 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mlzb91vv83xS6UoRv6kQTj2/DAjCHH1E4jjakjsuiwg=;
        b=aQ0Z3Nmy6q+KAq9UiLOjZNsYt6gp5r1F7edVKxFr8RJT5sv06MLjmDhNGhrw+o+W9n
         PzluCivNfLBQesYNXDitq9fqOLSeFEubZI9mGg8U4ctw5vd9+z9zgsUMpzFNyHBPBUy2
         okRTLzsEXwQy4P3kxRdWJ3dvxs6wzyaOQy3hm/TIYK+iWDpskJkVCY7MyRGWoBzx2S0f
         ToA3qu5p/Y777kF6b5kGftWCTa+jjj/xhr+oM51H8bmDvd2n/rL4B5QIUAwmuMK6J/L+
         wq4uvX+66HOfcdY+oMreM0wW8yD13a6rLc8TRm0GxaqziQjk3amugpm6YbOQP+LEV3vx
         923g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mlzb91vv83xS6UoRv6kQTj2/DAjCHH1E4jjakjsuiwg=;
        b=p1vlwK7AA4EqlNrgKE+kG7x5jYw11dUp2UiAxxCAmmPc72DwmdjT/1EVW9UX89CPnu
         NUwYTLL78hQl45jVao2HH18OydwMaC71B8+HEUXvuKN4Kdlk0AaItcX+tnDV33S9GguL
         DIVRBDdDE+OKCEgqnmx21aLc9Y5pimo+L1N3bMk4YZwQ3UQuhqGSHDYvXQ1Yf0BW06dQ
         V9ydAjkh4nw7hFjiAVXGsyZ7XvbteBScUfUVMyfBZcJ91aHOxpCa+bLfoPMNH4jxZZuZ
         oGxe3iZCVSkZepx1X45cxj5tFA69cqbUbpJK/JEE+JG+w8VbShmfRp2apOSeIg5U0d/o
         mjPg==
X-Gm-Message-State: APjAAAVxzBZQ8R+5aNRWMM2ws4NpJRadbzp4OHtwVAjy8ogW/kVrTHOZ
        wAZSB+4s5uzwp3OfmyO6HqgMcg9sriOCww==
X-Google-Smtp-Source: APXvYqx0kRReicqPxEr0DtPz5CEZ+SMgO/aZGoexG+gUk3h9/Ak5QGZXIc8sBOCXrGvjcIzIHGWrrA==
X-Received: by 2002:adf:fe03:: with SMTP id n3mr9255409wrr.59.1554938136072;
        Wed, 10 Apr 2019 16:15:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id n6sm8504947wmn.48.2019.04.10.16.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:15:34 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 6/8] arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
Date:   Thu, 11 Apr 2019 01:25:41 +0200
Message-Id: <20190410232543.13297-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410232543.13297-1-peron.clem@gmail.com>
References: <20190410232543.13297-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and add supply to the Mali GPU node on the
Beelink GS1 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 0dc33c90dd60..21440d572f0a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -70,6 +70,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
-- 
2.17.1

