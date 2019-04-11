Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5781C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0260217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIN27jXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDKPef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:34:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34447 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKPe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:34:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so2227467wmf.1;
        Thu, 11 Apr 2019 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9wE08WFWjh0xFwSx2AERYeUXb2IDNuVR3sIckyG8ws=;
        b=eIN27jXpw+XRgfDAFyLMlvsSe3oU+9B4e0qJy69pPF/npzb20zfqz9XB9nZY2RH6bL
         5R5xRZAyLgawFzsvgny+ODIdjTvTWSPmOCxLg8RdylblsMOP8z05jKT9O450sBBJiTjb
         Jx8en6T/1lX6d0Bn3GkYzfW2Mn1nuOdteWX5H0vga6gm+QH+h0+F+LTnuR5LYhr1lcKr
         /3+oLEfix1GjGF8ZbiXHHwCmgK3uAr43fmvG0pv/VLOUMtsgBn+Tmm52FSH2j0JIIQUs
         1ag0NsXCDo2LkkVIuVrvWUqBeC9jdqCvsqndPuW2DwGc3YdrkqRW2Ah5kKx1U/k9T+/v
         KhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9wE08WFWjh0xFwSx2AERYeUXb2IDNuVR3sIckyG8ws=;
        b=E9tD4N5dXB3VkM5RaQuwUTpXZiAczUM5vG3Xkoz5rM5vPDcHT8DTAnevNYTqb1SEBm
         sc6jmpbPgri+BB2dMQka3D4PaB4EBCpB/GfeUz5zacyNyt/Z8UkEdI5uDNrTm7wz2xZx
         4hwQvCohm486+cE9kH7QLYjuHCU7zeY8DomQDmZ/8tDJZd4XJBuqd7rzLPT9zQYza5oO
         ooaiEbpssi7mFrucj0Y5gi863Z5THcqYsjsAGJcK0e6Ff0R3XbDP9nPXhnizCEtBf6VV
         zwkv1yV6sfrmxr9S8x6iU7UkReR3xsDjSBaR8TXW5qi09QiY5IK1WZyYyQwyKfOzvZBj
         oDFw==
X-Gm-Message-State: APjAAAVDjOKs8TojGQ9ACegHWeq0Fs0KkgUxKjenHyi2vWlI+a24u5QE
        83yx/ZPOay7QTSDKEvQxkIg=
X-Google-Smtp-Source: APXvYqwXNsVvKYOVESNy97iJrAdFkYCGIXe2DT53s1nwBao8iv383NGWsBSdo5HS7t5NFhzH/sX98Q==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr7119885wmj.45.1554996865923;
        Thu, 11 Apr 2019 08:34:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id e12sm38327342wrt.94.2019.04.11.08.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:34:25 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 3/3] arm64: defconfig: Enable Sunxi watchdog
Date:   Thu, 11 Apr 2019 17:45:34 +0200
Message-Id: <20190411154534.25563-4-peron.clem@gmail.com>
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

The SUNXI_WATCHDOG option is required to make the
watchdog available on Allwinner H6.

Enable this option as a module.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..c266d6babbcc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -426,6 +426,7 @@ CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
+CONFIG_SUNXI_WATCHDOG=m
 CONFIG_IMX2_WDT=y
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
-- 
2.17.1

