Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554D6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B6C23402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495807;
	bh=Qxmb6vn3g3QEs2Y31wCulIpv1Hya/mij5H+crVxaM88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snas3I6Y9awnuKRmp6Snr57VcgYsnkNdLjjXVr/WxAvmU3qUwR3RNPuwMw3//pGb4
	 qJ2PzrmOAmoeysz8QwzSJ+dS0Ld1U/rIGXSj6WEWRjhOzAi5eNQsQDhMzGCQzD/biD
	 8umqQfA9ytSVC/B4VtnB/U4QdoMgSJrPIbffnsdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405313AbfHVRnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389984AbfHVRX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:28 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EC7423406;
        Thu, 22 Aug 2019 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494608;
        bh=Qxmb6vn3g3QEs2Y31wCulIpv1Hya/mij5H+crVxaM88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=foxWwP141Q1oLMK0E8OlBHm6txcg6gImsw7fQehg3SJienL+OiTJP0T4xGehiVQyH
         e/3YpaBU5vnYri3RKZ7GW7qEQW0jXqLjH19NdO+YGLuw95zG0fxwgxef8Sci0Hntyn
         UoMXyMWhc4nAe0+vlRZFFoaSUpBYohjkUky8XiGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+d6a5a1a3657b596ef132@syzkaller.appspotmail.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.9 031/103] can: peak_usb: pcan_usb_pro: Fix info-leaks to USB devices
Date:   Thu, 22 Aug 2019 10:18:19 -0700
Message-Id: <20190822171730.094161937@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Bortoli <tomasbortoli@gmail.com>

commit ead16e53c2f0ed946d82d4037c630e2f60f4ab69 upstream.

Uninitialized Kernel memory can leak to USB devices.

Fix by using kzalloc() instead of kmalloc() on the affected buffers.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+d6a5a1a3657b596ef132@syzkaller.appspotmail.com
Fixes: f14e22435a27 ("net: can: peak_usb: Do not do dma on the stack")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -500,7 +500,7 @@ static int pcan_usb_pro_drv_loaded(struc
 	u8 *buffer;
 	int err;
 
-	buffer = kmalloc(PCAN_USBPRO_FCT_DRVLD_REQ_LEN, GFP_KERNEL);
+	buffer = kzalloc(PCAN_USBPRO_FCT_DRVLD_REQ_LEN, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 


