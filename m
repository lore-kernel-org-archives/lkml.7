Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1A9C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167F9216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bFK+PHFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389898AbfETNs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:48:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39415 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389822AbfETNs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:48:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id w8so14711582wrl.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ts3fE5bTuGyoy6N0BRtizoFKFVetgP769BF9fFBWGDU=;
        b=bFK+PHFO5iWfD0nCgJ85WKQubwVR6Dpu8ZHVpY6sr9pRbwyzfHECVAIjqdSRLWeSzA
         3Fw2LvRNPzuu5+okXgXSHDPI2AMIIFgXN3d0EFZzBWkIgqP3JutsKtWHH2CPsP2IMDvg
         WjN5aWELbgdHEzNi+yZySS/+13+ojsZd3aF8eVVpbkSx1PouAZldLWVe23Zwtvnpptji
         iHHFhWTj9b6KCLoEcfNY8aDtCu5i8BLEinRvBH25pviAtucTL9ada2OZKSueuK9LXydp
         1TrlGibEgbzncxfwqhfFYFQX6ZCMzLcgCiQOTU0b+gfD/714Loe08h6I8CphL/tC3b/u
         ESUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ts3fE5bTuGyoy6N0BRtizoFKFVetgP769BF9fFBWGDU=;
        b=f8NGE+zk2zNepWm72N2Bo8Yt+Gu0g6QKJyHtoxzsB/m4NHNto6/NcYu+KGIIsVxrlA
         YeUvgIJvg3C40KQtq5opOoRcIB6klnkf7ympiMMNVZ5/avUlCfnksE7e7xCGQLuJquna
         9SRkRNeRlRNMciNBMVwROiyqgnEGMM1moS6UiV8y1jU3ZXGW+AZhPy3xk/kgpC/BVtBQ
         qIcKadGxmwe0oNllTiQiU9m3clH6oWeL9iwY8QWRzO5GAXqMJSvUi8LH83dCu3LdviQ+
         oStMy//YVxb4ZUcV5p2u/rjfuC6OZxOnG962ty1hvSfAy5LGUkjc/JEmAhyBeAZ6Kpak
         iy/A==
X-Gm-Message-State: APjAAAWNPYSbAT5JN7HVIail22fqSbfx8JqKSBs9nSMvWR//m8t5gAaw
        ewqDFkN5H/KOBhsEpgcQ2Kg1+g==
X-Google-Smtp-Source: APXvYqzjRAz47hAbOc3zzoJxPwMLmffkgvKgsWZwLoTq81bwJunQUo08tLhwktaWxnsxeE53i/Tp9A==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr47318497wrn.156.1558360107329;
        Mon, 20 May 2019 06:48:27 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h12sm12091358wre.14.2019.05.20.06.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 06:48:25 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson: g12a: add drive strength for eth pins
Date:   Mon, 20 May 2019 15:48:16 +0200
Message-Id: <20190520134817.25435-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520134817.25435-1-narmstrong@baylibre.com>
References: <20190520134817.25435-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the X96 Max board using an external Gigabit Ethernet PHY,
add the same driver strength to the Ethernet pins as the vendor
tree.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index aa678d92238b..8fcdd12f684a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -263,6 +263,7 @@
 								 "eth_txd0",
 								 "eth_txd1";
 							function = "eth";
+							drive-strength-microamp = <4000>;
 							bias-disable;
 						};
 					};
@@ -275,6 +276,7 @@
 								 "eth_txd2_rgmii",
 								 "eth_txd3_rgmii";
 							function = "eth";
+							drive-strength-microamp = <4000>;
 							bias-disable;
 						};
 					};
-- 
2.21.0

