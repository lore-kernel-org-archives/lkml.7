Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A8CFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D68222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213589;
	bh=SLrivsqtWUW1YaeUJjXQacHkwJO/47lWejE0nFG1YqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eqdsBTs+9KiJNtRIgpeD8bOwZlSK2HsulUupZ0jl5H7khcAJ5BMgJ6jHSMU9ERkHS
	 PjjEW4m7DiOZaxY3X+ZQUsK7HRFjPnyEK7MwvyjD49xyeFkDkmSwYVS8/9gIiq0Um4
	 iWNyZVIT88OjhtO6R94CsQxbchBgM1EuXeLWdB+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391350AbfKHLq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:46:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390158AbfKHLqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:46:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B05D7222C2;
        Fri,  8 Nov 2019 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213575;
        bh=SLrivsqtWUW1YaeUJjXQacHkwJO/47lWejE0nFG1YqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvPzkzZxmdF9okVi3Wcb2nDFqobKYx7pbXz3tf9mpXxSfbFFl/ho5gNoShN0jryjf
         pRwg9Frz93rQgrpWB8dsmJPzRRA7BXTELKMfocxvQBoK9XdWGCCWFdC/FVKZKgQQt1
         9/3/Lw6IUbarXbmKtBxStvoppwu2I6l8+Ihww4CA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Raghuram Chary Jallipalli 
        <raghuramchary.jallipalli@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 21/64] net: lan78xx: Bail out if lan78xx_get_endpoints fails
Date:   Fri,  8 Nov 2019 06:45:02 -0500
Message-Id: <20191108114545.15351-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit fa8cd98c06407b5798b927cd7fd14d30f360ed02 ]

We need to bail out if lan78xx_get_endpoints() fails, otherwise the
result is overwritten.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Raghuram Chary Jallipalli <raghuramchary.jallipalli@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index e143a7fe93201..a3f9d8f05db4a 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2621,6 +2621,11 @@ static int lan78xx_bind(struct lan78xx_net *dev, struct usb_interface *intf)
 	int i;
 
 	ret = lan78xx_get_endpoints(dev, intf);
+	if (ret) {
+		netdev_warn(dev->net, "lan78xx_get_endpoints failed: %d\n",
+			    ret);
+		return ret;
+	}
 
 	dev->data[0] = (unsigned long)kzalloc(sizeof(*pdata), GFP_KERNEL);
 
-- 
2.20.1

