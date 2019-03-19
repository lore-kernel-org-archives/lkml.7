Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE640C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23F220854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfCSNUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:20:37 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:32635 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfCSNUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:20:37 -0400
X-IronPort-AV: E=Sophos;i="5.58,498,1544511600"; 
   d="scan'208";a="28347284"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Mar 2019 06:20:36 -0700
Received: from rob-ult-m50855.microchip.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Tue, 19 Mar 2019 06:20:36 -0700
From:   Razvan Stefanescu <razvan.stefanescu@microchip.com>
To:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
CC:     Gil Weber <webergil@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] tty/serial: atmel: Fix RS485 half duplex operation
Date:   Tue, 19 Mar 2019 15:20:33 +0200
Message-ID: <20190319132035.18481-1-razvan.stefanescu@microchip.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a loopback serial cable with RS485 protocol shows that data is
received:
$ stty -F /dev/ttyS3 raw -echo speed 4800
$ cat /dev/ttyS3 &
$ echo "Hello, world" > /dev/ttyS3
Hello, world

Last line should not be displayed, as it indicates that RX was started
before TX finished.

This happens because driver activates RX when the DMA transfer
completes, but that does not necessarily mean the TX FIFO was emptied.

First patch will add a helper that checks if the transmission is
half-duplex and uses it throughout the driver, replacing multiple lines
of code.

Second patch implements the fix by adding a variable to the port struct.
This is used to indicate that RX needs to be started. When the DMA
transfer completes, the variable is set and the ATMEL_US_TXEMPTY is
reactivated. In the interrupt handler, if the variable is set, RX is
started.

Changelog:
v1 -> v2:
  - remove wrongly added check;
  - start rx and display warning message in case of error
  - add fix info

Razvan Stefanescu (2):
  tty/serial: atmel: Add is_half_duplex helper
  tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

 drivers/tty/serial/atmel_serial.c | 48 +++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 15 deletions(-)

-- 
2.19.1

