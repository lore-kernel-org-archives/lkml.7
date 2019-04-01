Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FB3C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9FA2171F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139116;
	bh=7T2Sfc2bVo2sDyoNs1dkH0I5r3VbtwKpQDDCv9RhW0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TR52yURP6o4vkq59DOMd/x0rnvL+QZDOj4McBa8V8mNkkhPhSkYWm65bBQ7vaocIW
	 Dt/mM7njy4A3n5PI/yol6EU2SDKAQrKCAsuoOorvNznF73mgP5l/oQGuLawU12B45Q
	 313wSLmAW9iNTvbRHCnT93lh4xBM3uRV729s+iiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbfDARSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731373AbfDARSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF19206C0;
        Mon,  1 Apr 2019 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139110;
        bh=7T2Sfc2bVo2sDyoNs1dkH0I5r3VbtwKpQDDCv9RhW0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gofr25D5gFOgFF7kBgwFZ1LYvEX1clzo24NorPlqrmHlYSUYMIED5btxW7F176YcW
         cc/fZJ/k4+pew79K7f4wIbWRBtk3KYLPSbTGugurl6tUuHMYYobTCPfbi2Py2UJJ3Q
         9ha0mnTsFWS6b3853HETqN7ZFOw/E0lGjZSlAgNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 4.19 079/134] tty: atmel_serial: fix a potential NULL pointer dereference
Date:   Mon,  1 Apr 2019 19:01:55 +0200
Message-Id: <20190401170051.754416589@linuxfoundation.org>
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
@@ -1156,6 +1156,10 @@ static int atmel_prepare_rx_dma(struct u
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


