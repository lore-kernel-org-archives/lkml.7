Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FEAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FB42073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013563;
	bh=cYhdYbZ2C62QFsCV3vUPORDRy2TMMCi6obS4+mAyaXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zcDnDeFkVZETLq8XIfYQEWqprRUvFgqT6DRY0Oipe+Mjd0F0feYom10udSqrxexQi
	 WVG6DaroZgr0auLQ7VgyE6JPNbANahj5EfT/KWpTMGSze9BHRamDNtauZ7T/wwDt2K
	 gyFBKBy/4CqUDqw6e/r991OiNV/NjOcBF45jDdjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfLJVck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbfLJVcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:32:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 854FA207FF;
        Tue, 10 Dec 2019 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013555;
        bh=cYhdYbZ2C62QFsCV3vUPORDRy2TMMCi6obS4+mAyaXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X6Uxk2m6LE3ARTcRyUIGE/JDp7McbXwd7MnfgwWoFFqeDWJRviSn9ZtciPO/16kQX
         WN7q9P/gFTU6SqSD+Nd82IVNXJVygEb3zYGOTH+JGD15jVy9m3gSuchQ4+DbnCigod
         6d0MZYZeosom3ZvQoO+3bk2T80iPrjPAvyycZByo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 011/177] rtlwifi: prevent memory leak in rtl_usb_probe
Date:   Tue, 10 Dec 2019 16:29:35 -0500
Message-Id: <20191210213221.11921-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 3f93616951138a598d930dcaec40f2bfd9ce43bb ]

In rtl_usb_probe if allocation for usb_data fails the allocated hw
should be released. In addition the allocated rtlpriv->usb_data should
be released on error handling path.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 5adb939afee88..1181b725f5033 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1050,8 +1050,10 @@ int rtl_usb_probe(struct usb_interface *intf,
 	rtlpriv->hw = hw;
 	rtlpriv->usb_data = kcalloc(RTL_USB_MAX_RX_COUNT, sizeof(u32),
 				    GFP_KERNEL);
-	if (!rtlpriv->usb_data)
+	if (!rtlpriv->usb_data) {
+		ieee80211_free_hw(hw);
 		return -ENOMEM;
+	}
 
 	/* this spin lock must be initialized early */
 	spin_lock_init(&rtlpriv->locks.usb_lock);
@@ -1112,6 +1114,7 @@ int rtl_usb_probe(struct usb_interface *intf,
 	_rtl_usb_io_handler_release(hw);
 	usb_put_dev(udev);
 	complete(&rtlpriv->firmware_loading_complete);
+	kfree(rtlpriv->usb_data);
 	return -ENODEV;
 }
 EXPORT_SYMBOL(rtl_usb_probe);
-- 
2.20.1

