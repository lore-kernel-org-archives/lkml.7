Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC663C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB3621929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253669;
	bh=tECfx1IbZmSmm8w7LzucapR9s7TDRYw62zVqv7bQkPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yZtVWh2wy4Px84vZXdlKsCtfUuimGVGHzzGmxa+7yU2p+XQo0eq4joKz47hpiKdON
	 ERjci/wtQ0UYgYpJy3ET84vXH6wSFk8fgteUaIfKMHV9nDs9F2Qq0EVL+uQO5wN1R+
	 P96imgPstp/DOnpjA1WON4pJyWT1mw3HyQ830RSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfCVLVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbfCVLVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:21:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D42B021917;
        Fri, 22 Mar 2019 11:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253664;
        bh=tECfx1IbZmSmm8w7LzucapR9s7TDRYw62zVqv7bQkPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2u01SiTnes5nZKTDUwkrQrsOHTNPIDVRJX5n6Mj0ZqKxFYKt71qOOf40ZJh/7Aldj
         Q4ALKw8W1mU8oFrljO1ZmyYuhK1wD0TCvvlUvreIY1s8fS8Wqem0tskStiTZv+pPuS
         oMdQHgMt14zWwMTjVGHkfkrifc1BeMUWghn/TSdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tomonori Sakita <tomonori.sakita@sord.co.jp>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 034/134] serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling
Date:   Fri, 22 Mar 2019 12:14:07 +0100
Message-Id: <20190322111212.201258363@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 815d835b7ba46685c316b000013367dacb2b461b ]

Using over-sampling ratio, lpuart can accept baud rate upto uartclk / 4.

Signed-off-by: Tomonori Sakita <tomonori.sakita@sord.co.jp>
Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 839e65da4d3f7..f18551ea5ba51 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1426,7 +1426,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/* ask the core to calculate the divisor */
-	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
+	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 4);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-- 
2.19.1



