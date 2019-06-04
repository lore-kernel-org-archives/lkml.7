Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92955C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE7320843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="opCDLjuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfFDQPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:15:32 -0400
Received: from smtp-good-out-2.t-2.net ([84.255.208.44]:42070 "EHLO
        smtp-good-out-2.t-2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbfFDQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:15:32 -0400
Received: from smtp-2.t-2.si (smtp-2.t-2.si [IPv6:2a01:260:1:4::1f])
        by smtp-good-out-2.t-2.net (Postfix) with ESMTP id 45JH8K75cCzZC9;
        Tue,  4 Jun 2019 18:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1559664930;
        bh=Nm0CTY9O9Jph9TjFeOTe73ck/7qXqL8hFmMf283KJ4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=opCDLjuLS51OPR3oIklcGovEgUBHiRmMSNHg38Aacg6q2bxv9U+uCKPRv9+kSaPhh
         QAUf4mwhn3C1WNJ2lxzKodcYA26ZLlUAD2+WjuaBAGXsjy3auN7t6lCFjxLmS/eIrk
         ftutAhUXES57MzBc+xndD4ElCZ6bAeAYn8gBfnrA=
Received: from localhost (localhost [127.0.0.1])
        by smtp-2.t-2.si (Postfix) with ESMTP id 45JH8K6rmFzMs33d;
        Tue,  4 Jun 2019 18:15:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.si
Received: from smtp-2.t-2.si ([127.0.0.1])
        by localhost (smtp-2.t-2.si [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NRqyCHxikLg0; Tue,  4 Jun 2019 18:15:29 +0200 (CEST)
Received: from localhost.localdomain (unknown [89.212.35.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: borut_seljak@t-2.net)
        by smtp-2.t-2.si (Postfix) with ESMTPSA;
        Tue,  4 Jun 2019 18:15:03 +0200 (CEST)
From:   Borut Seljak <borut.seljak@t-2.net>
To:     borut.seljak@t-2.net
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] serial: stm32: fix a recursive locking in stm32_config_rs485
Date:   Tue,  4 Jun 2019 18:14:44 +0200
Message-Id: <20190604161444.8819-1-borut.seljak@t-2.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604095452.6360-1-borut.seljak@t-2.net>
References: <20190604095452.6360-1-borut.seljak@t-2.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove spin_lock_irqsave in stm32_config_rs485, it cause recursive locking.
Already locked in uart_set_rs485_config.

fixes: 1bcda09d291081 ("serial: stm32: add support for RS485 hardware control mode")

Signed-off-by: Borut Seljak <borut.seljak@t-2.net>
---
 drivers/tty/serial/stm32-usart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index e8d7a7bb4339..da373a465f51 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -107,7 +107,6 @@ static int stm32_config_rs485(struct uart_port *port,
 	bool over8;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
 	stm32_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
 
 	port->rs485 = *rs485conf;
@@ -147,7 +146,6 @@ static int stm32_config_rs485(struct uart_port *port,
 	}
 
 	stm32_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
-	spin_unlock_irqrestore(&port->lock, flags);
 
 	return 0;
 }
-- 
2.17.1

