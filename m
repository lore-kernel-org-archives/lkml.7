Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56967C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28220214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Fv4cQwiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbfLMAIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33779 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731703AbfLMAIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so590596pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPHcF1Ac92GQc/SsDP7K+Yij8n5Op4P4c8xwvHBjRY0=;
        b=Fv4cQwiBepW2yfuVGe2bIGqgW8ota1ovR0Oqsbc4sPC1d1OUjKvZ6vQ1b4a/simvRZ
         hkt4QOw7eTenbSMFVj0LK6GV8yxReJromH9baY2pKzNpgT++N5JSrcQVJDe15ur6qMTK
         9aX4+KJQ5J3uFZQPd9WZgF0qk80Oa7uLkWC3MVX1R3A13K01fiCyDuP4hhWHh/TKLc1q
         +KjX4QkipD5ktT3q7JwEvS9TWquf/p9mTa6BPOsC//gM9+Nww7x0Zoo6pDayI7ACHyix
         wenEXpUU+010mB06MpA8ofbbIn25EJifvYxxvyKkWeZSh6sd3IQq2btODsElDw4xyqEq
         iSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPHcF1Ac92GQc/SsDP7K+Yij8n5Op4P4c8xwvHBjRY0=;
        b=GONLqs6s/5g9OkWv/WhFTm9hJpVNGA5uEyDPmW4QzvGt4fAkZjLuDO+jkfIs3x2MbC
         K809Rv02zOv7wD2IQpl7SrRLcOTGNzjhap/e4Mz90B+1rw2FkyTGtny/XhgtIEoeMLQn
         v8CYVhijNv2Zrz5pj0LLidDH8f+LGv/OWHVhmxD/Jy8ZHasvvNbuxphdsJfwDwwQBKq4
         rO87jexGUotjvt5pKj2P6jwMuOExzeVdzBP5owFKycrDM9vlZwCa+htJoiTVvJQ4XaQQ
         PPAQhCQwaYZAtyUW1Oc+GLczjxpl+KIAk8pWr8k3VIHEcjGq6OJg3BswaME6svsbSDMh
         rykw==
X-Gm-Message-State: APjAAAWqQBN3cJUx2/GQ7tTOqUS9hR5jgba2SIuXVFT65TRlHsb4bt8E
        eWbsBdtYTwz+NPZ/DPoBinngUFoWi/s=
X-Google-Smtp-Source: APXvYqyqFKCBWTIp8TYm3kDEts6GcpTPEPycbAbyvkwK3IpCwgEnNSAd2DdwsYCBcerQjSs5m25png==
X-Received: by 2002:a62:b60c:: with SMTP id j12mr13123896pff.8.1576195714876;
        Thu, 12 Dec 2019 16:08:34 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:33 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 27/58] tty/serial: Migrate mxs-auart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:26 +0000
Message-Id: <20191213000657.931618-28-dima@arista.com>
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

Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/mxs-auart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index e34525970682..b4f835e7de23 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -12,10 +12,6 @@
  * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
  */
 
-#if defined(CONFIG_SERIAL_MXS_AUART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -1693,6 +1689,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->port.fifosize = MXS_AUART_FIFO_SIZE;
 	s->port.uartclk = clk_get_rate(s->clk);
 	s->port.type = PORT_IMX;
+	s->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_MXS_AUART_CONSOLE);
 
 	mxs_init_regs(s);
 
-- 
2.24.0

