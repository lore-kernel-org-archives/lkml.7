Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA61C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE67020645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0jSuOww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDWHiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:38:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35955 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWHiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:38:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so7034200pfn.3;
        Tue, 23 Apr 2019 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RxFYCJET9zHUcOpjZ9bK7uMOuTUHPRpqiuEPuAi6Gtw=;
        b=Z0jSuOwwX6CFicJKldwZoTo3ZmYf1Xq5y9XX+JTNi1/r0ynpw2oqhP9K2VKQjxJz+p
         GbBOSoCne+u1WRAw2ID3l48V26UcB4jIJ1j6qBo4cqSwNExQfI4u3q7wBqay8lCxWm+4
         Ui8fxxAMs+GW4OdS7YGM5exYAwczGQzOFo83iSURpe+bqWvtmRN1jhC9y9ZgrJoqQxJy
         RCm9EGGpSrkz0JVM5+5oCu/BqmrIC25WByjyCo/Vb9HBaE1RI6junCh4M2DpLvPUd/Km
         VKi6LDJBUfLFOpQhufhVJ843f1vMIHFcZVBZByRRE2cOSXIYr41V/s5DNeAjAJyHx8xl
         5JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RxFYCJET9zHUcOpjZ9bK7uMOuTUHPRpqiuEPuAi6Gtw=;
        b=SRUNUTLHGcjVq6Cw7Sy0VEoIG6n59DuOD8ptKrkCylj/KcRbUhnxQw6Uqn2qdcYDRI
         NJUYeW349pia8B5vYHhARVb0+gvPgNs9IOH6CWBWJ5L7LuLl4WaPiNX8l/dv6rkhATSK
         R7/IyXmF7ypzYB3Viin7M1RVcR83V2mlacbxhLAcoJH/3r9AcFtRzD9n0ires4qT4h/V
         dQxRBukzMR2gskfEyIyqvRL1OrvQWkjWtplv1X1+mVIU98/wuJlf6vOupI17HtKv+Dxz
         7o/qZgWsOIdKZx2XvrmmBqbeO2PbZIbA48jifaK6CBcqKTH8hS1eAcVO2IBKXdl90SSz
         qL1A==
X-Gm-Message-State: APjAAAXsH5byiq9NiMk7V3NOWkdUGZvs6f6Hn/8DVeDU9/tYtpLmJsrt
        En7OAZTR7kBoyIPeRlBpFH949oGALUM=
X-Google-Smtp-Source: APXvYqxnz3kkhBSsB7V7qIRsA9Pk5nBHcRVpjVStC9T1ow+buVdCOiyRAH3sROKewjUe6EITFOZfVw==
X-Received: by 2002:a62:4d43:: with SMTP id a64mr25026195pfb.174.1556005085025;
        Tue, 23 Apr 2019 00:38:05 -0700 (PDT)
Received: from localhost.localdomain ([219.91.196.67])
        by smtp.googlemail.com with ESMTPSA id o81sm26360447pfa.156.2019.04.23.00.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 00:38:04 -0700 (PDT)
From:   Raag Jadav <raagjadav@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH] i2c: at91: handle TXRDY interrupt spam
Date:   Tue, 23 Apr 2019 13:06:48 +0530
Message-Id: <1556005008-6318-1-git-send-email-raagjadav@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Performing i2c write operation while SDA or SCL line is held
or grounded by slave device, we go into infinite at91_twi_write_next_byte
loop with TXRDY interrupt spam.

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
---
 drivers/i2c/busses/i2c-at91.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 3f3e8b3..b2f5fdb 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -72,6 +72,7 @@
 #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
 #define	AT91_TWI_RXRDY		BIT(1)	/* Receive Holding Register Ready */
 #define	AT91_TWI_TXRDY		BIT(2)	/* Transmit Holding Register Ready */
+#define	AT91_TWI_SVREAD		BIT(3)	/* Slave Read */
 #define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
 #define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
 #define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
@@ -571,7 +572,10 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
 		at91_disable_twi_interrupts(dev);
 		complete(&dev->cmd_complete);
 	} else if (irqstatus & AT91_TWI_TXRDY) {
-		at91_twi_write_next_byte(dev);
+		if ((status & AT91_TWI_SVREAD) && (dev->buf_len == 0))
+			at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_TXRDY);
+		else
+			at91_twi_write_next_byte(dev);
 	}
 
 	/* catch error flags */
-- 
2.7.4

