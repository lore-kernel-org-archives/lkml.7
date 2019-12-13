Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB615C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0D6206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XCdpRu57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbfLMAHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:07:53 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39156 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731492AbfLMAHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:41 -0500
Received: by mail-pj1-f65.google.com with SMTP id v93so339845pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOfw8DvGelk55VHYuQqtGjkzT+5DacD+SJoWHYJTR3I=;
        b=XCdpRu57dNmoWnj2l4EG7ZDbsjFSrjIpki7aSV4S3h/YRY5z9QZKOes+9is2EyjqDi
         Pggu8FM3/7QWvzeC21hsbCLhcGMQo4g+ugnC+0QPnM7fqEMVKKR/LOxJA4rFtuNZmFJ0
         emjiYa/2Ns4Yv3HuAJhAI8IRO7/Gn2ljOKX+tfvBR207LOLY4JpQpr3XmBD6pMHFFdeK
         +FFab1PlU1DCuACaqcrDYr+LhVt3ihA3qfjHHaEar1ILptYMg4ID3rVleAZoisR6GURI
         6gMOPR4kRiTK0OV22sjNYFT3GWYlyH+dJHuhFM/9DiKyQtsss/VGLt/tXriatRoDRFqI
         GabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOfw8DvGelk55VHYuQqtGjkzT+5DacD+SJoWHYJTR3I=;
        b=S1czzzhPCvoARci0qPxc4yuHKqpqIHyNc+tk/OvAG7rsOXzJm5KBzviaVvG7yYYnnP
         EtMTMBEg8gaF0uaE5NHzuMTW78RXG+sIXsTbX8SldJArIwk1JViUzaEr49YLM8gpzgQu
         dVeA9fpnx/S3B1hsjc4ZJpHXgT6lnCA9xdyQOdlCs3rBJDs+KxKF4ck5X9qOH8Zp15It
         SGeW9HPAe6bUmpqC8fUHhjWzgKD1fxoC7jjjC08xIAvltsaOoZIH4MtPKt47IoLcHiHc
         XhJwrxKtiTUevByGdUFyAMFaHfH9TH0XvAB1Za4nz99qw7FE/KsmYSYieMJkBFA7JSev
         OcOw==
X-Gm-Message-State: APjAAAUlUaFlumWYifRIR5FJ6SAp9bR6PGa8YyyfkwxErjKv3BxX8cLk
        tAMmmcizaTy28ybYGYQrQVzZKUeP2qA=
X-Google-Smtp-Source: APXvYqwKzXaCGQEeoKJrUNZJQ9fKFxNSrrIEiT/fYpiiBnXVX3v8SPs8UTDHVRjx6kdnyz5cai2w1w==
X-Received: by 2002:a17:902:b204:: with SMTP id t4mr12673801plr.137.1576195660500;
        Thu, 12 Dec 2019 16:07:40 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:39 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH 09/58] tty/serial: Migrate amba-pl01* to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:08 +0000
Message-Id: <20191213000657.931618-10-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/amba-pl010.c | 5 +----
 drivers/tty/serial/amba-pl011.c | 6 +-----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 2c37d11726ab..3284f34e9dfe 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -15,10 +15,6 @@
  * and hooked into this driver.
  */
 
-#if defined(CONFIG_SERIAL_AMBA_PL010_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -728,6 +724,7 @@ static int pl010_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.iotype = UPIO_MEM;
 	uap->port.irq = dev->irq[0];
 	uap->port.fifosize = 16;
+	uap->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_AMBA_PL010_CONSOLE);
 	uap->port.ops = &amba_pl010_pops;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = i;
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4b28134d596a..952483ec8ea1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -16,11 +16,6 @@
  * and hooked into this driver.
  */
 
-
-#if defined(CONFIG_SERIAL_AMBA_PL011_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -2579,6 +2574,7 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 	uap->port.mapbase = mmiobase->start;
 	uap->port.membase = base;
 	uap->port.fifosize = uap->fifosize;
+	uap->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_AMBA_PL011_CONSOLE);
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = index;
 
-- 
2.24.0

