Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BB8C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F29920820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYCkAdiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbfFJRXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:23:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45209 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfFJRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:23:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so9986194wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hE4cR11QUq+RsE+T2OXtTk5Fiz8rk9hoeeEatdOHPQM=;
        b=DYCkAdiUnfostkm8Hivw7VIDgB6ztRtb5vpXxRVM8Gy7u2qzeKbULe2FAkpkmxsGuC
         e8dFxmka3vVJmQtR0L+lKeCuI5rECXgOeNiuiqkohPLon3Zu/J6pIJGpDH6sAnVNBRdy
         iYj0cmRtJLOZIRfdYpm5c+25f1k1lOIQ9se8RXYe2kigfn9PjhP/jMhsnV4/FWwA8LMe
         vZ1pMlKVQDJHiSjjNr7yYS8h0bO1PSPX8pdEk1bbuu6UeNB+/3RqzTrG0tOSEYGNUQu0
         XM6/RHV4jttnLWJzsGRkz+OgNKuLBkLRBKKRjzkOgNcrw86Cci352k8OrtwaNR0g+ul9
         PiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hE4cR11QUq+RsE+T2OXtTk5Fiz8rk9hoeeEatdOHPQM=;
        b=ESPqflg7+PG++jCd8+kTCrp0ah9T1KUseappg4zYCP/9eJ/qNnZGi5GwSxtAI+Enuq
         fnMn8PyW/NnhHzEIigAd2QUK4Co/lXVCFv3Nqb3+oN1Dv4G8uk/SSmOiPFYZ2sWkpdBC
         zEdhlITR9csDsX1NLDeOR8mNX/P7sq7gMND7xeJFPZfbjuxR5JeRJI7CHx46Zxkxg14Q
         cBCSPMm7Qxxf7phLTd1Sa3rS3XRVAQ/hmcWnsc1K5e7Ao3eTsQTb5RlN9oAxJSu7WQ68
         N0pjUDq6EUCSxuVWh/9QpyXpVZqRtatShTVB1gxrnyfGFqe4TiFpmFbBNl8/uX+fbKcQ
         0wjQ==
X-Gm-Message-State: APjAAAWZ0+oEUefuT5FD1QO5uZEILRG+mBIHfb87rSjYW3VIFmPbo3me
        sQSpBPXppzHPEJvfCGjAtt/6wg==
X-Google-Smtp-Source: APXvYqyoZES/st9Q7kYb+Li6V2PdFuszQXBxanwuOTUOBVBPdGObPs4cF7PE4Wf0IvDmw5hHlnnD1g==
X-Received: by 2002:a5d:4489:: with SMTP id j9mr656490wrq.15.1560187393072;
        Mon, 10 Jun 2019 10:23:13 -0700 (PDT)
Received: from localhost.localdomain (233.red-79-146-84.dynamicip.rima-tde.net. [79.146.84.233])
        by smtp.gmail.com with ESMTPSA id f2sm19853686wrq.48.2019.06.10.10.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jun 2019 10:23:12 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
        agross@kernel.org, david.brown@linaro.org, jslaby@suse.com
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3] tty: serial: msm_serial: avoid system lockup condition
Date:   Mon, 10 Jun 2019 19:23:08 +0200
Message-Id: <20190610172308.21129-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function msm_wait_for_xmitr can be taken with interrupts
disabled. In order to avoid a potential system lockup - demonstrated
under stress testing conditions on SoC QCS404/5 - make sure we wait
for a bounded amount of time.

Tested on SoC QCS404.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 v2: fix exit condition (timeout --> !timeout)
 v3: add these clarification messages
 
 drivers/tty/serial/msm_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 23833ad952ba..3657a24913fc 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -383,10 +383,14 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
 
 static inline void msm_wait_for_xmitr(struct uart_port *port)
 {
+	unsigned int timeout = 500000;
+
 	while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
 		if (msm_read(port, UART_ISR) & UART_ISR_TX_READY)
 			break;
 		udelay(1);
+		if (!timeout--)
+			break;
 	}
 	msm_write(port, UART_CR_CMD_RESET_TX_READY, UART_CR);
 }
-- 
2.21.0

