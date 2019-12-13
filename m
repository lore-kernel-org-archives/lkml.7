Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CA7C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B0D206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bo2+fnwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfLMAJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42085 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731520AbfLMAJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so524420pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDtAK7kRlx+bCfDk3TtrxH2ze1hrkm3F6P7WSngbOvI=;
        b=bo2+fnwoAHbocMaQJwHhSICIDSFWy0wS2ykgZc5jqpdVJKvQt4T2S261UFKan0kaW0
         yVR0m9lojn/nuHntv+a6muGbZMcalQ5KxsZRi36EoshfESSiwe40HYAS2EQGammaSsgn
         P00Il+8IcVuKq48DthDKEfzYNN0WVMtQ2/qHefO/iJRkg6H+T/RhYsQ7JZh95KFybnSk
         W9smQpVxD+aC192g7q0qcOyBfu0JMXgmPuiQUukHfFWt3XJhHPWs3ri/BzdRRjz6s6p1
         VNg8cLQWkNwFHMZrWpLEV1rJP8ZKJxzwcn7aMv9+SQnOzBE+4fjyUVtUCaXLbI2klXlW
         OJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDtAK7kRlx+bCfDk3TtrxH2ze1hrkm3F6P7WSngbOvI=;
        b=tcBbEV8mDfo8X70Sycadyjq+rZCUpJoQ/UOLq+6KExntXQdIV16VF3p7mHENvimHHR
         pFTuGH4vRjVu5F9bF3es8vK8yvJ7uOHvAy33mxI2qxla7pfYM1QVjldybmX8r8BX3K14
         BpxaLF0dz55rFXR7kEmHzk2f4X3xDz5whGkih3z8sKMIh2h1wriz1DJrp8ptljfxHyx2
         440JKhBYgtkWCDz+lngCZUu2b6MmsV4oj9jFtqczRZ1/mrcQJET8w85QPLzl9jQbvSLE
         CIxAe6Uw8jYF7c/DLw8kWHTeTaCJDCxqJZZHTzIlPOWRxrgnO4EQ+bLCYEMYXHMj+jeU
         P0MQ==
X-Gm-Message-State: APjAAAUSpsgbJMn4z0c8PaobNJEfOOntYDQVX+ASTFVqSnfnX4Inoiam
        y9b9ahHveh9I+Do8woa4OG0SV8wOrIc=
X-Google-Smtp-Source: APXvYqyjs/7p8E6vVHpPBpIYOyNWJqycWMMOttSl7Iw1wzzROG6S3FqyHmds9VCOUZt21N1v4O2xrA==
X-Received: by 2002:a63:3089:: with SMTP id w131mr14051620pgw.453.1576195751335;
        Thu, 12 Dec 2019 16:09:11 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:10 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 40/58] tty/serial: Migrate serial_txx9 to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:39 +0000
Message-Id: <20191213000657.931618-41-dima@arista.com>
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
 drivers/tty/serial/serial_txx9.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index d22ccb32aa9b..b4d89e31730e 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -12,10 +12,6 @@
  *  Serial driver for TX3927/TX4927/TX4925/TX4938 internal SIO controller
  */
 
-#if defined(CONFIG_SERIAL_TXX9_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
@@ -1095,6 +1091,7 @@ static int serial_txx9_probe(struct platform_device *dev)
 		port.flags	= p->flags;
 		port.mapbase	= p->mapbase;
 		port.dev	= &dev->dev;
+		port.has_sysrq	= IS_ENABLED(CONFIG_SERIAL_TXX9_CONSOLE);
 		ret = serial_txx9_register_port(&port);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
-- 
2.24.0

