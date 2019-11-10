Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95A6C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A56520854
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 16:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ddfLyy7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKJQ2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 11:28:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50998 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfKJQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 11:28:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id l17so10066195wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 08:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uDYzPbc8kFGMl90TtuXpm0Vw0nr287sWY4H2QuIPHWw=;
        b=ddfLyy7aXWXAdGPxrcmEoISI8Z2gbsV4c+Mx0xLpGhfValfXwlA44mkT+yDYctfBPP
         qqOvAz6cGNsIq1nrvZx9YN8ofsuhtPMgDdVsgf0xJflKerALAzbGoa25gLiUHX9jz6nm
         ipEp43Z2I5ftE1gICOn3cjsEmkYnfCLELGyuAQpNP5ldSRqZlBPXSrOhlxYi5ypguQkK
         j4aH3dHdmNGkmuHXqFMXPooddYwnPl2F/weO+pGmD2svnNxdhKucfi5/clvYc0XGBoN+
         J1vWVAi7Wdbz8DKFbjJ6/t31t2RlgKojoqR8G4ce99EeJBhyxdwPn5TWAlpSncm06oD/
         qV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uDYzPbc8kFGMl90TtuXpm0Vw0nr287sWY4H2QuIPHWw=;
        b=O9nxEBG9OfVAqjgqQfg2E/ymcze+GqAyWcrbcCXyn+ZoEVnERpDkFIrfbMZmri8z6j
         yiR1wD7ku98OPx+eJ0yfSEJGvM9W0Sw+Aywn8jAsOogMeuhRO/l1zHuptUgGHqGgsYL3
         tV1m57RG79/S6Y5eH96OkB1QlI6LbkWeKhyBVPoJLhDemlaWID6EqxK4gqMiFoFjlTFq
         5wfjW2AURhkTZQPBGQUIua0yjogE1b9KWIcalmg8GhvGMi2S2MKrm2B5zCnHuIqEQCWx
         prc7v4NI62cKuts4HUzGAVLtPXdNUBkQiceKOX7MCDMUq8gTuWy37KDCaF47rKIbq7m9
         aAEQ==
X-Gm-Message-State: APjAAAUBeHjeow1kGBFxVs0TKWCa0gNf2qNHtwjGGLCNTDHithc1b9tt
        /4TniPJuoHc+0V1Cd7LCq5KXjN2112Y=
X-Google-Smtp-Source: APXvYqzaGdss0v0PWzY3jcMXRcDJ5/5ChUfRzgIevfnYj5rYCAr29Rt3E1EdUSXG7l6GXPoEYSa9cA==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr13065322wmc.129.1573403289391;
        Sun, 10 Nov 2019 08:28:09 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id m25sm10920096wmi.46.2019.11.10.08.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Nov 2019 08:28:08 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     robh@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RESEND] lib: Remove select of inexistant GENERIC_IO
Date:   Sun, 10 Nov 2019 16:27:54 +0000
Message-Id: <1573403274-3374-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

config option GENERIC_IO was removed but still selected by lib/kconfig
This patch finish the cleaning.

Fixes: 9de8da47742b ("kconfig: kill off GENERIC_IO option")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 lib/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index afc78aaf2b25..cb571767d080 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -447,7 +447,6 @@ config ASSOCIATIVE_ARRAY
 config HAS_IOMEM
 	bool
 	depends on !NO_IOMEM
-	select GENERIC_IO
 	default y
 
 config HAS_IOPORT_MAP
-- 
2.23.0

