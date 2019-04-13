Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A85C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 19:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F368208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 19:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSuqpKKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDMTY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 15:24:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45805 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfDMTY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 15:24:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so6673327pfi.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nWhVTMUidFAcLf4NDz+Wba0U8xH/f3ZAlJwUYWr19zA=;
        b=MSuqpKKiaND8eRcXZ30BtdolxfKk71i6YLpXbR1rLs+HvGA8A/N7L3vR4T65X72Z04
         VXDmit5GfgjSiZ9+ugD+h8IkqD+xS5DZFCg2Sr7r5U0A8rdxmgt/NuOkNbSGzeE626hx
         UZMIlo+D7Bf2oaTto7WUnte78emOfwuzk1Q68MVtpci8YJ5SCYsHvTzvKdj+akz61+Bk
         B4jvuAf0im/QYmbP6osVDqX8LuAFd5D1EwWP9/iDdF51NnUhEq20BK7wAqm2vlfkPyDa
         2YMOCoVEU1BSrglAdOOW0Lwx6jYF7BdPhfZC/Olcm4OirSBo8dyKHK5StUVrfFtg1xfK
         f9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nWhVTMUidFAcLf4NDz+Wba0U8xH/f3ZAlJwUYWr19zA=;
        b=mYvtzLRqiUvRb2FWmj14Z2onH1gCCfYIAXT6RsCcboVxGGIxNVUep53c/alVuyh282
         qEDcVyAHbIgy1jYl25XFkfrorSatTtJJ8iAta0uGGqiW25t4hC3m0K7iguVKtNeAhhLi
         yN2h8zolfAaP6Ywdc11cdfeUJSlkarRL8ucisBVg2Aq0a0nPRCnJRWZKnca20IxeZx8Z
         PTsWrqu4h7pmHCmNU4C9HN22JZxy7AEK5LSetKOecsPPZCbHEhEI0readWLHL6DGtfvt
         oviM7XFNXVXyj4IHJChRBt2tdf84BkvDNDo078oXsMsUcI+p/Y4M44sC7OwAUPdb07mY
         Opew==
X-Gm-Message-State: APjAAAVDg83Xy6gzusYK2oZk15E2IkPSsiC+0tE2H1uKbRb799mlYAPZ
        k0+yVfWMUK8yrrpi3PhksdU=
X-Google-Smtp-Source: APXvYqw6Fq/Eycg3N5MvnoAAM1T6W+P12i6b8YtZXSito2dJBv7YUbVjINl4a9sNiKD8gdqyE/UzuQ==
X-Received: by 2002:a62:ab14:: with SMTP id p20mr65080721pff.23.1555183496070;
        Sat, 13 Apr 2019 12:24:56 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.55.56])
        by smtp.gmail.com with ESMTPSA id m2sm77448201pgr.74.2019.04.13.12.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 12:24:54 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com, Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] drm/panel: Remove duplicate header
Date:   Sun, 14 Apr 2019 00:59:10 +0530
Message-Id: <1555183750-11028-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 2c9c972..1b708c8 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -57,7 +57,6 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
-#include <drm/drm_panel.h>
 
 #define RPI_DSI_DRIVER_NAME "rpi-ts-dsi"
 
-- 
1.9.1

