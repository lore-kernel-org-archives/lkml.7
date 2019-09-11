Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D750BC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A221720863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQHGkTsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfIKRrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:47:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38502 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbfIKRq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:46:59 -0400
Received: by mail-io1-f67.google.com with SMTP id k5so22549352iol.5;
        Wed, 11 Sep 2019 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m6EOAJO1qgEemJlkYFxDYcBwzW52x2O5dEl25GRcoSc=;
        b=LQHGkTsqCaP8EfYJI/4g9fzb5NhR+mH8Ofvj4v2IIjBuYitiqn/Iz0cp5UZVRy6EGq
         GcsPryMwY+RrBvooTU18BzfsCCX7TDEihCT8uSFRtDj/93ML9GR1wXg7Va/QCNIj7H+w
         aYd4DGYjJOJBQ01MdyYdzWl1PCZpdbt8UyAAzTzFEvRZE3euqOUQ+IDxvT0ZRV5Z+jXN
         8s8QBvTzTOnCp0IiDHH8OhOJtToHgAIiLEAfcFwk5UDydGLLuTMcKbVF1gdPLzTsd6og
         rnb0wU3P+F5ibXwLonI/Ns26o3b/RtvMw05MrWXDNphEP8JCw8WRUbiy5GBnoG1YyQDE
         0zVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m6EOAJO1qgEemJlkYFxDYcBwzW52x2O5dEl25GRcoSc=;
        b=jTlcSE/5N37jEjwwKmFFPAvguYXcusOj2ukpf5i/kBXBvXVbaeN/tIfgLS8OEvjvde
         thSeje9DQuj3rn4hK3m7CK9fpp1/iEqSMOKiNa8NrFEixOIfAsa5WNP/euqKMk4+gWwA
         xMjpXWdxCTAM72YEZJ8N3vC4zPpBU2HkrkXWAaapg+/x3YzbZME/inbkCkXoSHB7toC6
         I7RPXt7CwvczK+QjzaFlpe7aROIvEQvZ387sropbX0dK0jUOniiU7Y+WsnVFLn2Cto9Y
         bZslTvJ21PkPECImOI/MA0rCO35+RIOKDpC5u4e9c3DmWSwnjGzf4Zdf9lAdnUtOOt1b
         TKSg==
X-Gm-Message-State: APjAAAUt7CxFoZiqAwM58eI2PpYvnk7qWm/jWAb4WPykmSoCUD2DPVz4
        x4sws6hPORXv9Hp+vzDy1SA85l8y
X-Google-Smtp-Source: APXvYqzxTMSyzOm40fnhFm9eaQZkFEEtBWf0exKouA7+NALtOfOJVLpNgsp+8oDMNF52g0vv1Y8dZg==
X-Received: by 2002:a5d:89c1:: with SMTP id a1mr7693726iot.306.1568224018425;
        Wed, 11 Sep 2019 10:46:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id z11sm18788778ioi.88.2019.09.11.10.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 10:46:57 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     adam.ford@logicpd.com, sre@kernel.org,
        Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap2plus_defconfig: Enable DRM_TI_TFP410
Date:   Wed, 11 Sep 2019 12:46:47 -0500
Message-Id: <20190911174647.29721-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TFP410 driver was removed but the replacement driver was
never enabled.  This patch enableds the DRM_TI_TFP410

Fixes: be3143d8b27f ("drm/omap: Remove TFP410 and DVI connector drivers")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a0449d3b48a5..d384c13de19a 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -359,6 +359,7 @@ CONFIG_DRM_OMAP_PANEL_TPO_TD028TTEC1=m
 CONFIG_DRM_OMAP_PANEL_TPO_TD043MTEA1=m
 CONFIG_DRM_OMAP_PANEL_NEC_NL8048HL11=m
 CONFIG_DRM_TILCDC=m
+CONFIG_DRM_TI_TFP410=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
2.17.1

