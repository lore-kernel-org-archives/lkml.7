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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A802C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1967620679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vghv0vOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfGaRbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35699 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfGaRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so26083244pgr.2;
        Wed, 31 Jul 2019 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYvaX7J9cxUQhdKKG49/JdVPH2DZADlvSsthICTex0E=;
        b=vghv0vOmZGuB205Uf7RmqxX/rLdIbLuVrUnwbIX354eVfiRH0+HNzpG7HD8SiR+m3K
         fpVpCXzyzi1lgJtkpG+xqbOsA54p4uhoAvl1vfJ93VXPpbcxu1ipTBhoCQuTJx6hrBiE
         Fin1qTY6prNvzwVi96SNoMc0MggOe1fMTBHeFlK45OiynnhCLYboNKSJOdAHyLqh0cii
         T9rvA636Uy+b8FGl0Npeq6g4jyMJJmPo9rO+fT64/gQjM9H+DNrp6QQYG2qiH2WJvCO4
         6Z+OQZoieQCFISTJyi1bWqT8cxFoFSZOPTm1TmIJpJ3CcrbvAGmqtPAJRf/82JbJxlcX
         8HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYvaX7J9cxUQhdKKG49/JdVPH2DZADlvSsthICTex0E=;
        b=MDd/NR/zL5FK1x4bRgftw0mTe/FMjz5tRdsy3Vo3LGM9PSAJtwDgoxuVSOJ5Kbr2qC
         pCc+Tpxko4CgMHGG5pzHqZUTnYMKvZPfsEj9TQGnx6pcLhtrNEIXtVNsmT5zPlsss0xD
         /w13G0o9WgJ9npsOCzLMUx5EiMlzbZ20gFCFRRq0g//cgGh2JImt+hst4e/dQ/VqZhmi
         WGfvPTht25ulEChYHX6qCiiLwX/mssY4fdiCCAzgptRX/F9SluWati1bsKCKybeDzbP0
         Xov/csRb73O/4+klbqsCDytZmE5EWstG5K7PeSTFg6Pplv5Y4kmFaurZD8GqDZYHsVcg
         wCgg==
X-Gm-Message-State: APjAAAUIOVsD9LCHmgm4NtLyV39KtMx7Grh2x2rX6BCudcdEkOwMg7pR
        Pw1Dyh3C0V4Z3btH5Mnhuwtr/GXvSdE=
X-Google-Smtp-Source: APXvYqyTQWOJ0HD+IKe+gJd5xG0xk15GDOpEVvfs+lva41Ydb+r3H4UlCmFmm9Xrw3s9cyM227LLmg==
X-Received: by 2002:a17:90a:4806:: with SMTP id a6mr4086141pjh.38.1564594290072;
        Wed, 31 Jul 2019 10:31:30 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:29 -0700 (PDT)
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
Subject: [PATCH v2 11/23] tty: serial: fsl_lpuart: Clear CSTOPB unconditionally
Date:   Wed, 31 Jul 2019 10:30:33 -0700
Message-Id: <20190731173045.11718-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clearing CSTOPB bit if it is set is functionally equivalent to jsut
clearing it unconditionally. Drop unnecessary check.

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
 drivers/tty/serial/fsl_lpuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 79922f179b08..a0f38d7caa76 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1655,8 +1655,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
 
-	if (termios->c_cflag & CSTOPB)
-		termios->c_cflag &= ~CSTOPB;
+	termios->c_cflag &= ~CSTOPB;
 
 	/* parity must be enabled when CS7 to match 8-bits format */
 	if ((termios->c_cflag & CSIZE) == CS7)
-- 
2.21.0

