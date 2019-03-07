Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC0EC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA872081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TnjgW8Ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCGOCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:02:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36589 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCGOB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:01:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so9388836wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1TMWMcZ2gju9aWPi4sVcpM5P0Y4XnnG91Swh/yLEoM=;
        b=TnjgW8RibsO5fE6FaPH/e1Q5cPheNQETFNEUQRgcrmVzxEHAXXNxUWdutFr3lOlg25
         nO1/k5C9wMKvgqPcgenMK2XzM+uTlcbw79wPjNi2vkNB6Zzvfil2vRNFKkOyxhy9QWqT
         K5zIzZ9r/WrLBGEPIZgr1TG+q+VvQF1CbnEaOpuvxcpSIPrqPVkoipY5hKQbLUXF5H7W
         OHg9eFK0aDZuOJJErP6tZOH8YYS39ZSZW/PYKQ6IiW2wF06c0tvGi5Mr7vXBMLcO8494
         h1rOe0zW095znRsASSJWgVLe+qpUbzRqPUksg+zT6JVK8oAkCEmItmOKgONUUylgbQPE
         ZlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1TMWMcZ2gju9aWPi4sVcpM5P0Y4XnnG91Swh/yLEoM=;
        b=IkSIIUA1FLf6OpchCaSJ+T+jqUn7hFK5OHiDV/swvJ3B8bLFfRlkc+8kiGLKejKdi7
         TipkouxvoTVdCpSKA6u/jn587KXKd/YRqoqC2sDJPNFdJdzluGUTEYXBJ5Vh53xr48bB
         DhQB8vnWIIMyHizM5tvqYmkbnailjXPfs679CDE13hNVpakOQS9ai7dzgcX7biOyZFNS
         qe1vnvMiPxPEcdeOWm7NAg87+ddEZfOBhDbuZ+59YIARyIxnOpTJ83QmnJxOQ7xp6Pbz
         87VeMHtdCCko5fGiPcq+qxci5QM+wnW+coJfq9tfJENBTYPk88wKnZ/3wDFhCxTrVtLT
         4EGw==
X-Gm-Message-State: APjAAAViH1LNdPLvV7zZ9bAD7mopr0vk6RG4BFsKPSH7b/aPNtBUnqoW
        zzMBdtb5bfSkGIBXHggrV9SGkQ==
X-Google-Smtp-Source: APXvYqx/9WiONgfX7WxSX0zmZGGa6JptIQyZwOtRi/y+0BqYrz58K0KS478PyRtq6KUlq4uM/Dj6kA==
X-Received: by 2002:a1c:e715:: with SMTP id e21mr5775206wmh.122.1551967313763;
        Thu, 07 Mar 2019 06:01:53 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h137sm9892098wmg.41.2019.03.07.06.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 06:01:53 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: meson-g12a: Add AO Secure node
Date:   Thu,  7 Mar 2019 15:01:47 +0100
Message-Id: <20190307140147.22047-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307140147.22047-1-narmstrong@baylibre.com>
References: <20190307140147.22047-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Always-On ao-secure system control registers node,
which is used by the meson-gx-socinfo driver to detect the SoC IDs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 191d31db9853..30aa618dce49 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -122,6 +122,12 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
+			sec_AO: ao-secure@140 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon";
+				reg = <0x0 0x140 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
+
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
-- 
2.20.1

