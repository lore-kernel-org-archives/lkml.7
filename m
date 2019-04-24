Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF44BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1B9218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116478;
	bh=MZOVtwYIxiMB7GuQ7i1fXR3ccGHH9buChcrRgJRJwjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RpL/36NcN0nXCmZY5abJCawm5KYw0tHr3a1xmHUrwplpQyxWhGpN6WYwLkbnorAn4
	 ZsE58sXk8aul0+Gcl3X589cdwCaVttFgljVXyEsCuFDpZQIGbbbbGzjIpAM1u/FRyD
	 HLXh50wLRr0ylFmNlRlnK749776cpb0j93TPph+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfDXOeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731044AbfDXOee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:34:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B75D218FE;
        Wed, 24 Apr 2019 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116473;
        bh=MZOVtwYIxiMB7GuQ7i1fXR3ccGHH9buChcrRgJRJwjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R99oIRn6DQk1QOg6Z1lJ2kZbwK0kVhiHKpDftW9YXC9vUMdUyphGfqVGRKMkKwEUD
         Qr08AB/Q9Z9I9LgPxSybB0cgIE5qpIhO5tw6zDRWtRIRpXJt+MeASNTbDogpPvEcON
         i23eiQASvVBMJOXkyMtFvTL+8Jx8pwa0e1652MTY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 21/66] HID: quirks: Fix keyboard + touchpad on Lenovo Miix 630
Date:   Wed, 24 Apr 2019 10:32:55 -0400
Message-Id: <20190424143341.27665-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

[ Upstream commit 2bafa1e9625400bec4c840a168d70ba52607a58d ]

Similar to commit edfc3722cfef ("HID: quirks: Fix keyboard + touchpad on
Toshiba Click Mini not working"), the Lenovo Miix 630 has a combo
keyboard/touchpad device with vid:pid of 04F3:0400, which is shared with
Elan touchpads.  The combo on the Miix 630 has an ACPI id of QTEC0001,
which is not claimed by the elan_i2c driver, so key on that similar to
what was done for the Toshiba Click Mini.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/hid/hid-quirks.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 94088c0ed68a..e24790c988c0 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -744,7 +744,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DEALEXTREAME, USB_DEVICE_ID_DEALEXTREAME_RADIO_SI4701) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
@@ -1025,6 +1024,10 @@ bool hid_ignore(struct hid_device *hdev)
 		if (hdev->product == 0x0401 &&
 		    strncmp(hdev->name, "ELAN0800", 8) != 0)
 			return true;
+		/* Same with product id 0x0400 */
+		if (hdev->product == 0x0400 &&
+		    strncmp(hdev->name, "QTEC0001", 8) != 0)
+			return true;
 		break;
 	}
 
-- 
2.19.1

