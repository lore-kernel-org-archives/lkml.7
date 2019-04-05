Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A68C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A29320700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXk9R0Zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfDEF2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:28:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39572 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEF2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:28:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so2441984pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 22:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieDXWkWNFHDytcYjlcIgrOi8QIjGI3S9JoWjSja3KxY=;
        b=nXk9R0ZrWj/m3Mo+/zYOiLANsBNEUYijgiQ4o1PbJlfwVj/2wOTtJlC5Jr1K4KHkl8
         n6hxwJoGNG+aTTl+BmyG/Ea4HK+7Jr4DsIA/HJ2vjGMjQlTpd4WvK1R2CpM6F7eYY3dT
         B472QVro0UXRHnaeW/FGc9k1rlhVmUCqmpqZpJ7Xbx6omo/MWO94rlakJ3iXU+CzPPab
         BAMuPMIJEf1ndpAQ6796F8cuFsIxzv18HxZrg1dXeLRkmezw3RKGNbCIep87v6ZIG5YJ
         TcbTLuQXRg81+Gupr0/ubF8deQmjfF3W15H7D+6A1HxTI4J/qLxffeXgt7ekWUtWIepm
         RlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ieDXWkWNFHDytcYjlcIgrOi8QIjGI3S9JoWjSja3KxY=;
        b=LHD2LwPzewCCllSKur0NQY/npCI/4ABejXYgbGuiKVY9qEwsdqKs5FtKJd2tFKL7GR
         aAPY5IZtOO1ZqQZnoXHJ92ftVTqIa8SXWVHG6oYLyHVaTEyrLXXQ3+DZSEufKGAGDG96
         OA9UBsQ1KHwkv7JYk+ncoQiH0w7tEj2EL3vtnqFXAgzDNJ6dtZkcsIf0UhzJYAJNKFGF
         BE8usmy03C3SeS+t9CcjM740Ucl9P9TJ0zoLjeVqSGK5WRg6AenNGCwrm6DtWQznA82l
         myd7e344uzI5PvIWZpABAhFADWjpdQV9b+WRKkloaxDHjMhUTdq5is3qCep0STqJuY5Z
         aUaA==
X-Gm-Message-State: APjAAAWc6QiObdB4CzvN93+PymCxNQdzSXD3uKt9O3U7oTd50IqpzKe9
        Y/McjH37yqMOhANDhhTdGBPjSO74tZKq5Q==
X-Google-Smtp-Source: APXvYqzlpjxzD+9WhA2AVukFK50vWkuSUrcRumRv5V2BK+CLIJtSf+rzOyg3D80yR5jQSonwx4k12g==
X-Received: by 2002:a63:243:: with SMTP id 64mr9969327pgc.214.1554442121880;
        Thu, 04 Apr 2019 22:28:41 -0700 (PDT)
Received: from voyager.jms.id.au ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id n22sm24510348pfa.51.2019.04.04.22.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 22:28:40 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation); Fri, 05 Apr 2019 15:58:33 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm: aspeed: Select CMA only if available
Date:   Fri,  5 Apr 2019 15:58:30 +1030
Message-Id: <20190405052830.27899-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building this driver for architectures where CMA is not available.

Fixes: 4f2a8f5898ec ("drm: Add ASPEED GFX driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
This fixes the build break.

Another question is if we need to select this at all, as we have a
reserved memory region to allocate from. I am not familiar with this
area, so advice is welcome.

 drivers/gpu/drm/aspeed/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kconfig
index 42b74d18a41b..1775fb85ec74 100644
--- a/drivers/gpu/drm/aspeed/Kconfig
+++ b/drivers/gpu/drm/aspeed/Kconfig
@@ -4,8 +4,8 @@ config DRM_ASPEED_GFX
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_PANEL
-	select DMA_CMA
-	select CMA
+	select DMA_CMA if HAVE_DMA_CONTIGUOUS
+	select CMA if HAVE_DMA_CONTIGUOUS
 	select MFD_SYSCON
 	help
 	  Chose this option if you have an ASPEED AST2500 SOC Display
-- 
2.20.1

