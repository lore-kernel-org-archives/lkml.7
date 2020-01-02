Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F86C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6C5222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004496;
	bh=CAjwITj91/bhIiNOIMVBwwH75ImrDkutC+BU2fAoCaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xyPbwsjtPGZwTVKQAn3SqfiwHVZyuHqLlcRx+QFxojGFCywmEa5Vi8GAL4put/gyp
	 yjFc46eM7Z9gwWIF1njiNvopT/Mcb5HkBcf5qPrVRRic/9JHE5PpTPkiuIBtAsrt8E
	 yjg8lXlMGIg4+jb1UtEN28W2uoPb5TapSkTITPI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgABWez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729967AbgABWew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:34:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC784222C3;
        Thu,  2 Jan 2020 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004492;
        bh=CAjwITj91/bhIiNOIMVBwwH75ImrDkutC+BU2fAoCaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oy1K41P9fq1skZMGmWsL0ug4bkZTIGpj432Tn7wNopXwyRH9qqc6h5kZ3yQ8BuCEi
         MDKXx7KPtvHEhyT6J6zcMUer0BP346Hovd3+kXIz0Sd3lJFcIG4akPf0tyAG8TRXW6
         N+RdzpIS9SznQu0az1ChW4uDas3Vr7daAWEjsnZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 009/137] rtlwifi: prevent memory leak in rtl_usb_probe
Date:   Thu,  2 Jan 2020 23:06:22 +0100
Message-Id: <20200102220547.906833272@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index ad8390d2997b..9408c1f8e397 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1094,8 +1094,10 @@ int rtl_usb_probe(struct usb_interface *intf,
 	rtlpriv->hw = hw;
 	rtlpriv->usb_data = kzalloc(RTL_USB_MAX_RX_COUNT * sizeof(u32),
 				    GFP_KERNEL);
-	if (!rtlpriv->usb_data)
+	if (!rtlpriv->usb_data) {
+		ieee80211_free_hw(hw);
 		return -ENOMEM;
+	}
 
 	/* this spin lock must be initialized early */
 	spin_lock_init(&rtlpriv->locks.usb_lock);
@@ -1158,6 +1160,7 @@ error_out:
 	_rtl_usb_io_handler_release(hw);
 	usb_put_dev(udev);
 	complete(&rtlpriv->firmware_loading_complete);
+	kfree(rtlpriv->usb_data);
 	return -ENODEV;
 }
 EXPORT_SYMBOL(rtl_usb_probe);
-- 
2.20.1



