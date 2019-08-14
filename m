Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDBDC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8EF20679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749773;
	bh=Ifj00gfVsgvP+iQz6eKGgCcOciA1KGPr8g0npFZqP+o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=waST58Mct8UYaf+W6a2SwB0LL13KuMA5oTAijnEjr57lY5P6wzgnoVVu4XAr+TrHu
	 KIJ7jHtT1Z18VQ6h23AAjpFjZ1+V6Wq0lLg4KLWpPb2QUaIqPpt/x8laHVuNfhJOaR
	 urFFXyRINtD6nOh9ke4FS4LlvXKoHVx2OoF1qzUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfHNCXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbfHNCXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:23:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 420E620679;
        Wed, 14 Aug 2019 02:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749404;
        bh=Ifj00gfVsgvP+iQz6eKGgCcOciA1KGPr8g0npFZqP+o=;
        h=From:To:Cc:Subject:Date:From;
        b=hb/1zdwHXCKd+xV+DdzOi+yzo4OIWDSiOzFQQ2oRdT3G5HCuGf72KVUfi0GCOFBXD
         ArUihD3tDGNaEOm1RZ/1azB8WZ9VN3491/7tOKjNL0d+dRgMppQW086mL6J9d9Qe9E
         7AlS8y+/ZMhBNEsi2isz4O3Y5tbN0ZjODxuC4nSw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Trukhanov <lahvuun@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 01/33] HID: Add 044f:b320 ThrustMaster, Inc. 2 in 1 DT
Date:   Tue, 13 Aug 2019 22:22:51 -0400
Message-Id: <20190814022323.17111-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Trukhanov <lahvuun@gmail.com>

[ Upstream commit 65f11c72780fa9d598df88def045ccb6a885cf80 ]

Enable force feedback for the Thrustmaster Dual Trigger 2 in 1 Rumble Force
gamepad. Compared to other Thrustmaster devices, left and right rumble
motors here are swapped.

Signed-off-by: Ilya Trukhanov <lahvuun@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-tmff.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
index b83376077d722..cfa0cb22c9b3c 100644
--- a/drivers/hid/hid-tmff.c
+++ b/drivers/hid/hid-tmff.c
@@ -34,6 +34,8 @@
 
 #include "hid-ids.h"
 
+#define THRUSTMASTER_DEVICE_ID_2_IN_1_DT	0xb320
+
 static const signed short ff_rumble[] = {
 	FF_RUMBLE,
 	-1
@@ -88,6 +90,7 @@ static int tmff_play(struct input_dev *dev, void *data,
 	struct hid_field *ff_field = tmff->ff_field;
 	int x, y;
 	int left, right;	/* Rumbling */
+	int motor_swap;
 
 	switch (effect->type) {
 	case FF_CONSTANT:
@@ -112,6 +115,13 @@ static int tmff_play(struct input_dev *dev, void *data,
 					ff_field->logical_minimum,
 					ff_field->logical_maximum);
 
+		/* 2-in-1 strong motor is left */
+		if (hid->product == THRUSTMASTER_DEVICE_ID_2_IN_1_DT) {
+			motor_swap = left;
+			left = right;
+			right = motor_swap;
+		}
+
 		dbg_hid("(left,right)=(%08x, %08x)\n", left, right);
 		ff_field->value[0] = left;
 		ff_field->value[1] = right;
@@ -238,6 +248,8 @@ static const struct hid_device_id tm_devices[] = {
 		.driver_data = (unsigned long)ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304),   /* FireStorm Dual Power 2 (and 3) */
 		.driver_data = (unsigned long)ff_rumble },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, THRUSTMASTER_DEVICE_ID_2_IN_1_DT),   /* Dual Trigger 2-in-1 */
+		.driver_data = (unsigned long)ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb323),   /* Dual Trigger 3-in-1 (PC Mode) */
 		.driver_data = (unsigned long)ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb324),   /* Dual Trigger 3-in-1 (PS3 Mode) */
-- 
2.20.1

