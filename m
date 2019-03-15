Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAA92184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfCOJXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:23:39 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:45822 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:23:39 -0400
X-IronPort-AV: E=Sophos;i="5.58,481,1544511600"; 
   d="scan'208";a="25412861"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Mar 2019 02:23:38 -0700
Received: from rob-ult-m50855.microchip.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Fri, 15 Mar 2019 02:23:37 -0700
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
Subject: [PATCH 0/2] tty/serial: atmel: Fix RS485 half duplex operation
Date:   Fri, 15 Mar 2019 11:23:32 +0200
Message-ID: <20190315092334.13246-1-razvan.stefanescu@microchip.com>
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

Razvan Stefanescu (2):
  tty/serial: atmel: Add is_half_duplex helper
  tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

 drivers/tty/serial/atmel_serial.c | 52 +++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 16 deletions(-)

-- 
2.19.1

