Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B79DC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DA0204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419118;
	bh=+e/ETbEWsH2JyBNi2WyJ1GUqeQyLbyOOuyZQzVF1DIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AsqVNwESv11jVcVZAVXilaMYd8qCYMnepKgPk2JUgB5j0hBSlAgwxnWc3DQEfP3ly
	 dvh88i95Pne0qVyK1WeCPGqpSg6tx29F63Zq/xmLoJSsKoJOXjLqNK8zcpsZBuhiD/
	 qzqAhVNej9kyDFUs7lriTg5dX8UsnOovvyICOp9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbfGRDFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389899AbfGRDFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:05:15 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A4621848;
        Thu, 18 Jul 2019 03:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419114;
        bh=+e/ETbEWsH2JyBNi2WyJ1GUqeQyLbyOOuyZQzVF1DIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z6+1VihISGwjFSR448JA2ZmOXiEnm5L0DjObnjUF397j6BKjTw3/VjozQ7bTBbF7/
         xUIko4Xv3xueEbS8gOURhWrTRlS16kjuU1udJdYr7r6fTXuPfIVZ5ikj+MTkWlYpIw
         WZcneJ1CkJE+HKMiOwcsfc2mB6gAXI67jnXzfGrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 34/54] HID: multitouch: Add pointstick support for ALPS Touchpad
Date:   Thu, 18 Jul 2019 12:01:29 +0900
Message-Id: <20190718030055.964631254@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030053.287374640@linuxfoundation.org>
References: <20190718030053.287374640@linuxfoundation.org>
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
index a7037473ed94..b1636ce22060 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -83,6 +83,7 @@
 #define HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP	0x1220
 #define HID_DEVICE_ID_ALPS_U1		0x1215
 #define HID_DEVICE_ID_ALPS_T4_BTNLESS	0x120C
+#define HID_DEVICE_ID_ALPS_1222		0x1222
 
 
 #define USB_VENDOR_ID_AMI		0x046b
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 1565a307170a..42bb635895cf 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1780,6 +1780,10 @@ static const struct hid_device_id mt_devices[] = {
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



