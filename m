Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F46C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951EB21019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688459;
	bh=zPOfyGzNRP/9KepcR+LYiphi+vbDtO2u8/Q63+6+qOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x9USWb3JX++QuhGknmuSS1jq/1pWuiWUESbkjwD0lMN1PEMP18TsCwYwI1/Fiv8pV
	 dOzhzTs9cGq82MVSpjgPwl59hsUzgD8YfbeZHlKOa2o4kNn64oQ7c8zGoW9MOaTcbP
	 SrFPNbneL2nVyIWMIKFbK2MzDyoxr7/QDJPH0Zew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfCDIeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:34:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfCDIeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:34:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E2FD20823;
        Mon,  4 Mar 2019 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688455;
        bh=zPOfyGzNRP/9KepcR+LYiphi+vbDtO2u8/Q63+6+qOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=moM/JAx/WgsROlqTrd3R2T4x9ooeJ5lN2v1Fk8Ulr6+D5Ses8Xze3bUCBrLYGihLi
         tz8CQFbOA2H/xlhNoTKuez7W/JEir9Typ1G2/3mGFTtbAqWigAlpw004fc8Nv9akcc
         Wjbozc9T8Ipkz3pLyF7LowLpbf32ZktLWkBB2QXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 15/88] HID: i2c-hid: Disable runtime PM on Goodix touchpad
Date:   Mon,  4 Mar 2019 09:21:58 +0100
Message-Id: <20190304081631.174545237@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 77ae0d8e401f083ca69c202502da4fc0e38cb1b7 ]

A Goodix touchpad doesn't work. Touching the touchpad can trigger IRQ
but there's no input event from HID subsystem.

Turns out it reports some invalid data:
[   22.136630] i2c_hid i2c-DELL091F:00: input: 0b 00 01 00 00 00 00 00 00 00 00

After some trial and error, it's another device that doesn't work well
with ON/SLEEP commands. Disable runtime PM to fix the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h              | 3 +++
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 27519eb8ee636..81bc2f6b93a34 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -459,6 +459,9 @@
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
 
+#define I2C_VENDOR_ID_GOODIX		0x27c6
+#define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
+
 #define USB_VENDOR_ID_GOODTOUCH		0x1aad
 #define USB_DEVICE_ID_GOODTOUCH_000f	0x000f
 
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 8555ce7e737b3..c5edfa966343d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -179,6 +179,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
 	{ USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
+	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
+		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ 0, 0 }
 };
 
-- 
2.19.1



