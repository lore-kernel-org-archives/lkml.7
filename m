Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DA7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93682184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/rrAg9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDKKsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:48:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35287 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfDKKro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:47:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so6057527wmd.0;
        Thu, 11 Apr 2019 03:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuhRBMQmkLmEXKm2BYKcq8wbbgzPSvK5ds0MAMCI7u0=;
        b=Q/rrAg9vBYfYoAGD09Q4fPWwKDuaxC6g+9G+D3o2iFnzPbzoXLBupqwHWGB7gCRj7p
         NOCWoFQmhZyM5KCwpt93Zg1LXcLWYl7+/R4z1apy5PhNn9xOBxZfOqhFBp+8yQ/9Iwt/
         qAnt0/QrsIWXsO0f/YKf9vqYEhvbeSt+5HqomSeolqnzwzm+FIAkVT9tXoaVDnOyAkkW
         hkzyDWcgksVU/UnfbcSuW09l+R9BsrxF65pgGsFLZjljICwYCCOWB+6FQl1eDvtrQm7I
         rb6oULVgDQw2iJH2dceh8bFO+NIG1iPTazsg7B+IZufbMsWsoCoKi2vauXfcU9G23qJs
         u+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuhRBMQmkLmEXKm2BYKcq8wbbgzPSvK5ds0MAMCI7u0=;
        b=mN4nq6oWhpMSRSHfFvNZyra9uAP9SRtEwnOymQJevFKgRODbD1k0KURj5ce//QCIm+
         Whn5qFsDZqNsATOYFgHr5W65OyIlblO/b6gbmGzKUMLKpA3Is22LDS2QqjdztSpDe17Y
         iHQikJTSjg4bS4wVa915OshXqurpe7oDwumrEyHCI3Zowh1hY5d2P+l+DfYj6+pXsrvU
         5NYtzn4XfSM/oOlhXJxF3LXqHQjLo1HbO3azr5nsFzrFj3d9PpZrKOM8+BGl65V+BS8r
         L7LzljUP8FUIny8QVzGSTiY9MCscAo738iIVTfrtO0W8wctvoLtR+dD6/QU4pa0GkgTM
         E3Dw==
X-Gm-Message-State: APjAAAX6T4oWZXIvT7lL8voNPYTvAT58KO03+qCiaUQIJW+7SNBHc31I
        tSlPcIAii5okbnLHMz7bSEo=
X-Google-Smtp-Source: APXvYqw9AN3cvn36N8BP+b3HrDyX+J34RlOJ5e4RGC4s6yTLarYECk9ptfgi1nZ4qq3eEWrNSFs/3A==
X-Received: by 2002:a1c:230e:: with SMTP id j14mr6433035wmj.120.1554979662475;
        Thu, 11 Apr 2019 03:47:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id k4sm54987587wro.33.2019.04.11.03.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 03:47:41 -0700 (PDT)
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
Subject: [PATCH v2 5/8] arm64: dts: allwinner: Add mali GPU supply for Pine H64
Date:   Thu, 11 Apr 2019 12:57:17 +0200
Message-Id: <20190411105720.32357-6-peron.clem@gmail.com>
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
Pine H64 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 4802902e128f..e16a8c6738f9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -85,6 +85,11 @@
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

