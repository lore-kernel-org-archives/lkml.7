Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666272147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3ZWQdiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfC0Tkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:40:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39967 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbfC0Tks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:40:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so4369996wre.7;
        Wed, 27 Mar 2019 12:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPbwpoClirOKHHehiHtBNS96jUBaR1AsrRBdZxVLaeM=;
        b=O3ZWQdiLMnUV1MN+OfvTCFhC2/swODUA90toXZSOm/ma7gvbdgl5O2pgistdoFWYTC
         y3IiI6QvCShilr5m0kDelrjJj4KcQIlUjKixM7aUOaIHgY2aVYj/aFc3WasQUEwYuZL2
         pCZ8MNHrOOn70KljwmqLAJaYv38Oi9+VUYj5suJjiXQX69idxlVpbssWdPhCcsN7ELp3
         aDudVhhTu4gmXj1b/yR7oDngs/3P6np3SmViLmiA7P6m4u0T40vKbK1gvMs1YmT6Ob56
         RgxCgwxh+drnZctSWyDWEtE2uaYIqxH1FIoquqsu2X81RA1Pbwi2rcerJc5lIhQxgICi
         HK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aPbwpoClirOKHHehiHtBNS96jUBaR1AsrRBdZxVLaeM=;
        b=PMsLERpgK+g2EZ1sEao8HsSLzKk24KvgDXGEf1mQ9hChbDSTxDArcFTgXI1jRVuRS6
         rlxeFxLZ0F6cvK3xbl5Pl0UMwEK5J3NntST4eAT8HDrDAxzW/6VFbbP1e4oemeH9FOuW
         i0uP5tzjgXd6Wk7oOuUkxQ1WjOiR1V9Ivliui6sNpBoXMY8k+gf8yWFqruqfoASlEZED
         U40sbYhQCoAzu2ud1bgm4oesglf3eMAr4+U4lwOD7usYDZi3nHXjSaftKQ21cZl0rH6d
         8QB+Vb+54hRndKoARcC2HQxuV+wZlJHnz6I7JDFeMXD/A2pkbjcZDaz6vxU3taoWZH7K
         8E0Q==
X-Gm-Message-State: APjAAAUxNCpN6br7VeCEGssveJmUQlHUUUWTBnLdus4WB3sFzq5jeuB4
        YBP7IRCVli7Pa+F+7slyFnMlx7YU
X-Google-Smtp-Source: APXvYqwEnvAjqc8r5XeLXJ2DztXDPhdOuq25Ihb3X99xU2GXk6+osWkMorn7QloCL5AtorYwI3ByGg==
X-Received: by 2002:adf:e889:: with SMTP id d9mr514325wrm.162.1553715646631;
        Wed, 27 Mar 2019 12:40:46 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id a9sm23514364wrt.29.2019.03.27.12.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 12:40:45 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id ABD891143615; Wed, 27 Mar 2019 20:40:44 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] USB: hub: Remove returned value 'status' since never used
Date:   Wed, 27 Mar 2019 20:40:34 +0100
Message-Id: <20190327194035.15972-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326201557.20388-1-malat@debian.org>
References: <20190326201557.20388-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The returned value in status has never been used since
commit 4296c70a5ec3 ("USB/xHCI: Enable USB 3.0 hub remote wakeup.")
So remove 'status' completely.

Remove warning (W=1):

  drivers/usb/core/hub.c:3671:8: warning: variable 'status' set but not used [-Wunused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: change subject prefix from USB/xHCI: to USB: hub:

 drivers/usb/core/hub.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 8d4631c81b9f..15a2934dc29d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3668,7 +3668,6 @@ static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
 	struct usb_hub		*hub = usb_get_intfdata(intf);
 	struct usb_device	*hdev = hub->hdev;
 	unsigned		port1;
-	int			status;
 
 	/*
 	 * Warn if children aren't already suspended.
@@ -3702,12 +3701,12 @@ static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
 	if (hub_is_superspeed(hdev) && hdev->do_remote_wakeup) {
 		/* Enable hub to send remote wakeup for all ports. */
 		for (port1 = 1; port1 <= hdev->maxchild; port1++) {
-			status = set_port_feature(hdev,
-					port1 |
-					USB_PORT_FEAT_REMOTE_WAKE_CONNECT |
-					USB_PORT_FEAT_REMOTE_WAKE_DISCONNECT |
-					USB_PORT_FEAT_REMOTE_WAKE_OVER_CURRENT,
-					USB_PORT_FEAT_REMOTE_WAKE_MASK);
+			set_port_feature(hdev,
+					 port1 |
+					 USB_PORT_FEAT_REMOTE_WAKE_CONNECT |
+					 USB_PORT_FEAT_REMOTE_WAKE_DISCONNECT |
+					 USB_PORT_FEAT_REMOTE_WAKE_OVER_CURRENT,
+					 USB_PORT_FEAT_REMOTE_WAKE_MASK);
 		}
 	}
 
-- 
2.20.1

