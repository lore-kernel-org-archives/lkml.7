Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F40C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320A7204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+VcYzBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404191AbfG2T6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:58:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40346 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403987AbfG2TxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so28546196pfp.7;
        Mon, 29 Jul 2019 12:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UTe5mPM7f1pV9orkaVJAo8Cd7JN3aBjfBjN0gqFIAzs=;
        b=Q+VcYzBBoYzym9F4Y3YKDTnTyuiEMCxSJJT7W4d89Ynbb4KF/cNM+NCYRpl3r/6ElT
         f8Kw/QPxLSNWLSBKqVNEkrmnFW/4YA4N0OiLyq4fHXWs0e3YgSwh0Yl2srC7exH7yZxU
         OC//f24FWusvnHXAwiPtpmfGttgxFyhKJ73eBADItiey5769PUNVztGuX9kViFU7Ig0t
         C7PGBL/Tv26vEI9roGipcAPm1QrrwMxnUQZFb4i1yXpX7utXXpvbEYBQVaqdc8B8Y+zM
         9XzRimKtsN1RSxq78TLCVxqWvNVAuTxVxuYA7PxkF2jWzG45Nix2CuR6jjuUlsP0JGlY
         OZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTe5mPM7f1pV9orkaVJAo8Cd7JN3aBjfBjN0gqFIAzs=;
        b=cWscGmZJbxWdX19sKwz92Ywrkcpol2rR0mpEUatPI7R4ENM03r/pgcAWxbBcKIxgLh
         r8+td8phnmc2Un2ROfCDLoC3H0OmYp9GI03XreS55Q7vCY0eRrCeVwC3CqnHdIVwXJIT
         PDNmxVtqxBqBLZXrmvEIwbheaemXcfRIivjXqUUa4V3cENsFjBJnwZ0F8YsvAa5lfyyA
         1GBg3L4/DjyKZP5KbKYUQV+xW1VusgHmdBDw/silDc+JhaU0m46i9lTxJn4kTI8D72xH
         D6MrhJcHEPj4X4oyO7w3JQ6qJLNkJtiQRa0c5FZC3e1U9/l6ml0vBS8Ci0G0koXhxCTX
         yvGA==
X-Gm-Message-State: APjAAAXXOf2RmOZrTFOk3aePkU5Namy/UKguCRRCEznEdLRBbCzpUjXK
        uUqV3jfffbkuBUPhQM5NC1lztJ/L
X-Google-Smtp-Source: APXvYqymB4e0aI9pTVQhe+ehzNIfwM6rBdmBxZIDSFHt46QlEQYwLO0MYZD1TGtbghV6cb5exO+6WQ==
X-Received: by 2002:a17:90a:2247:: with SMTP id c65mr109572871pje.24.1564429998279;
        Mon, 29 Jul 2019 12:53:18 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:17 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/24] tty: serial: fsl_lpuart: Don't enable TIE in .startup() or .resume()
Date:   Mon, 29 Jul 2019 12:52:25 -0700
Message-Id: <20190729195226.8862-24-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
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
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
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
index 9643d4524e59..53b98065f9c5 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1409,7 +1409,7 @@ static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 	lpuart_setup_watermark(sport);
 
 	cr2 = readb(sport->port.membase + UARTCR2);
-	cr2 |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
+	cr2 |= UARTCR2_RIE | UARTCR2_RE | UARTCR2_TE;
 	writeb(cr2, sport->port.membase + UARTCR2);
 }
 
-- 
2.21.0

