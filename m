Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8ABC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943642067B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfJINyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:54:05 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:58840 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJINyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:54:05 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iICPd-00080u-TF; Wed, 09 Oct 2019 14:53:58 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iICPd-0002v5-DO; Wed, 09 Oct 2019 14:53:57 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Barry Song <baohua@kernel.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: sirf: make register info static
Date:   Wed,  9 Oct 2019 14:53:56 +0100
Message-Id: <20191009135356.11180-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sirfsoc_usp and sirfsoc_uart objects are not
used outside of the drivers/tty/serial/sirfsoc_uart.o
so make them static. Fixes following sparse warnings:

drivers/tty/serial/sirfsoc_uart.h:123:30: warning: symbol 'sirfsoc_usp' was not declared. Should it be static?
drivers/tty/serial/sirfsoc_uart.h:189:30: warning: symbol 'sirfsoc_uart' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Barry Song <baohua@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/sirfsoc_uart.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 004ca684d3ae..637b09d3fe79 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -120,7 +120,8 @@ static u32 uart_usp_ff_empty_mask(struct uart_port *port)
 	empty_bit = ilog2(port->fifosize) + 1;
 	return (1 << empty_bit);
 }
-struct sirfsoc_uart_register sirfsoc_usp = {
+
+static struct sirfsoc_uart_register sirfsoc_usp = {
 	.uart_reg = {
 		.sirfsoc_mode1		= 0x0000,
 		.sirfsoc_mode2		= 0x0004,
@@ -186,7 +187,7 @@ struct sirfsoc_uart_register sirfsoc_usp = {
 	},
 };
 
-struct sirfsoc_uart_register sirfsoc_uart = {
+static struct sirfsoc_uart_register sirfsoc_uart = {
 	.uart_reg = {
 		.sirfsoc_line_ctrl	= 0x0040,
 		.sirfsoc_tx_rx_en	= 0x004c,
-- 
2.23.0

