Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F71C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135752184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="M1yj+fuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfCNHSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:18:09 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:54030 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCNHSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:18:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id A635DC91
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nydv4Vjip4Ln for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 02:18:07 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 6CEE6C84
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:18:07 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id k24so3579101ioa.18
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oRmn4b9rhT3KDTlseWZhI2IzGPx/P3+INt92Eg01Y0c=;
        b=M1yj+fuo0rJqX3b9OyOKqI5LU5WCUiUzwlNCH13DL5l5yOWqW08Z1y7XGxYOyPuSjX
         FSHmf6KBzB3G0ki1tEhmNIwbeTOfFEuLTyS4YYwt9n4WthUJk7UmAvNUY8A0CBoNseFz
         cfcybQXbmmwLZmDIv30JD9ZpGDPAxdkvtZXCgql4V15dF0oqVX4PJwwd78eVvepCB95n
         3L+uMR+hzQQRPKLCbWvUpW+ZiBn/Jyl1J76WtmTA0JQRJI1hbQDTK7Kmtad2aD800y7U
         f3hKgib6F3S+mC3O63ARoSkWfDg6VBOy3/+z3ESHG0pcyAYFQqcUa4BAasSGHtE2kwgC
         z7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oRmn4b9rhT3KDTlseWZhI2IzGPx/P3+INt92Eg01Y0c=;
        b=qZAzSq6OKngWlORH1bs4CknU6UQUgBP4+6t9QjrjoVeWsFKD2syi1J02JSJQXBAmd1
         CVNLSn8aLyD7OfPZTZtWdmBnpg7Izo4Qlg7iF3WJV+q3KWfgx802l55GNDDPzzX+GuKN
         01H6MsOdMOdy2v9bLJUcb8uHWMkMLGoTQsPcjWTdR+FaKI/Yutb1aexdQB/iztfh1y7h
         f6gnk4xIMYqKnGKTjVRoOyAZLBaD7XCMfcxQrPbZ/2E6PfZWD0xNh90B7LAoaRrUVgdi
         N9IkrzUteHYTV/APaLIsZKXE/wE8g62FSYg4ODdYExqz8fgLBUt+JNWyPydBYWRKSbd2
         Pk1w==
X-Gm-Message-State: APjAAAUZzjqCEtifav9UXYbw9+JY5ZaKLQlV7TThZ0XRWKLBXL22Xz/N
        hFWQUyc1lLrtbU0gRTjlQqv8h8MyZOJixRVHI2qWDll/h4uN8akwgufJeKn7utQESEG0Akd5Ev5
        L7c7nIJrF2weC1a09M2jmNSpV9Htj
X-Received: by 2002:a24:d51:: with SMTP id 78mr1001978itx.133.1552547886931;
        Thu, 14 Mar 2019 00:18:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx3tadtwe+bSiINjlA7kUxPih+uN+gRSEnEL+OTIJYnGmVIF8fK5+kfFSuBsJnCuv9SMvTQtg==
X-Received: by 2002:a24:d51:: with SMTP id 78mr1001966itx.133.1552547886663;
        Thu, 14 Mar 2019 00:18:06 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id z10sm6112974iol.25.2019.03.14.00.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 00:18:05 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: atmel_serial: fix a NULL pointer dereference
Date:   Thu, 14 Mar 2019 02:17:59 -0500
Message-Id: <20190314071759.18845-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case dmaengine_prep_dma_cyclic fails, the fix return a proper
error code to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/tty/serial/atmel_serial.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 05147fe24343..cf560d05008c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1237,8 +1237,10 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	dma_cap_set(DMA_CYCLIC, mask);
 
 	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
-	if (atmel_port->chan_rx == NULL)
+	if (atmel_port->chan_rx == NULL) {
+		ret = -EINVAL;
 		goto chan_err;
+	}
 	dev_info(port->dev, "using %s for rx DMA transfers\n",
 		dma_chan_name(atmel_port->chan_rx));
 
@@ -1257,6 +1259,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 
 	if (!nent) {
 		dev_dbg(port->dev, "need to release resource of dma\n");
+		ret = -EINVAL;
 		goto chan_err;
 	} else {
 		dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n", __func__,
@@ -1288,6 +1291,11 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 					 sg_dma_len(&atmel_port->sg_rx)/2,
 					 DMA_DEV_TO_MEM,
 					 DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(port->dev, "Preparing DMA cyclic failed\n");
+		ret = -ENOMEM;
+		goto chan_err;
+	}
 	desc->callback = atmel_complete_rx_dma;
 	desc->callback_param = port;
 	atmel_port->desc_rx = desc;
@@ -1300,7 +1308,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	atmel_port->use_dma_rx = 0;
 	if (atmel_port->chan_rx)
 		atmel_release_rx_dma(port);
-	return -EINVAL;
+	return ret;
 }
 
 static void atmel_uart_timer_callback(struct timer_list *t)
-- 
2.17.1

