Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5342DCA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207E4206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096487;
	bh=gJOIq6DLbnNigNe4FwTklnHE3ntXFFrsVq6k3vM7U8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ovPJi/ylXe7b1+MhDx0t8WRmL1XdQaQWlMB0DKG4TndbdI3++ju2vd3KoWVDsT33R
	 t7wcQxpOuL/x5ZFmSgyZ0+iZvYZnOQw1i/awN+OjL9vb9CU7a+WEzYlRsvtpaye+lb
	 5CJrQvBMK4k2o9YCmyfpv6m4TjNlHI9c/UbwOW1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfJZNVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfJZNVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:21:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8985E222C9;
        Sat, 26 Oct 2019 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096060;
        bh=gJOIq6DLbnNigNe4FwTklnHE3ntXFFrsVq6k3vM7U8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2L1/bq1v9aoMqfu22SFdLa8IkPpwr/KYLqWQk9hm3t5mXhUpAUvSyDzJhlhDTPB8
         0LCZg8N49tQZ/hSxizaT0UOgpTWQg6CK6/qAJVo0rowN5CByZhYA+zE9SKpFfyFP4Y
         GZQX4Jq4+i8RK8uX1ejPYiPV/Et495hHaJEh1Aww=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Daniel Wagner <dwagner@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 56/59] net: usb: lan78xx: Connect PHY before registering MAC
Date:   Sat, 26 Oct 2019 09:19:07 -0400
Message-Id: <20191026131910.3435-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 38b4fe320119859c11b1dc06f6b4987a16344fa1 ]

As soon as the netdev is registers, the kernel can start using the
interface. If the driver connects the MAC to the PHY after the netdev
is registered, there is a race condition where the interface can be
opened without having the PHY connected.

Change the order to close this race condition.

Fixes: 92571a1aae40 ("lan78xx: Connect phy early")
Reported-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index e20266bd209e2..06d2499ba127c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3796,10 +3796,14 @@ static int lan78xx_probe(struct usb_interface *intf,
 	/* driver requires remote-wakeup capability during autosuspend. */
 	intf->needs_remote_wakeup = 1;
 
+	ret = lan78xx_phy_init(dev);
+	if (ret < 0)
+		goto out4;
+
 	ret = register_netdev(netdev);
 	if (ret != 0) {
 		netif_err(dev, probe, netdev, "couldn't register the device\n");
-		goto out4;
+		goto out5;
 	}
 
 	usb_set_intfdata(intf, dev);
@@ -3812,14 +3816,10 @@ static int lan78xx_probe(struct usb_interface *intf,
 	pm_runtime_set_autosuspend_delay(&udev->dev,
 					 DEFAULT_AUTOSUSPEND_DELAY);
 
-	ret = lan78xx_phy_init(dev);
-	if (ret < 0)
-		goto out5;
-
 	return 0;
 
 out5:
-	unregister_netdev(netdev);
+	phy_disconnect(netdev->phydev);
 out4:
 	usb_free_urb(dev->urb_intr);
 out3:
-- 
2.20.1

