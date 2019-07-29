Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FD9C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4348021773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPMJGjuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404012AbfG2Txg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:53:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35138 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390485AbfG2TxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so28575262pfn.2;
        Mon, 29 Jul 2019 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TnvWZKjKvU7u+vN708MQjB0flGfxnL4OAYKB9SzTAVc=;
        b=tPMJGjuApb8sMGO/2XiiL8eIpbfas7MTF6YJfM0Jcy9y1TU2+vl6hN/g+srNaHB+Rl
         Zpu7Ehe7I+O/PIM653NFNBOT616ksllegwuxP61bJoMDwrSNg0kXgtFAZMfN/6AU/Zc7
         ql49C55VdLVOwQfwpAg1BooFx8qeeIwdKt7bIfmLIwzREH0XHv2Wib1kldWRHEGshiOH
         jcsPIMwSxdYVN/oAPCclDS/PS8zNq48mRU4mf8CSLS6nVp6as4DofC887y4CZkO/Aoje
         f6bhevE+Bxk7JxN1fqrf5jGgC32h/xxq36tPNQbki9BBth+xKxdGKAxFdshrDqsOtNB8
         Blew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TnvWZKjKvU7u+vN708MQjB0flGfxnL4OAYKB9SzTAVc=;
        b=Ne1ibV6pqMW+X2WXWEmQxhUfXoGcDKYxu1eksassNvOqRdI0g/fGjaCdcg6an7zfrM
         0qFngkGRhemVwLteBnhBqXKKUA9I94FmGne+gJrM5/L/suap9qH6ytPzoHBgoFdnz5Bg
         fky+D8/KaviAdEdx5fNcf58DOR+6xdsVKMonAnL4YjFPZ4lLPmttjEkPNWwazRLlQqI2
         hHfIFmoaWLwyWrjt4Bgo3lLaI5BOetslYccBrxlD/D1tL5IYqpYYQ0ytY7kBEZzIpMSz
         OileXWHf0XlBDqDM7Xh3RQJa2E4vUNmJv1XCND610wbwjcZdrlCJiXa/8if41iBLOQiV
         ELJw==
X-Gm-Message-State: APjAAAVoTVYjEBGUkDZR8n1+EEU/FrmeER3fqxb7NW5Q+OlcgfkMVz9j
        gInaHicRCh+ym+vgVirYlQRNtAic
X-Google-Smtp-Source: APXvYqydNON7mPwRQxitz3ODwEGCeCMHli27bW+4p+C8zGMsxl/z3vNT16+Z8xy7Q9IvJjkoNcbp0Q==
X-Received: by 2002:a17:90a:bf03:: with SMTP id c3mr26607274pjs.112.1564429989563;
        Mon, 29 Jul 2019 12:53:09 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:08 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/24] tty: serial: fsl_lpuart: Drop unnecessary lpuart*_stop_tx()
Date:   Mon, 29 Jul 2019 12:52:19 -0700
Message-Id: <20190729195226.8862-18-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the time lpuart_shutdown() calls lpuart_stop_tx() UARTCR2_TE and
UARTCR2_TIE (which the latter will clear) are already cleared, so that
function call should effectively be a no-op. Moreso, lpuart_stop_tx()
is expected to be executed with port spinlock held, which the caller
doesn't. Given all that, drop the call to lpuart_stop_tx() in
lpuart_shutdown().

In case of lpuart32_shutdown()/lpuart32_stop_tx(), TIE won't even be
set if lpuart_dma_tx_use is true. Drop it there as well.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index a090b93211e3..67f196f66533 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1575,8 +1575,6 @@ static void lpuart_shutdown(struct uart_port *port)
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
-
-		lpuart_stop_tx(port);
 	}
 }
 
@@ -1608,8 +1606,6 @@ static void lpuart32_shutdown(struct uart_port *port)
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
-
-		lpuart32_stop_tx(port);
 	}
 }
 
-- 
2.21.0

