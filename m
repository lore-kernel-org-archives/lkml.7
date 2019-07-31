Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0D5C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CAC20679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuB5pUam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfGaRd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:33:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43542 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfGaRd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:33:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id r22so4783826pgk.10;
        Wed, 31 Jul 2019 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdV6/Tiu5GvjTMQ9QyyZRYNM9k08hzpDwPXSgG/A8Dg=;
        b=kuB5pUamsLMzn3eMA3P/mkWE7du9IThy0cdm9QUoImLarnasa8mUfzp3zsMNI9pqJm
         h92Kt4xPIRpV9MDiBSQAhGYjEYw4MwWX6OTF4MxVejLuCAY8fb8+S1flttfD66GqeyfQ
         z8ycPseeJlLQj8Dglybe156Hn1EtIDvmrD8ongvSQ+l1SSGeno8gU60pB0iQ15fW2GRY
         xAZolxpl94nHXkM/wmAwxf9cuBM++7tkPdebUYg95aRvATCd1t7oGGQh0njltsqWleKR
         ieI+RrieK/cx0LCRqfcX+3/nnGG1OEJPRuweZDya+gBbJ/YA93hMtn1PaCqL3r2mhqV+
         2fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdV6/Tiu5GvjTMQ9QyyZRYNM9k08hzpDwPXSgG/A8Dg=;
        b=CxM83wrVZBf78IaO0dP/QYDylcQnAWeG0xAbnB3uQqYeFS1ha1VgUYr2KalMOAzPJD
         EWeBfbQAMvH25kxWwcKUZySG17bav2TXbSHjQdMeQi46G71wFT/8BFozVHahQC+uqpCR
         yj2jWzXV/vXukquZkMvBiz7MstGMiphBnjtXvSDQD7hC5vj52Jd/G3Z/YqYwUk/09RKW
         bvMHEkJcQIVWRk1rF6t23HfBBKeM8oZIizUeRnLealeIY3Rp/rdn7RdqDhOeUtMVMLBx
         JY/N9F+EDKdWpqJWu4LmDB4SyoXvpOnsWgSe1hrLvYps1KS0nGA3izAQ5k8ndpDhTiuu
         rRLA==
X-Gm-Message-State: APjAAAW+FNqUpgvj5H0iDoq0bm9Cuw53tQXOkPZ22pL5JMXrfms0os0T
        6aRyYVG9E0md0F24I0H174Slma2G
X-Google-Smtp-Source: APXvYqyOZTU8Urd2YRmIKl/GZ5fXUT532nAQ5L5R7ou+tXyadFX616pjxt0kLCYsjFhFg5XaLMhyDQ==
X-Received: by 2002:a63:550d:: with SMTP id j13mr52267097pgb.173.1564594406609;
        Wed, 31 Jul 2019 10:33:26 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.32.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:33:25 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/23] tty: serial: fsl_lpuart: Don't enable TIE in .startup() or .resume()
Date:   Wed, 31 Jul 2019 10:30:44 -0700
Message-Id: <20190731173045.11718-23-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling TIE in .startup() callback causes the driver to start (or at
least try) to transmit data before .start_tx() is called. Which, while
harmless (since TIE handler will immediately disable it), is a no-op
and shouldn't really happen. Drop UARTCR2_TIE from list of bits set in
lpuart_startup().

This change will also not enable TIE in .resume(), but it seems that,
similart to .startup(), transmit interrupt shouldn't be enabled there
either.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 8ab5f9939597..237690a6e80a 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1410,7 +1410,7 @@ static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 	lpuart_setup_watermark(sport);
 
 	cr2 = readb(sport->port.membase + UARTCR2);
-	cr2 |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
+	cr2 |= UARTCR2_RIE | UARTCR2_RE | UARTCR2_TE;
 	writeb(cr2, sport->port.membase + UARTCR2);
 }
 
-- 
2.21.0

