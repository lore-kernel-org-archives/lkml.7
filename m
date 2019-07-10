Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A80AC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1C321473
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4+Fnl7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfGJQUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:20:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44344 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfGJQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:20:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id d79so2323189qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QibyFGWnGdatOh5nsBNwpo+J2I04tbVTYJ/VYtxRgmY=;
        b=T4+Fnl7gXl1bl8llcUm3/9pqHh0ZYkmBG6TpVmEq6dIxAwEVcCJQYVUOULCPceUcP9
         1Jl0GyE7nKC6qh7eInjKVNdp+cGBk0t7j4n1/wgmJUYQUC0XAWqXhPWe0Gf3lBL3dsRI
         djqj0npByspo8KYXIBmm3hkfHblagArY9vZMISTbJgrOpLWTZMz4aYcy1RXorOgbomym
         gcuyshTAhmEsFg1JtVem18bXWhof2PEtVztmnuTKNaQiS2ph3cy5u6X5iqju6l0mkp8O
         uTjjNrHc0Lb/zF4Q3ZjfHrrjfUKjo+xIEyTLFLT5Cdrd/yQFocMMWb22PFKKxOCMZkeB
         3hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QibyFGWnGdatOh5nsBNwpo+J2I04tbVTYJ/VYtxRgmY=;
        b=YPyW13MuMxZEdyEjM1GvMfLzbTCzYtVfk+b5FSrqS9UZA/sIAbnEgViRWDIw4CcRe1
         k1DBKnW7wiAkbkyo0Y8VA73oUj0t466ca/K8VX6ymZRvM2SWYLiyQqKX7qLj3wasTFw+
         OHprPRV9o0NhsmR1I3fHAbaI79OSyj9ug1NMu1DG1vRLjEEUpCx310I44JOiAzejXwN6
         qseS4ikjYvrBdTszeFd9iMabILUUfRwEM3U/BgZ5B9u1d3VXs1nGl3ePtoHrmIwJK6PK
         FJicrcuHzku6x2pqt52DSSAUosH8dLvcU3JaCWcHiDyotOHId3GMvTLHCvM0r2RiJZNt
         m27g==
X-Gm-Message-State: APjAAAUn6g7IMnXayNPLfvps2+ccHZDsFealZUV/LR1/FP+OgDUB94yC
        YxNCenoiOPUL6eC5b9n5ag==
X-Google-Smtp-Source: APXvYqxVssmy8QQI7rLDeD1eZVdZ4DW7d8qWxdxiaMn/YNYrzpr6p+bYlVuIkxf22mrsNYDvJMmv7Q==
X-Received: by 2002:a37:4c4e:: with SMTP id z75mr24407869qka.230.1562775632730;
        Wed, 10 Jul 2019 09:20:32 -0700 (PDT)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.googlemail.com with ESMTPSA id 6sm1546208qkp.82.2019.07.10.09.20.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 09:20:32 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     iamkeyur96@gmail.com, David Lin <dtwlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: add logging statement when kfifo_alloc fails
Date:   Wed, 10 Jul 2019 08:20:17 -0400
Message-Id: <20190710122018.2250-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing logging statement when kfifo_alloc fails, to improve
debugging.

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 drivers/staging/greybus/uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index b3bffe91ae99..86a395ae177d 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -856,8 +856,10 @@ static int gb_uart_probe(struct gbphy_device *gbphy_dev,
 
 	retval = kfifo_alloc(&gb_tty->write_fifo, GB_UART_WRITE_FIFO_SIZE,
 			     GFP_KERNEL);
-	if (retval)
+	if (retval) {
+		pr_err("kfifo_alloc failed\n");
 		goto exit_buf_free;
+	}
 
 	gb_tty->credits = GB_UART_FIRMWARE_CREDITS;
 	init_completion(&gb_tty->credits_complete);
-- 
2.22.0

