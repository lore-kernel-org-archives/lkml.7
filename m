Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39D3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B333920870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495800;
	bh=l0WcdKM9midXBSgbS0kuvCLb/a3DAIBaazN2F+3+060=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0MxMuQj/oisOPGHN3LQHKh0r3BfJ4BzTsSLnatllI9akRk2Kspd0MgVZFf6TReAYK
	 yEAe5OQm0DyPLYXXYVVnhplYP0KsMON0xk97wwT9zXSB5jT5KApHQBf0hyMxys+wni
	 S8khhcdCdqHYYxAV6v1KeckRxZyyjYrsmQYnSizc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405250AbfHVRnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391477AbfHVRX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:29 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0D8623407;
        Thu, 22 Aug 2019 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494609;
        bh=l0WcdKM9midXBSgbS0kuvCLb/a3DAIBaazN2F+3+060=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxCCCLeMgCyE2n0e/qJIVkFGa8pOmx8pq6MOQ+IiiLiYfmbGul5ru/aQtamm7XPSr
         cSWEg9yLMrQWOeI8LmZo/D2cNmr0IFSVO9MhuZIan1hx9Z8hdCYOoiTcrToBTnA1hn
         xmeximZn2RBca3+OKAPD2I3GToUHiLFgygVbVAFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.9 032/103] can: peak_usb: pcan_usb_fd: Fix info-leaks to USB devices
Date:   Thu, 22 Aug 2019 10:18:20 -0700
Message-Id: <20190822171730.137376675@linuxfoundation.org>
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

commit 30a8beeb3042f49d0537b7050fd21b490166a3d9 upstream.

Uninitialized Kernel memory can leak to USB devices.

Fix by using kzalloc() instead of kmalloc() on the affected buffers.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com
Fixes: 0a25e1f4f185 ("can: peak_usb: add support for PEAK new CANFD USB adapters")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -851,7 +851,7 @@ static int pcan_usb_fd_init(struct peak_
 			goto err_out;
 
 		/* allocate command buffer once for all for the interface */
-		pdev->cmd_buffer_addr = kmalloc(PCAN_UFD_CMD_BUFFER_SIZE,
+		pdev->cmd_buffer_addr = kzalloc(PCAN_UFD_CMD_BUFFER_SIZE,
 						GFP_KERNEL);
 		if (!pdev->cmd_buffer_addr)
 			goto err_out_1;


