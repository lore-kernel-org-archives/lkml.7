Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02785C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C8F214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="V7J5u9jP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfLMAHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:07:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38446 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731529AbfLMAHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id a17so385566pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0iJ/wjFyDhw9dj51HK4n0REzjKw3i28nQeld4BBkF8=;
        b=V7J5u9jPoSW+CaaUiXWu/PsHwKiS46Y4g4wCsDl2sHoBQkFtGRWLk922f2OWcHQmoD
         MP5o7Qhnw/KQfjKFPG03GcR+Q/TUi4t088ySGals829CZSjUDArt+nBzDz6hAIAQO5Mz
         NmU5gnTNu4yEV+x4CMFw1WwDfNy69WbSmvnGvJBvYsRqxyStSe14EuKz/IqbOY+oHBsd
         gn7RCqHf8WUmRqoqBwKo76Td4eWmfLaCz/4C7xceMcQaI/+U8jseRmyK0Ea8Mldz3xIM
         G/n3Ovr4S77tVbxoaOxaMZ9XHYvRMqBQPqxtnwn0esUYTHDv5FQdtSH0Xh9FIdPAzFvc
         kQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0iJ/wjFyDhw9dj51HK4n0REzjKw3i28nQeld4BBkF8=;
        b=T67+9W+gdNKX0qMQe+TJJyACeL3lEejRGra1kMe68jGy5VK2BXFTY6qmzGYfxOAdNF
         aIGx6+OsQAMf3WH5ruwsMwVKQfMXELmQH62IG66YN/phq5Lu7Tt1oc3otU68UF1+GLXb
         bGPP9e+mpisRB5dW+0V8ZpEwCt4dcm45tCYiwE6uASnoWfDQlm+f65WMVaXQo2+HdR5O
         pCppUOlMHnRq4nn0pIx1FcI01yov70TGxTpe2T20zitT/3Qk5U9aVAMkYPcUyOz8amQz
         9Y4twbTZJkWO8ABhH37pLAPG2Xvq7QJQWx2kuF7cecqnW9/s2zGQOhYwGRBC+yWYu0H5
         btZg==
X-Gm-Message-State: APjAAAUXGLJfopKbjWzboOpn63jm/64nZ1XXkgid2WLvLXWjx4Jnj5/q
        J9uczW9Yrwcz3T+rPDkQP5AGr9NEcTA=
X-Google-Smtp-Source: APXvYqz9WR2vmA1AuTVd5cFtEVGwazlSwZxY1yIWdWk8qc5R86jSyfTCb5F1MznOQVCGkbyFMIfRtg==
X-Received: by 2002:a17:90a:a004:: with SMTP id q4mr13043529pjp.106.1576195663262;
        Thu, 12 Dec 2019 16:07:43 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:42 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 10/58] tty/serial: Migrate apbuart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:09 +0000
Message-Id: <20191213000657.931618-11-dima@arista.com>
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

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/apbuart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 60cd133ffbbc..e8d56e899ec7 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -11,10 +11,6 @@
  *  Copyright (C) 2009 Kristoffer Glembo <kristoffer@gaisler.com>, Aeroflex Gaisler AB
  */
 
-#if defined(CONFIG_SERIAL_GRLIB_GAISLER_APBUART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -626,6 +622,7 @@ static int __init grlib_apbuart_configure(void)
 		port->irq = 0;
 		port->iotype = UPIO_MEM;
 		port->ops = &grlib_apbuart_ops;
+		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_GRLIB_GAISLER_APBUART_CONSOLE);
 		port->flags = UPF_BOOT_AUTOCONF;
 		port->line = line;
 		port->uartclk = *freq_hz;
-- 
2.24.0

