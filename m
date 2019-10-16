Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4821EC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B3A21835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjvu+S9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391460AbfJPIgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:36:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32937 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387395AbfJPIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:36:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id i76so13867654pgc.0;
        Wed, 16 Oct 2019 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFOAm0KEEOL2hee760g8AZEKV489IZzr5TEqXGhsPJ0=;
        b=Pjvu+S9cr1LuhjKwbTEv5zAdliS8WLrFYSV9ajCz3Q/g4wItEtxZ84LHPaBzLPQsQn
         evHe1kYjcS468/RoFpq3ShSUZR4iGEFWGAI4h7GGFPZU0/qQkfM4wN8r/FOELtWUvHE4
         Ax7xGEsXESpgj5OHeVJH19bSPDRHuVaTzWHZEGjWjCU0PbobeiVNYY0AIlAg/Ohf8y54
         mJTsl+6XIAeKPy9Hp2gJpdXOrWmWj2ysOO/ErFYDFiMaTqYGtxD7rrBR4GHuVDUZdAz5
         eqwy0LF+aVyOEVQCvkb6iOP8QiN0c5b88OV2VLvEQ1ipHgNu3x7h7zVB62tighmBqm+k
         rkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFOAm0KEEOL2hee760g8AZEKV489IZzr5TEqXGhsPJ0=;
        b=qYlG0qcfjmApDCq/WhTxgiLsIaC+HLvQHDIroOPrAJEAUuPBKBCseV5qPdXdrHxTIi
         q2tC2yVfSvmVWa1b/u1qItwMlX2H1nHJrgqIN1wwJvEjHrOe1Ot1McCbn6pvi75LEDD6
         iVukFt5cdY8LvA5cSzRac3v7fLAXKWXqbQ5fF+K+MwOxCG0grtNogNqqyTemLCCUGuiy
         e2U31hzAvfw9ne6qoodmSuHBlshmLORpwceoEK+qYZ1GJrKd8Lv4Z77Pn51nXdgulY4d
         e5Mp50KaIxHy0+bRF6qZJAr4n21f2k3zDtfJme/X2A+vtQjNr91qBUbTMuJhVp3d8Icp
         fZMQ==
X-Gm-Message-State: APjAAAUIXY8XuXZXUI2zO+SvC65oy6yzC9gBDzRKsy3AAG16PDDUfqUL
        CeEC2iTq7kAvL/tQuVq2GjMxAfT1iKw=
X-Google-Smtp-Source: APXvYqzqnCbOUwdGnLmvPGdh1jL4IXUNN4vHWxcPxg/XaX21u92gWdQkDPImbOFLonrO9o5MV8L1Dg==
X-Received: by 2002:a63:2049:: with SMTP id r9mr5005744pgm.257.1571214965347;
        Wed, 16 Oct 2019 01:36:05 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id y66sm23847751pgy.23.2019.10.16.01.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 01:36:04 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] USB: bcma: Add a check for devm_gpiod_get
Date:   Wed, 16 Oct 2019 16:35:32 +0800
Message-Id: <20191016083531.5734-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcma_hcd_probe misses a check for devm_gpiod_get and may miss
the error.
Add a check for it and return the error if a failure occurs.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/usb/host/bcma-hcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/bcma-hcd.c b/drivers/usb/host/bcma-hcd.c
index 2400a826397a..652fa29beb27 100644
--- a/drivers/usb/host/bcma-hcd.c
+++ b/drivers/usb/host/bcma-hcd.c
@@ -406,9 +406,12 @@ static int bcma_hcd_probe(struct bcma_device *core)
 		return -ENOMEM;
 	usb_dev->core = core;
 
-	if (core->dev.of_node)
+	if (core->dev.of_node) {
 		usb_dev->gpio_desc = devm_gpiod_get(&core->dev, "vcc",
 						    GPIOD_OUT_HIGH);
+		if (IS_ERR(usb_dev->gpio_desc))
+			return PTR_ERR(usb_dev->gpio_desc);
+	}
 
 	switch (core->id.id) {
 	case BCMA_CORE_USB20_HOST:
-- 
2.20.1

