Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C906C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A669214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="QdO6faUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfLMAIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42427 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbfLMAIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id x13so378799plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XEE0LGDV1J/8PNdfM5R+G2BENKuEh6gWNO7Fuw2PlT8=;
        b=QdO6faUQ9IU/Iu3hc9HssBIFSyYwL1wjx6YLW1AGrFNfD1NEqfQWLvBbb7cncEUgM4
         kQNSs1EkyzWRVaSAXzHHvTGkZAPoKwhyDXu97A+VZwti2nj1I5pWHpnFM9QWA/lxoZ13
         VrknhWKh1KzguA6nOSPPffDORtX3W7EhuGtzagBADUGjmlbzM7Q2UqoXF5G8fEDSrm2A
         svAskRSke+8ffBqi9jrnIhsH4v8M/CIzFCAlcXKFmeVGJQARdG2tS0Gk8GQrUY4fyGJu
         jQ00/4sNwNy20ADchZObQ4QB5SV3L17th2C9opjauWqVn7y0oaboxFBUdzXe2K6GG6wn
         1L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XEE0LGDV1J/8PNdfM5R+G2BENKuEh6gWNO7Fuw2PlT8=;
        b=n26TpPX/gheHLmAxJEWKq6H9zXs+vgo1tclk2FY01hFhCbbhnRZyTEgS3RixmwhFIE
         U23ei9gzx6R6yIrwvj4w/6l07i/+I3apzK+Ub3VZ+WJ/1bcZjz/zy/g4ttmbzz3RYpfP
         VloQ0YLKP/qkrgBv/7c18mY4KDj/TTvoR8TiNg3OWrHoDutlj/+//GNx8HXQdkpB3+6U
         Sq/tLAr3VbBWWXPl5csxXht92K+6eOxN3/2DJk1Lqw1STGH5rm7KrVjtALxsYaxJkdkY
         2UXbG8KwVhYmyaHPyyE4nM6HmIjaSagI2NUbdf04oybk6ie/iN6YxWrqBYiDuYcXXs9D
         Qm1w==
X-Gm-Message-State: APjAAAVsVcMdED/MlAc761/PoVLh/L0TDUm0eCubXNLd5mv1MdUtMYjl
        JvSmmGHk4Eu+WLXLBSZhcg/ZaJ0qJ+8=
X-Google-Smtp-Source: APXvYqzcYT0DHwWe/kfTwr+RdnsOlzCzNojd3O1sghIDf52D2BkxpgOg5Y3f2CLhLhsf0d2pnd8l+w==
X-Received: by 2002:a17:90b:4391:: with SMTP id in17mr13218028pjb.33.1576195717651;
        Thu, 12 Dec 2019 16:08:37 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:36 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 28/58] tty/serial: Migrate omap-serial to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:27 +0000
Message-Id: <20191213000657.931618-29-dima@arista.com>
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
 drivers/tty/serial/omap-serial.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6420ae581a80..53b38a226f26 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -16,10 +16,6 @@
  * this driver as required for the omap-platform.
  */
 
-#if defined(CONFIG_SERIAL_OMAP_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -1680,6 +1676,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.regshift = 2;
 	up->port.fifosize = 64;
 	up->port.ops = &serial_omap_pops;
+	up->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_OMAP_CONSOLE);
 
 	if (pdev->dev.of_node)
 		ret = of_alias_get_id(pdev->dev.of_node, "serial");
-- 
2.24.0

