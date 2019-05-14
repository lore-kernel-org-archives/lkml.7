Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50B7C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B214B2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv6VK2nF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfENKOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:14:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32941 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfENKOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:14:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so11194176ljw.0;
        Tue, 14 May 2019 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4EmGOKmnVBQqEED+58Lv287Y6Xqzhezr5xh4jatbgao=;
        b=Jv6VK2nFKFlbU+7D4+/OCW3P1X3F3eEqeF1KKbSA3bfOwuqXSLrnmLrL6Br+OCDBy3
         +3SIqsEkYbaqU7m7gInXOiTh4bvi7LrLieyOyZ5qaCc2TLa3YpexyxSnoXrVnFk/jt97
         sy0+nEZvXRLP5a9WiyiZuOMDVz/X9BSizW8/2l2wy57uxU3X1ZWcm0TYiUEJLbyA4Obj
         UEI0O7nfVc0CZn7tgrk3GjI5CuME00as7poeCfic9/FaZgHWnVPD9dh0vhrk2j55oUxg
         8Fm5lDOdMDAAtbr60gRlaA5GRaNY066BoY6s+q5mwN1CjjgGehQb/bBH0BtaLV3xQGve
         kPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4EmGOKmnVBQqEED+58Lv287Y6Xqzhezr5xh4jatbgao=;
        b=XJtQpTTCIr5376Yce2cOhYmL/Cv86/Nq986Vx41d3m+TA7TPpoIb9nRrYvHaiFW22R
         jPEQ0f/4A1Csdtzixur7NwS3MHo6/zPYfwL4fqLNR2NtGzIB81xITj7lMsp25+Tcuude
         ocJTKuSHiShmx/oETCTnOpZ46ErDEVv2ArJBM1PNudqQhzoo0P3/QGelchlD3EDBGbsT
         TiQ70u0TACryObuBORptdAOW+rt1Ual/86JzWYHYAGu5msefsAXPjq8T6qXjEVbz55s0
         BV2DEeb514OahZGybRXv0BmUQu+QI2iITWNBqte9L8U1jN51CwLx1U67OCr7TEZpACGz
         aE1Q==
X-Gm-Message-State: APjAAAW2piT8kJ6xGGx8ngR8O54RTuJYcT8wF9X1qP10qkBmCu5m3MVM
        i2LWgemGVVDMm+NUjlCfob3236s5
X-Google-Smtp-Source: APXvYqyzwPCnnIzDdET1+EP3ChHDwT2Ej7H9sHsxFWGJgKtMako0u2QZUzQ+WN5Gcv3UkcIg3904fg==
X-Received: by 2002:a2e:5852:: with SMTP id x18mr4301689ljd.81.1557828870971;
        Tue, 14 May 2019 03:14:30 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id v2sm3126359ljg.6.2019.05.14.03.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:14:30 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] tty: max310x: Simplify tx-work item code
Date:   Tue, 14 May 2019 13:14:09 +0300
Message-Id: <20190514101415.26754-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since cmwq introduction in the kernel, workqueues've been turned into
non-reentrant execution contexts [1]. It means any work item is
guaranteed to be executed by at most one worker system-wide at any
given time. Since tx-handler max310x_handle_tx() is called by a
single work item we don't need it to be self-protected by the mutex.
We also don't need to check the tx work item pending state before
scheduling it (which in the first place was racy btw), since cmwq will
make sure to reschedule the item if it wasn't pending at the moment of
schedule_work() call.

[1] Documentation/core-api/workqueue.rst

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 450ba6d7996c..4ee805862b68 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -263,7 +263,6 @@ struct max310x_one {
 struct max310x_port {
 	struct max310x_devtype	*devtype;
 	struct regmap		*regmap;
-	struct mutex		mutex;
 	struct clk		*clk;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gpio;
@@ -768,8 +767,7 @@ static void max310x_start_tx(struct uart_port *port)
 {
 	struct max310x_one *one = container_of(port, struct max310x_one, port);
 
-	if (!work_pending(&one->tx_work))
-		schedule_work(&one->tx_work);
+	schedule_work(&one->tx_work);
 }
 
 static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
@@ -826,14 +824,11 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
-static void max310x_wq_proc(struct work_struct *ws)
+static void max310x_tx_proc(struct work_struct *ws)
 {
 	struct max310x_one *one = container_of(ws, struct max310x_one, tx_work);
-	struct max310x_port *s = dev_get_drvdata(one->port.dev);
 
-	mutex_lock(&s->mutex);
 	max310x_handle_tx(&one->port);
-	mutex_unlock(&s->mutex);
 }
 
 static unsigned int max310x_tx_empty(struct uart_port *port)
@@ -1269,8 +1264,6 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
 	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
 
-	mutex_init(&s->mutex);
-
 	for (i = 0; i < devtype->nr; i++) {
 		unsigned int line;
 
@@ -1298,7 +1291,7 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		/* Clear IRQ status register */
 		max310x_port_read(&s->p[i].port, MAX310X_IRQSTS_REG);
 		/* Initialize queue for start TX */
-		INIT_WORK(&s->p[i].tx_work, max310x_wq_proc);
+		INIT_WORK(&s->p[i].tx_work, max310x_tx_proc);
 		/* Initialize queue for changing LOOPBACK mode */
 		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Initialize queue for changing RS485 mode */
@@ -1350,8 +1343,6 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		}
 	}
 
-	mutex_destroy(&s->mutex);
-
 out_clk:
 	clk_disable_unprepare(s->clk);
 
@@ -1372,7 +1363,6 @@ static int max310x_remove(struct device *dev)
 		s->devtype->power(&s->p[i].port, 0);
 	}
 
-	mutex_destroy(&s->mutex);
 	clk_disable_unprepare(s->clk);
 
 	return 0;
-- 
2.21.0

