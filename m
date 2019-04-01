Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A9BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE852208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141255;
	bh=En+o/ldLhCWof7UhYPdSGpUcozkzYCe+LMDy/q52jH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V/ZMSzeZlQ8bKcNZa129DkvmoCGPp2TMFkKrJ+7fD6tGeuAs+WinXQWmddIoJdz7S
	 SqBp4GBL8/w1rOK7Vn/ArTD4gDTto2rBRBXCszMydhfHiAm9sIMwghpuQfaYDK3NjH
	 ka7uAawhfCrIilg/YFlTEPVMK3YjzrXxA0YgLZ20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbfDARYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731282AbfDARYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 932EC2063F;
        Mon,  1 Apr 2019 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139481;
        bh=En+o/ldLhCWof7UhYPdSGpUcozkzYCe+LMDy/q52jH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hERALvVn1UqWDlpG0RHN2xFUg+2xTYmM45SFSIvvSInRQJDRquhSwA8RYoYr+tBYR
         cxy4rJrKxP96tOtyjDedA5kPp4zEpwbEOf1NoYBoHBdverN5+N82Gnj7nZCUZnr0GW
         ONutC43I1X4B3FMqaN9ZHSupVpjOt8aD4xOjXUZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hoan Nguyen An <na-hoan@jinso.co.jp>
Subject: [PATCH 4.14 081/107] serial: sh-sci: Fix setting SCSCR_TIE while transferring data
Date:   Mon,  1 Apr 2019 19:02:36 +0200
Message-Id: <20190401170052.999982066@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -806,19 +806,9 @@ static void sci_transmit_chars(struct ua
 
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


