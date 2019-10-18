Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B77CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B8720869
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CINJsrk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440155AbfJRTr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 15:47:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55456 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbfJRTr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 15:47:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so7297484wma.5;
        Fri, 18 Oct 2019 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=29JeKgSY9LOeN+no+XK07axfqq3O5QcjOGKm4qRL5EM=;
        b=CINJsrk36mjN7138rzjhlMMfh4ilot3xmvC1TB2d9BRMmAacU52tSwExBmUwbYZjRl
         nqJ6tQzdzbYY+DvgKoxR9QJBH/HWI05vv4ChdX4pB02PH3lmbKTvUC1OCi08k+osbo0z
         aGt3tSr8qVVSKLa+/2lYqorZVEdCWuyxsY+TKNX9IUbUVLaA0PFfJ/Ci6UZeykwMOBJW
         nBdAFdHArkTvM2OJMedMfGZ1ojFwLr2qJhkZ2iPrqbseNMxIzJ8n64X5FHJ6NF4kRwPU
         odLGBVCQZcrBIzlbkptRcvY/z8jSbm5K0ZosPqNxBmcJ4ycyZSkQ1c+9aIUYzpXYSTke
         Iqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=29JeKgSY9LOeN+no+XK07axfqq3O5QcjOGKm4qRL5EM=;
        b=jha1AXYPpHJsP8pe/r3NUuIQsa0Aj32m0fNr1dCz1+6d1lRsYA0QbYAsT6X8CsETDu
         s7hsmp+5E2jC9KKmppHDbbpU8Y7imUTq+KFvOC/ERMuNPFCOCvVqn8ZzUDcwmOzujTeV
         H58ty54aXwYeGBBOlscTG6jLjjoPGxN1G4bJmSXKB2XZDxf+vb2xbkOUupunAI6Jm0CS
         y/wvag84cxTWerA30ZIhaXdJ1F4+It41dOCBzyo6rTR4+4tRkiLgtdufpf7vokaRM1WH
         dhFh24cnQuRgGsw7k8bn/znDAl0XO3mY+5Xl++bUYBtRIXUr/jg4BTUN5wsHpMxl3ElK
         Zxlw==
X-Gm-Message-State: APjAAAUxDIIxyFEq6zb4Ys47dXR7uQ4GyYAYoKoBEhm7FcqKoCRedYLL
        jeAOZtUYZcQrdYDDXFIDDY4zCA66
X-Google-Smtp-Source: APXvYqy5sv6eFU4eQ/y6qL6QoHw1G3w39Y6P+ecZKsa5W/pDOYxVgfTVPiUv+YZiOHdPCetozDLF7Q==
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr9181923wml.8.1571428043566;
        Fri, 18 Oct 2019 12:47:23 -0700 (PDT)
Received: from debian.office.codethink.co.uk. ([78.40.148.180])
        by smtp.gmail.com with ESMTPSA id q124sm11346224wma.5.2019.10.18.12.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 12:47:22 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] tty: serial: samsung: rename to fix build warning
Date:   Fri, 18 Oct 2019 20:47:07 +0100
Message-Id: <20191018194707.27188-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build of arm allmodconfig gives a warning:

warning: same module names found:
  drivers/tty/serial/samsung.ko
  drivers/mtd/nand/onenand/samsung.ko

Rename drivers/tty/serial/samsung.c to drivers/tty/serial/samsung_tty.c
to fix the warning.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/tty/serial/Makefile                     | 2 +-
 drivers/tty/serial/{samsung.c => samsung_tty.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/tty/serial/{samsung.c => samsung_tty.c} (100%)

diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 863f47056539..d056ee6cca33 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_SERIAL_PXA_NON8250) += pxa.o
 obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
 obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
 obj-$(CONFIG_SERIAL_BCM63XX) += bcm63xx_uart.o
-obj-$(CONFIG_SERIAL_SAMSUNG) += samsung.o
+obj-$(CONFIG_SERIAL_SAMSUNG) += samsung_tty.o
 obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
 obj-$(CONFIG_SERIAL_MAX310X) += max310x.o
 obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung_tty.c
similarity index 100%
rename from drivers/tty/serial/samsung.c
rename to drivers/tty/serial/samsung_tty.c
-- 
2.11.0

