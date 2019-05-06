Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15679C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D265D20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153374;
	bh=nD6+/xIy6pqXa9KgPPOcUQnBHoKVtX0H5oZGvLHkLbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QVtiUbmZkG1AoltXCHAXYjfbW8d0WRfqBsIspplh6qcVWgnRIpvd4nE/FsqMpZ8cb
	 x3lpV2UaTDpca0k4mD+A3mHJx2v07syYoUj6uge7DnvsbqmrDort3bwjmUZ5QRLR9d
	 cxm48SqGoo7y9f7mr1+GcgifnCgc00QjmWekSfyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfEFOgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfEFOgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:36:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4696E204EC;
        Mon,  6 May 2019 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153365;
        bh=nD6+/xIy6pqXa9KgPPOcUQnBHoKVtX0H5oZGvLHkLbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pW3pc+4vMvOfaIrFt7+lxOTvyYxsijmb0GhnS8bUCdynji2vHcXyeDIbUY25qdCkU
         Zg+irWttomtxWvKoY6wfCLK1RzS6S3t+AVKWin6PAU5cL8bmEapPS4GbmjTePuh3IK
         hQhYR63lhLqhGg1aovl42ybA580VrVoZ9CwY/IfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 044/122] HID: quirks: Fix keyboard + touchpad on Lenovo Miix 630
Date:   Mon,  6 May 2019 16:31:42 +0200
Message-Id: <20190506143058.868183112@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.20.1



