Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6178C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17AB21871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca6nLxHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfDELul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:50:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36246 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDELuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:50:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so7654252wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rQj8PuuZentu2XrU7HxdJRdnsCGuNjbn3VjTmF5ty2Q=;
        b=ca6nLxHCGKyID5DoD5tSyX7baDMUYrCaBg/hUAalVUUz24hicnDyEPvUjHa8Hf3HnW
         hhGPZKgDQcQCUzkC8ic8k2Drdm0d9JkmsptyJ+WviQMMZZVC1O5+Nf9y1C6fpDTgEtUN
         8djaRsqbP+iGseohY/E7rR1O8bUNJ+bk7EHRgvP3NUOJGJJkoVkeQgIBz9KuhWx6o4UG
         BXWzjtmltNN1uYnwG4Fa7eCuZPU2FBXGvjn6JdDSkfcnt/LGag3NpZ0IpwyoGFOhx7c0
         c3JrxlqaKBtFubxYHvKhY44wvxKybf3egpSzRX6Ts00GvMWgqCPFDg6D2S9h7xrqi5Ju
         OIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rQj8PuuZentu2XrU7HxdJRdnsCGuNjbn3VjTmF5ty2Q=;
        b=K1GBKds6yujTfOgRQtvy2MLAM/VQ7awszVMMJ0bnHVMkfk7w/oUiGEzcqVOSnjibVJ
         6/A59pIVMqF6u/Lbwv8bMMz/Ctf9CPNb/Vg/bzLqSRmimNtX62yOCzt+FWxV50HLQTur
         UAeSNcAx86ph+FxXG316NN6G5ejWyi/l46yWbClMYOLS1p3cQ9UHKSXXXZVJ6SijZzis
         jYSv6o4cVzrpRF257U64gVZo2NWSuTormP1R7Kr2oyDBYEBf9Rlu4iElxiNmb7CoZ/Qx
         gxoLJ7Hb5w+OHYPfMwqXJnPFvUBDUdupmHhJTZ2NOGFoiOx5HRFJqFg1ZmJkNzQDFyd9
         qohA==
X-Gm-Message-State: APjAAAVanQYEBMZEoovxN3H0oyCNYYTXIvaep5wHuRT0VliK//BAKraU
        A648xidPl0a3GpOgYXCYwF4=
X-Google-Smtp-Source: APXvYqweXrqvYqw1SXr6ywgBo8ZPVYoZgCyzZk0sYZHg5vmlGQ70RzHCUjsy6XDTTeJVXAz2uEQMoQ==
X-Received: by 2002:adf:f1cc:: with SMTP id z12mr8407553wro.180.1554465038256;
        Fri, 05 Apr 2019 04:50:38 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:50:37 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 02/20] ASoC: efika-audio-fabric.c: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:49:52 +0300
Message-Id: <20190405115010.28838-3-andradanciu1997@gmail.com>
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
 sound/soc/fsl/efika-audio-fabric.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-audio-fabric.c
index 667f4215dfc0..3e832902fc99 100644
--- a/sound/soc/fsl/efika-audio-fabric.c
+++ b/sound/soc/fsl/efika-audio-fabric.c
@@ -1,14 +1,9 @@
-/*
- * Efika driver for the PSC of the Freescale MPC52xx
- * configured as AC97 interface
- *
- * Copyright 2008 Jon Smirl, Digispeaker
- * Author: Jon Smirl <jonsmirl@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Efika driver for the PSC of the Freescale MPC52xx
+// configured as AC97 interface
+//
+// Copyright 2008 Jon Smirl, Digispeaker
+// Author: Jon Smirl <jonsmirl@gmail.com>
 
 #include <linux/init.h>
 #include <linux/module.h>
-- 
2.11.0

