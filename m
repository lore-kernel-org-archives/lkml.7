Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D9BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24A520856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139771;
	bh=1Ggic0OxhynrH99m7mIHi8evBe/s8T5N+THJ95yNzII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j8aoT9nt7Ln2Z1spgGbG8hvtvzCXBMauKCp9zlfzEVospzd9tsBMEiiSawhe/QWBQ
	 q14j24kycwvZIi91346rPEqrf5weUf1+xvEgmd5hcKKDo2cPxE+LXa0g/P1RSXKoBf
	 luEuqhN7cE8mcHPDusqI/U4k9uWm+E3KXh82SVWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbfDAR3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732938AbfDAR3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:29:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5AF20856;
        Mon,  1 Apr 2019 17:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139765;
        bh=1Ggic0OxhynrH99m7mIHi8evBe/s8T5N+THJ95yNzII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ynNWebnJYzPHC5uZraVzQbIzd7HDehGQIMs86bzexBxAlkaOp2EvQU6Pb6MTwlCB3
         yq6pkVPqg/8JPZe/CAHKRSNBfN455UNGKEjnJIeP1UoukmkWCXDM1We/wWLNvWJao/
         m7RrwHK+b8w1GTPfn6me3Es7OeFzo+dwiyqrBHUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 4.9 32/56] tty: atmel_serial: fix a potential NULL pointer dereference
Date:   Mon,  1 Apr 2019 19:02:48 +0200
Message-Id: <20190401170105.691117725@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1166,6 +1166,10 @@ static int atmel_prepare_rx_dma(struct u
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


