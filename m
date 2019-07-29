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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29629C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79E9205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duEiWJqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404362AbfG2T7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:59:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46463 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbfG2TxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so9730240pgk.13;
        Mon, 29 Jul 2019 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txBFEA0p0mencL2FMZffTtTBfxW3XrDp/4JH32LKLg4=;
        b=duEiWJqAE4UPSZq/9tzAYpc+uL61VBt4tJ1ePuEtIn+sKgLJgKuO88g+UOLkEHty+a
         H+e80AqYmT2zulzRH3YmpyzB+wiNa9wpbKqzcU/tm5VK11dTgzYRwSZLFE3gXkQ0kstB
         81ikjiImNRIF09o2tFebG6wcs0h5InIqWz+5hN5L31xlSn0dljW0q99WMOYwnMrJOtSQ
         8ZzSjwZVNE4TJjD1SXynbxEY6YEeL5PbsHqC3/z9ZZOQn2Mlvvoj2yb0yjNbdQbzWQAY
         UHdmjKEEzvmq1Pq2/1K5dc31I/Ubt1fjDBsZcDMWpEt+LNHz1MRiScHBwLT5n6sH/Q/Q
         45Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txBFEA0p0mencL2FMZffTtTBfxW3XrDp/4JH32LKLg4=;
        b=XQicbLnfMCDjlXO5kQgt6iQIJo+jNJ+RCQHqpHp/n2ApeUfrkbCTRL0/hEb8SGoFPO
         aK077GXl4YHjgAqr9GMxvsdCq74+1IvFHrjt/KkVk4w5YQBabXCpNiTMN+Ufi5ABYbHY
         xE/apzkSztTHWxAZJkylGuh/sZwFwjktgEbTvZHyO5J+QPwj6hyR82D7hjYRS/0fFZfH
         tdxLER1Ae7jhwUC6j9M6JqSE7OFDTS0id0b5va14s6pIMkQtTBzd6MISaSlmkbcRKhAN
         vrvRhy7Ae3C9u96AV5+JC/6DIslVNv5vBoJnSrPFTC/VwkCE493Xmom425QfwatTdM/h
         avIw==
X-Gm-Message-State: APjAAAVbGxT+UiX9iFQituVilmw5Fqo5h7mtzL+FB9uGA5tt0vqZnPx5
        S2B2yggV1pqY/TsLiVnoBEQ7Oq4o
X-Google-Smtp-Source: APXvYqyZA64AdyyRDDWjGksnRFKzgAF1EPZGhkMHmGHI/TUqw1qcy2bpBGj83iyyUVhQS7SaG9cWFQ==
X-Received: by 2002:a17:90a:360c:: with SMTP id s12mr115325049pjb.30.1564429979746;
        Mon, 29 Jul 2019 12:52:59 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:52:59 -0700 (PDT)
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
Subject: [PATCH 10/24] tty: serial: fsl_lpuart: Drop no-op bit opearation
Date:   Mon, 29 Jul 2019 12:52:12 -0700
Message-Id: <20190729195226.8862-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for termios->c_cflag & CRTSCTS ensure that if we reach else
branch, CRTSCTS in termios->c_cflag is already going to be
cleard. Doing so explicitly there is not necessary. Drop it.

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
 drivers/tty/serial/fsl_lpuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f87ea889ff86..5181ba5d8f71 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1651,12 +1651,10 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (sport->port.rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
-	if (termios->c_cflag & CRTSCTS) {
+	if (termios->c_cflag & CRTSCTS)
 		modem |= (UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
-	} else {
-		termios->c_cflag &= ~CRTSCTS;
+	else
 		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
-	}
 
 	if (termios->c_cflag & CSTOPB)
 		termios->c_cflag &= ~CSTOPB;
-- 
2.21.0

