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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C31EC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD09C2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esaCnLO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404356AbfG2T7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:59:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36194 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403808AbfG2TxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so27923646plt.3;
        Mon, 29 Jul 2019 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XiIa9lXs8v+pYOtT7URPOSD4VArWS1Smglfft6t1XIg=;
        b=esaCnLO1sT9NJGBg3xQAwvQ26OUBBftQ03MkyOb5d1KiKtZXlji6iRGCYCMv4jQfwg
         CEdGXMSJgfKmnLvN8ZNXuXTBrUCK/lDIUJeGTSsJSzf4fGVnPCh5cHAwwfjsyu2Qa8bp
         es1CDdog/4Ib7Gedb1Uwv2dc1b5KlU/KTKjutfmj1IgF88xky4vU20opwlWaBqzRPuwA
         RTARCivQXv/oEd1sdwq5wRHBf4j/RLFarpZZRzvU65uuG1XeF7zjNS0aD/A8HZW3SjqE
         wSCwYtrAJOO6mYjUcCvKRnOjp2Kngco5q12DLPhZiRSIa9ycO9lIyYyfG5yQV+o2r8hY
         oG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XiIa9lXs8v+pYOtT7URPOSD4VArWS1Smglfft6t1XIg=;
        b=ho+FJcsLVHgnDmYea72xA8iMOiZsanX+zCaidzTjf+tUs0Ey1R1twFaLmhP3aXTGV5
         tiJSg/0LZskas3JKuGkAsQWeqmvT3ceZ3sFz5hv6fnb3PzWU1/xt5rQpL4ycumOjHaly
         HjPVQuuHIFDiWXFnTHgreTzNinbJmIIJGjsm9lVlsrIgczQhxmrdOxcseinu2QbTvgqY
         eVUxy5GnKFcmt7nKrRpT9jZvo7sf7S+3Ochh/HeQdXVwpD1UUGxZcc3x3wvShBV2aIHs
         MoEwOKDqGaILdYR4/V/oH5+v2WCtY60jthtay8bz/LxW3IxsXJx/MXWxijYw1q/MD4nu
         29lA==
X-Gm-Message-State: APjAAAXGbe1+S08BnrLErT7y2OoCK+Rvn7sB5SW59iYKz5Ejgum5tVf0
        zE3G91zhtqjgE6rlpiVTUeu4E4ll
X-Google-Smtp-Source: APXvYqztZGUNuIrsL3tAAmpY9hr8MQkaVsR2ZXjk3dHrsBzizrgnpfjidEzOs61cKmbmbVdK0yiJuA==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr58106268plm.306.1564429982286;
        Mon, 29 Jul 2019 12:53:02 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z12sm43983750pfn.29.2019.07.29.12.53.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:53:01 -0700 (PDT)
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
Subject: [PATCH 12/24] tty: serial: fsl_lpuart: Clear CSTOPB unconditionally
Date:   Mon, 29 Jul 2019 12:52:14 -0700
Message-Id: <20190729195226.8862-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
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
 drivers/tty/serial/fsl_lpuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5a1e19733353..10f1af51c58d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1656,8 +1656,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
 
-	if (termios->c_cflag & CSTOPB)
-		termios->c_cflag &= ~CSTOPB;
+	termios->c_cflag &= ~CSTOPB;
 
 	/* parity must be enabled when CS7 to match 8-bits format */
 	if ((termios->c_cflag & CSIZE) == CS7)
-- 
2.21.0

