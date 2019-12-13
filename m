Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD17C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8BC214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cwLK4NNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfLMAJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45148 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731817AbfLMAJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so514631pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjqr9PsS0EovzJGQYpD/pwwPvvnyZIwKp6EbPz/5EgY=;
        b=cwLK4NNB2VWHR4d7JpiEvbIAkwzbxJnPfZRa8DuBvQuFwUNYO11+2xy87bxT8WfePD
         owa871l8tcOEzZCC9BswW1773QFWI3vhOLaPkOHEOnkzVwJED1OqwQtSPz27a3YEBaXb
         W9VM2BPgmz4oKWUvOq9BdWrJvYCEZQ0OyM9+kVS/G4PJcBmlmmybzb6fD+4fTiarvje2
         I3ZccabCSytAd6H7kbx+ULDd5Utcapa7yyCKlYxclYQiw9OEUuoVEIgVtvhKOntI7O3v
         OpJaKtBcSUL6h6OL6nagXEwYjQsv1z8VcELiylZ3PcbBgDsjoMLCTrS69+YmjuwLKuT3
         76Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjqr9PsS0EovzJGQYpD/pwwPvvnyZIwKp6EbPz/5EgY=;
        b=h+DNtXGVRfauy4V9A+7e8E9TSFC4vb26layna2MmZ8nAhcv+bwyrt8aA6PrwXpVRiZ
         grIVFxqddAgKAGvaUs+phiff8z6GwfIyeGXSqTNcV+azdcHkbKqF50VCVmnk4F7X0+XT
         JKT9vHzaleol0qUfjIgxl2ZyrMeB4Ci5jAcg1aL29RY44Mb+8H/GHSC7KCm4RODzOlb/
         PiC1xybZpv131LUj3yi/jBpHNxRjQVzhelS0hTiTmcwP3MbDnIm9lXb6Zp4rDiKT9BNl
         FtbhZDvXhQO8pnfNEINahYqvOhAwHZOTxENk5pL+Ib6fBLWUHlPB8sI6o7e9sWwEIhuc
         ZdKQ==
X-Gm-Message-State: APjAAAXGrm/onAFKHctQC7y+FGyblLYRsten+bKboWZ3waI6gEU04ZpN
        xlVmdwZnbJhR6saB3umdOJ4IFpRR6tg=
X-Google-Smtp-Source: APXvYqylNIScI/0cKlTTskoG1NnO9Lpswns54njx5jJy10duraYGPjumdQEWf5EWn2gPG/Cr/NBhLg==
X-Received: by 2002:a63:510e:: with SMTP id f14mr13779333pgb.35.1576195758296;
        Thu, 12 Dec 2019 16:09:18 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:17 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
Subject: [PATCH 42/58] tty/serial: Migrate sprd_serial to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:41 +0000
Message-Id: <20191213000657.931618-43-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/sprd_serial.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 31df23502562..0c3b7420b01e 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -3,10 +3,6 @@
  * Copyright (C) 2012-2015 Spreadtrum Communications Inc.
  */
 
-#if defined(CONFIG_SERIAL_SPRD_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/delay.h>
@@ -1227,6 +1223,7 @@ static int sprd_probe(struct platform_device *pdev)
 	up->fifosize = SPRD_FIFO_SIZE;
 	up->ops = &serial_sprd_ops;
 	up->flags = UPF_BOOT_AUTOCONF;
+	up->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
 
 	ret = sprd_clk_init(up);
 	if (ret)
-- 
2.24.0

