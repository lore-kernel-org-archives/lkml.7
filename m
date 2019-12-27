Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D5AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF49C21D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uh9RYnq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfL0Rou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:44:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45146 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbfL0Rol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:44:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so26629014wrj.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 09:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1HXhzt2IyWFOUMdQkirC9Hq8z+cMg4U8grq8VYELPXI=;
        b=uh9RYnq/w/BeVXC/bTMfScw9j1sOr+DwMV/d5YGPZ/2utrxm7lgf46xnt1SfzvQHet
         hEMvyDZdfSoqDbwqAMVnBSZCCUU49UK5mDEaTWCGp5TR+BfUAc62GhO6QCmeODv0RmtJ
         WGbleOTQ72/2GLsbL/rFHzpgXZbOvBIKAggPc45ouC9yuTL1Hs1GhKm77CiFcUohzgR0
         zWMQJW3J9bY0qzNHzN2xLdb+qWIorbmjjRuUmQEVEw172pmRKcrbIqrjBlHcBJk6AtUb
         VUtm+Ha70+EGfoPiCo7fP7r66acjaGPoqi3MklnUuhVmoiKHV6+fIf/Dk+9JyiwytEBM
         bRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1HXhzt2IyWFOUMdQkirC9Hq8z+cMg4U8grq8VYELPXI=;
        b=sQc5aHEl78/+at1UtVQA781PH3rkzi49F/qTb94lITXr43kABQpgUqRDKuy7VYmPnH
         jZWmKW19u94g6Zvev2zXjFdr8D+3Mvb9AUixx4mywWe7HFsN6jHBn+oefBnJ+qzXQL4Y
         5Fyx1k3XajKgzdMZ3CAZCX0m5bSp73g9hUCCxTltDOzzAJ0ytEcMF6EaS/BRrBB3YIEM
         7ZaX4wwk/omQ7RIJQRcWH81umWmvkD6y9HawKfLrLEW/PO/yHFOAEJJt6h+8rPNHrSyg
         S+H/RG5VhFekJBfN6tdTXA57p4YYf+DUPkwTfgWANp0DLHWkjiFmPzUts8TTOuLfdfgj
         zT2g==
X-Gm-Message-State: APjAAAWI7/bBrr28euiz3ku6DYAlVH030TjbcPIetJJ1RI6vnbNJKiOy
        7W/Hb58IxkqoiWrKJXEoYb8=
X-Google-Smtp-Source: APXvYqwAXW3FrwEfV7yJm1iriKeHgMMSG0nbqsOJyZ0BTuHPUZmQvFPqkjoR55qKgghw26BSNuZHAw==
X-Received: by 2002:adf:f581:: with SMTP id f1mr53051373wro.264.1577468680310;
        Fri, 27 Dec 2019 09:44:40 -0800 (PST)
Received: from debian.lan (host-78-144-219-162.as13285.net. [78.144.219.162])
        by smtp.gmail.com with ESMTPSA id c68sm11819819wme.13.2019.12.27.09.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 09:44:39 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] tty: always relink the port
Date:   Fri, 27 Dec 2019 17:44:34 +0000
Message-Id: <20191227174434.12057-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the serial device is disconnected and reconnected, it re-enumerates
properly but does not link it. fwiw, linking means just saving the port
index, so allow it always as there is no harm in saving the same value
again even if it tries to relink with the same port.

Fixes: fb2b90014d78 ("tty: link tty and port before configuring it as console")
Reported-by: Kenneth R. Crudup <kenny@panix.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/tty/tty_port.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 5023c85ebc6e..044c3cbdcfa4 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -89,8 +89,7 @@ void tty_port_link_device(struct tty_port *port,
 {
 	if (WARN_ON(index >= driver->num))
 		return;
-	if (!driver->ports[index])
-		driver->ports[index] = port;
+	driver->ports[index] = port;
 }
 EXPORT_SYMBOL_GPL(tty_port_link_device);
 
-- 
2.11.0

