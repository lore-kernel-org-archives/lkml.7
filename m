Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1721FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF796218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="MbeiDwXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfCOHWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:22:05 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:55654 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfCOHWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:22:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 8BFB0D2E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 07:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GAT1o2cjDwla for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 02:22:03 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 5B6DDD33
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 02:22:03 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id v125so6885536itc.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 00:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TQ0tQmmX8QXWU0Hds24juWk9ZzMhqD5yDnDhPpHmiys=;
        b=MbeiDwXbuRQQl2vMiSbf+EXKawuFxxP93LXjRHc5O6elTlGF8sFqkruBKUqqI4NMiG
         6/WluOARuayFMgL1+Fc9L6FuXHM0zVDkAfJU08GMB3msqgvNRLWifSLfZQi99DpAnrAl
         WXzpbNlhKKx8VRo84kaDrI4IFm9x2e0HAxlkYcdUJ7nDb7yumBCVmiuNqKs4TdSCSvUi
         aa1+7hhs/4/b1bAl91tkzsO5vOQ24GLToOqTtXF5QsEU6PnTKx+UUB0JOPVgUpmqmeGD
         tfdeQdfTdQt7cZzyVm/+ndCsT+dTSj1wHyd4AsFqeIJCqQsqi17Xzkym2LsvEnY7Yizr
         NIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TQ0tQmmX8QXWU0Hds24juWk9ZzMhqD5yDnDhPpHmiys=;
        b=e34L1vR/JGNzBUhT01oqnB+7f0UcxFHZDGHIrqcA9+9itpLQ/IgqrxCMzcgOaoHl9F
         maHHZiE0EBq+UFu+zumaVeWV489QHYm3IGOboyrGxNg9G1AMO9U0Qm4mtf5thyuYZYLK
         tr2EyKAaOIbeJ2gtKj9EXs30z/vleYZSBf4VE80jYBN7tiar+lYFSMUhavWIifzSiCI1
         DWpTc3cb9Nw2arDrBvq40XHLSqG7zOSrEAlOgPyNcn6tKQR9SgofmlwaNKT0+jwbeXd4
         X08zzzzbJcvI/jqU+djjp/9ff9eQ/qvqBv2kDFVCx8ZSJDrfm+BQgIiysq17X21qOH9a
         ilUg==
X-Gm-Message-State: APjAAAWDOZWQd9LELbGv42LlREMdzUKq0nCOLP2enylza4W+JWzW7scl
        gEW1PYFNlu+qmUGcyaD2dJ8cUafy5mqJhEERYXdeYKBVmDAjzQJCQDebN4vSx+Ma+LB1au63lVE
        N8Cit/V69uOs2z+H7NhXhLzOHynWR
X-Received: by 2002:a24:4211:: with SMTP id i17mr1192073itb.157.1552634522575;
        Fri, 15 Mar 2019 00:22:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSGTals64TE76hWNeUaP48YX0Pqa9DOWqZTeKfUMWFqLMXfHBABX8kzMT9RUXNBDrqtIQ7Kg==
X-Received: by 2002:a24:4211:: with SMTP id i17mr1192058itb.157.1552634522333;
        Fri, 15 Mar 2019 00:22:02 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id f192sm677637itc.42.2019.03.15.00.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 00:22:01 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: atmel_serial: fix a NULL pointer dereference
Date:   Fri, 15 Mar 2019 02:21:45 -0500
Message-Id: <20190315072145.22650-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <4369f8eb-e8d2-1f78-6fd5-f878ffbdee90@sorico.fr>
References: <4369f8eb-e8d2-1f78-6fd5-f878ffbdee90@sorico.fr>
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

