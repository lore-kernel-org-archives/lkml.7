Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF78C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF8420870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566496105;
	bh=l0WcdKM9midXBSgbS0kuvCLb/a3DAIBaazN2F+3+060=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nAjAGSKZw5jZPO4t5dFOJGaJ8fGU5USviOyHfwR/Bx7/Z1+okE6DoXuZ1OBEXwVYg
	 Rnl2Mcfed/1d8ckTVe2muE/tOMnPETJpK1igos18gVs+MBot0TgBK1MFWtGBZKHTw/
	 mnzNR8jS32+LNOcddBW1YeUHk+58WYyDHqgq7At8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391324AbfHVRW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390280AbfHVRWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:22:24 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4090A233FD;
        Thu, 22 Aug 2019 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494544;
        bh=l0WcdKM9midXBSgbS0kuvCLb/a3DAIBaazN2F+3+060=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVDtOGmeixsynIokytC2oRnHONprsDT27tEK5k+XxBaU/xfM7CgOEJK0dWECeIdqM
         ZrwoaWxopXqrTq4qUCwDgrm4lZLkCM6sKiyZXdSfneYCSJW7OGZZ6F52Y29oBusOto
         Vho85inNpJn2hyDMi3+FrQIaDFil+NG5gZ5kaooA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.4 25/78] can: peak_usb: pcan_usb_fd: Fix info-leaks to USB devices
Date:   Thu, 22 Aug 2019 10:18:29 -0700
Message-Id: <20190822171832.771598059@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
References: <20190822171832.012773482@linuxfoundation.org>
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


