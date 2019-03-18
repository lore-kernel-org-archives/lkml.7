Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39624C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D4E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfCRKUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:20:07 -0400
Received: from www3345.sakura.ne.jp ([49.212.235.55]:13752 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfCRKUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:20:06 -0400
X-Greylist: delayed 3193 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Mar 2019 06:20:04 EDT
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2I9QbCV000983;
        Mon, 18 Mar 2019 18:26:37 +0900 (JST)
        (envelope-from na-hoan@jinso.co.jp)
Received: from www3345.sakura.ne.jp (49.212.235.55)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Mon, 18 Mar 2019 18:26:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from localhost (p14010-ipadfx41marunouchi.tokyo.ocn.ne.jp [61.118.107.10])
        (authenticated bits=0)
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2I9QW9d000938
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Mar 2019 18:26:36 +0900 (JST)
        (envelope-from na-hoan@jinso.co.jp)
From:   Nguyen An Hoan <na-hoan@jinso.co.jp>
To:     linux-renesas-soc@vger.kernel.org, geert+renesas@glider.be
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        ulrich.hecht+renesas@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com,
        magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        h-inayoshi@jinso.co.jp, nv-dung@jinso.co.jp, na-hoan@jinso.co.jp,
        cv-dong@jinso.co.jp
Subject: [PATCH] serial: sh-sci: Fix setting SCSCR_TIE while transferring data
Date:   Mon, 18 Mar 2019 18:26:32 +0900
Message-Id: <1552901192-29748-1-git-send-email-na-hoan@jinso.co.jp>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoan Nguyen An <na-hoan@jinso.co.jp>

We disable transmission interrupt (clear SCSCR_TIE) after all data has been transmitted
(if uart_circ_empty(xmit)). While transmitting, if the data is still in the tty buffer,
re-enable the SCSCR_TIE bit, which was done at sci_start_tx().
This is unnecessary processing, wasting CPU operation if the data transmission length is large.
And further, transmit end, FIFO empty bits disabling have also been performed in the step above.

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
---
 drivers/tty/serial/sh-sci.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 64bbeb7..93bd90f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -838,19 +838,9 @@ static void sci_transmit_chars(struct uart_port *port)
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
-	if (uart_circ_empty(xmit)) {
+	if (uart_circ_empty(xmit))
 		sci_stop_tx(port);
-	} else {
-		ctrl = serial_port_in(port, SCSCR);
-
-		if (port->type != PORT_SCI) {
-			serial_port_in(port, SCxSR); /* Dummy read */
-			sci_clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
-		}
 
-		ctrl |= SCSCR_TIE;
-		serial_port_out(port, SCSCR, ctrl);
-	}
 }
 
 /* On SH3, SCIF may read end-of-break as a space->mark char */
-- 
2.7.4

