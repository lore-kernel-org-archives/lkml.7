Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B5C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FA22173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419308;
	bh=QyIkETiSk0+AQfqQMDBR1e3aoZ+23XmB8DjtpCueYgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d6Khxzov4DqtrR1hiiDe8xt50xq4Y5GMALj184SCEfbPYERMQHhF0y8urcbYhpCqJ
	 6GXbxove2jg8UiJ5vdYTLJ9ldPe5c56QwxooC3aDnKQd46+Ci3VaYQqCbzXVH7qjum
	 vizaTeYPF6UlRU5tCIZmqU2ajJCqfnQHpcQtPhKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390740AbfGRDI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390715AbfGRDIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:08:23 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEED42077C;
        Thu, 18 Jul 2019 03:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419302;
        bh=QyIkETiSk0+AQfqQMDBR1e3aoZ+23XmB8DjtpCueYgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRxxxKlj9DHTlU2VsheRVJvWbFJEFlB9dXGE2DLH0Jpp6H3H/LbWjZM8l+kmKplPA
         PionffycqLqBhm/KJ5C4o3P4mF+dPJSd0x1dTFue9SEysrfbbXtDBjnmcz5b66EkHG
         TtvBEp6RbxAoNkjWiiLmGkZ2XPqcoGHocEZq1Oq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 25/47] HID: multitouch: Add pointstick support for ALPS Touchpad
Date:   Thu, 18 Jul 2019 12:01:39 +0900
Message-Id: <20190718030050.859172951@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0a95fc733da375de0688d0f1fd3a2869a1c1d499 ]

There's a new ALPS touchpad/pointstick combo device that requires
MT_CLS_WIN_8_DUAL to make its pointsitck work as a mouse.

The device can be found on HP ZBook 17 G5.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 97b4ecab7c12..50b3c0d89c9c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -82,6 +82,7 @@
 #define HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP	0x1220
 #define HID_DEVICE_ID_ALPS_U1		0x1215
 #define HID_DEVICE_ID_ALPS_T4_BTNLESS	0x120C
+#define HID_DEVICE_ID_ALPS_1222		0x1222
 
 
 #define USB_VENDOR_ID_AMI		0x046b
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 184e49036e1d..f9167d0e095c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1788,6 +1788,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_ALPS_JP,
 			HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP) },
+	{ .driver_data = MT_CLS_WIN_8_DUAL,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_ALPS_JP,
+			HID_DEVICE_ID_ALPS_1222) },
 
 	/* Lenovo X1 TAB Gen 2 */
 	{ .driver_data = MT_CLS_WIN_8_DUAL,
-- 
2.20.1



