Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80C8C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B870F22CE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148753;
	bh=1Nx+pXv8/xDANp9AAKMymmPxnaEzBXyhJvBdMDF0yUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FB8ZBV4Al4aBHYWvhxTCtpcVtmCmvVzw/qDSaNgVnYMn23mDuhcxDTV3vDJLI3tlJ
	 J8HKcy/JJTG2jclQdLPURlTlK+7dYh/kuZ2D38Sq0apCPrtA6x0s/C1jHGWmXfjNfb
	 Iu6iUQWvx73NTVP9egc9ZTvHlnk4qdLxcG/rxCV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbfGZNpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387912AbfGZNpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:45:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E8C22CBF;
        Fri, 26 Jul 2019 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148746;
        bh=1Nx+pXv8/xDANp9AAKMymmPxnaEzBXyhJvBdMDF0yUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEGKCBmXIDCGVKv37g2GiLx0dGkqFM5waOJAyFbEC/jumPNYpljUXbXFKqUrP+tY7
         PDriG17SbzCvFD2XUrELrwhqCwujBMCBhPU1/6AtCatu8Fz3idTs8lLm8XU/cM6i66
         8orWJAC1JBJBUQAYUV4tdhHBZjsUY1m6cAvb9ICA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Phong Tran <tranmanphong@gmail.com>,
        syzbot+8750abbc3a46ef47d509@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 11/23] ISDN: hfcsusb: checking idx of ep configuration
Date:   Fri, 26 Jul 2019 09:45:10 -0400
Message-Id: <20190726134522.13308-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134522.13308-1-sashal@kernel.org>
References: <20190726134522.13308-1-sashal@kernel.org>
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

