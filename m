Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC31FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC8D217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553910007;
	bh=rBxZkjukOLFjsKQLOILGKnvVuhN5XKBDLNS6LwUvXSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CEIfBTkmylDQQZb2Jm8xIxUn0ALaGgPRB+Oi6qIVx6CTA2HX/70i43mjQIIOw3zED
	 xCvDnKYrllCW9ZGObH7Zb3eSBK1pCuut2hEIOgxCX/9XwOjy0LqlyX0wFGLb46LgTF
	 isEC/Oj1SQejsD9kuR7r5PvxSy7a6ZVq4KJ3UQfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfC3B3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731033AbfC3B3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:29:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A63D5218D9;
        Sat, 30 Mar 2019 01:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909374;
        bh=rBxZkjukOLFjsKQLOILGKnvVuhN5XKBDLNS6LwUvXSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAMWho1Vuka3EaSFIoSg3eE505RK7hX2qOlZlm6nFhrWSOWYPp18iYcj9i1v+F2nS
         zmo+1pD43ftUVpV30dXBHaRB6AAhRQizZgLOHM3PMOVAABuukMqisp+X1UGdds9loh
         P+eRUDY0u7TEhyEmyldzbiYn7qGEchFxkPr174QQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 19/57] HID: usbhid: Add quirk for Redragon/Dragonrise Seymur 2
Date:   Fri, 29 Mar 2019 21:28:12 -0400
Message-Id: <20190330012854.32212-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit ce9d58d3eafcb2d452a69bdcc1c5f8b8ff640de5 ]

Redragon Seymur 2 stops working since commit 190d7f02ce8e ("HID: input:
do not increment usages when a duplicate is found").

Use quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE suggested by the commit
can solve the issue.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200995
BugLink: https://bugs.launchpad.net/bugs/1793846
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b7870e7e41d4..97d33b8ed36c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -348,6 +348,7 @@
 #define USB_DEVICE_ID_DMI_ENC		0x5fab
 
 #define USB_VENDOR_ID_DRAGONRISE		0x0079
+#define USB_DEVICE_ID_REDRAGON_SEYMUR2		0x0006
 #define USB_DEVICE_ID_DRAGONRISE_WIIU		0x1800
 #define USB_DEVICE_ID_DRAGONRISE_PS3		0x1801
 #define USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR	0x1803
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 77316f022c5a..94088c0ed68a 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -70,6 +70,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_REDRAGON_SEYMUR2), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE1), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3), HID_QUIRK_MULTI_INPUT },
-- 
2.19.1

