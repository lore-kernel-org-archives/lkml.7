Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4781FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155B121530
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rX5R1krX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfENKPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:15:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43618 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfENKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:14:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id z5so13752839lji.10;
        Tue, 14 May 2019 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9s95PEyKvrKcIxnCrKXPxIhz9gSDtf2oaROGKu+HmG0=;
        b=rX5R1krXwY3mXws0q1xHY/0wi0cgtHA+Xo9Iy7cRRkxMJ9g3nWRX5DkyAT2GlSbY7I
         bhQ4bA8AR/gH8H8i0v2xqi36w8zEAIjWVh2sh4fV333x+ViOAe/QYQkphW3IOkkRxWgo
         w/882SaPwpnh+Xgql748e8K+IvKurUvbvm3k4J4APf7Cj3rChht4eUo70+BYaxedhUs2
         uUry/olMrKWvqTUE4xvQeNYuUc3LFClB/QA+41NaHlKu6EUfJEfyTWI7wlGzZMPPds3D
         gnNHhBtaBIIFPKLcjgoV9n5HSGRbS47/xdT6mKvhco4Y8ZLCfF0aKxvuCn5wBSbhZJcF
         R+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9s95PEyKvrKcIxnCrKXPxIhz9gSDtf2oaROGKu+HmG0=;
        b=PBHFKv4l8uiZoKiAcN6ZrBcL7eHTZVumbfuFEMTD2WGBQmHMwnlxnBBjUSlgbxJlnh
         qkJDVvICdoAISIt+pJyHo4eJoVW4qf9L9h4UULwwHpddzprgpWgE64loNxLgteZ/Jn7q
         iZZ45yndqd1YnX3Mw3RnGhwmye0Kz9AGonX20+iK2P21FPPH3KN+6ZT0PgvvRJlXwTq3
         +sl1H4pYjCiPJ6FCLJW3JA9b1CwYdbt4QVCHhzA1Pky4+k5edtvP2ao2F6bPEWoPnwui
         OEG/JALNHrJ2NsmQUul3IyOlC0y34UPtLZQFfUpy0qw1PxAigFTPgeM3v1GURGrWjSw6
         fi1g==
X-Gm-Message-State: APjAAAXfUe5BTCFaXrDEbsSQCcJu2L/i98tAGoqxJESFUHRIzSKGDVYE
        WZJNhBC4clOUOiRUoikXH1k=
X-Google-Smtp-Source: APXvYqxd+eNICyCIxuMtAN/hcvvAqN3FLgLucqpULtEZsaRT7hhWHPnlnYsmgNRZm6G2yfyiMqK5Jg==
X-Received: by 2002:a2e:8716:: with SMTP id m22mr1091852lji.128.1557828874518;
        Tue, 14 May 2019 03:14:34 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id v2sm3126359ljg.6.2019.05.14.03.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:14:34 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] tty: max310x: Fix invalid baudrate divisors calculator
Date:   Tue, 14 May 2019 13:14:12 +0300
Message-Id: <20190514101415.26754-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current calculator doesn't do it' job quite correct. First of all the
max310x baud-rates generator supports the divisor being less than 16.
In this case the x2/x4 modes can be used to double or quadruple
the reference frequency. But the current baud-rate setter function
just filters all these modes out by the first condition and setups
these modes only if there is a clocks-baud division remainder. The former
doesn't seem right at all, since enabling the x2/x4 modes causes the line
noise tolerance reduction and should be only used as a last resort to
enable a requested too high baud-rate.

Finally the fraction is supposed to be calculated from D = Fref/(c*baud)
formulae, but not from D % 16, which causes the precision loss. So to speak
the current baud-rate calculator code works well only if the baud perfectly
fits to the uart reference input frequency.

Lets fix the calculator by implementing the algo fully compliant with
the fractional baud-rate generator described in the datasheet:
D = Fref / (c*baud), where c={16,8,4} is the x1/x2/x4 rate mode
respectively, Fref - reference input frequency. The divisor fraction is
calculated from the same formulae, but making sure it is found with a
resolution of 0.0625 (four bits).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 51 ++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0e3dc89c459b..ca044f96c5cc 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -501,37 +501,48 @@ static bool max310x_reg_precious(struct device *dev, unsigned int reg)
 
 static int max310x_set_baud(struct uart_port *port, int baud)
 {
-	unsigned int mode = 0, clk = port->uartclk, div = clk / baud;
+	unsigned int mode = 0, div = 0, frac = 0, c = 0, F = 0;
 
-	/* Check for minimal value for divider */
-	if (div < 16)
-		div = 16;
-
-	if (clk % baud && (div / 16) < 0x8000) {
+	/*
+	 * Calculate the integer divisor first. Select a proper mode
+	 * in case if the requested baud is too high for the pre-defined
+	 * clocks frequency.
+	 */
+	div = port->uartclk / baud;
+	if (div < 8) {
+		/* Mode x4 */
+		c = 4;
+		mode = MAX310X_BRGCFG_4XMODE_BIT;
+	} else if (div < 16) {
 		/* Mode x2 */
+		c = 8;
 		mode = MAX310X_BRGCFG_2XMODE_BIT;
-		clk = port->uartclk * 2;
-		div = clk / baud;
-
-		if (clk % baud && (div / 16) < 0x8000) {
-			/* Mode x4 */
-			mode = MAX310X_BRGCFG_4XMODE_BIT;
-			clk = port->uartclk * 4;
-			div = clk / baud;
-		}
+	} else {
+		c = 16;
 	}
 
-	max310x_port_write(port, MAX310X_BRGDIVMSB_REG, (div / 16) >> 8);
-	max310x_port_write(port, MAX310X_BRGDIVLSB_REG, div / 16);
-	max310x_port_write(port, MAX310X_BRGCFG_REG, (div % 16) | mode);
+	/* Calculate the divisor in accordance with the fraction coefficient */
+	div /= c;
+	F = c*baud;
+
+	/* Calculate the baud rate fraction */
+	if (div > 0)
+		frac = (16*(port->uartclk % F)) / F;
+	else
+		div = 1;
+
+	max310x_port_write(port, MAX310X_BRGDIVMSB_REG, div >> 8);
+	max310x_port_write(port, MAX310X_BRGDIVLSB_REG, div);
+	max310x_port_write(port, MAX310X_BRGCFG_REG, frac | mode);
 
-	return DIV_ROUND_CLOSEST(clk, div);
+	/* Return the actual baud rate we just programmed */
+	return (16*port->uartclk) / (c*(16*div + frac));
 }
 
 static int max310x_update_best_err(unsigned long f, long *besterr)
 {
 	/* Use baudrate 115200 for calculate error */
-	long err = f % (115200 * 16);
+	long err = f % (460800 * 16);
 
 	if ((*besterr < 0) || (*besterr > err)) {
 		*besterr = err;
-- 
2.21.0

