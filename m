Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56824C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262EF2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BI8hfDTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCKJ47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:56:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38978 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfCKJ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id z84so3587923wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0mJeQHwni9G1PzZz5IxpYbYbaw1ul62/qW1dc9n8A+I=;
        b=BI8hfDTgA3BUB9GXbu8XPCGETjf8O6HsG4ogOamCLJf2tvdduYx2oEKDyZsQ/YCamK
         0pW6/jZ+29UlhZ/irKE+O3aLEHuH47hi8NHN9UT8tLZzZrITbnFxABF7pA0ALQaD3U8V
         eVqjfu3xxBBfWfY75yLjBAPZSRkzTWpRTBP3AabT3MqrKDxgSc0GGvwFqingzUhKs9t2
         DbsMRYuqeE3W8AfvpVeoEDwkMwHsImlB7dGXV8jNyDeoix1X+d7R1w4FsXi+JUegJiub
         FmYBkpyZoDxXVi+nRY2VuS+kxoeMG2pz6kL/eRU0DEmnmbyyo6JqU8/ZotfAtBAZgqFL
         62ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0mJeQHwni9G1PzZz5IxpYbYbaw1ul62/qW1dc9n8A+I=;
        b=t46/KZrR1FphnZdylHSlFmnKGPZL7bjba8YEVra6HcFY2G+gAM0oSJmfmar4Madhi4
         UsaL435Pzd71qsl1CoPN4nR02S20OjXzA4AljxC06SmE8yGbdzUJhhw89hHa8rFwUjAY
         gXY7dmqYYAhdOLYeSG34xdcD2Pj8ggoPsPs6TtrPR7u0SmTPDED39QOmR2ALNqLe8VWJ
         KWT2vN6hg3pk0hr7jn8hAIhJpVOhmf6MEL7XwRsPjdlrv28yQuUG8KKltSgL8ITMXxIa
         22t/UDIbj+shKSnuhFZhTPFfaBcC5yfeijdJ4B1nGgl+O7HzwjHRKSOrYosTZeR5tMau
         dAvA==
X-Gm-Message-State: APjAAAXGmKMyQy3q7z8DrBAr1BVJI4fVqk80xWJHUMJvggS7xcCVqWq5
        CuoIl4IN6TdHKMrLxUzYwoIb/vGUuBYlog==
X-Google-Smtp-Source: APXvYqzY1e7HfD50NbpmHvvqk/UaIQzx/xAYjtIZJE9tz8zYC4d1mvAKgN11dAaV18IcIkmuOtk1gA==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr15972691wmc.5.1552298186022;
        Mon, 11 Mar 2019 02:56:26 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:25 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] arm64: dts: meson-g12a-x96-max: Enable USB
Date:   Mon, 11 Mar 2019 10:56:13 +0100
Message-Id: <20190311095613.11371-12-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311095613.11371-1-narmstrong@baylibre.com>
References: <20190311095613.11371-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB2 and USB3 Host ports on the X96 Max Set-Top-Box.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 61606601fb4f..625e240a9c09 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -105,3 +105,12 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&dwc2 {
+	status = "okay";
+};
-- 
2.20.1

