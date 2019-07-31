Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ECFC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C51206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9qTtjAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfGaRdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:33:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33956 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfGaRdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:33:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so26165585pgc.1;
        Wed, 31 Jul 2019 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/lI9Y+iuMqu0/88TVov6DxL4UL/ibIqCQWpqsUjgQE=;
        b=c9qTtjApobnJnkUtjbZgrCEe6ORor1BWYjjLIf8kYPgyf+wi1mZOOA3SAge2YRRyvN
         wFaY8eFQX600DnVGw4dgTqQjUtK/JwzzwyQqs2x565q/vWnhHwKtEXUK9vDEXpzfeGpU
         XoXdIOkRam2Dzpz5I8vDf1YzMu1Ldq2cX3FCJRkBKoJ+TfSc5lx46jItuvmnuEPU8ZXJ
         eclEKsjvJ36fbFp5/mAh4LHsYoCJ5opDbknF/V86258DRF7IPJB1DkNqhCuWlLW+w3OU
         Kun8dDIOWIPTI3kmTE7Mr2YSPdzI5c6MPHa8IBJe4ccna0L/rydBPvHufgoJvDdVzKb7
         YsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/lI9Y+iuMqu0/88TVov6DxL4UL/ibIqCQWpqsUjgQE=;
        b=gzc2/rTiSaTY4el/EdR8/921ihGXrbBDgNykISzMphiKjYcdjfG+MVlIl9vQH8Ir9q
         bQ5BiHwneds2EP1wms1vAaTnoEOail20N5RiG7jREuVvzIAVaICU747f9xXMfyvE+NSD
         QO1rr/NcOlu2t/WAFyhJb6gUJ9HCzWcUcBTYBwrdj9I6+9rNsORHoC85+d9clUvoZWBm
         UVjHybTXyAfNrV2EaF4Zp6X/6zd/gu6c6zXGkP0aPF9q3O5Aqeyf/bNHuknfEcSxMVc6
         qvmgTXYT1dGyyVshXaGel09n1npeJZC8Arg+cg8WNP7ivr08zKaNA9PE7eZVo+RFTBJj
         sEkQ==
X-Gm-Message-State: APjAAAUd65dkLnParsYCIvvcoU1K02ejbjkkzYsbTjGfZTS/tyB2Qugy
        C9Kv/y1gQW+CW8c5HLAbrOWxia43
X-Google-Smtp-Source: APXvYqx89nO0ID4KvdGJWas//BKX6lntSQr/4mYrYUB6MdCKX7JIiBzf3RxdLx1pxlXA5a7FqOeUqQ==
X-Received: by 2002:a62:1616:: with SMTP id 22mr49470661pfw.120.1564594410026;
        Wed, 31 Jul 2019 10:33:30 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.33.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:33:29 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/23] tty: serial: fsl_lpuart: Ignore TX/RX interrupts if DMA is enabled
Date:   Wed, 31 Jul 2019 10:30:45 -0700
Message-Id: <20190731173045.11718-24-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a mixed DMA/IRQ use-case (e.g.: DMA for TX, IRQ for RX), interrupt
handler might try to handle Rx/Tx condition it shouldn't. Change the
code to only handle TX/RX event if corresponding path isn't being
handled by DMA.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 237690a6e80a..e758ca57113f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -967,10 +967,10 @@ static irqreturn_t lpuart_int(int irq, void *dev_id)
 
 	sts = readb(sport->port.membase + UARTSR1);
 
-	if (sts & UARTSR1_RDRF)
+	if (sts & UARTSR1_RDRF && !sport->lpuart_dma_rx_use)
 		lpuart_rxint(sport);
 
-	if (sts & UARTSR1_TDRE)
+	if (sts & UARTSR1_TDRE && !sport->lpuart_dma_tx_use)
 		lpuart_txint(sport);
 
 	return IRQ_HANDLED;
-- 
2.21.0

