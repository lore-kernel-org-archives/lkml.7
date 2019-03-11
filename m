Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B006C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6762084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GktK0i8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfCKJ4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:56:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51094 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfCKJ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id x7so3703238wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VvcECapshJ7XfO9MuKZr8qEVioYerHM8ByTg5+dctvY=;
        b=GktK0i8wbAW4DFjvk1wG9azjHTowgPf2vdP2xIJ/VuYOFzNOAokVyJcAeOf3zHUdtC
         XiPKPgvsDT/ue2DbdmmA3ydOk3w4Bwj3TZ2rpXcjRpVcX9P+4wMLkxOLzHsqcoLiMUHm
         QfVo24ubM3N9HEN249VCCWgK5x1CyiiFabyineQ2Pz1Gxg7MTmccHbbBbghL7TZFF8dT
         9+S4f46TRy12qr+RFSXjFcom9eRUAN2dJ+DuT3o0Fv4WKFC6EiPZPEzrDacLOESwla1X
         iaW8hjKr4Tq7/+/0+WV50QjgIQGd0pvCdkoQA1bUPVslU/wErQK57I11oGvJGMRO78Cf
         CJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VvcECapshJ7XfO9MuKZr8qEVioYerHM8ByTg5+dctvY=;
        b=s0SYDdVEO/5H7I7W4UXq0iC/1j7j2GGrOPCbjIPxv6zNVLpJDd5vVwWizdYcalGU12
         CJ8bxKC9oZA9qTznuAZa1uu3G2t0dsV19SQkNX9JLGsf1Y2f4P0GMkS1jElvKXVysBWT
         6CLKegLSRiPmgyGvSWdrbxqrC4yG5hXGsxl7MCSJZZazgnJqxpsCvzfzYaMz5MdE9Cd+
         5aFSW3KXrQ/4BwWldLLT7nuKlHTZMYYxyzlDMVaMs+n9562uT1rVO+OFaA6BWc29n0Vu
         Z93SepM0zalDMk/3vU8zQYZEhxk4yr779DzDWvBR1l7YPvJ4WmCay9B/QFCdUslDpxpW
         DWOg==
X-Gm-Message-State: APjAAAWc1bwaG+YlqnpfzgF1ma/H7gZWJSPzbWrpc8ojzv3LWMk/2ubu
        3UaP/V50prycnFC38BO7xbtTeA==
X-Google-Smtp-Source: APXvYqxf7aMtO5JIx6vKMnx+gAwJjrEEuGxq/7YCEe/N0eLVwYPxzoOL8RaY1nJaq8VvOYBejFmgpg==
X-Received: by 2002:a1c:9e97:: with SMTP id h145mr16184974wme.147.1552298179415;
        Mon, 11 Mar 2019 02:56:19 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] arm64: dts: meson-g12a-x96-max: add uart_AO pinctrl
Date:   Mon, 11 Mar 2019 10:56:05 +0100
Message-Id: <20190311095613.11371-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311095613.11371-1-narmstrong@baylibre.com>
References: <20190311095613.11371-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl on the always-enabled debug UART AO.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index c62d3d5706ff..0edbd00b358f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -25,4 +25,6 @@
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
-- 
2.20.1

