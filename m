Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A05CC10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586AA222C8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGKjTtMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfCXOyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:54:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37496 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXOyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:54:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so4611026pfr.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EV0mtIUAZRfpoAAvMR47kvv6+WC7oxtvXJXhTk+1wes=;
        b=tGKjTtMcbfkgYDwCTNLSSZE7OFMBUz6tpdMRv2cG090DsYEgqpFLTay56OTEMO4SQU
         5l9tccGnugeFZuoUWtpjVmyXt/xnpTn1a79zECaAQ72yOyHswkSxgHUVwDmHMy7u5lBo
         UiquzoOydvu+MSl0HDsIIVhQttYWBmV+1aNOghhzzhOVkYiw+7Pah917Po1a5SWvdyzH
         Y1JC8RhzhVUHCD+GgNMm75gWKkRpSQKq2RPiIsNn4zgAWAS73G+3cT7QcHj0tId53gxR
         hQju77C3Hlx9RDbyO31se3qLSyCsNZjgK1HCnk05MdFIIE2er2nXwr0kisUmrzr7O1Zt
         MmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EV0mtIUAZRfpoAAvMR47kvv6+WC7oxtvXJXhTk+1wes=;
        b=ezo/ySuyFzkcBvCqEWsjq2i2pnZP5L/z827vA4ibXyo8MzFuII4fWMVDlDahu+BWYz
         ctrbYPilqAy/RApvqHE5q5HXpkaREhx3voTvEnRMmdlkWlb66Sd7R3ryWCkiZjTft+fi
         FNV+vR8PSoAyiGXGm6T5rOJiR8vpON/cgI47pDI6Cf/cLjJjg2jMMlsdLklrkMlSUWuu
         iIxGNFGf2+ZYiRmeU4/ChBkXMc/q0cF9uzJnVh6KQah74Qm96o4HM6AmGbIJCb34V5Kb
         D+e5/lMSsLh0o/ayVRqeKL0UStAZbCzmxT1gfQkyhJFbvO1DT8SB1X5niM5uCH3CNFdi
         1Yiw==
X-Gm-Message-State: APjAAAXBq9QKwrgOTuTH5gr5HBKo6QwmvvZuE4sqgk41BdvDAKbT6oxD
        EW4zzjDbE4px9zX8pSh49ctkbDae
X-Google-Smtp-Source: APXvYqz/oYuFkToSANQ1vR8Zd/fgQOinUHYFU8LHMeG0rF928P1hH8ZcyO6rtc3yBJka4Y+FRTXtew==
X-Received: by 2002:a17:902:e40a:: with SMTP id ci10mr20248567plb.77.1553439294445;
        Sun, 24 Mar 2019 07:54:54 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id 10sm20777961pft.83.2019.03.24.07.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 07:54:53 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hugo Lefeuvre <hle@owl.eu.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: remove unnecessary calling rf69_set_mode()
Date:   Sun, 24 Mar 2019 14:54:41 +0000
Message-Id: <20190324145441.10013-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary rf69_set_mode() function call when rx is waiting for
a telegram. There is waste to call rf69_set_mode() twice for becoming
standby mode.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 53928af696a6..e822f87fc533 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -650,21 +650,19 @@ pi433_tx_thread(void *data)
 		disable_irq(device->irq_num[DIO0]);
 		device->tx_active = true;
 
+		/* clear fifo, set fifo threshold, set payload length */
+		retval = rf69_set_mode(spi, standby); /* this clears the fifo */
+		if (retval < 0)
+			return retval;
+
 		if (device->rx_active && !rx_interrupted) {
 			/*
 			 * rx is currently waiting for a telegram;
 			 * we need to set the radio module to standby
 			 */
-			retval = rf69_set_mode(device->spi, standby);
-			if (retval < 0)
-				return retval;
 			rx_interrupted = true;
 		}
 
-		/* clear fifo, set fifo threshold, set payload length */
-		retval = rf69_set_mode(spi, standby); /* this clears the fifo */
-		if (retval < 0)
-			return retval;
 		retval = rf69_set_fifo_threshold(spi, FIFO_THRESHOLD);
 		if (retval < 0)
 			return retval;
-- 
2.11.0

