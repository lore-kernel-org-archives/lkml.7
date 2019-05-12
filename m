Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB90C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DE3217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u24eCC2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfELRq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:46:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35044 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfELRqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:46:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id w12so12735356wrp.2;
        Sun, 12 May 2019 10:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lb3IP/Hl9lXy/TNODmgqSdzhcHKCTOi5Q6K9F3iD6Yc=;
        b=u24eCC2SgKLBkmO/LnDz2izzPhp4h023a+HZEvpM6YzgQ7pIzUHZItuuECjuW4vP60
         E85x71N9IoxOKj5h+cTaH25KQ2NWmsQvioP3XzSdgZBXrg7CLYBHjlWO+zr/r5rnPZ7o
         AJ5kguSwtuaoBFvZ0fpVvxWsAWn7HvTVWdhsyTPpIir82PdndXqLNSrYL8EWwJZPF07H
         TI70oBn08Y/j8mgJdUPt4t8nBIHU7TTUFoK4NO6PQiiKtX3JwedlOTGCBCQLfkTKwxCZ
         18Wxma2Ew8biSRB8zxUY25ZZ7P2x5171XH7oXs8gjEXcdlSdJ7DY6n3VNWzMj5Vjf6/+
         hw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lb3IP/Hl9lXy/TNODmgqSdzhcHKCTOi5Q6K9F3iD6Yc=;
        b=CgNSUEpBdUK/Q9SnxIzDv3SoCnf/OhUelI4cJYxsOPRnHI8PG9fcHA8kkRrFagMJ0f
         mgs8VjD4pzadal9lS4blOvhRkBIYFIQvT4RwdqYoUBFFCM9+IYGAK/R/xU9/6AOaxP5o
         owTTzFGaJRG5lnhZDUSeoYt8e9COHYXrkEel77AqiZqpPCJHOD4nJmktEJ29umtFkxPs
         nbuP4sn/ife7A020re4O5/T5sgVHwJ7pEV4SmqrXfiJDOQp5cGNDzybNODXuWeUnGYuY
         5UoRrBRxqilwxOFBB0tdvvWbVqK6tMWkx7MoXd2gY/LUjg34zxT3y5ceuceLUU0K/2Sa
         IY5Q==
X-Gm-Message-State: APjAAAWjJ5DWh8bY7SWXptUJ+kzSsJFRXUn4EtpNa5iyHd5w4aEjUXP/
        sf2uSCchi4M0eESSsrz1FRo=
X-Google-Smtp-Source: APXvYqz/VewqOJnmZC2dZcKpaUrdwzIGnGakbHjHUF/LaI2SfDQMiogOyo/etrjKnneSrTsw/xi4RA==
X-Received: by 2002:adf:f9c3:: with SMTP id w3mr5934677wrr.271.1557683184146;
        Sun, 12 May 2019 10:46:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id d14sm9090558wre.78.2019.05.12.10.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:46:23 -0700 (PDT)
From:   peron.clem@gmail.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 8/8] arm64: dts: allwinner: Add mali GPU supply for OrangePi 3
Date:   Sun, 12 May 2019 19:46:08 +0200
Message-Id: <20190512174608.10083-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512174608.10083-1-peron.clem@gmail.com>
References: <20190512174608.10083-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Péron <peron.clem@gmail.com>

Enable and add supply to the Mali GPU node on the
Orange Pi 3 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 17d496990108..d4c989cc92a7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -58,6 +58,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-- 
2.17.1

