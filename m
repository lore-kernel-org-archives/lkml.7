Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA21C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699962186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVoxKxkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfDELvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36327 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731251AbfDELvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so7656390wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cZ2Eh8nPw5NozYwIo7t9ZHAY0mdcKQwnuOcnp67UPzE=;
        b=OVoxKxkj8B96yrWm7JVvuaRWaFhcSnGecIO4ZJA9Q3U0iudg8mqJvstNdf9OCWepdx
         8vQaxrPXV0yj28goSjbqV1NblFDB5vV+cNtkxBou4BXHrN5Ui6lZ1jj5HVgqR0h2O7kO
         OIZklqibGur4wOpAaKrbYvEnF8O+Hc2mR/prJvz1h0dyYR00nIALrWg4DZb0LoFigfaF
         O3xeHHytblQF5ysFn2lNoxs6yL0BTs0RYCtib+J6+1eevxclcMD4WHT+sFeFp5eYBtY3
         8OqFpEPH+apkI06+saNp8zS6VvhMNUns/uikLjxFOu2YefRqy6HxfQeZdb7ob0fyinL0
         KkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cZ2Eh8nPw5NozYwIo7t9ZHAY0mdcKQwnuOcnp67UPzE=;
        b=mOm9Dt5oSXf0l3aLbX3hJPpifnteu1G2SFn1/OnFUQQQuTRrKZnpKcJNL1VX7ryfDe
         j6FJpX4l6zt0net23nHxmxbkjv5Y9uU+65LrVUbzot4pwVnnkJxOYya+C6kwJ+fvqyJP
         0OaaqLjsRbI9Ms91EmRjcg8pxu/L9yPyMh+dhA467DeB+VVNmnr9T3BS04MrN25L6loU
         6CjLz6xMFbLEf3T92fqvo8L6dCcgxo9xCmAX60WzrTbqPS/XmGmBf5XFd8xGJjb6v1gJ
         nm3UN0eh6Hfso77Lv2B1JP/SEQDpcQDnOFHmSexAp5/KKdN6Uq6fhND5p+MrGrsT2XOV
         m6xg==
X-Gm-Message-State: APjAAAWS8ApGbVlw58kAXqpfEnnYKJWoTfnpyToL736GWLGujC0qbt6w
        6UjedOOJRikFP6OpYJTBR1A=
X-Google-Smtp-Source: APXvYqxEhgbZvCol9ZhROcY/Z0+1bqWFNApeJ3p7e5cSeHL6F7oEa1m08Xo3gEHPs14NohPvNIFfOw==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr8020892wrr.275.1554465069868;
        Fri, 05 Apr 2019 04:51:09 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:09 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 12/20] ASoC: mpc5200_psc_ac97: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:50:02 +0300
Message-Id: <20190405115010.28838-13-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405115010.28838-1-andradanciu1997@gmail.com>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/mpc5200_psc_ac97.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 07ee355ee385..e5b9c04d1565 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -1,13 +1,9 @@
-/*
- * linux/sound/mpc5200-ac97.c -- AC97 support for the Freescale MPC52xx chip.
- *
- * Copyright (C) 2009 Jon Smirl, Digispeaker
- * Author: Jon Smirl <jonsmirl@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// linux/sound/mpc5200-ac97.c -- AC97 support for the Freescale MPC52xx chip.
+//
+// Copyright (C) 2009 Jon Smirl, Digispeaker
+// Author: Jon Smirl <jonsmirl@gmail.com>
 
 #include <linux/module.h>
 #include <linux/of_device.h>
-- 
2.11.0

