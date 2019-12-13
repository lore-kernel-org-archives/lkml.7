Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCC7C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D00227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="N44hjPgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbfLMAJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:09 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38779 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731764AbfLMAJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:04 -0500
Received: by mail-pj1-f68.google.com with SMTP id l4so344571pjt.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0AvuSAjkIKauhY++c7YWp6c3q12AUyVxjR83OEuWwPU=;
        b=N44hjPgUKP1rna4pDgr1TI6pgfXmWzNYqT2os27E2x9CgNvOq4XfY2uvZg3QbDL4q8
         lC2uzw05PZALhHdfZOv00DF4DpIBbBiXA5k9+3/l8Go8fBWKLx0KNKMDxH7lsbo1ZYEF
         QNGRGBDlsm1A5d+/s31tS1Eirnkr5aZfaRGP3QM+eD3CVaZ1++8VCJxOmoc/n4bNNa8k
         wvVJzYhEIKOStfkx7/jI7JW+1eS53I77LUvwumVzjIJf9Vu1T+gi29abhbiOlFuq+5oZ
         MMODig9sZun8DmyfjTS/+mELafP9hPHcMY44LTbnyeWo9KguTxA4KnALSwzn1jcrCX/L
         rpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AvuSAjkIKauhY++c7YWp6c3q12AUyVxjR83OEuWwPU=;
        b=JPkATx7oyG2TRgVEHd3mcYpQATubjYpQ/GnBB+okQEgInJxV+m8Y6ATvOsRmOulfu0
         1TWyd5jT+d52vgp+ViqYVl5nwIkNIpPQBsy/0kwuqFFWVvifx7i2/I9kh2+LljTqVjXB
         HMz1nOSCn1rSP/9m8L/zOrhMCHj73eSPSFqF7iONV0gKNra7O0ulyzOFZQMNeIqlqNBY
         6k2AydD4+cGV5R+/E9C6TMGlHfBOgu97M7O8hFyU/LwEZsXcy+z2YrAknPwIRB0AWM+0
         bZZ/0x7GOlJSS9g+g45f774imrw/GRdyB9DB/uRdsTlldOU1xvdTNWAzM8IPevSRnE+s
         Pcyw==
X-Gm-Message-State: APjAAAWCqp7dutUSHQDWB94J9eYg9PjDeaj0QRaL7ZX3o34xelFV2MYM
        06G5uyNqw1EsV8cDD4hcJTk4WfmyKwU=
X-Google-Smtp-Source: APXvYqwYRTF3MnCYATLiJ+ZqcgT9/DArauisQ+e4UKASVqEwmtFvSwNn2galsFLV/dQmuwgAPCREJA==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr13586682pjp.116.1576195743090;
        Thu, 12 Dec 2019 16:09:03 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:02 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 37/58] tty/serial: Migrate samsung_tty to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:36 +0000
Message-Id: <20191213000657.931618-38-dima@arista.com>
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

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/samsung_tty.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 83fd51607741..9770fe29ae86 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -21,10 +21,6 @@
  * BJD, 04-Nov-2004
 */
 
-#if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
@@ -1909,6 +1905,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 		ourport->port.fifosize = ourport->drv_data->fifosize[index];
 	else if (ourport->info->fifosize)
 		ourport->port.fifosize = ourport->info->fifosize;
+	ourport->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SAMSUNG_CONSOLE);
 
 	/*
 	 * DMA transfers must be aligned at least to cache line size,
-- 
2.24.0

