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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5051C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B561E204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVIQeW2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404367AbfG2T74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:59:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40172 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403793AbfG2Tw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so27859131pla.7;
        Mon, 29 Jul 2019 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KotmfPrwT18RHgM88KlaX3lPR9Sm0I4P1BxMeCf6KdI=;
        b=LVIQeW2VeA0efJol8LrqUzmEf0utzN3AOjeQeB9t1szJZOpODsTxqEbWnfHqDW1cB2
         MrCd36Xq4UznZnhkNn9jgFGgTvuzPQB9x1k2d2FRFGuTDr+pSXZ2yWS+jL7epTDS9ePg
         WqBjXTYodrqrANY68cAPoN16Xq/rvawhHH0kawm9ET72JJphKLkS8GRgFRCXcnSPCgwU
         yUM974AIOp0s64eby11dkrxUKBoNGSXaLEjKyYYfDGK+fw25NoinBTS9F9Vt+kyurp2z
         gcdE3AMcttSYiMsm1z3df3gvdD0JmMF27Mt7N0R5tTU5SGUhucOqGtzcC1vPAM8b/+ZP
         TRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KotmfPrwT18RHgM88KlaX3lPR9Sm0I4P1BxMeCf6KdI=;
        b=GDQmDvHwLw+OVRQOLZgg6SjbLry0oUfgfvwnok68IS7llp5mKmHvk65Sxk/P9Hnt34
         nBMix+yy7c+p1t6cnrQWeXtCYnV8Eyn5SpGd6/vPB11LKaaz0L92TdtF3ue1fSLGDiXV
         eRp/GYtmM9WiasOuqnlCoJTeoPTng9JlZLjHRDhEeysA1Z6znrs+BzTz3aelwNoLRusO
         iFw464tdiisPmodUvUyoShmvkEwtg02ZtAW6sUD+RNJ7IRxi0AJj/Tudf2YpJ/DOwBcK
         y510LG5ReFNzhRwfD33ymFQkL6z3FjUbZ1c0wxE4iJW5nE69SS3JM7k4MzmBtLtqfy8i
         Nwdg==
X-Gm-Message-State: APjAAAWGBzrWKIXKE9xYb4izeLr6avSfi/g8wfaumcpulTm4e3535I5u
        wGpdAZOPqeLG3Mn04ls028uylilv
X-Google-Smtp-Source: APXvYqxbZNbG0lxeegJkXnpkYbLAbiklpenVntDNCT/iKbMk8JxHM4gxErpSK9AfuG2eW1ecLEwx3g==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr113082092pll.27.1564429975198;
        Mon, 29 Jul 2019 12:52:55 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.52.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:52:54 -0700 (PDT)
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
Subject: [PATCH 07/24] tty: serial: fsl_lpuart: Drop unnecessary uart_write_wakeup()
Date:   Mon, 29 Jul 2019 12:52:09 -0700
Message-Id: <20190729195226.8862-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uart_write_wakeup() will already be called as a part of
lpuart*_transmit_buffer() call, so there doesn't seem to be a reason
to call it again right after.

It also appears that second uart_write_wakeup() might potentially
cause unwanted write wakeup when transmitting an x_char. See commit
5e42e9a30cda ("serial: imx: Fix x_char handling and tx flow control")
where this problem was fixed in a very similarly structured i.MX UART
driver.

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
 drivers/tty/serial/fsl_lpuart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b600f591c8c2..840dcbb27e5a 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -797,9 +797,6 @@ static void lpuart_txint(struct lpuart_port *sport)
 	else
 		lpuart_transmit_buffer(sport);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
-
 out:
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
-- 
2.21.0

