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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DFAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E5B20679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWlCOg5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfGaRbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38195 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbfGaRbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so23567224pgu.5;
        Wed, 31 Jul 2019 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Rq4ixRwzTusnM+r4uVBay3rBSCCdr5LrRUS010+F0U=;
        b=eWlCOg5Hdz1qSpJeRYwg3iuMlVPg4PoJxR7JZMVAfCHl+eNr9cdTsjj45SIIHZ/ef8
         dKNctXKA053xAmYU9E5XFmzcAa7ZFH4wm+ySkqd/9me3XuPqgi2ZQNKnWqL+ij7ujx9C
         5ntXpNwNMGgIIajoYi4fr0G1JCa9atthyNkADM5ikWp5Xi0vs0VmnKOUaaRw4A8w1IN7
         OezZGKhalV5dBdH37KDLreWQGmx69LSVvV+TNjDBcYEMUNy2B+EoSQX18dvCHMDa20kP
         8jRTp+7y351Sbc8YrUhX7EnIX2jJ1r+54qV7t71KVhqDKYzibA/4wG32OyqmokJ5zFGW
         WxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Rq4ixRwzTusnM+r4uVBay3rBSCCdr5LrRUS010+F0U=;
        b=XTN34cieG1t1W/6AwI5L0OANcjmHQ+QRNHIifFOwT0pCmqhZBxIl++WzH/ls9Sq7v1
         hFYboanbAppYbyW+5VZQXszIB/65sUbeDYevu4Mnu+HV/4yMxv4qpFGPudG9LbKmyjwz
         2wN9Y4iYvXlprlzyPGKgox9eC9I8T80yKxSSH4j0qN4UQ/flh66P3qsx2GJa1VDEvuM5
         GQDTufJJIPl71zJWoVtBmpbuq0xAN99NVFWX4pYHU7lZgdaHdfpyI9CX9tLkJn/3NI/L
         dYdmXc98BPRfa3urM+vBKhlVBxB0KvOexUZcr7I40VoI940xDpz/SddvvBMo9KZ7CpFu
         htmA==
X-Gm-Message-State: APjAAAWtMKi0h3tk0qKaY8m0tqXM6DvwZ7AQSOod4XA9H9R+qqp1fRCz
        Alxzzx0NMfZ5eo6MzODTtLybi/nXQyo=
X-Google-Smtp-Source: APXvYqy8Cbiv2LiwMeZqjKVYKvkZ6s2SqIcxIx7B0qEOeCS0WBYVcEyqvLcLcf2xU1m7ISbqnXm5FA==
X-Received: by 2002:a63:724f:: with SMTP id c15mr117597354pgn.257.1564594281510;
        Wed, 31 Jul 2019 10:31:21 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:20 -0700 (PDT)
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
Subject: [PATCH v2 07/23] tty: serial: fsl_lpuart: Fix issue in software flow control
Date:   Wed, 31 Jul 2019 10:30:29 -0700
Message-Id: <20190731173045.11718-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although I haven't observed this bug in practice, it seems that the
code for handling x_char of LPUART is pretty much identical to that of
i.MX. So the fix found in commit 7e2fb5aa8d81 ("serial: imx: Fix issue
in software flow control"):

    serial: imx: Fix issue in software flow control

    After send out x_char in UART driver, x_char needs to be cleared
    by UART driver itself, otherwise data in TXFIFO can no longer be
    sent out.
    Also tx counter needs to be increased to keep track of correct
    number of transmitted data.

    Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

should apply here as well.

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
 drivers/tty/serial/fsl_lpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c35f81df0cff..8657addbfd1c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -782,6 +782,8 @@ static void lpuart_txint(struct lpuart_port *sport)
 			lpuart32_write(&sport->port, sport->port.x_char, UARTDATA);
 		else
 			writeb(sport->port.x_char, sport->port.membase + UARTDR);
+		sport->port.icount.tx++;
+		sport->port.x_char = 0;
 		goto out;
 	}
 
-- 
2.21.0

