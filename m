Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA47C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4A621773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8xdb6wZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfEWPLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:11:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39507 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730756AbfEWPLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:11:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id w8so6699123wrl.6;
        Thu, 23 May 2019 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gc5Q9HCaQ5rPgkj8KRzJTbdaxTJ0kW48gLvYL3xRMJ0=;
        b=M8xdb6wZwYfZCgHc3Bw+Bw5y9J72T/s0dD3w/SIV1z+UVpKhQ0+QPXNjZDQJEcznfB
         ljIoX+5rCbr7ead2MGjgQHmGV+hAK+zKCuhTsOQQts4NWc6oIwQwWXQFze/rtiUCgNAZ
         BprM+1fpa9g+yedn7B7rv+3fSwcP5zdKtRV0r/wYe+umPZ7hhlMFqjB6z0mWLFHbm/og
         knKO72rDJlbe1v3dzfBs9+8hREUV7kGtlSJNzGOZp/D57uLOb1UtIRqy6FY6uyE17InL
         2QivjhrymxxIIjHPK2w9Jc8QO1DunpEAxBHx5VRXo++XG+IaD8UuDtfbBbVSeUN8ZsXu
         oVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gc5Q9HCaQ5rPgkj8KRzJTbdaxTJ0kW48gLvYL3xRMJ0=;
        b=I7zIcADtlgYo14PzcZ9JyhgxuN0Z/ljUUZeVDwhUNXnCbQjG9LnPFL9aeOQav30q1I
         sy392+95Ii5ARs7G8W3b2ri2hhrYvkgF9rlePMAbqRaqJVmQwgsHIOicSiWOhk129CRx
         mq5XbAuPlml+0m+TCt9YXs+OUue+BxlZtSjweaBxTDXrgvd7Rv7Pg9jG9v1y1VjZ+tWL
         q/8jU+oyldjJ/UwVfR8PJLHWCQToghkmjZKc/4FwtfKFxEqcMTlWfOfr+k4p/Y/0KGHD
         9I+81WbT+HgMslh/idRttb0osWt+WF4uMXVcFoYByLX5n4PxUh5T3Wr2LMVihfDJvH5f
         NyYg==
X-Gm-Message-State: APjAAAUCjEaQFNrkooGSsIHlL7/H+JfyMqV1OgG/Pwj7Ekq9cNTy+oVG
        zkCS3Mj060G895xHF/dxERE=
X-Google-Smtp-Source: APXvYqyhry9skXqUZHuz4MBLzVwV4UhZXVj9Afk7FyiwMdTrNP46yL9NLed8GYbSR7agDLkb5+Xypw==
X-Received: by 2002:adf:a4d8:: with SMTP id h24mr3142017wrb.171.1558624258158;
        Thu, 23 May 2019 08:10:58 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net. [37.60.189.18])
        by smtp.gmail.com with ESMTPSA id q15sm11436324wrr.19.2019.05.23.08.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:10:57 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 2/4] arm64: dts: allwinner: h6: add watchdog node
Date:   Thu, 23 May 2019 17:10:48 +0200
Message-Id: <20190523151050.27302-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523151050.27302-1-peron.clem@gmail.com>
References: <20190523151050.27302-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a watchog node which seems broken
on some boards.

Test has been performed on several boards.

Chen-Yu Tsai boards:
Pine H64 - H6448BA 7782 => OK
OrangePi Lite 2 - H8068BA 61C2 => KO

Martin Ayotte boards:
Pine H64 - H8069BA 6892 => OK
OrangePi 3 - HA047BA 69W2 => KO
OrangePi One Plus - H7310BA 6842 => KO
OrangePi Lite2 - H6448BA 6662 => KO

Clément Péron board:
Beelink GS1 - H7309BA 6842 => KO

As it seems not fixable for now, declare the node
but leave it disable with a comment.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 16c5c3d0fd81..13e70aebddbe 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -208,6 +208,15 @@
 			reg = <0x03006000 0x400>;
 		};
 
+		watchdog: watchdog@30090a0 {
+			compatible = "allwinner,sun50i-h6-wdt",
+				     "allwinner,sun6i-a31-wdt";
+			reg = <0x030090a0 0x20>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			/* Broken on some H6 boards */
+			status = "disabled";
+		};
+
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
-- 
2.20.1

