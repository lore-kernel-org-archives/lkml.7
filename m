Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C21C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A232146E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HC8fxqJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgAIKPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:15:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55404 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgAIKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:15:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so2224636wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhPSwUwjAsJRbhdmE0cVGRUouZ5x8oaruQHda5jd55I=;
        b=HC8fxqJPjClPxESQg+0LexxqsyidMnZOoLeiIdUEVFGcSScR8sksKA8q5LQ6QyhVV5
         8VBJIJEry4vesoZt4jAg9/kBIHnwcETmPNkSAADxYybXsQR/UKd+wa/m6lVPDPd+B5Td
         13QrybTcCngrUVdXwb58E0/eQaDP0flCvPnqLulrWUvepPx7EUeHe6eJDQ+QsW/oV4nx
         UNraPa50rixC4EH+olOkJKgpoKEFvFWN84EiB+XcVbTNqZKlwa/0ZNfV6ER5mLkg7z2Y
         zKAK6QA2B0KAQrZgSg7oNulTVVT9aO0/LHgomXjDA78sQrB4Q2h6fm2yZ4gkNPBy8vY0
         8XRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhPSwUwjAsJRbhdmE0cVGRUouZ5x8oaruQHda5jd55I=;
        b=L+d5aOEij5EioVMem9j3XlUk4FkmCVPLOJCmI3/3GfLo94gofNKK7xMYcvZ4q8M3z2
         Hego4Nw8BQsQwTWlGD+ZuVGNksJ+/H11aBoOu57AiUrbuU8Q+euF4UDr4KtXgwVznV8E
         qxlRVZtThhCUSPwvP77qwCv1dEWYFkZMe4aDnlqGGxkbLAe7SQNea+aLRW5zt4oXSyaU
         8KmwPcwfoLDExKwro2fvoaGTCaZ1S+9eBTHldoqsKFIMeLSKMHgGRJJKqFC3UBVsKU2d
         woFEz2i+5pIQZGpR9lq2h8ZT0dgApOVjJLDhYHiJKiTOEyYYDxPvoBxNuxCsMGka5aEB
         rcvw==
X-Gm-Message-State: APjAAAUPW/gs5+12MCkwPv03XfwrC072m6fKvShYN2HjhYVlBnu3JXUY
        BAIa7ZnLEZtSU11f/ppP1PJKWg==
X-Google-Smtp-Source: APXvYqweHN/a/x3NQ1r25V7h01jTBfRaAmdv+1exRitS5eU4c76wXJrzSyRMerZ3vIWt3dYZVjp/ng==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr3822007wmk.124.1578564941075;
        Thu, 09 Jan 2020 02:15:41 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q19sm2250460wmc.12.2020.01.09.02.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:15:40 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, Tim <elatllat@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: g12-common: add parkmode_disable_ss_quirk on DWC3 controller
Date:   Thu,  9 Jan 2020 11:15:35 +0100
Message-Id: <20200109101535.26812-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200109101535.26812-1-narmstrong@baylibre.com>
References: <20200109101535.26812-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When high load on the DWC3 SuperSpee port, the controller crashed as:
[  221.141621] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
[  221.157631] xhci-hcd xhci-hcd.0.auto: Host halt failed, -110
[  221.157635] xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
[  221.159901] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
[  221.159961] hub 2-1.1:1.0: hub_ext_port_status failed (err = -22)
[  221.160076] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
[  221.165946] usb 2-1.1-port1: cannot reset (err = -22)

Setting the parkmode_disable_ss_quirk quirk fixes the issue.

CC: Dongjin Kim <tobetter@gmail.com>
Cc: Jianxin Pan <jianxin.pan@amlogic.com>
Reported-by: Tim <elatllat@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 3f39e020f74e..4b002e799e5c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2381,6 +2381,7 @@
 				dr_mode = "host";
 				snps,dis_u2_susphy_quirk;
 				snps,quirk-frame-length-adjustment;
+				snps,parkmode-disable-ss-quirk;
 			};
 		};
 
-- 
2.22.0

