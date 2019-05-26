Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763A8C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 22:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC90216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 22:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYvjitwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfEZW0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 18:26:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35667 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfEZWZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 18:25:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so14994354wrv.2;
        Sun, 26 May 2019 15:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MeV22BL5hfS4X5C1QCisA6E+loww6qQHxa27Rpq4STA=;
        b=cYvjitwt6Zssvyq0y6oSHGLuaB5wjzWR35lt6S5xd4v662DyRpgwsaejZD4ispPT2g
         6KdrANRs/Yij48RioY+QNv2g+oQ6DRO4FvLSLb97UcWN1BJGgpxxh2oDbuGi/PM2Urd/
         sMZnvjdgb2mHIa0ZPsEesxkjZGjdajj4/g8bPfNCPDBIeRsQH/ZaaDc0t5i1juAmnXYo
         CQDkTKN/ANGGjeh5IAFWb/NQZDkcpmWrICvALYpcWWXUy0u+gRWsev0mE0LcdYlLoSQk
         xWRzb/MVmIx5YPRbgzVLWr8SQ7E05tg6OGklxz7oYbcLzp+0yydxCayJfaG5dOpZZWmp
         cvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeV22BL5hfS4X5C1QCisA6E+loww6qQHxa27Rpq4STA=;
        b=SbMNWK8n2MxYmbQ57cfno58CD16+rWoHsE1xYVCypbswfEEHi3kdnY6IcR2XjKNxoC
         SC2T4rx2jmQKoxEmCBmPApx4RK7BPgrX+HaOAnZOpemmPAvtwXH5VoV8dWpIAWCwggDY
         9VDWWumJ9/J8ItCyxig7yZAjHNiygWPZ35k23QaNYq/bnGJDKLxe24Fbfb1S5JOu1dHV
         B5c4MIBHXyANQRdYcNWWAx2ptN/Z3lhSmDXXNbSWYWAaZcpbjQDNDf/d1eLuRbp9R6HT
         k1VzNU1H/zKfbTI7g5EAueJjO9Sebwf6knzCRVvUSa5KG0n/ATZ8JcI1CXEWh0R4AaQq
         xycw==
X-Gm-Message-State: APjAAAVJJHoWMQk3OtdAE6YaxBcS6NTB1aFDxWSjPLj5QobvkyBOv01r
        vM/B1MdOyFiNyZ0/UgrPSKo=
X-Google-Smtp-Source: APXvYqyTduyrC6vwtzNZtpslsRevUwtmp5f2Hx9nBBNt3DvpbqG+lo3ER9TfZm0nW/X0vDWROl0kow==
X-Received: by 2002:adf:bc94:: with SMTP id g20mr19235766wrh.206.1558909550377;
        Sun, 26 May 2019 15:25:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id o20sm10368398wro.2.2019.05.26.15.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 15:25:49 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 06/10] arm64: dts: allwinner: a64: Enable IR on Orange Pi Win
Date:   Mon, 27 May 2019 00:25:32 +0200
Message-Id: <20190526222536.10917-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190526222536.10917-1-peron.clem@gmail.com>
References: <20190526222536.10917-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

OrangePi Win board contains IR receiver. Enable it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 510f661229dc..e05191b71adf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -180,6 +180,10 @@
 	status = "okay";
 };
 
+&r_ir {
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.20.1

