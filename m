Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9D4C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04BD2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="V4YsKDvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfLMAJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:34 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:44946 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731849AbfLMAJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:32 -0500
Received: by mail-pj1-f65.google.com with SMTP id w5so334410pjh.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MM87Orb9mjoqPJJZ7fE6T1iLGpS8nu1v2BHGmFgBN28=;
        b=V4YsKDvxBQsNKupfvhOfCfEI8IiASsLkz5MHqSGEz3X2YFcI6e6Q7YFTivbVaKyxOO
         XMKPJx6pdyCvZYSG2GNcdyOxiR9eoLqkHkJNI3Ko9C0D0iuYjYr4jRPHHvJThVCongTR
         FYE3RB/6pIHEW3Q4HoVKAQ7N3fI1wvf24nA7XA3bqEnCOjqNrVb7JvZotCOTn2VZOy5U
         yKKU2bVfaIEX6Acw/4tNwRBp4mVbT5J4xyGMlZIo7T5GpnsNohkbV/BaIoPnLekeHUj6
         HVmEfHegNn4PzAof1YbxnGeIHHzCC/ikG11wkFr2KRcu06CTsw/QVxQrfolNi9Vqfhky
         J7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MM87Orb9mjoqPJJZ7fE6T1iLGpS8nu1v2BHGmFgBN28=;
        b=kh+GLOrKKPIYWzOLG4fkLbhh2HxpfmbXNLBHkWhQi+gCslXsITa5bS2XpeEqqmbMWV
         N8XbdejhYkZqtO9/qtD2Khfe7IvNPZlD6Mj2wQrvbRUXziRqAqNLRgX+pBNVoR9H0vAK
         Rm/YwpEwtPaDsH3K7vvXuQjaTBDflJoLpzUCDuD5iRb7keBNb0H+RPEXu6IQVy1WoE8/
         4OA1ffX9b+3A/G+80rmW7CMS5CyX9V7+B2hdx4qfZ52+9NBc9HiSjrLblzS7+WuSTF/G
         OWlmZr3mFvlOuueR1wEvrvaGfCesVZloDWhulH5/plCm/F5gko6pF4qw9RONEi2/Dujs
         hT9A==
X-Gm-Message-State: APjAAAUCMqpzBLjc0KOhz3aYyztM9hxpHu13EC6holUkv8aEhQu9Z2zQ
        MhCFFpFQ//h0NMZXKdzOg6Id9nO5eeE=
X-Google-Smtp-Source: APXvYqw9osG5+ClV6+xwyklwL7TpqMWpbcYwH/Gy/NWXNMzoUezcaMFROo7bqxHl7IZQepVB1w8N9g==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr12924092pls.335.1576195770978;
        Thu, 12 Dec 2019 16:09:30 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:30 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 46/58] tty/serial: Migrate sunsab to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:45 +0000
Message-Id: <20191213000657.931618-47-dima@arista.com>
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

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/sunsab.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 72131b5e132e..1eb703c980e0 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -40,10 +40,6 @@
 #include <asm/prom.h>
 #include <asm/setup.h>
 
-#if defined(CONFIG_SERIAL_SUNSAB_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 #include <linux/sunserialcore.h>
 
@@ -985,6 +981,7 @@ static int sunsab_init_one(struct uart_sunsab_port *up,
 
 	up->port.fifosize = SAB82532_XMIT_FIFO_SIZE;
 	up->port.iotype = UPIO_MEM;
+	up->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SUNSAB_CONSOLE);
 
 	writeb(SAB82532_IPC_IC_ACT_LOW, &up->regs->w.ipc);
 
-- 
2.24.0

