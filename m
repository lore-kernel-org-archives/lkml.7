Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DEDC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993562465B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="QPdsdxdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfLMAJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40152 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731862AbfLMAJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so383602plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0+CfWIFGihQH67XHnawEzkvoyIVNkVRX2gLwjLz17c=;
        b=QPdsdxdz+7fnUfg+ryQJ1hukm13ge1RG6WbJ4GuPFOVdGsIsI1VN0s6f6KdEfYRMYM
         GNsSAjDvcKr2NEhMXVawk//rUq/pplZk+LZZDBs/jGnhdDyULBt5b8FosBm5+x4ogCzH
         5kYnXBnf6YJqa7AA3KLjmT8xi8TwjHEXKFqMdX4jLDtXWE8qoCo99VLwPEeULQUF8ilD
         dgyaSKn1tk90cqOeFUeCXHeVtlUx6dulDnFA7L6XWQZtRjcXiv2NnSg2UIjnXhMAEMG+
         Fe0ROQCiyuUd0IKlJTHJDdBlRUEeBP91pgYw4pSAg2FEQrQk8Rre09skWWa/GfWHUSMm
         Ylcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0+CfWIFGihQH67XHnawEzkvoyIVNkVRX2gLwjLz17c=;
        b=R+BgbpahYAnIwSD9Eb4XkDmFnxFPjdlt9UhHJEuEEH+Wz+uX+1t27vEI+J074Ogy80
         UaS2ZftdvAGtMDgVobTYBjyfiT05IC9dFNjhTXRNf5M0I1ooxH7K1n1HyXwvcYQnkSBz
         wRZcIXp7O3x8D4eJrFtZCdcGuQiZIn6zJK2LEw3tJASbzm7o8IbCbZPtYBvop4Sz8QwI
         FNWWoGwZDH7IRDk7xu5uLlEspxGsk/vTZVDO524kKNikGzEn0z8VB1Av8NYmaC58gDov
         8cYqjzJgN+GO/W+t+NOi09wnBMYmBdLBMBMlVsGLXBeywMLdFYrTVIjnARDA6fTM951S
         l0/w==
X-Gm-Message-State: APjAAAUxshqMD65Dw7ZWnCso5Gm5LRAZx+1xQOzYXJljPdhmlTehtmxv
        IvikZaBdzfV3Q1+7WzuLRJI9HTcYM1c=
X-Google-Smtp-Source: APXvYqzIuS7M4yHWD10vEbVE/hOa5on4D8SJXWBXNr+6FGA9VhmKJitIku5Vb/N4Xg24L/HYsXy9Eg==
X-Received: by 2002:a17:90a:2223:: with SMTP id c32mr13650677pje.15.1576195774307;
        Thu, 12 Dec 2019 16:09:34 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:33 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 47/58] tty/serial: Migrate sunsu to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:46 +0000
Message-Id: <20191213000657.931618-48-dima@arista.com>
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
 drivers/tty/serial/sunsu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 4db6aaa330b2..8ce9a7a256e5 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -44,10 +44,6 @@
 #include <asm/prom.h>
 #include <asm/setup.h>
 
-#if defined(CONFIG_SERIAL_SUNSU_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 #include <linux/sunserialcore.h>
 
@@ -1475,6 +1471,7 @@ static int su_probe(struct platform_device *op)
 
 	up->port.type = PORT_UNKNOWN;
 	up->port.uartclk = (SU_BASE_BAUD * 16);
+	up->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SUNSU_CONSOLE);
 
 	err = 0;
 	if (up->su_type == SU_PORT_KBD || up->su_type == SU_PORT_MS) {
-- 
2.24.0

