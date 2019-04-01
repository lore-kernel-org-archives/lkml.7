Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2627AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9A3206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139449;
	bh=5YbcJOtaja98G6wI8v38r5c8Tlm3c+CxCEw12tLJdSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Su5+Bv/VV1O2BBDGhe6EQx2P4Hon63GadiPVOdO7WYQOdcrftthoy3xC0/2jGRbOk
	 hBl3ELpqwGl8Av3r4GXVCbexhPT7UbOSo3hkSJ7ozDMGcOJ643hxBX7p1CqQf7t/tB
	 6rZdAP8+35XMB03JsNiEzS7cA/9mZPWzXx2M0h6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbfDARYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731786AbfDARYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07CB42063F;
        Mon,  1 Apr 2019 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139442;
        bh=5YbcJOtaja98G6wI8v38r5c8Tlm3c+CxCEw12tLJdSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Skkt5djsPt83MH0WAMEu3aP7suaOq9BNIUKadG/z82IsxCUxcsZj25hWfoCN8JfAF
         pFKKWk0NCTqvw//aXYTqJ35SkywlTow7rwCcy2urhgKwap7UjjboLCsfT3Bp+BsdRM
         2gJAQoiN4YoM8ZUbLfQJ5gxCoJRmbhEsF4m6omg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 4.14 076/107] tty: atmel_serial: fix a potential NULL pointer dereference
Date:   Mon,  1 Apr 2019 19:02:31 +0200
Message-Id: <20190401170052.545995214@linuxfoundation.org>
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
@@ -1163,6 +1163,10 @@ static int atmel_prepare_rx_dma(struct u
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


