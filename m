Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B3EC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89C120679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642008;
	bh=uG3ifd4LdU/S4tdk5jXdV8M3Xx9rLvJA2I7pmFRBINY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i1xm39u49KN7sh2bo8ch4kAyoUwLmGPHB+zJzq268Tv2tvhgTtOJzXf3ba2Xr2CbW
	 9ZrwEHJZfliaMLaeVLge4m4A+DBELI9B/oyBVH7ico4OTFm5n5QzPvP4Cg9+GGhuvc
	 PsSg39arKQhW3NMScH2qncdVVK3FeDVocry+iCxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfJIR0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732377AbfJIRYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:35 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB9221920;
        Wed,  9 Oct 2019 17:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641874;
        bh=uG3ifd4LdU/S4tdk5jXdV8M3Xx9rLvJA2I7pmFRBINY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SspeWhi0CajVZ39KNWCMCrWeKG04DChsiP8OY2cdRqJJyFE726GwTWNVU3WmC5oTw
         BFoxcWzAqr6RioEo75NWzQKl+rTgYZtx5iZ7oUPgLy3DQsgX3O44MKzFaxhlYwWp2m
         IxafM9od+qU/TfURaAw9eDjmVCn7nkAH0tGe5oSQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 19/21] r8152: Set macpassthru in reset_resume callback
Date:   Wed,  9 Oct 2019 13:06:12 -0400
Message-Id: <20191009170615.32750-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170615.32750-1-sashal@kernel.org>
References: <20191009170615.32750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit a54cdeeb04fc719e4c7f19d6e28dba7ea86cee5b ]

r8152 may fail to establish network connection after resume from system
suspend.

If the USB port connects to r8152 lost its power during system suspend,
the MAC address was written before is lost. The reason is that The MAC
address doesn't get written again in its reset_resume callback.

So let's set MAC address again in reset_resume callback. Also remove
unnecessary lock as no other locking attempt will happen during
reset_resume.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 455eec3c46942..c0964281ab983 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4465,10 +4465,9 @@ static int rtl8152_reset_resume(struct usb_interface *intf)
 	struct r8152 *tp = usb_get_intfdata(intf);
 
 	clear_bit(SELECTIVE_SUSPEND, &tp->flags);
-	mutex_lock(&tp->control);
 	tp->rtl_ops.init(tp);
 	queue_delayed_work(system_long_wq, &tp->hw_phy_work, 0);
-	mutex_unlock(&tp->control);
+	set_ethernet_addr(tp);
 	return rtl8152_resume(intf);
 }
 
-- 
2.20.1

