Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E53C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04357204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q10J5m66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404339AbfG2T7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:59:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38270 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390354AbfG2TxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so28558729pfn.5;
        Mon, 29 Jul 2019 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6J2Bzq1GXw9rAwkaKUbpuPpI532SYGVFNOZbKomKTQ=;
        b=q10J5m66RRck11EaByFbZdFvCPcwue6yhfjEI76qKwBSNKWNdp0+NkcnZP83KS/Gjn
         nhIGjFttaNeB/ZZwkjO7jg3zHwpUSNb7KqtXWsTty4zUnuXWHzNgYsMh9ScGcq7vHAUW
         9vU+5GgF9sihqf+7JAX7aEj2YAANIqOr5pmFx7pXcBApHpd+4nw5rmvC7x6H4HPAD4Gt
         UsLnFN6qNybXrdj67+JMkD8789Ae7G8fgA0hXOGg4qQpMM0ckuijNvlIKXFcgasYugjn
         fnEBgjRalosVxA3zJKThxXXm9c86qRzh4G362JxWtbAm22H4xUsAO7z2/OsSpI0p68D5
         oUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6J2Bzq1GXw9rAwkaKUbpuPpI532SYGVFNOZbKomKTQ=;
        b=ICD/n5TSUHTn9kakjBSTKB/Fs8X/8Hw7obikXGCMas/tW5bOH1mt/xHElKCPZukhpW
         Z1rSiRGhL5EPbZ9Gsa95xPVY1GtioEI3xO2yaw2qPWRhj3lnFHIIgNACBYJ1gp4eieQ/
         IuUxjdaMmwqLa5C80b2wx+ZT7LufgIqGu2wKQnTVGb27jOoJjRHCePXNRYL6eoJhVVM7
         oFXSgkf1XzgYhHI4gD6D6wAbGIjCWdthRUOIOfVibZXzm3Eq1/bylBEhw5C82MMXcLPo
         DROz2uyChYnA95QM6vB8AWfqvmqAKv+cSOnxKPJHfVDYzVmkX97E4Whwpy3/15odPm5q
         z8xA==
X-Gm-Message-State: APjAAAUpzgq442Ni/16iU/Ik47vttlKlYk5XgxHvVD/kxThH0h5qa26Q
        SX8l0hatFsf/80vppTVOVxgLUqh2
X-Google-Smtp-Source: APXvYqw03kc4TY4XB7ev9wGo+8PkhlJoTQd5b7hrllVKbvnSdES8hoyl9RdZRpjK0iYs5AFPH9cAbQ==
X-Received: by 2002:a17:90a:eb04:: with SMTP id j4mr109525050pjz.103.1564429986627;
        Mon, 29 Jul 2019 12:53:06 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:05 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/24] tty: serial: fsl_lpuart: Use cpu_relax() instead of barrier()
Date:   Mon, 29 Jul 2019 12:52:17 -0700
Message-Id: <20190729195226.8862-16-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use cpu_relax() instead of barrier() in a tight polling loops to make
them a bit more idiomatic. Should also improve things on ARM64 a bit
since cpu_relax() will expand into "yield" instruction there.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index dde5caf724ff..7a0f96952291 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -552,14 +552,14 @@ static void lpuart_wait_bit_set(struct uart_port *port, unsigned int offset,
 				u8 bit)
 {
 	while (!(readb(port->membase + offset) & bit))
-		barrier();
+		cpu_relax();
 }
 
 static void lpuart32_wait_bit_set(struct uart_port *port, unsigned int offset,
 				  u32 bit)
 {
 	while (!(lpuart32_read(port, offset) & bit))
-		barrier();
+		cpu_relax();
 }
 
 #if defined(CONFIG_CONSOLE_POLL)
-- 
2.21.0

