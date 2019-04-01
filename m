Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FF6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EF320896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140126;
	bh=+tQhtLo0TzNrG4mFcVHrjI2C58GACDY0KF3BHEYQB6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i5SA8cu2pWNZw9fanS7I/GCDEnfpFLm7OLXlw+s5VVpmh+332KyeG/wcEIuReBj4G
	 AN5nnAYVXtXXE2PU00g5XWeQpcbTTUE5vKw3dXX0T51lkRQ4uJfbxww9Edu0BK8cT9
	 q0WcfqxknzkrHnpBIIn3XwsxGbOExq0sV2LDjtzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfDARfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387894AbfDARfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:35:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2223220880;
        Mon,  1 Apr 2019 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140122;
        bh=+tQhtLo0TzNrG4mFcVHrjI2C58GACDY0KF3BHEYQB6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNVgko8C4uV/WuHhIo1hBD880dyjxZhtMc/kW0KoSl1J067EOg49Fb40UCBxCS/Yi
         uyp19VWxq77elb4gDK7x4p7EZRaaqDLOvPLoMrLmepiA+JzrXbuUPkN3Bqcx+Vm8XF
         YAaW3ENqT+DSAO/hcQOd9PmT8Fwza/BWQ8JdQ1HM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 4.4 111/131] tty: atmel_serial: fix a potential NULL pointer dereference
Date:   Mon,  1 Apr 2019 19:03:01 +0200
Message-Id: <20190401170100.995545354@linuxfoundation.org>
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
@@ -1167,6 +1167,10 @@ static int atmel_prepare_rx_dma(struct u
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


