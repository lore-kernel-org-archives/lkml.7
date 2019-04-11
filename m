Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BF1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15657217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh5qFk6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfDKKsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:48:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37162 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfDKKrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:47:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so6049599wmf.2;
        Thu, 11 Apr 2019 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mlzb91vv83xS6UoRv6kQTj2/DAjCHH1E4jjakjsuiwg=;
        b=Nh5qFk6MaVPdek9JN8ROuJxKlWK/CKVAS5nuwEsXKDiwbRxV/YwyZQuAPNgb+i3pSA
         snVOty9y86iJWjjJKEVuLgUSdECnD+eeufP/jv9pj/EqEpSS/syeWpeluWURNA7KUjYT
         82XNpHufHG15wVFXI77gITwKXprSk0x9iDDbbrT2LXMg69MUz5o1ia6mqS2Ma9DBbM/s
         Y/i4bbDZxjm1Kf7TuctRR5LHfmYjnu0SDNgrJiW6faC0rPCuYSHtj3hTkKYBuDzEjmHD
         b9/4NqbNdPDPdYmdaLZr+KpJkCQzWj/R93QlOFGOC6Ec6UsL1Be9PFWh6N8feWWLC3En
         Ij8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mlzb91vv83xS6UoRv6kQTj2/DAjCHH1E4jjakjsuiwg=;
        b=iEBv3uzpO5VL9GW46/0nOZWVQrpuVrmpQgXr9rRrnB87wxEPFXRCDcacbb9ek/dScl
         5jUL9FGx+R4ro1nCRrK9QfJzba9/DwjKgnCDPtp8Vu32vlT6YY7nmHcjaFWyBojOXEo5
         GZ9M0TxGDaSfzY+QVaicYSx2EGQ5ZBBXdq+FH0ibbMGMKM1UTgK7C2IeHusMYrzSJbK/
         B0e0VIpfUIwMnshkQqRnhDk3Ic3ZAvqXm5qFBJR8Pbnys73pOlKx1HWNKwFR/jaFDBAq
         joLVfZOwK857pVK+1UYUgyNwzLuoqocF1xOysQdWv8kdEREazsbCGyczAmPkAUiN4pQs
         PPiQ==
X-Gm-Message-State: APjAAAXxJf+MDErOzeHp7Ppfoj+x9rw0pq0FhMQA29EB5n41NG9UQBGT
        i15dFBglcB21cf7juAbri7IKFx3be2fgDw==
X-Google-Smtp-Source: APXvYqy3K2FjIzG14mNBpzthX3a+MU1TFHPyr1P7K7PrRdr/Z+5idGHATszMkxp1k+yaHUnT0ehoKQ==
X-Received: by 2002:a05:600c:24f:: with SMTP id 15mr6425572wmj.48.1554979663480;
        Thu, 11 Apr 2019 03:47:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id k4sm54987587wro.33.2019.04.11.03.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 03:47:42 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 6/8] arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
Date:   Thu, 11 Apr 2019 12:57:18 +0200
Message-Id: <20190411105720.32357-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411105720.32357-1-peron.clem@gmail.com>
References: <20190411105720.32357-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and add supply to the Mali GPU node on the
Beelink GS1 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 0dc33c90dd60..21440d572f0a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -70,6 +70,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
-- 
2.17.1

