Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0039DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A992070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="buu/8B3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfFFI44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:56:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38309 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfFFI4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:56:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id t5so1529672wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 01:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+fylG/tOnqGX2aIqT+71+ORb/4AkkvDue4m4inFcks=;
        b=buu/8B3ZYXUp+j5g3/g50Oflkw24Cs1+pC9lzsokOuI3yr2ENAMA5G1Eefknu9gFou
         KCyVxXXX5Bq+xnhf492L2kyWpbIDsHIXBmR0EFkxUXhKTCDj2vmjDuMao/cbiMsMoWYX
         QL46D6bDryv4WOyzI5QF6v6PbY1r2c/6evGe2b0jO6+06B4PqNVUUrGMikpTCWpNlPAS
         kwcw5BgPzTsiyD727FDftgI22jIPYNB7yo68qpTYjVIy1agGcAlvxxT/Tqnchx3woGMb
         fhQEl/KK0QzjakKqcsdl8HOHbXTS0Psi1RQIDJqM+5FziVGasPH89EicPXu2cXyVWmHS
         nMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+fylG/tOnqGX2aIqT+71+ORb/4AkkvDue4m4inFcks=;
        b=SvPJFTqlcXkiIwMdT/bvOit6cY1cTLHI5MdG+WIGICItrxpbPo90zs7ESJSct3avmY
         bEzNLGA7Hav4qWQ5bfR9Gsk0KxtsAPAO9V6Adu7uuqxxwe24Jw5NbBDjNIhv7l++FNyk
         xKPoM/y2Q0oQzohErf9F2lyeSE8BB6zb40xo2EQ493Uwj4C8KN5z997Lq8CXVQ6qeT20
         46b2/264Wh2bw9kRMM1LuY/9HvQkveqxVP8P19Y3jVKyFMXcKOjC7o+l/uvx3TX25vbS
         89YygmgU8fLeZEkwYPZhN8p3Hob5vEg32s3TcbeouTBfqnQkxfQ2LGwQcGWV0tnn8ltx
         8krw==
X-Gm-Message-State: APjAAAWTIfM8n16ze2d7vomgdwxm/H2UMXTUYqLWG1lEQqQIkZjTvsld
        QcyCGlzQtkjYXVh21vWq23ks9A==
X-Google-Smtp-Source: APXvYqy+e2uWcrVijNb10BfH/ocbR5J0+gtso73gONGfKdAF2BhMjMq+uGYcq6aztFzWdyu+ddPV4Q==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr14679576wmb.168.1559811412162;
        Thu, 06 Jun 2019 01:56:52 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f24sm1087334wmb.16.2019.06.06.01.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Jun 2019 01:56:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     arm@kernel.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: enable Lima driver
Date:   Thu,  6 Jun 2019 10:56:45 +0200
Message-Id: <20190606085645.31642-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606085645.31642-1-narmstrong@baylibre.com>
References: <20190606085645.31642-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bunch of armv7 boards can now use the Lima driver, let's enable it
in defconfig, it will be useful to have it enabled for KernelCI
boot and runtime testing.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 952dff9d39f2..0757e0278e22 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -656,6 +656,7 @@ CONFIG_DRM_VC4=m
 CONFIG_DRM_ETNAVIV=m
 CONFIG_DRM_MXSFB=m
 CONFIG_DRM_PL111=m
+CONFIG_DRM_LIMA=m
 CONFIG_DRM_PANFROST=m
 CONFIG_FB_EFI=y
 CONFIG_FB_WM8505=y
-- 
2.21.0

