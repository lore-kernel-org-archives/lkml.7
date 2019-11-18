Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3815FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D432073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLOox4gX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKRJiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:38:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34821 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfKRJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:37:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id s5so18575817wrw.2;
        Mon, 18 Nov 2019 01:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGqUalssFt90BW+qC26cPJ2ocimtOg3RIH0RE3W1sS4=;
        b=tLOox4gXBgeuMcVf6MPAAv697SJ+irwwdmKmBr5Y/n1W/KDxkadEcy+ffgp4gbfPu2
         YZV8mDzXoU/DHJ4YvPNk6Gx8xVQUmQM+rWgm8jV3IXROjViFIosyi2eLKzbPRW4PsS3p
         w54uwjSjthL3gl9VJ3VhNtAYWBieiOu9+kVg6q3m/yVXyE1y5OY9eCfPv7+ckJEiJIAq
         3bYg3t107yXwdeHQdxi5D7FPBk/kxLgrhUYhnR+GJEYplDIVEeSm6GpMp2u9nO5bK99X
         H2eZa0YyOymjzaVKyI355x9IQR2srhgyyc0MldA0FBfy5LN5srnSclLFv+FCrhfjOTCh
         sZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGqUalssFt90BW+qC26cPJ2ocimtOg3RIH0RE3W1sS4=;
        b=dwjBxqU5sIuKzFvxSrCEzCkwCrqDUgWzWyrpzNz47zVs8CeN3AQhsm0jftHjl6uC/I
         XVbxVjQzuHtaZjOQn/TrT0jgKZweb7JpivHPX9aEs7RMDY3ffbFXd9NOtnirUehHbc8L
         //N+SR0rpkFia1KenZDC5v3UrnGUrMzGUwaDT627ITU23wUkfcKkHNT1D95wYgpI+Tly
         sWyoKHgMzv0ov8hD+//piJQI3vGe2yTWLdq/4DgcRoWuG0fI6FXHW9fQaCmvHQnPn5ts
         mti0fNCI62Kna4g6FY0+Tn0nglkaPaVBLvlhvroZ+LmPAUNTfwDDnL2QRbdoU7up2wQv
         GNCA==
X-Gm-Message-State: APjAAAXyXXyKkZPy185pV4NHXC6irZAiuUryrU9ZJ4xiBWePadaUxRIj
        97Y/wo2qLrWp3j2RJN+zzeM=
X-Google-Smtp-Source: APXvYqwJTC4TGwM9hvlm2LKX+ev9HQJG633L3So58N0alxBGkAmetvFIYpwsUfKCX1Z+oAukbL2Qkg==
X-Received: by 2002:a5d:4b08:: with SMTP id v8mr26653916wrq.338.1574069869088;
        Mon, 18 Nov 2019 01:37:49 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id w10sm19006687wmd.26.2019.11.18.01.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:37:48 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 8/8] [DO NOT MERGE] arm64: allwinner: h6: enable Beelink GS1 PWM
Date:   Mon, 18 Nov 2019 10:37:27 +0100
Message-Id: <20191118093727.21899-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118093727.21899-1-peron.clem@gmail.com>
References: <20191118093727.21899-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index f335f7482a73..cf684bc7374d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -136,6 +136,10 @@
 	vcc-pg-supply = <&reg_aldo1>;
 };
 
+&pwm {
+	status = "okay";
+};
+
 &r_i2c {
 	status = "okay";
 
-- 
2.20.1

