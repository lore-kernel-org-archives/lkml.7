Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FC9C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F804214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="I+MIep7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbfLMAJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35464 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731885AbfLMAJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so399469plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1hswEx2x16MZg3+wDm34G7hX0t+6S82ALeLREnIqNI=;
        b=I+MIep7ItOXumU24ng/GyM9a7ltKAp6dkShxqK9wAVtQKd1MMVjtKEXTNYDA+BihOc
         J7NyR38T+KMaxkIoFMz9N7EDDKKgsV4ePu75mYUJrAgz45yNC/QR7b+hOIlqxb+tDRwE
         elvi0laNYNd9atPasKFN8Zv1vQU2NPyA8qvOdwK+/WRWzmgFxmLIM+qKbdmnIa7BKncb
         fNpAKO5vmCPaM9Z0xatNN2tRdg9WMvgut3z7+QjboxXDx1zAehLeYZMQoFnkoJnaPzH7
         fEkJjsaCR2yX8eDu0t8MUhuj7Bt2XGrfao2gVmue+/W/i10Ed545dS72OL49/WmTcAfx
         4sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1hswEx2x16MZg3+wDm34G7hX0t+6S82ALeLREnIqNI=;
        b=bI9OILDTGacvugg3ieWvHndOUsZz9y6yIwSRd00mGoEKE0fyDHxHvKpCpzassAVj5c
         w/19keYy7xaf3JVb+o3tgGgJkkvY+NKdDpwRSfcKr86+azjwVGMSR2zepyIQx+U+pbN2
         SY7uOA/fQZpIYDjbLDKiZ0xyCYMaa4nKEq4u+PDlL+n0/dXgGsem9J9JZ42F9v3zVX0s
         f3i43NebaYfgvos1SGIXAQCoEtoR+CWZ1dWVklFfmi+YbJ7GGZL95xvUYZYh4C5VjiGm
         JXANk6w8nQHUpKYOQoS5VogiJTqNOijvnZFseNkPcfUFtr07bXByuodOKpgu+lZSWCyu
         LO5w==
X-Gm-Message-State: APjAAAVxbuk+GDsCbH8VQkVi0Q65ZHE+Eje692GE8rA1iPc+JqAzD1Mw
        pIXux/DbOUlE3oPlRXS7A8V820Zmc98=
X-Google-Smtp-Source: APXvYqw0EJa5ClivPVkgMXHfBEu9Z0IvagnSOcvWrhNhKfyBhx4nsaI6cRdF6xZPH2fPRrhHMtpQ1w==
X-Received: by 2002:a17:90b:1115:: with SMTP id gi21mr13212775pjb.95.1576195782898;
        Thu, 12 Dec 2019 16:09:42 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:42 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 50/58] tty/serial: Migrate vr41xx_siu to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:49 +0000
Message-Id: <20191213000657.931618-51-dima@arista.com>
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
 drivers/tty/serial/vr41xx_siu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 6d106e33f842..eeb4b6568776 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -7,10 +7,6 @@
  *  Based on drivers/serial/8250.c, by Russell King.
  */
 
-#if defined(CONFIG_SERIAL_VR41XX_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/console.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -869,6 +865,7 @@ static int siu_probe(struct platform_device *dev)
 		port = &siu_uart_ports[i];
 		port->ops = &siu_uart_ops;
 		port->dev = &dev->dev;
+		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_VR41XX_CONSOLE);
 
 		retval = uart_add_one_port(&siu_uart_driver, port);
 		if (retval < 0) {
-- 
2.24.0

