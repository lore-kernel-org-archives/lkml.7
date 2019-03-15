Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E123C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE473218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="CBie6IVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfCORQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:16:28 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:33800 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfCORQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:16:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 758B075D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 17:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ivc0Nz84NmdR for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 12:16:26 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4F3AD75
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:16:26 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id i1so7639296ioq.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kk3h+OuEgiYucZ4gPcQYueJ8msxBwlUWYnXS7Ps4WXI=;
        b=CBie6IVRxdbTCw1/p7ZcfqV1mjrWtBphD8lF0IGxNyorKa3tk/XTQTBRasQurtaUFL
         umk0q8/9iZhB2dmCMdhhZ2M3U8s7d0MqPaETMM8if3OfMQ++DsytRNLhLNJf02kzjK/F
         Hn1IpAyhQk5WXlWQO9poHcMOgKXVEgBxuZK15pEtm7+0BH554+QXILj0ffcoo0jcIAEx
         ZCHNEFYDuwN+R2yyZolgf2Sx4KanY72+VHATpztgujxu+SVqWN39uWRvhJsy2a9Nf5gz
         GbhTTBQsMFFy1L6a9wAO8VLy/z0RdNgJPDmJvc8oTV48TBPG+Btd745V3fqUSZGD9zxt
         cBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kk3h+OuEgiYucZ4gPcQYueJ8msxBwlUWYnXS7Ps4WXI=;
        b=RhYlwdsGtsSatCEMySyGjmVMme2Z+AzjgBZVP9vB0CTe/H8oWmwTHhTC+GSKmpn4zY
         Us+IxNfRCbtR87LmkABiRyOtPGWcBVo2dQmW7KajGQ+prcdSySDCmSNFw++Jw3oGya0Q
         HeyQ2KWKHNRymR3mL97+Kvn95YlOSm+MdGcGpFs+b2Gy1RRbyp+4Lo5PjhVMC6g3T1DS
         TRmvF1gavS5FCrJj0dsxlLwy6O1YRzNNf+UHouzpqZBQNQ0V0ll/mjnI7AXcdS+AEm9F
         4NlJAZdBgkAsQNfv9BRutTiIV7j4sKIKt/YDTkT0e/dJBCuaBWUU3BF9Y7c7Gb8sT1sT
         xk9g==
X-Gm-Message-State: APjAAAUgqX4vf24SKVSrwtdcnS8MXo1Y5TZrspXgDG8a8P2Jcrm9Mt7P
        cfjROcBpNNcyoOk0U6Wa9janAaO/lArG8SO5N0n+++nsSfUawmLZI+RsPJWgYkZs3SLSzbxd83B
        Z3uiShb+h0mnmFzzBwA56Lno1qUGB
X-Received: by 2002:a02:5145:: with SMTP id s66mr3062256jaa.109.1552670185622;
        Fri, 15 Mar 2019 10:16:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqmbHsiWob7LsodszCcxrcpkvnERTMzNkbucUpS6PBE06VOSNgLkVuHl707x1JjHOVAr1MsA==
X-Received: by 2002:a02:5145:: with SMTP id s66mr3062249jaa.109.1552670185357;
        Fri, 15 Mar 2019 10:16:25 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id u66sm1024003ioe.74.2019.03.15.10.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 10:16:24 -0700 (PDT)
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
Date:   Fri, 15 Mar 2019 12:16:06 -0500
Message-Id: <20190315171606.6282-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d8978a94-23fc-3610-e3da-5e1da2d86914@sorico.fr>
References: <d8978a94-23fc-3610-e3da-5e1da2d86914@sorico.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case dmaengine_prep_dma_cyclic fails, the fix returns a proper
error code to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Fixes: 34df42f59a60 ("serial: at91: add rx dma support")

---
V2: simplified the patch as suggested by
Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 05147fe24343..41b728d223d1 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1288,6 +1288,10 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 					 sg_dma_len(&atmel_port->sg_rx)/2,
 					 DMA_DEV_TO_MEM,
 					 DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(port->dev, "Preparing DMA cyclic failed\n");
+		goto chan_err;
+	}
 	desc->callback = atmel_complete_rx_dma;
 	desc->callback_param = port;
 	atmel_port->desc_rx = desc;
-- 
2.17.1

