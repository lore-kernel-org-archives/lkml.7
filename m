Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7575BC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400B720640
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932243;
	bh=0+SfaMpsb/mjXk8vRGdMDX1dEeGdzQStvV0C3yCOG64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WLK35kZRqW7bcLqPZYov3NAIXYomxp2Dd9SV6yi8LFO3+iqloHJe03k1ZgTz9FZAU
	 GCFyqz0uZ9vZ5nBXb1SZ5hVVX1+Nc0wKkAkFvSxKHjT1CLevwRANK0IwU30CJDyAOv
	 zILHjGOyfLGCSsV1AP146jw08CvwAJaVs3tdXoNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406205AbfISWPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406180AbfISWPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:15:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B87321920;
        Thu, 19 Sep 2019 22:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931342;
        bh=0+SfaMpsb/mjXk8vRGdMDX1dEeGdzQStvV0C3yCOG64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AA5qIXVGFGBjYCPEC8OcuOkx1zWqpo61KU65pZb7rfTLcODHZv3L6MOeRSsN8K223
         TJ+seMevYE2+MwBeFC75RnzfATOT1HGhHQqMWQ03gFXsMM3CficqW8R0XyKd/W2p5O
         3Hp+doG29++wlwDKMN9xNahGotXefj+TzZV9sxzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>
Subject: [PATCH 4.14 12/59] tty/serial: atmel: reschedule TX after RX was started
Date:   Fri, 20 Sep 2019 00:03:27 +0200
Message-Id: <20190919214759.354987361@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@microchip.com>

commit d2ace81bf902a9f11d52e59e5d232d2255a0e353 upstream.

When half-duplex RS485 communication is used, after RX is started, TX
tasklet still needs to be  scheduled tasklet. This avoids console freezing
when more data is to be transmitted, if the serial communication is not
closed.

Fixes: 69646d7a3689 ("tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped")
Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190813074025.16218-1-razvan.stefanescu@microchip.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/atmel_serial.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1276,7 +1276,6 @@ atmel_handle_transmit(struct uart_port *
 
 			atmel_port->hd_start_rx = false;
 			atmel_start_rx(port);
-			return;
 		}
 
 		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);


