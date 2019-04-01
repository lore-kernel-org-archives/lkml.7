Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727AEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CEB20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140141;
	bh=b8WM7whjftxy9t4I7BYkPHZthKRQE+gn+bqewVPXn6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nk5xfG/7ZIkrpFKgGcmRbWbwxqsdTY5t+wH0auexnH9xmIhD5K5MPnJsvV41fFZw3
	 0a1gPxZSNweQNhmQ8LMUy7wQmaqmY18w5E+f8DwrY+XT8sJGMLYU0Q2kaT6VaMIK0u
	 rLaaCXZz39Yaz2+vzUEvpXeozYtRPtfh+WuEFDWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbfDARfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387541AbfDARfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:35:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB9ED20880;
        Mon,  1 Apr 2019 17:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140136;
        bh=b8WM7whjftxy9t4I7BYkPHZthKRQE+gn+bqewVPXn6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRK/q1qR92NcfblMHH6apmsohvOzCheFTIch9VrYniDBG06LbMyr8pjDQe3jI5JOH
         kG6Cza3VVTFCYp++H/6OcJtejXCEAIonxz1yMAIW2hFvGxYM87D+WBNmf9ZsuF8i6x
         u32f793ew/yjV0jyIS88VI8MIUJKkRiVnkKXIzaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hoan Nguyen An <na-hoan@jinso.co.jp>
Subject: [PATCH 4.4 115/131] serial: sh-sci: Fix setting SCSCR_TIE while transferring data
Date:   Mon,  1 Apr 2019 19:03:05 +0200
Message-Id: <20190401170101.266887323@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -746,19 +746,9 @@ static void sci_transmit_chars(struct ua
 
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


