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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B819C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF5B218FE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+ttkZ2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbfDELvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:51:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35403 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfDELvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:51:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so6887238wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fGwHro2dMoRJktZIztlEg/HLmc2ioAxEn6YwGJJIAe4=;
        b=p+ttkZ2iTmUqeyAG8wRxS3F2vwmPs92k6+h4dDHEJgKv+5/nSMJTwlRqgLrcvQ7nip
         kez0X+xlBiiY2bfj4USqavJQBm7a0QMiFmqyBKhwzpE9u3qeTAM8FedVsq1uLDj6Foe3
         W03EBqSrIv4bWPs/OMrWdNTLbowNjIlLjpkLV0J+WsN4jUjrmKMmk7/21zVf+pP83B5V
         hZVQlFvJj36zkFe8NBkfVcYwl60ZewFpjUL8Ue3ff/Oy7QLS/N+C5SRWpui5b1E+LZob
         9nVVuEW+x8dWnqhK4VT+aZcidtj2D1KLwDsPwbJ16iRlexh6kesEt7P+btLNQcpK+mcX
         CYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fGwHro2dMoRJktZIztlEg/HLmc2ioAxEn6YwGJJIAe4=;
        b=phmW8pY+UOMTdGDjFVlLETsDiEwhNdkOPs0e+ymZQulfKDfB8IkEhLNAKT74iAzSQn
         WtvcmcAcFoz4OHsvurWlX2zA2qMhMnrj8WplbUoyDFRaKx1SAdkvjHLi9I64x4Df1JZn
         Gz3pcX37wpddxdlvwFp014ZZHWaujWA6jzCjnsFlvOx3sYGewnPecJkOyKF04CTt98K9
         eSxKnlJSqKVXmapwnsX6SuSF7DC326BJUJz0sdznuuSTCJ7Fh6RdUOSHkpgkuTYVslIF
         7YcNssyywowFJfMHRInyy8AxeFqSti8DaWvnoM1PD7UcykM0lqsTdTmNr2K7ocd8aPCk
         I1jw==
X-Gm-Message-State: APjAAAWBTghKfJPW0YoeL/aeiBnajI+54RXi2vNN4YKvdY8dxZ0olKnM
        0YOqmxebw1i1zvANYZ6HDj8=
X-Google-Smtp-Source: APXvYqwTxQoV8/3pyKFUCoyJyb4EkBUy1Ykw1fAOP2b69z1oMyiShjZDTglykHyUZBnKxSX0YkMpDA==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr7202571wma.35.1554465064815;
        Fri, 05 Apr 2019 04:51:04 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:51:04 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 10/20] ASoC: imx-ssi: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:50:00 +0300
Message-Id: <20190405115010.28838-11-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-ssi.c | 57 ++++++++++++++++++++++---------------------------
 sound/soc/fsl/imx-ssi.h |  6 +-----
 2 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 06790615e04e..9038b61317be 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -1,35 +1,28 @@
-/*
- * imx-ssi.c  --  ALSA Soc Audio Layer
- *
- * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
- *
- * This code is based on code copyrighted by Freescale,
- * Liam Girdwood, Javier Martin and probably others.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *
- * The i.MX SSI core has some nasty limitations in AC97 mode. While most
- * sane processor vendors have a FIFO per AC97 slot, the i.MX has only
- * one FIFO which combines all valid receive slots. We cannot even select
- * which slots we want to receive. The WM9712 with which this driver
- * was developed with always sends GPIO status data in slot 12 which
- * we receive in our (PCM-) data stream. The only chance we have is to
- * manually skip this data in the FIQ handler. With sampling rates different
- * from 48000Hz not every frame has valid receive data, so the ratio
- * between pcm data and GPIO status data changes. Our FIQ handler is not
- * able to handle this, hence this driver only works with 48000Hz sampling
- * rate.
- * Reading and writing AC97 registers is another challenge. The core
- * provides us status bits when the read register is updated with *another*
- * value. When we read the same register two times (and the register still
- * contains the same value) these status bits are not set. We work
- * around this by not polling these bits but only wait a fixed delay.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// imx-ssi.c  --  ALSA Soc Audio Layer
+//
+// Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+//
+// This code is based on code copyrighted by Freescale,
+// Liam Girdwood, Javier Martin and probably others.
+//
+// The i.MX SSI core has some nasty limitations in AC97 mode. While most
+// sane processor vendors have a FIFO per AC97 slot, the i.MX has only
+// one FIFO which combines all valid receive slots. We cannot even select
+// which slots we want to receive. The WM9712 with which this driver
+// was developed with always sends GPIO status data in slot 12 which
+// we receive in our (PCM-) data stream. The only chance we have is to
+// manually skip this data in the FIQ handler. With sampling rates different
+// from 48000Hz not every frame has valid receive data, so the ratio
+// between pcm data and GPIO status data changes. Our FIQ handler is not
+// able to handle this, hence this driver only works with 48000Hz sampling
+// rate.
+// Reading and writing AC97 registers is another challenge. The core
+// provides us status bits when the read register is updated with *another*
+// value. When we read the same register two times (and the register still
+// contains the same value) these status bits are not set. We work
+// around this by not polling these bits but only wait a fixed delay.
 
 #include <linux/clk.h>
 #include <linux/delay.h>
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index be6562365b6a..19cd0937e740 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -1,8 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef _IMX_SSI_H
 #define _IMX_SSI_H
-- 
2.11.0

