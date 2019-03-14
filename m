Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61C3218A3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/tr6J2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfCNNR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:17:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34356 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfCNNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:17:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id l5so4795247lje.1;
        Thu, 14 Mar 2019 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7jFaqzBkBgJOqqcmYk+H8RgQmMqHirtHzXa3rG7ILY=;
        b=E/tr6J2xgdxNI4dV5BJmLthQudBaXiXEIzVOJgdw1bJ34gPE1jYJFPnEzmiuioZapi
         XqhLSGwAlvxza3sT+1+NRzwtM/UgjG0KfFWPZcwI3bR9l7+4WlGQft4xO3LC3xd54Ipt
         c6ydk5F64I7TVsKZ79QjRwWjlnNzfFfXyXD5aBSDCcYo0CKFobdNJUmwEkRXmnkUWISs
         F7d0eRWtdUQxl5s1vzTCtS7YOMu/Ey1ryQaFhzgY783DAtq8Fsa05hm8Vjrn2dcgvIYQ
         SKGzE3Chfm3P2YTuwZa5GW0a1GoYECYrY/RcjLZujxSGeYrHCIhiL2XmqD+jOs14LBAW
         rj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7jFaqzBkBgJOqqcmYk+H8RgQmMqHirtHzXa3rG7ILY=;
        b=PrlWSnEoMRcAK7KC+GzLapLp25KzIRsJVmoIEvvUUT1NXQDD89cWqvqz7XPSEkF9GG
         t/usv7OoBF9g/nDaQOLZHYp/1VrAJaG24M+vfrcYvd/46edU9qh+J29DKPeS0mD9634w
         G+HbTT1chh9yH/NStlaW9JqWS8XISH4QbQY7XS5aJlKrKDQaFlLTTluoVJdFstqQ4lg5
         jVBaZli9OyYh/ihPL5+KpkYkWPdDrjkY9Kq+2xOhTyEBXsBsXYVIwTnq1Ecv08oWNsYP
         bNW85aUyPfsBYCXUKW9d6D2lPfMyeXbMrt9znqD/3kboTKE1piDShyc8CJezI8+ukuYf
         S/vw==
X-Gm-Message-State: APjAAAXov+D6RBes7d41Uff1yq8M2weFJ+GlIy5Rwh7CTnF3/+7Xp4qr
        dlgvXQQ/eKGYSyuA39z4llNZRvKJ
X-Google-Smtp-Source: APXvYqxeuPnTRROXqIz8/xnaTcRk2dQyBypVKc+uk7fZ4IN3js4PpNLviHAx55KF4TrDPKfCL9jc4A==
X-Received: by 2002:a2e:425b:: with SMTP id p88mr25332270lja.78.1552569475936;
        Thu, 14 Mar 2019 06:17:55 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id y63sm2733082lfd.58.2019.03.14.06.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Mar 2019 06:17:55 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        davem@davemloft.net
Cc:     andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [Xen-devel][PATCH] xen/netfront: Remove unneeded .resume callback
Date:   Thu, 14 Mar 2019 15:17:49 +0200
Message-Id: <20190314131749.25706-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Currently on driver resume we remove all the network queues and
destroy shared Tx/Rx rings leaving the driver in its current state
and never signaling the backend of this frontend's state change.
This leads to the number of consequences:
- when frontend withdraws granted references to the rings etc. it cannot
  be cleanly done as the backend still holds those (it was not told to
  free the resources)
- it is not possible to resume driver operation as all the communication
  means with the backned were destroyed by the frontend, thus
  making the frontend appear to the guest OS as functional, but
  not really.

Fix this by not destroying communication channels/rings on driver
resume.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/net/xen-netfront.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index c914c24f880b..2ca162048da4 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1422,22 +1422,6 @@ static void xennet_disconnect_backend(struct netfront_info *info)
 	}
 }
 
-/**
- * We are reconnecting to the backend, due to a suspend/resume, or a backend
- * driver restart.  We tear down our netif structure and recreate it, but
- * leave the device-layer structures intact so that this is transparent to the
- * rest of the kernel.
- */
-static int netfront_resume(struct xenbus_device *dev)
-{
-	struct netfront_info *info = dev_get_drvdata(&dev->dev);
-
-	dev_dbg(&dev->dev, "%s\n", dev->nodename);
-
-	xennet_disconnect_backend(info);
-	return 0;
-}
-
 static int xen_net_read_mac(struct xenbus_device *dev, u8 mac[])
 {
 	char *s, *e, *macstr;
@@ -2185,7 +2169,6 @@ static struct xenbus_driver netfront_driver = {
 	.ids = netfront_ids,
 	.probe = netfront_probe,
 	.remove = xennet_remove,
-	.resume = netfront_resume,
 	.otherend_changed = netback_changed,
 };
 
-- 
2.21.0

