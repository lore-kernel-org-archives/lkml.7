Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EA1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA165206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XF2rsfp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfLMAKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:10:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39549 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbfLMAJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so385329plk.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q6Z6h55fqcKu/1XdEPBrCCQZqpAqK/dlHyYZRu6yk0A=;
        b=XF2rsfp6S8eVpNAwetphzdMntNRfleo8sRWtjge/7tZNQ00G6D+xDWInIppahrgaVP
         56NMUvPSH2EP7N0FdLt7Ve9GX2Ow5BwokuTIs/7QmH5OuaOObM07n0rTevRAkVOsN1eB
         uRvdkEL83YmHbC4hH8sbKzbm40UaJHO/CO1bz1f5qfJqVJmrZ3j+wxV95kM95LLSlrsF
         bpAY3+MTgrkQ1t12PDoKlijBzwBbfGbZcCmy9w1qVsEeg8M6TOJ5y5fQI/HV6aXO3ksH
         t8bodtXGK2fCSZcgJSEidF++iq4gbEzVvOwNlntWLZXF+s6M7gk/HuXXKLqM1011bMb3
         urUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q6Z6h55fqcKu/1XdEPBrCCQZqpAqK/dlHyYZRu6yk0A=;
        b=gE9EOUsFSka6O7JNd1K3Muw/3q4f5ki/3RQUwyl6But1itmSelh7vuJujnJWaT+HOg
         oEw4EBIhmDN9B7EqF4GhWtgQPHkudooqOI26zTdJO0iraA+/e+q4eVLVGwKMAsa3wrHL
         xktDqYsbpgPK6xlypSOwHHx09yLhALQ9PUBfLExt1tB87pUIHmXYRN7WxdByhvkPCmGi
         mGdt980O82FRqj/hTaBkKJDQA0Sxq7dKRrewl8seBjqPg3lBBfu5HU8XyPwfq7AsLJVU
         BewsvBMPzq6esyYfzMyAUExeSGeXyRPL58oLkslphwYOiz4iKM+mqu7kd5zpKR4sieg7
         40Mw==
X-Gm-Message-State: APjAAAU4/iHJlPTXgal7ymR/BKSpO0xTqICaj2UcJ8WYFOPKiWzjU3Wf
        ayhFtgHPS4nHQfa5PZmYodt/7mQBe4k=
X-Google-Smtp-Source: APXvYqwlkJz/Si2OVsRDCRLc+xPb5dEar6sDzFHhlOaQ2a+RW7qzAwTJAfBum3Dn/5w7f+5voW+Utg==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr12764749plr.263.1576195761332;
        Thu, 12 Dec 2019 16:09:21 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:20 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 43/58] tty/serial: Migrate st-asc to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:42 +0000
Message-Id: <20191213000657.931618-44-dima@arista.com>
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

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/st-asc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 7971997cdead..fb6bbb5e2234 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -5,10 +5,6 @@
  * Copyright (C) 2003-2013 STMicroelectronics (R&D) Limited
  */
 
-#if defined(CONFIG_SERIAL_ST_ASC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/serial.h>
 #include <linux/console.h>
@@ -730,6 +726,7 @@ static int asc_init_port(struct asc_port *ascport,
 	port->fifosize	= ASC_FIFO_SIZE;
 	port->dev	= &pdev->dev;
 	port->irq	= platform_get_irq(pdev, 0);
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ST_ASC_CONSOLE);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
-- 
2.24.0

