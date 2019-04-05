Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF5AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6039B218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0U7o2qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfDELvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38746 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731304AbfDELvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so7652045wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gZNUFVuK2Ip7Na6VoAF8VrYLolRGJOUaAHxJxLV2fxQ=;
        b=h0U7o2qkomaUsnyU5u/DMoTV/vKWJq1BYNKOlbZGj8KA+lHIZ4uUd2zOPNFsKfOkng
         bCXqaqc5Higp7eSDX1Ll84Q9vQs49Ijn1di2EkQRBGQd9FPV5LsKUpOl3GUj6mdkG5Ra
         uRjenwN/QiS/G0nQzjnp4BNi74HGm5pEnafUCQDgKmQyX517VFEwjMeeH64CWz2YWWNU
         AkBKIowDy9xDiDYmu/rTHOwG8e/Wx9ujcMqh0Ga48cFxSFxedbY3KQOtoKzJ7G/z+9jG
         YffJSpUONHg6pEQHvJ7RBPbqidyV3XUHZb7ygusQV6BTA4UpNa4widr5DpOk2O16ickr
         e0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gZNUFVuK2Ip7Na6VoAF8VrYLolRGJOUaAHxJxLV2fxQ=;
        b=mZF8BrOLfhOclbbxSHE5PanAT4yKne/TMqRGON1NrcoDnWiXyAvXQwCoAn82uJrArF
         2TRsa+qeOSQDngSl/KFtBR00DQNula70i2dMdHzy1qPFDVZuNxsh2jCAkUW7tgTacXN6
         8r4bj2gxQ8pwlZbciNZ7jGZwksn2ecyb73z9gZSyn8ysWbEf3R4FbefmRv9dAhxHuurh
         hH8FfW0699ADsLyyCQDZdRPDbYiquKagcji9qF64KSaMVvC3Ss7qS+khdik2ZSnCcvzE
         IwYaoUnjBmMNLOi46S7SFUeGN5u/zK/ZsyQGDUC+a/kze5+nKZtM0fSXWbEICAIhXYVV
         ufXQ==
X-Gm-Message-State: APjAAAW9BNuPB923pIkKpOzVj+GueLMGkjb37gmJdXhj52GlQXr6CJ4f
        WAbbqVbewIagm84eLKdCOjs=
X-Google-Smtp-Source: APXvYqxmQjiuc5lPmpCVW/t03gCutNrhBUicA92cYZvj8lDyFHa1XDF2y0mPr3vgs3SwmIi7aLDtIA==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr7950780wrq.94.1554465079801;
        Fri, 05 Apr 2019 04:51:19 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:19 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 16/20] ASoC: p1022_ds: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:50:06 +0300
Message-Id: <20190405115010.28838-17-andradanciu1997@gmail.com>
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
 sound/soc/fsl/p1022_ds.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 41c623c55c16..80384f70878d 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -1,14 +1,10 @@
-/**
- * Freescale P1022DS ALSA SoC Machine driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale P1022DS ALSA SoC Machine driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2010 Freescale Semiconductor, Inc.
 
 #include <linux/module.h>
 #include <linux/fsl/guts.h>
-- 
2.11.0

