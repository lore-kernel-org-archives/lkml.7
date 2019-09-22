Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4594CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174FB21907
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178634;
	bh=QrVb8AKqGho74elpDM3t5GaiRxbdvP6AAaWnOKIF96A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JsFqB05aafh301RDxWQXCwAj4kx2qo66LT5U4IOywy9aN8ze4vJrKF4ZUBBvP6/Cv
	 mKwF8YmIfgznqGnn0bruFYJgTVcNhW7ebEccEZkJA3r0JylU0cLzRZrOuPoMRkLggB
	 das2nDRhYs3iEj00kuZWUxDXzO8+qFbxVWsvf78U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394802AbfIVS5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394783AbfIVS5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:57:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41591206C2;
        Sun, 22 Sep 2019 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178629;
        bh=QrVb8AKqGho74elpDM3t5GaiRxbdvP6AAaWnOKIF96A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elu7Isr8NGOyhVLs4M69M8OJSxJ4WTG1VXYqv12DFqjIxOrmXe197h5tkOXVNegzZ
         dDZn15OuMB+m0JXIDWnsbEja0xDJZVGOXX8EgWXHmo/CqjoQvnPSeMKQq164WI3whD
         DjzdwkFZTlaZ0efq3Pm7Zx0QkgamZADzHqrzif70=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+0522702e9d67142379f1@syzkaller.appspotmail.com,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 125/128] media: ttusb-dec: Fix info-leak in ttusb_dec_send_command()
Date:   Sun, 22 Sep 2019 14:54:15 -0400
Message-Id: <20190922185418.2158-125-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Bortoli <tomasbortoli@gmail.com>

[ Upstream commit a10feaf8c464c3f9cfdd3a8a7ce17e1c0d498da1 ]

The function at issue does not always initialize each byte allocated
for 'b' and can therefore leak uninitialized memory to a USB device in
the call to usb_bulk_msg()

Use kzalloc() instead of kmalloc()

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+0522702e9d67142379f1@syzkaller.appspotmail.com
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/ttusb-dec/ttusb_dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/ttusb-dec/ttusb_dec.c b/drivers/media/usb/ttusb-dec/ttusb_dec.c
index 44ca66cb9b8f1..f34efa7c61b40 100644
--- a/drivers/media/usb/ttusb-dec/ttusb_dec.c
+++ b/drivers/media/usb/ttusb-dec/ttusb_dec.c
@@ -329,7 +329,7 @@ static int ttusb_dec_send_command(struct ttusb_dec *dec, const u8 command,
 
 	dprintk("%s\n", __func__);
 
-	b = kmalloc(COMMAND_PACKET_SIZE + 4, GFP_KERNEL);
+	b = kzalloc(COMMAND_PACKET_SIZE + 4, GFP_KERNEL);
 	if (!b)
 		return -ENOMEM;
 
-- 
2.20.1

