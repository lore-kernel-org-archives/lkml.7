Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8638BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3B720856
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En5KRv+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfEWPLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:11:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36361 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbfEWPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:10:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id j187so6167890wmj.1;
        Thu, 23 May 2019 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1UxkviFcc2uyTwrd3ZvJWwn1Eze38luDkUCGodjsAiw=;
        b=En5KRv+QW8l+oUcFzMAxToxn8fTbpPFxninqX4PPYPg+ijK1iD5FuXyaewyALXg76d
         THu3i0BjLs7YAzwNQzles29+JYXC4fBm8Y0raXJvQ8zlQHs21P5SyT/7/AUu/DvJu+S2
         DoIpeliYoTF20cM8TTmLlyk0nR9L2DJscL9TKagdeWV0Buci77lCNaacPjt2wouIHe/N
         21SAG6uGdFruB5VhYygkCSU1rS5Fy+SbB0rANS12o9Oqg1xjOVQJ/Fqoa21Kcwy5W9vz
         vehaSbHG1R+XiATyKPU0jRTw3z9WI682BpJqWj1iLj9eNHamVayfmxbUwW+v5VEWv7ON
         hpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1UxkviFcc2uyTwrd3ZvJWwn1Eze38luDkUCGodjsAiw=;
        b=dlhsaVqQUM5+oxdFLaobhEyKwQhRdVifv4ERIQauYTtHNa+NVfXh5yTae0UEmLmQ7o
         OGqeQ00aOHFOwg+vZiDNIAJe1Z33SOVeO2PcJEdXg6mVk3HbacMNjWCyYB/se3UaypQj
         Uv4eM7+dAp3DNaTzk6vw95rYmWeZ0zMWrlwGbkP/tWyR/Vp6kwD11lPo5hWKUyzZrb1V
         p4MEpsqk3P6VfkxriG2h1TDNYRi88N04nAPL9vmAbRYdh1ogB99cKiJXY/6f/KclTqN8
         IDxzgTeMzHCDShWNCwVi8xKQZPmcRIVH0nsXtNBsk22L+iRH08HaPAaywNwQKJfmo39V
         Y/lQ==
X-Gm-Message-State: APjAAAXAAadyVN6v5J2vTEbcEvyW44owQtkoz/FuAxMh52xjZ3bfRWyg
        qjjwyL4ALlKW4CJmAmFgpqM=
X-Google-Smtp-Source: APXvYqyBnXGEzrQH5EIcjEGjEn2UAjpqSm02cOAUGl5CqQy0YExdI5o/WI12QkAdGOi6Uf//0UqU4g==
X-Received: by 2002:a1c:e009:: with SMTP id x9mr11880160wmg.117.1558624257108;
        Thu, 23 May 2019 08:10:57 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net. [37.60.189.18])
        by smtp.gmail.com with ESMTPSA id q15sm11436324wrr.19.2019.05.23.08.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:10:56 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 1/4] dt-bindings: watchdog: add Allwinner H6 watchdog
Date:   Thu, 23 May 2019 17:10:47 +0200
Message-Id: <20190523151050.27302-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523151050.27302-1-peron.clem@gmail.com>
References: <20190523151050.27302-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a similar watchdog as the A64 which is already
a compatible of the A31.

This commit add the H6 compatible.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
index 46055254e8dd..e65198d82a2b 100644
--- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 	"allwinner,sun4i-a10-wdt"
 	"allwinner,sun6i-a31-wdt"
 	"allwinner,sun50i-a64-wdt","allwinner,sun6i-a31-wdt"
+	"allwinner,sun50i-h6-wdt","allwinner,sun6i-a31-wdt"
 	"allwinner,suniv-f1c100s-wdt", "allwinner,sun4i-a10-wdt"
 - reg : Specifies base physical address and size of the registers.
 
-- 
2.20.1

