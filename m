Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EA7C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6AB227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NX0gv+nV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfLMAI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42446 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731407AbfLMAIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id x13so379293plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJ/K67n2T5JKCf35S1BcGc2M+5ycQJ72kMRDMo/lBe4=;
        b=NX0gv+nVHqjcOgV/2F+Ya/vhafp0KyetvAVn6TzCw7SMvq0/u4RLiLESz4QUOmHh3A
         EVmV2RNWYSowwhMlisVrMGgBp28oC5Z/xp1GfeA3KD3PrL10tmSk0PYSsYbVSYtc8+Hq
         TIZ8mCLritKRQOgi35ODpufNBlOjZcPiCBmn2z1juJZdlrO/hTM9rXpJapf7KTLz6kJq
         KlLi36WcjYreAqRWg3RKp1geiDE2EvIWuif8gb64BEjWQEICvNfRYhvQYTHpkokEj3Kw
         4z6H0GJey83qOqMeRLbOpy2/zfgVzinlaLJnHbm29q9lfr6ZAfk2uUC+h1EFABhzwt4O
         gNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJ/K67n2T5JKCf35S1BcGc2M+5ycQJ72kMRDMo/lBe4=;
        b=o4ovtrugPQlsaNpszo5PoEs8/3EKnNP8g8eanwIYwtO+MieLO84iUNnP2to8e9Kn8+
         aCEbFh2b24vW1KT4tQHWUg1zP0sJ4ltQdEhK8XjV/z27QyneG3U6TC6eG7wgdTUc3gy5
         HuyP2FqGdSfxWuPiDwtM1yXNGKqv50weLcjksMxyVU5V4jNtTPQROcGHfzyFzMGiK5ts
         r7s8knXJMTl6lwuRiMGNvzmNQsDFttDisDrumHBFZNHu8bGwJPwIFKjiysidsw18iPq8
         ZggniRe0HbJWheksE2u6QdcTRNveV9YERTm/MPlLDZBZlCb/iWW2NoNPIom0S0XpvBjs
         G5rA==
X-Gm-Message-State: APjAAAXqAb1cJEBxsGoXWhfR935aDtAhHgcj8+Z1DUvcSIVcs9ep2fCL
        Y/QBqxVu6sfBmwaJht7IO3nF8W5s+Y4=
X-Google-Smtp-Source: APXvYqxBiIWzDGmJW2EGWJGBn1iFjkHGX2XegbsBDBpEz+UVnAGvV4Tdgr4/zKm03jglZxdYW08fOg==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr5081948pls.65.1576195734438;
        Thu, 12 Dec 2019 16:08:54 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:53 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 34/58] tty/serial: Migrate pxa to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:33 +0000
Message-Id: <20191213000657.931618-35-dima@arista.com>
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
 drivers/tty/serial/pxa.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 4932b674f7ef..41319ef96fa6 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -19,10 +19,6 @@
  */
 
 
-#if defined(CONFIG_SERIAL_PXA_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -879,6 +875,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 	sport->port.dev = &dev->dev;
 	sport->port.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 	sport->port.uartclk = clk_get_rate(sport->clk);
+	sport->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_PXA_CONSOLE);
 
 	ret = serial_pxa_probe_dt(dev, sport);
 	if (ret > 0)
-- 
2.24.0

