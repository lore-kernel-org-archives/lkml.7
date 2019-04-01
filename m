Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E94C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35212196E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138497;
	bh=7WE7Yn/5Nvq3tzfotCAcm3mnt0iFKQRJVC6JXsz6luk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vEwaVt7WGXp71mYpOYipxU3JTnxbgt7q3SMmYZvtUEs4iDkVxo4TWfjlgpqys/qz3
	 uSTb0bhSQDrzzTc+JsP9Pcu9lkeALrpRjO7YygAr3tPMQCn+UvXGTWbEZBeQWkA6cR
	 k268Iq9ndsjEKgQGXQMnSViBAnwQEzetLWfppHuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfDARIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbfDARIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:08:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05FDD21924;
        Mon,  1 Apr 2019 17:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138489;
        bh=7WE7Yn/5Nvq3tzfotCAcm3mnt0iFKQRJVC6JXsz6luk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjO+aa2ZzfPREJ/VvgcsG0BsIRMLJp4DyWx02KODCrpN5onTm6O1cz/pydPE2X7vk
         VVlDu+pXzsVP2Tadpm7r5F4gwCb595mtCAa9sUGr7ZNgvJtYcYGNqOpoKACPrVGhk/
         IlhCwPf85x7Ve6gEsAS/WP+Pr1GZk2qJqMkrfRFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 5.0 080/146] tty: atmel_serial: fix a potential NULL pointer dereference
Date:   Mon,  1 Apr 2019 19:01:32 +0200
Message-Id: <20190401170055.644868744@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kangjie Lu <kjlu@umn.edu>

commit c85be041065c0be8bc48eda4c45e0319caf1d0e5 upstream.

In case dmaengine_prep_dma_cyclic fails, the fix returns a proper
error code to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Fixes: 34df42f59a60 ("serial: at91: add rx dma support")
Acked-by: Richard Genoud <richard.genoud@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/atmel_serial.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1297,6 +1297,10 @@ static int atmel_prepare_rx_dma(struct u
 					 sg_dma_len(&atmel_port->sg_rx)/2,
 					 DMA_DEV_TO_MEM,
 					 DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(port->dev, "Preparing DMA cyclic failed\n");
+		goto chan_err;
+	}
 	desc->callback = atmel_complete_rx_dma;
 	desc->callback_param = port;
 	atmel_port->desc_rx = desc;


