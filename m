Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA549C28D16
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801C92804B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2Ie/h4H8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfFCJry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:47:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42913 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfFCJrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:47:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id o12so4177528wrj.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3SKx4XRWM8BeL1IT8cdljXN1WfKTiELxY4AFeUt8cM=;
        b=2Ie/h4H83Parn1NAqbsfpl+cqjGciqNLWktE9yU8F5Wu1eiuO7vBgmdjroB9d9/6yW
         WGAWpIsqZ5h7Nx9hbcdFtF2M+pT0Y357Teg8UbOmET4h04ZQf30ho2+IUGqfVyQH2aHI
         27ZsFxVQ75uxhiTAKi2koxOYe1MUp7cMF1QczSnOesJQDnLZS1q3rj1J2yMW8AuHCxEb
         pJLRRRh2uKLSA2syI74GTlsxAoEE+SIVHw7prgiwOYRRW/9eSrjaWqdpXNy8MC81N9jK
         8lvz7DL6AMzAnQhLunrEB6CrRx7VOFjrJbZT69UARDmEe1L/xXObO0pykKFoRnb5c0qw
         SgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3SKx4XRWM8BeL1IT8cdljXN1WfKTiELxY4AFeUt8cM=;
        b=alVn8BrEMYEyy9vxwns9JOS3ngvUS/QSjRZN2RLHc/1fh+pp0WcRcjfeJiOseWH459
         sIiUMRSNktmz3LjKJTIIwwXaKyL7x2NDQqL2MegXTl3GJm7MpdZKGshzLzlDa4uxZ9ab
         Qv5wd5VLhqZuXx4laGOOq3KF+HPLc+QF6EHxqOl9M7tVI8O8L12eYkVx3N/tuXKWNBJn
         pDAw3xuoTTsT92d2PQs+8v1tI8Cgwlq8enyY9bgTns14586YUxqragQWr2f/VmoBjeof
         yfqRNyuv07TxmGmUz/EyRe4v9qemR4VfhCtzQYnvVBr/3/HMcqB8Y2ZQsd8YjbeSi+y1
         +9ww==
X-Gm-Message-State: APjAAAUk7AiNvxYwpAn8bxLPQsbSZnhsrGM+AufcXWFAlt0ezFdHo+fM
        ReVFlQ5oij7wxWXPidiOEgu8jQ==
X-Google-Smtp-Source: APXvYqy2XBlQJstPqfMb4Anuzykhl7kWIDzWYiNsCkJbOe/WK+Wjw9v5b6HEixuGViFvp7vEwYZD3Q==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr1580983wrm.68.1559555268990;
        Mon, 03 Jun 2019 02:47:48 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14sm11235375wrh.86.2019.06.03.02.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 02:47:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/4] arm64: dts: meson-g12a-x96-max: add 32k clock to bluetooth node
Date:   Mon,  3 Jun 2019 11:47:38 +0200
Message-Id: <20190603094740.12255-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603094740.12255-1-narmstrong@baylibre.com>
References: <20190603094740.12255-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32k low power clock is necessary for the bluetooth part of the
combo module to initialize correctly, simply add the same clock we
use for the sdio pwrseq.

Fixes: c5c9c7cff269 ("arm64: dts: meson-g12a-x96-max: Enable BT Module")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 2c10ebfd9e7c..aa9da5de5c2d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -206,6 +206,8 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 	};
 };
 
-- 
2.21.0

