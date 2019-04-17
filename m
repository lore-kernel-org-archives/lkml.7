Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7EAC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006BA2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfmerjlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733093AbfDQRaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:30:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51605 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733072AbfDQRa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:30:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so4351710wmf.1;
        Wed, 17 Apr 2019 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuhRBMQmkLmEXKm2BYKcq8wbbgzPSvK5ds0MAMCI7u0=;
        b=QfmerjlDpCpEZErcvFNkKDsWzu2g9gfSAOIZF+du6EJnSEbNmXT5DLqEbsxeNRmNCo
         FjFardyHDa28QVa0/YKnONg42UOPpbZs5rM6G2nCJVuigJb2zzKlin3fv3IeLUjT8kBU
         p7ixBbFJutcNBKNySWp1dcucfGv7501nWHq74alwKAU/MlyVcqP1JD7VNRGvyE+CsrIm
         uqGzMexGhM4NiB6gbM71oN4r9YYmaGD9T7T4OPr86gnWu5pqCt5gJMorTZpoXXgKU5WK
         Zje5FZVBRMMla71udCxLbXU/UR0RLDhfqCMofG9LrDrT9Vz3zxSKskZhOVl9W4IAbkFQ
         BEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuhRBMQmkLmEXKm2BYKcq8wbbgzPSvK5ds0MAMCI7u0=;
        b=pSuZPCaNGuAZsh7PQQK/1LydEipKhe9l8SlKQc8D/7mctNSDlsmWD1nO3G218Z+jmR
         hFtTYZK34bfhdA+SWZxClcgkGSsDjQ2ZjrhM1R8yh0XB46DSl5e4Iefy42ONto6k8Swi
         e8jmdPv7pQdecMmA3yfkjXNi4DyrTriRdv1NW7UjMDLvlg0CwlhP9TmJLNLpKuOZSvM7
         Jej09K+J5WnhJHr24o5HibOWdfyZLIsXriCyqY9Rur4GMyhm1Ha8xqjFgX4qFwDEj/kk
         tjBhF9xc4AoZAqHISMEXnuM7BKd2IH22gxr1eZL8J8fuxzO/ltUiqn25DiSVnA9YUY/y
         /Mgg==
X-Gm-Message-State: APjAAAWgoBi70X9y52mOUHTGcX0lRCKDYAXi6pR1I9nNHYKCBXwmrBCq
        xI6XpCsmJXG/VkL3RSEhMkAiRP5b4bI=
X-Google-Smtp-Source: APXvYqznJQ4GelTOWZ6R+FwW6bNiDHzBBkUrPTxzT2OF5ojkJA14uord4oMFuhLdvotoYXMehdJc5Q==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr32824145wmj.12.1555522226461;
        Wed, 17 Apr 2019 10:30:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id c6sm2669306wmb.21.2019.04.17.10.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:30:25 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 5/8] arm64: dts: allwinner: Add mali GPU supply for Pine H64
Date:   Wed, 17 Apr 2019 19:30:28 +0200
Message-Id: <20190417173031.9920-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417173031.9920-1-peron.clem@gmail.com>
References: <20190417173031.9920-1-peron.clem@gmail.com>
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

