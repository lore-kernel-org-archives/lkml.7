Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D969C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B2B21873
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120490;
	bh=fosSDEmRwDBzgJQEi7Bq48fKrUZBN23RlErwkIjrFcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=afzKnV4oWstqHG5h3lDv4DAOvSJnkkeLaSdhGGrf8Dxi2aMefUQDpPkG+UI8AJ+S3
	 UcDGy1BiNt9kQidHaLekQMa9tg9YTmYCbC/3hCV7gLlPM0mvZIvdaSzG3wcaZ5ZonR
	 mSZB2N3IiCPLTXd1CisRtpzjfw8pkWyBHjKt/D4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfGCCV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfGCCQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:16:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D72AD21897;
        Wed,  3 Jul 2019 02:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120161;
        bh=fosSDEmRwDBzgJQEi7Bq48fKrUZBN23RlErwkIjrFcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lB3VbpphUMHHNW/LxtAD08vnbWCV9XgRN1t2tGr3+DkAKS/AdeAxScPKRsa+p7BNE
         mtyR/TSpLSKMjXP0tgthn5/y6X6X+tji32bKDwg/p/CR4jbHWMzKP2C7PYlJL/i1Fy
         oXvBK+PeSo9tf5S/iNVC5bpJWwLRTjm/49VRLUc0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 32/39] HID: multitouch: Add pointstick support for ALPS Touchpad
Date:   Tue,  2 Jul 2019 22:15:07 -0400
Message-Id: <20190703021514.17727-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021514.17727-1-sashal@kernel.org>
References: <20190703021514.17727-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

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
index 4ea272eb34c8..cd7442eb25b9 100644
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

