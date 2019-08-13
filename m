Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61096C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B7420679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfHMHkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:40:36 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48101 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfHMHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:40:36 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Razvan.Stefanescu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Razvan.Stefanescu@microchip.com";
  x-sender="Razvan.Stefanescu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Razvan.Stefanescu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Razvan.Stefanescu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cxXL8660C9M6aAGH2Uluy4pcamff96/clUOJXI9w+01rqmasY0c+Z3YC/5KrXvVwTnoGGDOOVM
 svl2t9PlHw9U1CtHEd0w3eW9usRPRTPaAXTFitv4XA3ciqUFsPScxeMd276tteDf/SLCimGAY7
 Z2373lX/AjNYX5vjjc0HkI8NmHwRvTp4wiQcvpLNUKUId8H5iuREpjnjyc8ZeB99oLsuZGxQ/6
 dLBeW1QwY7/pZzzlaJRq52j6YWpzVn6RRsgHX6AGJ8NZ035bbgIflK/VpoNiClDiewbJuqkswk
 Z0c=
X-IronPort-AV: E=Sophos;i="5.64,380,1559545200"; 
   d="scan'208";a="44893566"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Aug 2019 00:40:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Aug 2019 00:40:29 -0700
Received: from rob-ult-m50855.microchip.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 13 Aug 2019 00:40:26 -0700
From:   Razvan Stefanescu <razvan.stefanescu@microchip.com>
To:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tty/serial: atmel: reschedule TX after RX was started
Date:   Tue, 13 Aug 2019 10:40:25 +0300
Message-ID: <20190813074025.16218-1-razvan.stefanescu@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When half-duplex RS485 communication is used, after RX is started, TX
tasklet still needs to be  scheduled tasklet. This avoids console freezing
when more data is to be transmitted, if the serial communication is not
closed.

Fixes: 69646d7a3689 ("tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped")

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 0b4f36905321..8e667967928a 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1400,7 +1400,6 @@ atmel_handle_transmit(struct uart_port *port, unsigned int pending)
 
 			atmel_port->hd_start_rx = false;
 			atmel_start_rx(port);
-			return;
 		}
 
 		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
-- 
2.20.1

