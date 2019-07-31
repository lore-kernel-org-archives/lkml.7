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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24284C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEFD20679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sspsKgwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfGaRb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:31:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43366 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbfGaRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:31:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id r22so4780751pgk.10;
        Wed, 31 Jul 2019 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhB9UAG5LMtMLqhbRAHpprtUUF9g0FbRQZwyKChRHE0=;
        b=sspsKgwFal2uExFBhgXxBFvRjoB+WDPkx1FG0rSvsEdDK5Rliw9/UzF3m7o0H3VMCS
         1YfcmrET8yBiWOcIYA+7wHdIuh5LIS0rA596H218tEhOh6hBjbwoyEpkFN1Eb2p0FmgB
         PpOs9Jh3oKyHaXRFLkZV/MuhXxoZOeY/IyOjwWAwp+m5GQ0UkODWzcl8RWyHblgPKKow
         LrPV4h53cx5pbgb5a4LGMnj+HK9ncWYG+egtngV1FZGf2gS+S4nXixdZoZIPh+nsXBjp
         +3z9BarI7J8HtMvAldlUvEhpyUdlMH25e1JI4JFQRmaf2vfQpQhhlvU0MO0BSQ+LgORI
         UaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhB9UAG5LMtMLqhbRAHpprtUUF9g0FbRQZwyKChRHE0=;
        b=QWV+H1B+LqbuF8Pz/B5dhGmKQfLzkdQKIz/iLSa1vEAobTKqCMOXig/XwYBqZp5req
         sAmTrd5Nw8OoCv0AC/RRj2bhSqh7HLBvw2p/OkfJ9kO/oH3B59WZ1RBUzQd+JIn1sT/L
         aHpBU60JiVlw+pRnhS9lJWmXvK03fJL3GvGMLrmze3mZWuNAnf1UDZIIuzEf+ywhti14
         VE0YbDHRRhAILc2WyPiIpiYWNF8Kn7DoIsAe6XbcqsrU4/z7vDZUlWrNnx95ZMiKSXz7
         kzfjLY8ThUqyNiYzW3ia5+g8rslShbprkh95wbhavGwMUWrsD8eK9re+h0+pnnE2MsM/
         EZ3w==
X-Gm-Message-State: APjAAAVcpRs/wh33W2kj/pWnobwZ6gnJ3gtcoMycnTjSRlQEA09EAOL2
        mG/m1/ASxye/+DTQ8qH+soPrU8V/0j0=
X-Google-Smtp-Source: APXvYqz7+8ET85JyzRDp1tTVzbWdhqfjjg6PGO7ExrrB3Zx+ix2xk7E12eGgg2zK8N3R9naosOfAKg==
X-Received: by 2002:a62:770e:: with SMTP id s14mr46992799pfc.150.1564594285671;
        Wed, 31 Jul 2019 10:31:25 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id bo20sm2089617pjb.23.2019.07.31.10.31.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:31:25 -0700 (PDT)
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
Subject: [PATCH v2 09/23] tty: serial: fsl_lpuart: Drop no-op bit opearation
Date:   Wed, 31 Jul 2019 10:30:31 -0700
Message-Id: <20190731173045.11718-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for termios->c_cflag & CRTSCTS ensure that if we reach else
branch, CRTSCTS in termios->c_cflag is already going to be
cleard. Doing so explicitly there is not necessary. Drop it.

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
 drivers/tty/serial/fsl_lpuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ed6d3f836c93..b3cc44548b34 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1650,12 +1650,10 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (sport->port.rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
-	if (termios->c_cflag & CRTSCTS) {
+	if (termios->c_cflag & CRTSCTS)
 		modem |= (UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
-	} else {
-		termios->c_cflag &= ~CRTSCTS;
+	else
 		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
-	}
 
 	if (termios->c_cflag & CSTOPB)
 		termios->c_cflag &= ~CSTOPB;
-- 
2.21.0

