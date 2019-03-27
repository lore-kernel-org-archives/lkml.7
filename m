Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD91C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B482075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyxOplVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbfC0A2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:28:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39583 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731159AbfC0A2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:28:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id b65so2421156plb.6;
        Tue, 26 Mar 2019 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tpIB+F+Vle8Et2/WM3Vp1dIY6yPIYpBRV58j0zhNAFE=;
        b=qyxOplVVxk8U2Bfe+NIfqO4xRcSkf706u79Gf5Do0zjC+ICfTzsYgitDDrq74B2IIE
         vpYOdx/10PxQgq5xzm/12B7n2IcGZAGIlQ0JqQeFBuz4r6/LbjPjNXKpg8BRNizkG3Nc
         TvQyGzpQEwVuQ3JhSez2KgMSPlYo0ggpEprO+5djqVdAujAlIpUX8SgiT/JD4o5xVtrn
         eO0IMw4KwdzRlkTHPJEp0gfMzYqYG22+Faa+WwZwA1DM8gL9oS6Oo4aoi4xrHRe1Eezu
         FtPe5gdkwviydFaWq2fvuqdVe3IEBjlpOK9vTcP/1dbRZhuUWhOwb08aQ0LN72ZxGQ49
         u6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tpIB+F+Vle8Et2/WM3Vp1dIY6yPIYpBRV58j0zhNAFE=;
        b=Bt3guoQz412Eruszhv8S7+qJMDxproLbgqhg+MVVUzbmnM9ImFyov9G0tKF+v5aI1m
         wU7JpdCwNyLnKsi0Tu0IabJGcUaLQWxHQHRndyjMEot7tB3fMpZwLpGZW/XmfnU1Yuqj
         UUtl6/k9tRDUpHH28B/5MmDY9eamv0kqYYI6+0nzI/r4f6/gDgYa2C5pcAVJYuXVCdW9
         oYDwmZcb/emFoAF3/ep2OLs++yYvGZ7rZz/F74GKwsIypTtGCPiZ5IydYlS8P213Dotk
         oRw6WkYF62AOuesmNcxOa4Zeo861QyZgQA5UiXhOcpV8VBmDqNG9yoD83tJw2mGUYON2
         zlBQ==
X-Gm-Message-State: APjAAAVeoYpOkohXN0Oa1DJl1g623bgluBGdQC3gSDTZVEpvcy0GFjYd
        TJLAdDQfub1EZup0cHrZlH4Pp1GQ
X-Google-Smtp-Source: APXvYqwWZLYaA7ylQCqc3UJ7vS7e9oVQPPdPDBhPNAV6z0L2orV4WpDrGqn1608+Q0lWzTj+KceEVQ==
X-Received: by 2002:a17:902:b788:: with SMTP id e8mr23739594pls.339.1553646483184;
        Tue, 26 Mar 2019 17:28:03 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l7sm64927023pfj.162.2019.03.26.17.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 17:28:02 -0700 (PDT)
Date:   Tue, 26 Mar 2019 17:28:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Shaunak Saha <shaunak.saha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: i8042 - signal wakeup from atkbd/psmouse
Message-ID: <20190327002800.GA187083@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of signalling wakeup directly from i8042, let psmouse and atkbd
drivers execute basic protocol handling and only then signal wakeup
condition. This solves the issue where we increment wakeup counter
simply because we are getting responses from keyboard/mouse to the
commands we ourselves send to them as part of suspend transition.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/atkbd.c     | 2 ++
 drivers/input/mouse/psmouse-base.c | 2 ++
 drivers/input/serio/i8042.c        | 3 ---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 850bb259c20e..3ad93e3e2f4c 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -401,6 +401,8 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 		if  (ps2_handle_response(&atkbd->ps2dev, data))
 			goto out;
 
+	pm_wakeup_event(&serio->dev, 0);
+
 	if (!atkbd->enabled)
 		goto out;
 
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index d3ff1fc09af7..94f7ca5ad077 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -373,6 +373,8 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 		if  (ps2_handle_response(&psmouse->ps2dev, data))
 			goto out;
 
+	pm_wakeup_event(&serio->dev, 0);
+
 	if (psmouse->state <= PSMOUSE_RESYNCING)
 		goto out;
 
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 95a78ccbd847..6462f1798fbb 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -573,9 +573,6 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	port = &i8042_ports[port_no];
 	serio = port->exists ? port->serio : NULL;
 
-	if (irq && serio)
-		pm_wakeup_event(&serio->dev, 0);
-
 	filter_dbg(port->driver_bound, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
 		   port_no, irq,
 		   dfl & SERIO_PARITY ? ", bad parity" : "",
-- 
2.21.0.392.gf8f6787159e-goog


-- 
Dmitry
