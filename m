Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3696FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0542F20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ty2zUG67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfCGPNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:13:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43339 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:13:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id d17so17844515wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GBFRZsUQw0bBZQL90PNVj3Jv0ULoLY5X2nGjMgBmdvc=;
        b=ty2zUG67x5jO05y7afpZl98SU7hXHheLhviOFxtAB/sADi7zTrPmb51U/ABPKRYMxW
         LlkYKH5qCtVHihrEFPYVGN5fvdAU0Sm5kb0rhkHDGj9cmL7zH3vonzwnAlYypcRCwOOr
         fm/yGvk51YFIH4tmYp5pylRnVKDgigPoGYYbQ4OjShrS/s0ZJxUyF0ie1wiw8O1VMB/n
         MWfIMPHT++rbzEGgBEinHuim9uXOiEjSTAv50GfzaHrQGo1Pr2QIzVvsVqCCRoRT2p+/
         xMGz0oFRvLpm9LXxmXfYaKZAHMK7KO/7+TST9/DA6kxjyKQ3dtfa3boLmZW+3JRD2ifE
         IBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GBFRZsUQw0bBZQL90PNVj3Jv0ULoLY5X2nGjMgBmdvc=;
        b=sPgh1vgvz4uMhuDzdRwfpUv6DoRkn5eWZIPrx+II6tWtEBWsxjs3RQ294r9lRDAFe8
         cVQMaeFtoeNCztsXbnwYLhGriwTYk8DCpzCnUeiOaZml8g1QQuGd5cYW5eoPeHNGwWYl
         ylsHBCcm/9k/zoax2wGte7mm9Li9k/6hXwQj2XYG1Uyb+5mgkTwnA7Se/4c3/pGj1xXt
         E8lfN+elD5aK+9UaHx7JvTLZQ5LFwI8k/Gkr2lL14QxKSsnkRgbDDssZqUSKa+6W7gI9
         nWMsX1+sxz2VTQ08oPz9zlQcj8SbULW7qVLGbWl8yWoOMkQ4PDphY0Gy6rJ9zhaC6Pk1
         1qKQ==
X-Gm-Message-State: APjAAAVwcCcSAf7qkpUuLU6zJnSlPLpbtPaxoanIYGyqojMwGGseuPxT
        LxoCfShcih4un4tOAGbqmicVQg==
X-Google-Smtp-Source: APXvYqw5tHzPpQjgs5Cg5xx7q1ecOXwNxUk3p6vmcrlDy60aFeZmfHWt8vu60kclREdd6stK40h3Gg==
X-Received: by 2002:adf:ce91:: with SMTP id r17mr6941861wrn.80.1551971625386;
        Thu, 07 Mar 2019 07:13:45 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r15sm5756563wrt.37.2019.03.07.07.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 07:13:44 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] arm64: dts: meson: g12a: Add AO Secure node
Date:   Thu,  7 Mar 2019 16:13:34 +0100
Message-Id: <20190307151342.7381-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307151342.7381-1-narmstrong@baylibre.com>
References: <20190307151342.7381-1-narmstrong@baylibre.com>
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
index 0eb5220da82c..f2fc0f654150 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -139,6 +139,12 @@
 				};
 			};
 
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

