Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0611C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C7D21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="qsWnD9Sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfCOH1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:27:22 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:58810 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfCOH1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:27:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 29CF96F1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 07:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WFQ4E098cx1w for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 02:27:20 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id EDBE27B9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 02:27:19 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id k24so6246830ioa.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TQ0tQmmX8QXWU0Hds24juWk9ZzMhqD5yDnDhPpHmiys=;
        b=qsWnD9SawKXiZtf0UHyY66jAdPH8N6jTUS8hIhSCjgQCtYebnjCGdRZn54pnlB2vNE
         Hk/amq4ZSPIAV0gYM0ZkUrstCIkuw4sk9HuQFDOsO4/3P4rNklAKMLLKDtLRUZN8MFN0
         LX+TLjBWqXkKvs4gTjOzJI49QwUAIDKvcuGxR9xiaO8HbnZE7L/MU7vva2c9zxzPbbA9
         Kyy8cVf07cfyt1V6XoZTs+Atlw7qQmEmlNJ/sfUqRyu1Wscd+AeOS6sXq0Vft3wxIbu8
         mFnt8ION0h7kmDbUr4HMUGvSYzhCw27G67FyRe24merbHmNrxr3OWMHiCg6YhInJR3Rk
         wjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TQ0tQmmX8QXWU0Hds24juWk9ZzMhqD5yDnDhPpHmiys=;
        b=FEH/60Mdz0sb5VPrfHYFwGCu8KPMWjKAgQIMf9+6ZrGzo4hbr22a6nq/QdT1O8LRAF
         iMFk2V1zoVXBsN/kuv1hxtceuI0WvnBqJrBs/W9cDfdL7/JeSGXOypLAmsO5xmGKxpQs
         n1+zJcBF+rIju7DtamGMilZvT1Cut/IgF3/Mr16we/vmtcs7xSjInfB/I6tRJNfAuqF7
         Ld4bJYy7wKIp6IfM0+kgxVYVhvpIUwp8SP8qrM+FSLXSXelXsHnD6GFVdaydMWWJQY68
         +1IWqj9KuwPqaTiyS7c4SrjW6eN2fQvIrCcoBQvr8sMO+PCRI24lYLBi5vP6SG8c9rAm
         wpqw==
X-Gm-Message-State: APjAAAUE/2vC1mX7LeQf7HKAjrtCKQgMZFQ3VUNxF1P3EJLcOppR6iCj
        laYLxeuyzVLA1Q85yjOO78ojmc7BmdPhyqP26KH0QJ7I8mMm6jp1ZmWiTs0dyxTplmoN2fZvHgI
        PNgj6HBmxGMUSDKZdlFjv13NX5H3Z
X-Received: by 2002:a24:5a8d:: with SMTP id v135mr1075521ita.87.1552634839589;
        Fri, 15 Mar 2019 00:27:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxDA/FLvyfagxVeW/n/12nxNE5mRsKp2MeTh4LNh+K6Ld2Rasa2g5aF2tCpccK9U9TKtq+7lg==
X-Received: by 2002:a24:5a8d:: with SMTP id v135mr1075514ita.87.1552634839382;
        Fri, 15 Mar 2019 00:27:19 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id z25sm582980ioh.43.2019.03.15.00.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 00:27:18 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: atmel_serial: fix a NULL pointer dereference
Date:   Fri, 15 Mar 2019 02:27:09 -0500
Message-Id: <20190315072709.22811-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAMuHMdX=XwxVFb1eLupmyHBOMBGzB+=RXxcUCH9D-J1+YKiq5w@mail.gmail.com>
References: <CAMuHMdX=XwxVFb1eLupmyHBOMBGzB+=RXxcUCH9D-J1+YKiq5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 34df42f59a60 ("serial: at91: add rx dma support")

In case dmaengine_prep_dma_cyclic fails, the fix returns a proper
error code to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>

---
V2: simplified the patch as suggested by
Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 05147fe24343..41b728d223d1 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1288,6 +1288,10 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
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
-- 
2.17.1

