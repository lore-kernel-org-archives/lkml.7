Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B5EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C292077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rK63TRNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfH2PYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:24:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38440 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfH2PXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id o184so4291911wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fj/LO7/D7tssJ3to73Z9MGIPwyIiTagd9paTVbTbFLY=;
        b=rK63TRNtrq6CEarF4++/it4urtORDVjn0BExYKp022HdoDVPWrGEfG+f7RTp87ybaf
         dyYEDEj3E1mXX16W2lxXtghN6ZYRMrJX8HSaYN8OuYvUoSY7mvrYzqLD9fkMmDiwMI+C
         mmauM5+hK22brenu2p81TiLbiQ7rFU3j2gkJMeNo+RdI2+Qh+zKLCK3z8vHeG+8PP20M
         0VhkNtV+lFhy9BwEuvjLqmgfHuZbz7GvW091pjg/3CM+5qNAyYQ9YUuwrXe5eY8BEz3I
         ZOTLrk0UV54Pf21OsyyJUppJ8LDAhRPdr7sq/uT4G5vZkmCD6UzQyoUDyQlDWs0+3a8u
         Eu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fj/LO7/D7tssJ3to73Z9MGIPwyIiTagd9paTVbTbFLY=;
        b=YZHacBz/VkqVFNmLr32U9BtdLksYETHfSqxYCl+1KNxl+IUIhFPq/utX2Yd1CXcjq6
         8ru7UdckdWncipJ92HNSE/Yxma1oJi1xJCf5BvTJ62YDxLxTskWJDWtoMiQ6/YilZKF6
         66QT0fsiKir+6AniCXlZ0KI6xCeoPHwODPsHdXlNKsDRlWD0EEiPy1w9lz5VMRtTSxk2
         rPme9vsaelBKAo+NQU1sVy1J0xwrv1AoUfRZl7UmnPIb1Z6LkQLF5j0IKVf1fLJhpI38
         J8+HvbNJ5T4TyPqtNicp8gV7D3JWt2p3fY2nXmdgUYj7gqevKlrbt4clan/uwHrJZ4O9
         zOtQ==
X-Gm-Message-State: APjAAAUxKNZgZ0l7chKcJHL6OHj9dRa2HSf7UL652GE38luiXKHY+E48
        Gu6XhZjanD9TwVwbwZTXsqEceQ==
X-Google-Smtp-Source: APXvYqzoShKlKTer46VXGXNQxBH/E4Wn+9taYruGKsP8S+VHedlYb9VuGCuIYT/XjoXMQlbFGSW3jA==
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr749460wmc.110.1567092229816;
        Thu, 29 Aug 2019 08:23:49 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 07/15] arm64: dts: meson-gxbb-p20x: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:34 +0200
Message-Id: <20190829152342.27794-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829152342.27794-1-narmstrong@baylibre.com>
References: <20190829152342.27794-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WiFi firmware requires that the power is kept enabled while in
suspend mode. Add the keep-power-in-suspend property in the SDIO node
to specify that the power must be kept when entering in a system wide
suspend state.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 89f7b41b0e9e..e803a466fe4e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -170,6 +170,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

