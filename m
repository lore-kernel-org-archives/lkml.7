Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95000C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603002085A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565748836;
	bh=X+Ec1Epi8YKzHbbrViQD/m0/f4StJkTKOw6RGCVSHYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AOvIs/+IfszWpqO52zbozo//h57SfhepAYRYiPNVeDyIztjHjm0qM9y7wpy2XO2M5
	 DsOigg7rb2dWG2UbrBt8ZwghFGXQHfxXfT7xVRfxvaZpoIUtVF6ufcrHKoKIwbxk6y
	 3cbliluk9vKfPhZKWlVGEqAi7Y95PBDd+KT4opdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfHNCNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbfHNCNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:13:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BE0E20843;
        Wed, 14 Aug 2019 02:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748827;
        bh=X+Ec1Epi8YKzHbbrViQD/m0/f4StJkTKOw6RGCVSHYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HccSGUEDp01Xnr0iuZeN/fmJ9AAiqvCo8N3ScCELPhf+EoBGqs+221qYAdoY+cMJl
         7FTwJHcVQ4Ri3UJ1NgXj5rE3iZ8FhyIHgKgfEwR+V/RIgI6wqN/BjgLro/z7MQ9SAr
         371jwFqrq6EvYgDm9d7fi4MFkE318xPaeSsxxcsU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        syzbot+965152643a75a56737be@syzkaller.appspotmail.com,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 087/123] HID: holtek: test for sanity of intfdata
Date:   Tue, 13 Aug 2019 22:10:11 -0400
Message-Id: <20190814021047.14828-87-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 01ec0a5f19c8c82960a07f6c7410fc9e01d7fb51 ]

The ioctl handler uses the intfdata of a second interface,
which may not be present in a broken or malicious device, hence
the intfdata needs to be checked for NULL.

[jkosina@suse.cz: fix newly added spurious space]
Reported-by: syzbot+965152643a75a56737be@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-holtek-kbd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-holtek-kbd.c b/drivers/hid/hid-holtek-kbd.c
index b3d502421b79d..0a38e8e9bc783 100644
--- a/drivers/hid/hid-holtek-kbd.c
+++ b/drivers/hid/hid-holtek-kbd.c
@@ -123,9 +123,14 @@ static int holtek_kbd_input_event(struct input_dev *dev, unsigned int type,
 
 	/* Locate the boot interface, to receive the LED change events */
 	struct usb_interface *boot_interface = usb_ifnum_to_if(usb_dev, 0);
+	struct hid_device *boot_hid;
+	struct hid_input *boot_hid_input;
 
-	struct hid_device *boot_hid = usb_get_intfdata(boot_interface);
-	struct hid_input *boot_hid_input = list_first_entry(&boot_hid->inputs,
+	if (unlikely(boot_interface == NULL))
+		return -ENODEV;
+
+	boot_hid = usb_get_intfdata(boot_interface);
+	boot_hid_input = list_first_entry(&boot_hid->inputs,
 		struct hid_input, list);
 
 	return boot_hid_input->input->event(boot_hid_input->input, type, code,
-- 
2.20.1

