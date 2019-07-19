Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A73C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAA0206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563511022;
	bh=XRfZBIvwwvJEotxUX79ZQHqiqmY7KdKnFRGsQhI4u9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xfWRPeLymkY//gVUpH+oX7cHZRDB93GvD8uA7XsMFnO/HMrc8pCsSHQAYDCMO+bcA
	 7oXiMi+mPFyZY4KIJJ8qMxvG6jPvWlOhHIJPkUZEw5BqmaMsRnmgdhfl4plHQuCoM9
	 KvKcXPhbMt8k0Dqm3nwqISsY9i4XLWTjRcqurUfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfGSEhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbfGSEAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:00:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD70218B8;
        Fri, 19 Jul 2019 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508823;
        bh=XRfZBIvwwvJEotxUX79ZQHqiqmY7KdKnFRGsQhI4u9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qzJ5t31wSuOhes6pIgro4a1THCj/BBMYOrQEB9Pd1QR5O1tPefzc1pfo+/uh+nfVH
         8QIBYFynMV27vDf35vLWF5Y41rTfGxXIWZduzhUGDllkfLSc1YGVbZvWTGpcruFWGU
         /nZQGoPqPZtDFLQjvkxjFDZr7UV7F+7pZCA5ljc4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 109/171] serial: sh-sci: Terminate TX DMA during buffer flushing
Date:   Thu, 18 Jul 2019 23:55:40 -0400
Message-Id: <20190719035643.14300-109-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 775b7ffd7d6d5db320d99b0a485c51e04dfcf9f1 ]

While the .flush_buffer() callback clears sci_port.tx_dma_len since
commit 1cf4a7efdc71cab8 ("serial: sh-sci: Fix race condition causing
garbage during shutdown"), it does not terminate a transmit DMA
operation that may be in progress.

Fix this by terminating any pending DMA operations, and resetting the
corresponding cookie.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Link: https://lore.kernel.org/r/20190624123540.20629-3-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sh-sci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index abc705716aa0..1d25c4e2d0d2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1648,11 +1648,18 @@ static void sci_free_dma(struct uart_port *port)
 
 static void sci_flush_buffer(struct uart_port *port)
 {
+	struct sci_port *s = to_sci_port(port);
+
 	/*
 	 * In uart_flush_buffer(), the xmit circular buffer has just been
-	 * cleared, so we have to reset tx_dma_len accordingly.
+	 * cleared, so we have to reset tx_dma_len accordingly, and stop any
+	 * pending transfers
 	 */
-	to_sci_port(port)->tx_dma_len = 0;
+	s->tx_dma_len = 0;
+	if (s->chan_tx) {
+		dmaengine_terminate_async(s->chan_tx);
+		s->cookie_tx = -EINVAL;
+	}
 }
 #else /* !CONFIG_SERIAL_SH_SCI_DMA */
 static inline void sci_request_dma(struct uart_port *port)
-- 
2.20.1

