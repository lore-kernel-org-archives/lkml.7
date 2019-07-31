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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0160C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851F6214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlrDk3S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfGaRbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44102 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730740AbfGaRbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so32383702pgl.11;
        Wed, 31 Jul 2019 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qV6Busv6K6PZcOPCNp9BVszEaNH5iQz+7fpeXLC5Mlw=;
        b=BlrDk3S9CzohBJMWhD4N1C5ISGUaJMH3qZBuh4ClRHvjooDE87Io+uU3De7AY9Gy8K
         037vTg2QkUyjV6ftnL+UZ+QyY+E/5mlYTxETZ80D9bMd6GEn3HwXT9av1Vzj3bBxnQ0M
         sToHZmgmgx6BaXw2LEE98uSarHlvSB4PPMdecFiafQYdS/Y4MfbiKxamyuiN2ipqXB3c
         oTHbTNajX2UGZ9g0zODii5lGSxigkJz9Kx015cwUsF1Z4H31WvElCVwCHAGwA3BBgohR
         gvQUsdsyql6Cxeji2XZOuX2Crns4rnOHeVkn7pPsPZq4Fe8GyJhdivXVsKckLXG3MQ5B
         o4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qV6Busv6K6PZcOPCNp9BVszEaNH5iQz+7fpeXLC5Mlw=;
        b=miBx60hS5mR0CvI+c/rT7CzahY9Nd6P7jOdr2dfGW3rm6usAoshREwe6m98LjWI+o2
         XIP0pUPmt3M71S4UouAtiI+b4u/pwPPwT512GdAOA9GmAEjyIUh0MENLmIKO9Y1DUczF
         DAH4Nl24XaC4a36w/HAH6JjOnGxiK2z+APl8x1GgHZMBLOd4EYFhD6wVofvNU22KFq8e
         wTtdbcfAshTD1Bmu25HdO6HtM8az7pxMiBoBDMVnKhwzuVCxuzdG4x17t80N3HM+rEj4
         1319PcE7raF9h/6b/cekBbTcEjoB121B2+nCJs0uaHTRHJOEJOMWJLAZpGfZXBYgIy4N
         6p4w==
X-Gm-Message-State: APjAAAVQhYWR4i7fJKMlRkubkQbDaWb69T92kEQtMVWvGPJXQsW7Vcn+
        Cv6opywQt852WvnfeEy/2Tg5THvmNzs=
X-Google-Smtp-Source: APXvYqwpKDngBhEeRb7Atr0Q/m65KimWIhobbvb859KvmFlySjMQGiN6LaJPKw2392Ldjdu3Rl7/zg==
X-Received: by 2002:aa7:9531:: with SMTP id c17mr50336275pfp.130.1564594296678;
        Wed, 31 Jul 2019 10:31:36 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:36 -0700 (PDT)
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
Subject: [PATCH v2 14/23] tty: serial: fsl_lpuart: Use cpu_relax() instead of barrier()
Date:   Wed, 31 Jul 2019 10:30:36 -0700
Message-Id: <20190731173045.11718-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use cpu_relax() instead of barrier() in a tight polling loops to make
them a bit more idiomatic. Should also improve things on ARM64 a bit
since cpu_relax() will expand into "yield" instruction there.

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
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index eb748ef85da7..58043e01a242 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -553,14 +553,14 @@ static void lpuart_wait_bit_set(struct uart_port *port, unsigned int offset,
 				u8 bit)
 {
 	while (!(readb(port->membase + offset) & bit))
-		barrier();
+		cpu_relax();
 }
 
 static void lpuart32_wait_bit_set(struct uart_port *port, unsigned int offset,
 				  u32 bit)
 {
 	while (!(lpuart32_read(port, offset) & bit))
-		barrier();
+		cpu_relax();
 }
 
 #if defined(CONFIG_CONSOLE_POLL)
-- 
2.21.0

