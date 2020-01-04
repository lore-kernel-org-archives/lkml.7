Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38344C32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 20:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1042124654
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 20:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzvNX5+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgADUXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 15:23:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41792 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgADUXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 15:23:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so24960058pgk.8;
        Sat, 04 Jan 2020 12:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ak1ZP2tAeQ2Y7PwIriFfKv0Dvf8KKmq9+RENIFVGY1w=;
        b=hzvNX5+d5/anUwiewELIOCTAcVqVIVLnxoSL1b8FFQviE+oxyRLxqHSR0FD0Y3ZewQ
         MzY44YYmxLRErJ/0Is12RzfnjMSysRWnbGMVdk2Ea8rk/pFKwFNbHrtHd8+Iq/kDJkbc
         BA/spVGI3YNI25ZTgKkCvLx6QBeTpjBJTTIDih2jzavSm+plyihMDSq1gVUXh6OqAH7Y
         CB5hz1Gb42zXLrMKTy3ddpyI+/jc3Rd68pEvrHwpEEtj+mhzZXggHSOrYSNHu5szr4pj
         Fug7rQtkhUXrlOqVambUZhr9N/MYr1X2Q8rLvTjnaASxIclHm7jvo4EB+9td724mAgw7
         sXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ak1ZP2tAeQ2Y7PwIriFfKv0Dvf8KKmq9+RENIFVGY1w=;
        b=AgWlSoL16RnFxl7ZyKuISvjxx4F+03hDmYN5mmOfWbSnJjYPT+tP4YxrPMkkP7duA1
         TLlAmPstv8Y/W1jtdIRZZR5R4ap5jvlSr1dAZ3/gnw9RB0DDU2mSUZ0XoEaiV3sJxVbu
         3QSe9JY+7StAEOLsstiSPqCDff4EBsTw0IzixXbi9vYPV6ZqHxwjICJ6y4b4V5UIU2ZA
         91pH4rnIL88yoXSu2yDhRI6ZLeL6rRTsBKlUTRPRv2hOjjAy7qj9DuvbNEwYSWNNCg51
         GBX5opYIbGK/ulgwUf99GjyHdAloe5q7xWHGhNklsr7yRNj6M83WUOLziD5OA9vP3NY+
         hO/Q==
X-Gm-Message-State: APjAAAV07FozzVkH7z2q8FviZqFKfwtTCIgdb/PC1a7e/SbSXwX42BgZ
        iqM+x1/Z1HI4Og948IKGkX0=
X-Google-Smtp-Source: APXvYqzVkQYHU5NLlzN2zHDwMxx94FyQUPEadRQUR/l/4WEeZDDkirJIVM31SREzm8dxsp+Hc3SniQ==
X-Received: by 2002:a63:dc0d:: with SMTP id s13mr99709717pgg.129.1578169397182;
        Sat, 04 Jan 2020 12:23:17 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h126sm48756038pfe.19.2020.01.04.12.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 12:23:16 -0800 (PST)
Date:   Sat, 4 Jan 2020 12:23:14 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: st-asc: switch to using devm_gpiod_get()
Message-ID: <20200104202314.GA13591@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node pointer in question is not a child node, but the node assigned
to the port device itself, so we should not be using
devm_fwnode_get_gpiod_from_child() [that is going away], but standard
devm_gpiod_get().

To maintain the previous labeling we use gpiod_set_consumer_name() after
we acquire the GPIO.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/tty/serial/st-asc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index fb6bbb5e22344..e7048515a79ca 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -504,7 +504,6 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
 	struct asc_port *ascport = to_asc_port(port);
-	struct device_node *np = port->dev->of_node;
 	struct gpio_desc *gpiod;
 	unsigned int baud;
 	u32 ctrl_val;
@@ -566,13 +565,12 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 			pinctrl_select_state(ascport->pinctrl,
 					     ascport->states[NO_HW_FLOWCTRL]);
 
-			gpiod = devm_fwnode_get_gpiod_from_child(port->dev,
-								 "rts",
-								 &np->fwnode,
-								 GPIOD_OUT_LOW,
-								 np->name);
-			if (!IS_ERR(gpiod))
+			gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
+			if (!IS_ERR(gpiod)) {
+				gpiod_set_consumer_name(gpiod,
+						port->dev->of_node->name);
 				ascport->rts = gpiod;
+			}
 		}
 	}
 
-- 
2.24.1.735.g03f4e72817-goog


-- 
Dmitry
