Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2655CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 02:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A505215EA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 02:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCBNhza0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfKCCoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 22:44:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42655 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfKCCoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 22:44:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id j12so4137774plt.9;
        Sat, 02 Nov 2019 19:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e5Z79bwYl0OhALgJD5ePQmrk9nW6xClWUVxotkT037U=;
        b=aCBNhza0kG7U87MsMKos/HxtSogbYZk9TpyT8CH8HsJ0IFCLdQp8Qec4wrgel0T3OR
         +rh1GOPjKVp2id+IDpoEqQ31gpKr6GUlMF0qwM3q6xuRRD8BRUZaBCtZyyTUcuPCbFM1
         Ptqf6FD+RSver7yCJgw32C6cx+hP1g6gHxBzi6El0pM9Y1z7lTYytnmgaks14reVjTrv
         gVajmVHjCTI+MhYDBXyZWI/7oC4uiljZ2sKLSsMDTs7lMuB6TGKrEmdsHVkNmlBwRGVE
         7lRqJnR6Mi4I2Zj3B/S8UpxNLCKcg1D8nM7kwTWV8IdRjU8Ho5TlLQi715jV5zWGFwmx
         tm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e5Z79bwYl0OhALgJD5ePQmrk9nW6xClWUVxotkT037U=;
        b=cCntHUflfPQKVtwDrepsg0p2UDd4nU7F5nG2XG0i4xR6dqmb2L/5N/z8tqDW6d60fM
         iydjhuv2QtxXuoF0+xMgBwLsNBQjNV8s1BKNpuMExKg2EKYKxcPHpDv/EiDVTkAMYN8y
         1+mXglpg9G6BUhN42AmtcNH9LQ/MBcPxKcFmo2nrYoGsTtaZk5OxOLpG3UWpMs14AYzH
         AR+hUZWHMpLE1oI7el9KpnjbUhD1vkdUuLjqqz9XALpwnKckn228qbrLxDrsNe+lpGya
         5neNqLo7C41miDVCv8RBLVAewUyvMHOgNv7MmKGcmZLHJHgml1/J6YBYCrHO0AWd9DVa
         6Cbw==
X-Gm-Message-State: APjAAAXsuFRsmwJmA1/nH0cZ8i6/pudbgt7J9FfzfdFlSi94+8I8m2FR
        kxca6t3+objkS04rde3+j20=
X-Google-Smtp-Source: APXvYqy6iaiQ6Gm1bFyoiXKI5GTQ+7BxJEADa3XE0Ms5zjWC8G6Cv+DLYzZ33cd1fu0H1z3SQTyjfw==
X-Received: by 2002:a17:902:7089:: with SMTP id z9mr20029115plk.51.1572749052350;
        Sat, 02 Nov 2019 19:44:12 -0700 (PDT)
Received: from ubuntu.localdomain ([118.193.245.26])
        by smtp.gmail.com with ESMTPSA id o191sm9090143pfg.64.2019.11.02.19.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Nov 2019 19:44:11 -0700 (PDT)
From:   hui yang <yanghui.def@gmail.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, mirq-linux@rere.qmqm.pl,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        YangHui <yanghui.def@gmail.com>
Subject: [PATCH 2/2] USB(u_serial.c): it has a NULL point
Date:   Sun,  3 Nov 2019 10:44:04 +0800
Message-Id: <1572749044-6091-1-git-send-email-yanghui.def@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YangHui <yanghui.def@gmail.com>

Unable to handle kernel NULL pointer dereference at virtual address 000002a0
Kernel BUG at tty_wakeup+0x18/0x8c
[<0000000095135e9d>] tty_wakeup+0x18/0x8c
[<00000000c35f19e4>] gs_start_io+0xc8/0x158
[<00000000b11b184e>] gserial_connect+0xd0/0x174
[<00000000642201de>] acm_set_alt+0x70/0x180
[<00000000a9d38e8b>] composite_setup+0x1848/0x1a7c
[<0000000072c88781>] android_setup+0x1ec/0x1f4
[<000000004c0127a5>] msm_udc_irq+0x8d0/0xc0c
[<00000000f8bb9acf>] __handle_irq_event_percpu+0x74/0x294
[<00000000afd57256>] handle_irq_event+0x60/0xc8
[<0000000076719b24>] handle_fasteoi_irq+0xc8/0x1c4
[<00000000421f3d87>] generic_handle_irq+0x34/0x4c
[<00000000b2f2d343>] __handle_domain_irq+0x6c/0xbc
[<00000000c74325e8>] gic_handle_irq+0x6c/0xe0
yes,we can see the port->port.tty==NULL, so system crashed

Signed-off-by: YangHui <yanghui.def@gmail.com>
---
 drivers/usb/gadget/function/u_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 65f634e..a1c2ac2 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -562,6 +562,8 @@ static int gs_start_io(struct gs_port *port)
 
 	/* unblock any pending writes into our circular buffer */
 	if (started) {
+		if (port->port.tty == NULL)
+			return -EIO;
 		tty_wakeup(port->port.tty);
 	} else {
 		gs_free_requests(ep, head, &port->read_allocated);
-- 
2.7.4

