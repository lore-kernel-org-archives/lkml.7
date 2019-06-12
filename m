Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840E7C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E84A208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="RlNbC4v8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438313AbfFLLO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:14:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51106 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438299AbfFLLOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:14:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so6144731wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RX9kf328gim4qTbNApKo0P/QFvgZZ5niZju8LY4fMbw=;
        b=RlNbC4v8AQPmlZyHhHsjf3AqOF0nCui8MGbGfB153yQHQOxseZbCxE0QMP/j/ohMQx
         ubuXlfJE9JC6bcuD7MXezh0pcQ9Vxvbse8B6PBLdLZeik3ydqmdEVYWByfIegFIug0JI
         2rytqyr3HAgqTNiaQSFhmbVXFtGd22lz/fONwnA+eHCGfIiuyqEqvDSVy7e+kJ9asdDf
         /OkIFO7eGS9K6+12vteUCFt3vOWn1M003QCmhSkU4icWAQXTY3ntEVUrviQ3UVLencga
         yXXSpsfU13FjIDGHaTwCcvTsWo06MtZqUXWmyFM2XPRxdL0wub+wZXIWCVaWWlBQo9yc
         /img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=RX9kf328gim4qTbNApKo0P/QFvgZZ5niZju8LY4fMbw=;
        b=ZjG4Xj3IlXcDOClzfLCvNJAm3aPRlgKeOfSy/WTAYhHAymWGinEgcQr9Bu3NuypLS4
         t5kGFMKxclIUHbcHVRvc+rdZwTYkKQL+6J3OPyDLsjIvqCwGs9Ok6B9M1thOtbyBZbGP
         vWeAbe4fnXneYzRkm9gUt4yHqj+8EVJjjpqzsIpFq67Qyap1kmJNWptU5dGOr6T6FAKi
         NwV/hdjoqlqbXfMRz8EnHaXagWjpe4qNqyYT6PsPeT5YACJTbxT5gCJWlbwxKZtxpkaT
         cT6f6ShxIWhcYCggLoLjuAyMJSrma9OzSxXAzFbqYzPt0CfqHBkhFp5twvO2/Y/jXs2P
         eDeQ==
X-Gm-Message-State: APjAAAV2g03x7UqBi7OdimbFjkzrgZ/e1sRXWyKNowi0833qeBNNe2Lf
        5EKqIAk33dR2JZjSZL7JeFgZgg==
X-Google-Smtp-Source: APXvYqxfSaq6CTixvYxa76VBxtjwsDr/CJ8DUniRUVH+idG29OzBqKzhBE3pa8Y9Mws4pqelMSUz8A==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr20735822wmg.177.1560338093505;
        Wed, 12 Jun 2019 04:14:53 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id u23sm5055140wmj.33.2019.06.12.04.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:14:52 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/6] serial: uartps: Fix multiple line dereference
Date:   Wed, 12 Jun 2019 13:14:40 +0200
Message-Id: <3a5b27987c5b4fc5ec7dc7f58485db63057edbfe.1560338079.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

Trivial patch which fixes this checkpatch warning:
WARNING: Avoid multiple line dereference - prefer 'port->state->xmit.tail'
+				port->state->xmit.buf[port->state->xmit.
+				tail], port->membase + CDNS_UART_FIFO);

Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Add Fixes tag

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c84db82bdaab..4cd20c036750 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -319,8 +319,8 @@ static void cdns_uart_handle_tx(void *dev_id)
 			 * register.
 			 */
 			writel(
-				port->state->xmit.buf[port->state->xmit.
-				tail], port->membase + CDNS_UART_FIFO);
+				port->state->xmit.buf[port->state->xmit.tail],
+					port->membase + CDNS_UART_FIFO);
 
 			port->icount.tx++;
 
-- 
2.17.1

