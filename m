Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26BDC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A8A2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610470;
	bh=b3c4b335fDpbExdLXTnXOBmYG4JE1zuFzosgRhz7beE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mSRX/xnDRxkcWIwM5Y+29Uou8nCN9IZvssm0FAMp9Q1AU4wWuXZvNiQNHuLjDYLKz
	 MlpoK5lsJNRXOVYmV7id6d3nqbPp/jkrZyHEN3yHq1AJLOh5x1baQ4rD53eUpE7TXw
	 DmgPFLkSCMKiO37yAmJKU3Tvtr791+3aA7tsMezE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390496AbfDRSBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390470AbfDRSBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:01:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC0CD206B6;
        Thu, 18 Apr 2019 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610461;
        bh=b3c4b335fDpbExdLXTnXOBmYG4JE1zuFzosgRhz7beE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HrQBPhyiagVsXWlSzMBmZAnoiOiIQv0+mk6ZfCLXlPmwvirOsPkjJPIFOtn+lxCSO
         1pdSthYS1xducqjQF1q86plKw0XWhbVfqznObrnBetzebV6VWXIsSr1DCZNLPiuGFo
         KPMK9lkaPygOk6e9EVx+bvbh9cLuOw03eYWMkVpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/110] HID: usbhid: Add quirk for Redragon/Dragonrise Seymur 2
Date:   Thu, 18 Apr 2019 19:57:00 +0200
Message-Id: <20190418160445.033891060@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



