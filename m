Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D88FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FD422CD8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148946;
	bh=1Nx+pXv8/xDANp9AAKMymmPxnaEzBXyhJvBdMDF0yUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wmCNNiLa1AtQQ8BOEwBTvVWNljFhYFJy7SreWJo2Olm1QZQMrPi6ah86L5t+tPZhN
	 yaAlQ0ULiAZdcWq9L1RZsCddt9bM0TxfwDq6rMmrg5XhbjyQy9WcYjkXpe58byjiIg
	 Vyy/F5DrihAkkxSxxfdQhOA6Dy+ZIY9xdwyHZzrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfGZNtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388456AbfGZNoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:44:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF07D22CBF;
        Fri, 26 Jul 2019 13:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148693;
        bh=1Nx+pXv8/xDANp9AAKMymmPxnaEzBXyhJvBdMDF0yUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tYjEE6+rFX/zTNvLx9ELQNE2uu8rxre+BOViGyoyWP13xSJKmJq87FBNxfk+d8rxX
         /CibHuGBaai4bwqQl6+bl20BDxk9HBR0+PR6j3CGh5MHa7iBug2U3u8yQqcHvdmV4Y
         t7wCO5bh4HFQii8Rc4KLTeiP4/+FfIubCFAq3/gc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Phong Tran <tranmanphong@gmail.com>,
        syzbot+8750abbc3a46ef47d509@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 15/30] ISDN: hfcsusb: checking idx of ep configuration
Date:   Fri, 26 Jul 2019 09:44:17 -0400
Message-Id: <20190726134432.12993-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134432.12993-1-sashal@kernel.org>
References: <20190726134432.12993-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong Tran <tranmanphong@gmail.com>

[ Upstream commit f384e62a82ba5d85408405fdd6aeff89354deaa9 ]

The syzbot test with random endpoint address which made the idx is
overflow in the table of endpoint configuations.

this adds the checking for fixing the error report from
syzbot

KASAN: stack-out-of-bounds Read in hfcsusb_probe [1]
The patch tested by syzbot [2]

Reported-by: syzbot+8750abbc3a46ef47d509@syzkaller.appspotmail.com

[1]:
https://syzkaller.appspot.com/bug?id=30a04378dac680c5d521304a00a86156bb913522
[2]:
https://groups.google.com/d/msg/syzkaller-bugs/_6HBdge8F3E/OJn7wVNpBAAJ

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/hardware/mISDN/hfcsusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index 114f3bcba1b0..c60c7998af17 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1963,6 +1963,9 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 				/* get endpoint base */
 				idx = ((ep_addr & 0x7f) - 1) * 2;
+				if (idx > 15)
+					return -EIO;
+
 				if (ep_addr & 0x80)
 					idx++;
 				attr = ep->desc.bmAttributes;
-- 
2.20.1

