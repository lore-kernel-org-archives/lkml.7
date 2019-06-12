Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC80C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BCF208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="gUz4s4x3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438331AbfFLLPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:15:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53123 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438290AbfFLLO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:14:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so6149687wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bYhm6q2mQOQHxwpH1cNDyslfzzaeNb5NDBbPExBr2hU=;
        b=gUz4s4x3wAGkHBCidbCda40ZHrM+oc5MtKFf8IFar51RKlJuK1zOLWaojoQZUxDrdT
         w5897ogwbbZPOnHWEZrig35pkYl3fmCEvcMf0ROCNClQ9Q8hml1Adv3IMHjMickCUPwU
         3UaHIWLyQmnprriSbA06WUAowV1Uuq+/7V7dhatbGWhVC/GXDc4o7CXsGZ3RsEWZGWMP
         vt2hylAoq102zrYvnqKX1TUeoOZ3S5M0L9icqq1CuDzPFeCuahixzClKF2/ooA1+TXV0
         aTRhJzAKqP5JG4oPxNYGTOUwo0Ewgn159jICgnUkhW+8i72KHQCQ6i8tkDVmxmJDEe0o
         LU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=bYhm6q2mQOQHxwpH1cNDyslfzzaeNb5NDBbPExBr2hU=;
        b=D08MtiP+2v229uctuJUeFoxFIWyQTotJlmTbU82CqjuygwYf1czVYUNy2jOJVqbwuy
         lVl1A1fQsQHjKQeAZuEqRgHzNa9kuNlAEqxSdDPITjBBZz2OY9RYkJlVp0xOw2DdJHp8
         ZRFyhqf9WfYyxwR2HyszdzvIW6gLzxw5eTj7/AiexyNPdPxfB9EkG49/CcaqvO3RwS9E
         CG0uvO4tc4xBtypuPzTCDNNXnv7v0R9qpppCwfVcQL5gjVr+Q3r49F6m0T8iP5li3lxK
         v9y7r9zbEOOqHNTOUGDT0lgCFfVogiH4ztTDd6Wq/x2j6ymcRF1wLampsEyEdUYzXLUB
         5wMw==
X-Gm-Message-State: APjAAAXsbpFPpnqiOpPlKhpgauF+whO/7ixyE5fi4tAKWyKMxhbsWKHm
        irjWgMuUBSFtJd/USZoFLhVjkw==
X-Google-Smtp-Source: APXvYqyGMKCnljobGJkFGV/NdFNdLPAxnN5nwF08PzReraHvnNcveanzCoORDBgv7OzKCjvRD9L/bg==
X-Received: by 2002:a1c:3886:: with SMTP id f128mr21530360wma.151.1560338095263;
        Wed, 12 Jun 2019 04:14:55 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d10sm19536766wrp.74.2019.06.12.04.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:14:54 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/6] serial: uartps: Fix long line over 80 chars
Date:   Wed, 12 Jun 2019 13:14:41 +0200
Message-Id: <a7eb75d2900d354b3b2ba4355f4c9b9cb00f1456.1560338079.git.michal.simek@xilinx.com>
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

Trivial patch which fixes one checkpatch warning:
WARNING: line over 80 characters
+		       !(readl(port->membase + CDNS_UART_SR)
			& CDNS_UART_SR_TXFULL)) {

Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Add Fixes tag

 drivers/tty/serial/xilinx_uartps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4cd20c036750..c3949a323815 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -312,7 +312,8 @@ static void cdns_uart_handle_tx(void *dev_id)
 	} else {
 		numbytes = port->fifosize;
 		while (numbytes && !uart_circ_empty(&port->state->xmit) &&
-		       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
+		       !(readl(port->membase + CDNS_UART_SR) &
+						CDNS_UART_SR_TXFULL)) {
 			/*
 			 * Get the data from the UART circular buffer
 			 * and write it to the cdns_uart's TX_FIFO
-- 
2.17.1

