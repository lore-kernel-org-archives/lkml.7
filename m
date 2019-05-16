Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB8FC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0B520881
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lm3M7Aba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfEPRZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:25:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45014 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfEPRZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:25:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so1936412pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMSAIsZhKZG2h1JTrxIG+7d55aHOlT9g/JHuAffMChU=;
        b=lm3M7Abais25GdMpfAmlFd1RXZxXFphbeQ7jGJe3AKBVsknHbMxhyrH4vT+MBb28A+
         xP4nQPC5QkLetlEYajhKUsKHtuJITm+LT9nnHbWlAddEHLklQyGCAK0zKonDIjCHRuRm
         n0incRdHOE8Y3OOvZzwBzlqIvRx1Z2ohANK2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMSAIsZhKZG2h1JTrxIG+7d55aHOlT9g/JHuAffMChU=;
        b=gGCk0CdMgPOtwp9UTy8kEHTx4NW51I7H9FaXh9eGtXQsKwqUaAfCAOE2GvqzxEBood
         Sn6JCPiXQ5QQTXAomEQ+Fv2mdxvgBTY7+a3yJsq3kuWtzdl74XaANhaCHViDSskMPPA5
         GJDzToW5p0DCGkmrSbXU25oYk0AgT8WdCbLE9Fi74oZiYAAYZ4M7ugHO4NoNKbj78TeT
         osPQcvzFrp9f8eMYy2t0U0pYcmmP4zg0A2UtMNH/+wXi84NB71lmbIjdI8mv0iCpeT6A
         OwSRUhVZg4nSkHaTeIlII+RPAjk7nYiCb1R6O6gPqrQ1lPHCnCT8oueV7RxY4y7zFvVt
         64oQ==
X-Gm-Message-State: APjAAAW07TBliAVTjc8bufJe8lYVAu+pmDOu23x0ufwmkfNjknLiuG5F
        m7nbA0YIJOBRpHCiN0I6VdkarA==
X-Google-Smtp-Source: APXvYqzIUsVmhUrS26/6IMXbb7QozvzV4UhQf72EtAlcEOaL7o68fTla/TZNzSHlTZB49FW8iDdDfw==
X-Received: by 2002:a17:902:6809:: with SMTP id h9mr51869145plk.129.1558027518307;
        Thu, 16 May 2019 10:25:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s77sm13264216pfa.63.2019.05.16.10.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 10:25:17 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 3/3] ARM: dts: rockchip: Use GPU as cooling device for the GPU thermal zone of the rk3288
Date:   Thu, 16 May 2019 10:25:10 -0700
Message-Id: <20190516172510.181473-3-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190516172510.181473-1-mka@chromium.org>
References: <20190516172510.181473-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the CPUs are used as cooling devices of the rk3288 GPU
thermal zone. The CPUs are also configured as cooling devices in the
CPU thermal zone, which indirectly helps with cooling the GPU thermal
zone, since the CPU and GPU temperatures are correlated on the rk3288.

Configure the ARM Mali Midgard GPU as cooling device for the GPU
thermal zone instead of the CPUs.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to the series
---
 arch/arm/boot/dts/rk3288.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 14d9609f0b15..988555c5118d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -547,10 +547,7 @@
 				map0 {
 					trip = <&gpu_alert0>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
-- 
2.21.0.1020.gf2820cf01a-goog

