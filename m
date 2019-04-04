Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC268C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2DF2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoab+KGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfDDMHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:07:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46828 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDMHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:07:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so3406116wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YhF7Yyp3NHJgHKxtsLDDJ4tfXEAoiWSbLHZVzljiCt0=;
        b=uoab+KGatCrUW1FrMyvvpx2NTLZlMCheQx8H+aZgmOO2503Z8AY/utFRnKYXUbnHj9
         zjScnwJnZlSvq0QsEIgqEB8EyARCheSHloSgKjRP7/udLU1i3s9SjPphG5CqHBZxSsZn
         b2clTnKeZCn8a/ZcdXBwQ+PGBKrpFzsVDsuxOsR4LKIBnEliSOBi/uOHBL19jcWinKLT
         35D6FGRqbEuqEvEt5+IMXP1GpDlI4Spdy57lEsvaU44JTQC/v4CVxFusm/ilPXl4ij/h
         TJWs9/cAE45naGMJQf5OADFbyRAuAt5ALzUGuNI5gcntIrnYMXaz2FDx7JirmmpnB5NH
         Xqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YhF7Yyp3NHJgHKxtsLDDJ4tfXEAoiWSbLHZVzljiCt0=;
        b=glE4S6ufbwbHca9P+IxfSJ8a9N8aL7CQ5ncbpcJsU0ECMX1udIQY1CtQtFnr8j+Rc/
         cNjKMJ0H9kcUWQpHmF2sAZRlYg3SYQ2jXyvQcG7MHxZQBIpfYPN0xAWee5RWLadtl++H
         sEmpUVlTM35EtpBSxO4Kj35D/bhmR3GJP6gDkWEmC+yRl19W1x9SiUKpwBwZjG3SxnXy
         TKfZjz+BWsucfu7si8HyEDJvGsCoS3vWkGkhcL47NZFBgLSvYRviG6m8OCufzrRJPSMf
         52H3+IeN9L0CGOh+AIW+5Y5sn4QPFHTs5VyuqHFc6IbL8OhIFXjI5tGB7c32dqNHY6LY
         ALiQ==
X-Gm-Message-State: APjAAAWVFZlW8uXXbxN0sAyDEzahkr7PCenP+i1+/Coe+dffDrGNM1Zf
        mZunHNabmI5bf6T3nTrmG1b9FLZtHOlnTQ==
X-Google-Smtp-Source: APXvYqy6DulF6oVhg6R91bVpVFWhckPT2aBbbsP5xgFX0nbcXAvWzxUv+SCDpYqgnyaqse16W6zD4w==
X-Received: by 2002:adf:e84b:: with SMTP id d11mr3640453wrn.289.1554379637557;
        Thu, 04 Apr 2019 05:07:17 -0700 (PDT)
Received: from localhost.localdomain ([178.138.32.90])
        by smtp.gmail.com with ESMTPSA id x192sm23965445wmf.48.2019.04.04.05.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 05:07:16 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH] ASoC: imx-pcm: Switch to SPDX identifier
Date:   Thu,  4 Apr 2019 15:07:03 +0300
Message-Id: <20190404120703.30054-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/imx-pcm.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index 133c4470acad..3ce2f437e645 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -1,13 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
  *
  * This code is based on code copyrighted by Freescale,
  * Liam Girdwood, Javier Martin and probably others.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #ifndef _IMX_PCM_H
-- 
2.11.0

