Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AAFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3D5217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oewdvft1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfDJXPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:15:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41806 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfDJXPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:15:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so4818689wrq.8;
        Wed, 10 Apr 2019 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuhRBMQmkLmEXKm2BYKcq8wbbgzPSvK5ds0MAMCI7u0=;
        b=Oewdvft1nTE7uHaoaEMNzogKAQjw4NxxZXX7ivoWsKA1pW5eXe+lxDIyE4NBOk2rHz
         m93d1Z5aVSQgSjE3YKvCpmycl+y311CVJ2UmDxey3St2FawcJU7LPjnYqj0EehzzQL4I
         HWg7riAGQ166jsdWM6o7wCpLfhNPKDyHf9ksuNWC7vk9ghbzI8lOzAZ2rd7c9g3Y4MyK
         x8LCu+L4YgoH0MwQlZ+VZe6iGQ6j5UNZ+JZZ5/1r0qAzeDHppn65vTCiauH5Zigd4BOi
         Y8Jfb3/2dzOx0LbvtNv2pxn85gClUACqmjbbUN3u7xMrI7N6Ag4bfu3F4oojObe9kjmA
         V9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuhRBMQmkLmEXKm2BYKcq8wbbgzPSvK5ds0MAMCI7u0=;
        b=WxDdP1M4V0CI+4WMzsXQO/pEZK7Md4gNuU5FQy0ZAX+ZdND/lTIZ8vOlksnbyacgfq
         cVyrO9dql+fUVbI3cDCAcNijUP8B5toZXGqiV6mUMrjIJ5ezrRiKuXkRxdtUp/j5Pi+d
         Fo/+CrPbGbhbcAWSVhTaCAdgasBVI93gepSMkgFAnYQ/Te34lFSgnsQWP6quEqZUbvxn
         WdJ8DTBEJVPJMlrk3Hpxlf5wX/xzidhUacJV2/p9yoXSNg0hZfuzHf4DijwPnniMGvGD
         r0qdZnTckcucCfYbqMfrQz84DFH26I/3pTA11Z3xPr2Ccv808ysaR4HticTsXCGmT42w
         oH7g==
X-Gm-Message-State: APjAAAUQq2R8IC42G1pwpKJGcTjiGZm/+zPdbnI/CSiGmSItL/KI01H8
        wcggqNoDWM6rtNL9HLiU+X0=
X-Google-Smtp-Source: APXvYqz6YREXV/q/g6DW2SN6F3A7SRojMAVqaFAF77Qiw2G8z/EbNPshjGfgMyxCsiUSJMeiejOg0g==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr7728890wrp.172.1554938134597;
        Wed, 10 Apr 2019 16:15:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id n6sm8504947wmn.48.2019.04.10.16.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:15:34 -0700 (PDT)
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
Subject: [PATCH 5/8] arm64: dts: allwinner: Add mali GPU supply for Pine H64
Date:   Thu, 11 Apr 2019 01:25:40 +0200
Message-Id: <20190410232543.13297-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410232543.13297-1-peron.clem@gmail.com>
References: <20190410232543.13297-1-peron.clem@gmail.com>
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

