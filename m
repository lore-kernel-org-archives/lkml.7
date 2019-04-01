Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD127C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81677217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfDALZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:25:17 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:35146 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDALZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:25:16 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id uzRD1z00E3XaVaC06zRDhs; Mon, 01 Apr 2019 13:25:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hAv3x-0003Yp-9v; Mon, 01 Apr 2019 13:25:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hAv3x-000622-6k; Mon, 01 Apr 2019 13:25:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Fix HSCIF RX sampling point calculation
Date:   Mon,  1 Apr 2019 13:25:10 +0200
Message-Id: <20190401112510.23145-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several issues with the formula used for calculating the
deviation from the intended rate:
  1. While min_err and last_stop are signed, srr and baud are unsigned.
     Hence the signed values are promoted to unsigned, which will lead
     to a bogus value of deviation if min_err is negative,
  2. Srr is the register field value, which is one less than the actual
     sampling rate factor,
  3. The divisions do not use rounding.

Fix this by casting unsigned variables to int, adding one to srr, and
using a single DIV_ROUND_CLOSEST().

Fixes: 63ba1e00f178a448 ("serial: sh-sci: Support for HSCIF RX sampling point adjustment")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Anyone with a good test setup for verifying this feature actually works
as advertised?
---
 drivers/tty/serial/sh-sci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 2bdaeba5d527a6ce..8dea59edde34c224 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2522,7 +2522,9 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			 * center of the last stop bit in sampling clocks.
 			 */
 			int last_stop = bits * 2 - 1;
-			int deviation = min_err * srr * last_stop / 2 / baud;
+			int deviation = DIV_ROUND_CLOSEST(min_err * last_stop *
+							  (int)(srr + 1),
+							  2 * (int)baud);
 
 			if (abs(deviation) >= 2) {
 				/* At least two sampling clocks off at the
-- 
2.17.1

