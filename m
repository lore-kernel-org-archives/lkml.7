Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B174CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8273F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPF60NQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfENKOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:14:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36392 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfENKOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:14:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id z1so13771747ljb.3;
        Tue, 14 May 2019 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wJX9SF3UY7JHR+kvaWwAxJyLE5sk5ey5I1uN0qqeGlw=;
        b=BPF60NQYM9hKHJxp283UcsOH9eBso8/DH2YH3zv61zystYy31lPADB1EF8H7jlXftz
         xAripLNHqO406rxkKpGMdQNHJyoIdddIHVyQPFpwV4dgt8AbFE1NGCeonNsLZmTTBjrP
         4ytt1nLn5L09LvqQLSAdNpH7qnrCzzWMRWeVbr5sLECLyODW2le0/fab7MKqLVdvUrdg
         rx507c98XQWJBr76TQbd7p76b2tdFBlvu8V46wM0IFNb4BV6v9VU0ruhNUlgqGQrxNdE
         AxQBCAAyrVKT0Jp57MOyTNcgHpTMdncHXaW6QJMYC1D3DACothTzdlj69RxE5wSpBFlE
         62nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJX9SF3UY7JHR+kvaWwAxJyLE5sk5ey5I1uN0qqeGlw=;
        b=M21KFz63VTD+Kc2sqtNfuHATxsLpFz/7CnbxTUO6a2lfdUodnnOTNlB8FSmQTDEg7B
         n3oR0p8/6WL/CGg6H4OYN1XVaYbl2Pfksk0IHBocohDk8lg2yU6/Dh0S6hK/JWolhgZn
         nOZ+VAtozsq+0+2dmqxsaCp4W+yYUONY38LEtmFLChCmAizZIXIbXvAmCGI77dgc5gZT
         5HbEXmPnBDi8kIVRvHhFmZJXbwNwF+oUHLiwqKoMHTjbk4OJnyh1rDUlA1e+W+Ih3lXB
         4ar833h448WHUFRBQxoUbWIbqEdhBv+AZ2OCX1McyEMd6VFIyNA1I9hV9wB6700Q+7+J
         pcTw==
X-Gm-Message-State: APjAAAVWhO2g8UHv9OMXto2WDgLnX9ve3kkeD49FectbXgPPacAxAtix
        1wpvGQUDV403FqWmKWTMQbM=
X-Google-Smtp-Source: APXvYqxKAPIKTgQcSFzsi/73Id8EZCbCE4nG6nPu5WuXlQi2bq+BsyGkuwf+TztsEOcE2FUUC2n6qA==
X-Received: by 2002:a2e:63d1:: with SMTP id s78mr17101496lje.166.1557828878014;
        Tue, 14 May 2019 03:14:38 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id v2sm3126359ljg.6.2019.05.14.03.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:14:37 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] tty: max310x: Split uart characters insertion loop
Date:   Tue, 14 May 2019 13:14:15 +0300
Message-Id: <20190514101415.26754-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Batch read mode doesn't check any conditions or flags except the Rx
overflow one. But it may only happen after the last character is pushed
into the RHR register. In this case we shouldn't push all the read
characters with overrun flag set, but only the last one caused the
FIFO overflow. This commit splits the characters retrieval loop into
two parts. First one is ordinary intsert-chars procedure without taking
the overrun status into account. Second part inserts the last character
checking whether the overrun happened and pushing a '\0' character with
TTY_OVERRUN flag to a flip-buffer.

If we left the loop the way it was the '\0' character would be inserted
after each character retrieved at the overrun occasion.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 36943f6c198c..81b2413c3da4 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -680,10 +680,16 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 			port->icount.overrun++;
 		}
 
-		for (i = 0; i < rxlen; ++i) {
-			uart_insert_char(port, sts, MAX310X_LSR_RXOVR_BIT,
-					 one->rx_buf[i], flag);
-		}
+		for (i = 0; i < (rxlen - 1); ++i)
+			uart_insert_char(port, sts, 0, one->rx_buf[i], flag);
+
+		/*
+		 * Handle the overrun case for the last character only, since
+		 * the RxFIFO overflow happens after it is pushed to the FIFO
+		 * tail.
+		 */
+		uart_insert_char(port, sts, MAX310X_LSR_RXOVR_BIT,
+				 one->rx_buf[rxlen], flag);
 
 	} else {
 		if (unlikely(rxlen >= port->fifosize)) {
-- 
2.21.0

