Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682CAC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A54B20820
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r62Z3kjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfIBNHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:07:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39162 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfIBNH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:07:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so13968514wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oRkNL7aLFyTbx8I/d8Bu/GE/++nW3B66VLEejNfzkvo=;
        b=r62Z3kjZmQedYMTll1fdxqWZMwZv1GALAvlzXnCBETrmHS+pXLGc+k4qf0Su/rWlMx
         gWys/cN7Ypl6sKIHSDskZrlSwdbtnISpol+mzt0HZks4S/oPM9cEfyQQ4y6brZYaXWPF
         /l0QRj84HrdD2Mt6Uhp4Yc5BPPatpsmPFrp7GYmyncAKtSLLJwgvKeZsFoD5V5ab0gEE
         uVDhCcxk+LhHI15zZCV3CwalNRYLM79zGo1/Yd+HjxbAOM3D4SKa9nLTrVzKgT2CPVd+
         LDTahqjVtMEH6EKP9F0ZGkSWn/gv7n9jqR7CQqIkW5IUQYIfnlViR/QrK3h3g7QmnIXh
         KZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oRkNL7aLFyTbx8I/d8Bu/GE/++nW3B66VLEejNfzkvo=;
        b=DgzyxzT6C92EpQgq1ly3B0A586faOmE/4gn/9uTPapGlrIB/LULHoQ8Yn2gkLZKYfu
         KoNBVZLi/u/UhC8lQAmQjE6Nv0Hj5HwOQpB65r35gRGtKCci1oFa4xvP24L6ZsnmDy3N
         MJwtx9fFl1+5IkcpBRQFvW9OFuNTUA+A/NJmWbI5u28/oGAlxDH1dkVpUK1GC9CukWBZ
         hx+jFLVWl4fGDh3+bRrkcRj7cfHVahvlJnm6tZN69rImpkhbmzWRlN4rsNaN5e18kdnG
         FM1sfcrAt6ri7a4PKAaDRDkdpzWh+QniMYf/WJzgVOdXkcKztDp4kiMNGhirEgRjjo2d
         ZHlw==
X-Gm-Message-State: APjAAAXIzaeMd2cxgXHtaCMZFd0dUYEzzvYFXl5yfRlb5l0EEL8MXfRF
        Gp48XOZlM89K9Rv2VzTNnF04ZQ==
X-Google-Smtp-Source: APXvYqyzVvfss8xBNM77gxp2OLahPkr+EQ4YjkJdcv91qcL7/dic5KUXyaBXlezCdhVn1g/OGYetdg==
X-Received: by 2002:a5d:480e:: with SMTP id l14mr35538688wrq.96.1567429648225;
        Mon, 02 Sep 2019 06:07:28 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id d28sm12352030wrb.95.2019.09.02.06.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:07:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, olof@lixom.net, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/3] arm64: defconfig: Enable the EFI Framebuffer
Date:   Mon,  2 Sep 2019 14:07:23 +0100
Message-Id: <20190902130724.12030-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190902130724.12030-1-lee.jones@linaro.org>
References: <20190902130724.12030-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on the Lenovo Yoga C630 where this patch enables the
framebuffer (screen/monitor).  Without it the device appears
not to boot.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0fe943ac53b5..af7ca722b519 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -540,6 +540,7 @@ CONFIG_DRM_LIMA=m
 CONFIG_DRM_PANFROST=m
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
+CONFIG_FB_EFI=y
 CONFIG_BACKLIGHT_GENERIC=m
 CONFIG_BACKLIGHT_PWM=m
 CONFIG_BACKLIGHT_LP855X=m
-- 
2.17.1

