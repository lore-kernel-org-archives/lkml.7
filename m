Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B79C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5C724BBB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv5/ilVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfFDLUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:20:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35278 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfFDLUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:20:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so15408758wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NfluWg4gx9fiVSiOTrSo1yhr6G3kE919Smpmk8u7f10=;
        b=Nv5/ilVC8pDGJ0SDVL3EZEIzC8pzh40a0mFt7bzyZ0jVXItBQdhJWbnHE4bcsASCmf
         6iKjB/x1auRVBnm5iIsqS5UBXH3tjZ5fB+xaFduy7sAT7jtVo+nIcRcpXiR5vx4YWE4X
         ciDCBrDKWyeqLSII3tI1I77vbnsH/SOOdxKEaxhZQVkT38zaXHSJpMJwCL9useA54NOe
         av/RrznD1GIqHf1AkT17+Viq6Oh1UPGyhvQxg5HXm5nI0pm2LtAxvo1u7xzOYQqyzFSV
         751FE4/b5IfZ/9gHNCfFO0QUhqpfzggmyu1kbjXq+6tSXxeJgK6ok2aCuAfOL4L6BS5n
         G3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NfluWg4gx9fiVSiOTrSo1yhr6G3kE919Smpmk8u7f10=;
        b=ajU+wMaHnnyk2ZY2Wy4Zj70BlSR7zYcEQITu2XQPqOcLS9JDjsq1YqFOeJtfH78UhU
         Rg9wl8TV3ao33KS3yD8AKbFcus5pZJecMwTDN8cOe4hVgwPWI5NtstQDgqu+mXQntBul
         dMj36UJuZNvYADpj/JkVZv2n87hOvDtmfnWnOBNpfBWRN3i3xt2WWvcb8xiGBqdBt9bl
         JrrYS/loIZKHHr4SIwcU6hh/TK306GIfujJW1CUil6KyUpcJHkULYbHzZeuB9DD1uyRh
         3++UNnEBM6xyNrXByakySUIRcu9M43lrsGcxFaYDLR9GjSVHsiCi4CpQGceJxP1PUNyv
         Pyqg==
X-Gm-Message-State: APjAAAXzA3BH1D4DeBwoCQpJ61ArAq7vCEGKZnGFBeUD7wLTAOz2BZ1i
        gCMgxg872mkntpslD5BMtrUKvKuL
X-Google-Smtp-Source: APXvYqy34B08BoTjG2EO8tqBphUvtAFpwS1/BNxQIcpl7f4Z6C4jZUwnirUFZy4qTx7kRf0qbomymg==
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr6352074wrw.131.1559647237793;
        Tue, 04 Jun 2019 04:20:37 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.213])
        by smtp.gmail.com with ESMTPSA id g5sm20580044wrp.29.2019.06.04.04.20.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:20:37 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     arm@kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE))
Subject: [PATCH 2/2] arm64: defconfig: add Panfrost driver
Date:   Tue,  4 Jun 2019 13:20:02 +0200
Message-Id: <20190604112003.31813-2-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604112003.31813-1-tomeu.vizoso@collabora.com>
References: <20190604112003.31813-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the goal of making it easier for CI services such as KernelCI to
run tests for it.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..d588ceb9aa3c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -505,6 +505,7 @@ CONFIG_DRM_HISI_HIBMC=m
 CONFIG_DRM_HISI_KIRIN=m
 CONFIG_DRM_MESON=m
 CONFIG_DRM_PL111=m
+CONFIG_DRM_PANFROST=m
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_BACKLIGHT_GENERIC=m
-- 
2.20.1

