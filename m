Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12011C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD2C208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="dfHnZnm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438341AbfFLLPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:15:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53852 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438299AbfFLLO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:14:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so6138262wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JC6Q8CjmGdxzS1r/l1ugJJUHGuJAio4YE7r12Sbrm1Q=;
        b=dfHnZnm/KeAKx0Y53W8U+Gve09GK0RsLcHKGzBp8skf8dieoVp+3rfiL2YnQayFHcb
         Lkfz1A+SwK7w+BUs52YV74L3fZLP3J9loLnVg+o9gWVgFH0oSAU6JzR3FOXHo2SkklyO
         s1WZEV1YfCDAmEPtAm3S/PpyLCfDN8f+/eiUzFsjKKNirIBLFta9bZocKUHJW3iuYWXk
         Kvz+A4Ujf8PryyBkA08Z4eCmgbflrI4pyjgutp3y8C0zfcrFW2FNAaPnpCkrMY3Tw/ly
         enYA/42NpbShVA/yMX21VKyJWtjCP4rreyRiWs0ec1wfiByCbkYA970s8PpE6ujeb/pq
         wq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=JC6Q8CjmGdxzS1r/l1ugJJUHGuJAio4YE7r12Sbrm1Q=;
        b=kDtbcVn5lI2I5q3TGS3Pk36xdpQbr1Fh+lCxXJwU+GDtnIJYPMS/hFwKVJBiiuVALX
         OCSgarODXe3//lq/N/RqyuKlTMW+UR2EuUIp32MXpK+nClskExjpYGekBpoRKVNp08YJ
         UkRN4Dnt0NeTRX1Rn86R0FGpdF14rNj+/mK2Ile3npEKbLcetzyCpD7Eo2DoGflEXrsP
         QKF/ZyIuvYV4VfNVuFV2VQtWZVfiKJtbfJkUtJ9yUsKTjgku8ZLPdEL6Zxwjh4u0aOA9
         HAvYCL1bieuUWbR8In183Y9goavaHO6XNB33X/dkOvUJnJTJqVL6dFJsvqe3DTrxp6Qc
         5sag==
X-Gm-Message-State: APjAAAWi446Ongnf/GpSkjQ4VycJaYuPCynnSf1EbttAXXZcPl81AuCn
        ZI9lOs0H3McBmX37HIIcwz1d6A==
X-Google-Smtp-Source: APXvYqxhsrtt2KXOawEWbugdsCleP2uygG0LIu+9qXaDXVByC4OzGpQkIVhgSA12n1EyQRy68HBOsw==
X-Received: by 2002:a1c:3d41:: with SMTP id k62mr19765359wma.61.1560338096902;
        Wed, 12 Jun 2019 04:14:56 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j16sm38159921wre.94.2019.06.12.04.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:14:56 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/6] serial: uartps: Do not add a trailing semicolon to macro
Date:   Wed, 12 Jun 2019 13:14:42 +0200
Message-Id: <5d938d34c3c4710577df898dbf4b70c74d2e6730.1560338079.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch fixes this checkpatch warning:
WARNING: macros should not use a trailing semicolon
+#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
+		clk_rate_change_nb);

Fixes: d9bb3fb12685 ("tty: xuartps: Rebrand driver as Cadence UART")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Add Fixes tag

Origin patch which introduce this semicolon was
c4b0510cc1571ff44e1 ("tty: xuartps: Dynamically adjust to input frequency
changes")
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c3949a323815..d4c1ae2ffca6 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -199,7 +199,7 @@ struct cdns_platform_data {
 	u32 quirks;
 };
 #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
-		clk_rate_change_nb);
+		clk_rate_change_nb)
 
 /**
  * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.
-- 
2.17.1

