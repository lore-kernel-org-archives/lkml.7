Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC29C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C4B206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDtklBSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfK0OQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:16:40 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45045 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK0OQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:16:39 -0500
Received: by mail-yb1-f196.google.com with SMTP id g38so9011269ybe.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 06:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CIUhEj1Cxl4mcTC+Hh8o1BVtvNMRQEU53pMe4Z0u5xw=;
        b=xDtklBSxpXCXUM/P4qgJEGo3w98bIz5pGXMkP4B03I3H/9KfBbAJot0wUh1KdzxTEN
         pxE2oHI6osm1ZQkG3bPbbTLiV8Dew0dg7nLKmFZedMyPR8W3OUTFCW4GvqBpDvKbuDF5
         olDE3NFrHm5QpDmOukxyOtmFiGgbRLISKz55cjBh7Njwpj3FQV7LLszpqklMpLAGKWMy
         1aArrg6nk/8ND6Ez/LJVOk0HeT+4WE8+lyEMkau4yyuebdZvL/sjiayLmqLU4R01ViXa
         Leq11dQX1KZdC6zEOAz5V3J8i5ZJpYRHbSFaz+RuzGe3wMwKTCrMn+qvkh8g4lXIH+MF
         HJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CIUhEj1Cxl4mcTC+Hh8o1BVtvNMRQEU53pMe4Z0u5xw=;
        b=c65r56LbYD4x/15ruerka6zwjTwku4LWYnmRKkzCv37KlVXbLISDH/KmPiioUdFX82
         VgqYm9FG8BhgppA3BPvOkj15JPf/jF4AFwtDFI2ruyWIu7oCdtz8Rb/tP0nE2NCr4fxT
         a5dMumN5VJTRfFPrOBU74kms5sEX0APeyRQjffUMJ+J64jBaau0Ln+T8NAYVjEOb3Dpr
         d3G4zaSmLQx0VDGWyF+h/HXBIjoUS60+a1CZFnahzZMgMv+kOh8yPR5+UC/+FfdnXyQ9
         38Sea9aBhgNXw89K/n/boY0MncXL8BqzNFIL2rVasJCMZ8HZimo0coLVcBA4EcIykuqF
         dkWQ==
X-Gm-Message-State: APjAAAUegaQ0gRc7kqfA0usOUbQg5SUNzZ+395P4jrtJYc2ovl2XSRUc
        Obxk9dh4sdSV5hsp7QL0cuNLQw==
X-Google-Smtp-Source: APXvYqzV12QvZsI3IM6caMeNz86H7K6ekm0izdoiqgIR4aCw110NrINyWls24m1l8P/VpKOPbObEKg==
X-Received: by 2002:a25:908d:: with SMTP id t13mr31248482ybl.265.1574864198588;
        Wed, 27 Nov 2019 06:16:38 -0800 (PST)
Received: from localhost.localdomain (li2093-158.members.linode.com. [172.105.159.158])
        by smtp.gmail.com with ESMTPSA id u123sm6911115ywd.105.2019.11.27.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 06:16:38 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/2] tty: serial: msm_serial: Fix lockup for sysrq and oops
Date:   Wed, 27 Nov 2019 22:15:43 +0800
Message-Id: <20191127141544.4277-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127141544.4277-1-leo.yan@linaro.org>
References: <20191127141544.4277-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the commit 677fe555cbfb ("serial: imx: Fix recursive locking bug")
has mentioned the uart driver might cause recursive locking between
normal printing and the kernel debugging facilities (e.g. sysrq and
oops).  In the commit it gave out suggestion for fixing recursive
locking issue: "The solution is to avoid locking in the sysrq case
and trylock in the oops_in_progress case."

This patch follows the suggestion (also used the exactly same code with
other serial drivers, e.g. amba-pl011.c) to fix the recursive locking
issue, this can avoid stuck caused by deadlock and print out log for
sysrq and oops.

Fixes: 04896a77a97b ("msm_serial: serial driver for MSM7K onboard serial peripheral.")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 3657a24913fc..889538182e83 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1576,6 +1576,7 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 	int num_newlines = 0;
 	bool replaced = false;
 	void __iomem *tf;
+	int locked = 1;
 
 	if (is_uartdm)
 		tf = port->membase + UARTDM_TF;
@@ -1588,7 +1589,13 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 			num_newlines++;
 	count += num_newlines;
 
-	spin_lock(&port->lock);
+	if (port->sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock(&port->lock);
+	else
+		spin_lock(&port->lock);
+
 	if (is_uartdm)
 		msm_reset_dm_count(port, count);
 
@@ -1624,7 +1631,9 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 		iowrite32_rep(tf, buf, 1);
 		i += num_chars;
 	}
-	spin_unlock(&port->lock);
+
+	if (locked)
+		spin_unlock(&port->lock);
 }
 
 static void msm_console_write(struct console *co, const char *s,
-- 
2.17.1

