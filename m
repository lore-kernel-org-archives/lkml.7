Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E3CC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6FB20870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0spRslg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfDNTPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:15:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38532 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfDNTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:15:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so17404621wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mNEsHRaFH3bUiAbsBbfcV45O7daG+K3xE7YuRVVXNPk=;
        b=T0spRslgLJbgcplq0dNL1CcImHfhgGK+gAi6nYwJva8YY1xcEPAGeMxhXW1yzxean5
         4t7Ea7LHj+Li+9zaVJ0cJ079DQ3VIbdWc5qrZ2nx7Y3R71ZsgAuOQXe2kbghx5XNLcwc
         5BQtXKitkEsQmdkvjQ/GftLCAbHHFBu2Vbj4ymJwicnni5wS5o37sfhIiHny3AF1QFiy
         SUOUIo1U6M66Vw4Wn9Vsnk+FuHD3+dbAlE26NjLBueAZOfTB4pZ+1eQhqdW+wEjaEJE6
         UU3jmVoVZAaMYu3mv2lKq8tH9PGAZtuVt3x0wFHBKXtI1blNUZMNtch5BVztxGu9x+IY
         Hzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mNEsHRaFH3bUiAbsBbfcV45O7daG+K3xE7YuRVVXNPk=;
        b=c2kSlJEoVi4aZeaIGpiGlbXwpW1BYOoomued90zvvYpZqP3XEEhcRv4kFB798XQ/vH
         lh3mWtjerS02prZWSyDyxSSRNjvTekW09oa6YYuWf6C6So0LKYmYSOyl9NBIHpCZliXP
         EUZ/KL2bztmmte9g2VJDN0EEedMbs2gQA05wC7DhbdfePht/D0CFXgbdIJe1YEv8mSLd
         Xz/2LjB1jmTUJ4RyBCPWj6bvjCPzX7jYicFzxDb4mmPpmAwuZWLYsGfizo2Z+gE0jJw4
         ekN8vI12mBAJ2QuRdE0DCAGwIhy/Z8yldzxOI39XFKFzs+UmS5tIc487seJYttuxZM2W
         ibNw==
X-Gm-Message-State: APjAAAX697vR2EKQvzsMLKGbM6Z92HwYGdyXBtXY1UgCAGux7smZ7ezi
        S4R4WIzdkXDobkhrJPMLcPM=
X-Google-Smtp-Source: APXvYqxNw7Oej+ztm3MeI0gGZ3/lctXa61YeRHdJ3cSbZaM3vzek6YVKZgIe0kqYPCu+oR+9/1luuQ==
X-Received: by 2002:a1c:a010:: with SMTP id j16mr18708650wme.40.1555269309146;
        Sun, 14 Apr 2019 12:15:09 -0700 (PDT)
Received: from localhost.localdomain (p12.eregie.pub.ro. [141.85.0.112])
        by smtp.gmail.com with ESMTPSA id v16sm96654246wro.48.2019.04.14.12.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 12:15:08 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, daniel.baluta@gmail.com
Subject: [PATCH 1/2] ASoC: mpc5200_dma: Fix invalid license ID
Date:   Sun, 14 Apr 2019 22:14:49 +0300
Message-Id: <20190414191450.18377-2-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190414191450.18377-1-andradanciu1997@gmail.com>
References: <20190414191450.18377-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the file had no other license notice/reference, it falls under the
project license and therefore the proper SPDX id is: GPL-2.0-only

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Fixes: 1edfc2485d8dc ("ASoC: mpc5200_dma: Switch to SPDX identifier")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/mpc5200_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 4396442c2fdd..ccf9301889fe 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // Freescale MPC5200 PSC DMA
 // ALSA SoC Platform driver
-- 
2.11.0

