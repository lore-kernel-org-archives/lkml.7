Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6308C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86401217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tELmZcya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfDKPem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:34:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52414 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:34:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so7285366wma.2;
        Thu, 11 Apr 2019 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sOdMFyKk56d0w/J3QLL7NnLqGzBT/BCupV2Zgzm7Gwk=;
        b=tELmZcyaPQzofEmpxbiQDhIybi2i/HblazXBf079I0m2PqR/XL7o4I0UdLwfjvlORK
         CjH8IxsbX8KXOp1EYE5RaI6VzkDXV3ziVudIFMFJ8lUNA+pf8VWPx2TjAqlU4iZPSgHy
         eouPPTmtS84GnDDlS7nYUfVu0gEUfqAQ6zSfcxKsUxR7BrkwU7TAfNWwi9DsSLCmVA/j
         zf0Ze1kdn6yEDCV9r1prdNagobudg7Jt2xuwgWr9D3BBEzO0f7G/yRJ1mu62VhIp5cHc
         yhHqSupfEVn0OdY9WIZHVAztZbk5J0VtSVa+gJ4tkvO0/hyw0KrzVScIQFeSAtUamb2m
         9fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sOdMFyKk56d0w/J3QLL7NnLqGzBT/BCupV2Zgzm7Gwk=;
        b=oSkw43GPzjMiHalEv+iTwajPpS34sQN1rN3HTYtyPYZR+dXXyWchv6LWAZKVPz8HRz
         aVHDpf4TWuW53C9G6WsXD37ofN7+AInxtvWcyI3AS6o7Sfw6W75tkncJmqk4mAhMXgYL
         XyhI0d+6PVJQHvTxpxUUUJJ5qd6n8HNO7ElBCMnyaHfcVAMvGsmcnbWseOru0nt8zTvD
         pQYFuN/C1eCLQz8ZyzPW3D7wBdJJNY6RTLjcZUaa+bLMY/WdeSmYAJtG/Wjf5pAbWuik
         kVz/fJ9x5DPIntdKYGB/UTN8dtaeivZ3/U3x7k5QM5z7/hQ2c5SMNTLptz5i/zwZgOnW
         2j5g==
X-Gm-Message-State: APjAAAVmo04vA1x9sSgqKqlUlHgL2qbtMHaQtJApuvE2ZWga2gMFSvRd
        XaJL8lEAKaz9Y21B2a4w67M=
X-Google-Smtp-Source: APXvYqxB5zsZhTq5iN8RGvrjpyV2z5T6MlX9Z8fYy30Oe/1dROj4JgP5us/PNYPPYwDN3vj7QLXhHA==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr7161627wmi.6.1554996863911;
        Thu, 11 Apr 2019 08:34:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id e12sm38327342wrt.94.2019.04.11.08.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:34:23 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 1/3] arm64: dts: allwinner: h6: add watchdog node
Date:   Thu, 11 Apr 2019 17:45:32 +0200
Message-Id: <20190411154534.25563-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411154534.25563-1-peron.clem@gmail.com>
References: <20190411154534.25563-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a watchog identical to A64 one.

Declare it in the device tree but leave it disable
with a comment as it is broken on some H6 revisions.

Test has been performs on 3 boards.

Chen-Yu Tsai boards:
Pine H64 - H6 V200-AWIN H6448BA 7782 => OK
OrangePi Lite 2 - H6 V200-AWIN H8068BA 61C2 => KO

Clément Péron board:
Beelink GS1 - H6 V200-AWIN H7309BA 6842 => KO

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index e0dc4a05c1ba..5c2f5451227b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -208,6 +208,15 @@
 			reg = <0x03006000 0x400>;
 		};
 
+		watchdog: watchdog@30090a0 {
+			compatible = "allwinner,sun50i-a64-wdt",
+				     "allwinner,sun6i-a31-wdt";
+			reg = <0x030090a0 0x20>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			/* Broken on some H6 rev */
+			status = "disabled";
+		};
+
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
-- 
2.17.1

