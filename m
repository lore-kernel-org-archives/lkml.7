Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2564DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEF52084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141640;
	bh=XTtuUlzYzWWjVHTD0EY+mjX2JDaNKo2WlpP/z0z6z/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zBQeAWkn9V6fPOdkppCriThLmZdjlG/J9CzTkF8Z49yNubIunpQ42lj4TVUFum799
	 7tUtDN61T5kql9w0LxTHpfdFZFAEjX2ssqGtZf9lml05EV6KX54Jhx7hJehESgAssQ
	 DOTHv47FaD5jb3tgoIGmbfT76JJ/bPMe1c37HHb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfDARQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731089AbfDARQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2ED206C0;
        Mon,  1 Apr 2019 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139014;
        bh=XTtuUlzYzWWjVHTD0EY+mjX2JDaNKo2WlpP/z0z6z/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGhusYMN+5JUg20Uy+5sVfUmNXwQ6awE8iRlCh1yB8LAc8QPMZHaGbt+zWKUnFK40
         gHrbUdxf60/0B3wZUAuK6C8EG7bbdYEUSmSGSieJnn3DgTNg2NfB2Ir82690gFHtKa
         uMe6UfWRvNlSlJClX+psW+eEUnfEHbJmAJBmOwjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hoan Nguyen An <na-hoan@jinso.co.jp>
Subject: [PATCH 4.19 088/134] serial: sh-sci: Fix setting SCSCR_TIE while transferring data
Date:   Mon,  1 Apr 2019 19:02:04 +0200
Message-Id: <20190401170052.504901286@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hoan Nguyen An <na-hoan@jinso.co.jp>

commit 93bcefd4c6bad4c69dbc4edcd3fbf774b24d930d upstream.

We disable transmission interrupt (clear SCSCR_TIE) after all data has been transmitted
(if uart_circ_empty(xmit)). While transmitting, if the data is still in the tty buffer,
re-enable the SCSCR_TIE bit, which was done at sci_start_tx().
This is unnecessary processing, wasting CPU operation if the data transmission length is large.
And further, transmit end, FIFO empty bits disabling have also been performed in the step above.

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sh-sci.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -838,19 +838,9 @@ static void sci_transmit_chars(struct ua
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
-	if (uart_circ_empty(xmit)) {
+	if (uart_circ_empty(xmit))
 		sci_stop_tx(port);
-	} else {
-		ctrl = serial_port_in(port, SCSCR);
 
-		if (port->type != PORT_SCI) {
-			serial_port_in(port, SCxSR); /* Dummy read */
-			sci_clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
-		}
-
-		ctrl |= SCSCR_TIE;
-		serial_port_out(port, SCSCR, ctrl);
-	}
 }
 
 /* On SH3, SCIF may read end-of-break as a space->mark char */


