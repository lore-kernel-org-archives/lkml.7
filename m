Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08664C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7939208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749594;
	bh=BvDBc8ULFIJ03Qy5ImvqS1zRetsqy50NWFJ2J/Aakvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TpJJlL6Vztv+ofQq5RQYVuNl5zgu2x+fAj9oXq36V8o0brhs5lyxloeubgw6Z6ynM
	 n3c+giNHVABV8MrDajGFjQshMExMI7m5Fgx9iyjYjcBIpnT6qXULa1AznJZhWLNDNr
	 rx+365qZgxGz5EsxMhr+GgRJit1NKAFuJc+0MCA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfHNC0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730312AbfHNC01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:26:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1030921721;
        Wed, 14 Aug 2019 02:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749587;
        bh=BvDBc8ULFIJ03Qy5ImvqS1zRetsqy50NWFJ2J/Aakvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgHIS0j7EhH+QawRmcMXCwVrrJ1flhI1hjV/0yx/V9PYGm78GJ8YumA+0KUECzP7W
         /UV0SKNtbLZ+8S9BNkNmAAMK6u6/gy9e4JI2xp/naC2m4PX2cd5qi+oFtOSiaoj9dh
         yEPJl9XhGyrzeykDzrZI/WQ59i3Q5/iGzVyGoddc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+62a1e04fd3ec2abf099e@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 21/28] HID: hiddev: do cleanup in failure of opening a device
Date:   Tue, 13 Aug 2019 22:25:43 -0400
Message-Id: <20190814022550.17463-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022550.17463-1-sashal@kernel.org>
References: <20190814022550.17463-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hillf Danton <hdanton@sina.com>

[ Upstream commit 6d4472d7bec39917b54e4e80245784ea5d60ce49 ]

Undo what we did for opening before releasing the memory slice.

Reported-by: syzbot <syzbot+62a1e04fd3ec2abf099e@syzkaller.appspotmail.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hiddev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 0bfc2009e4071..8903ea09ac587 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -330,6 +330,10 @@ static int hiddev_open(struct inode *inode, struct file *file)
 	return 0;
 bail_unlock:
 	mutex_unlock(&hiddev->existancelock);
+
+	spin_lock_irq(&list->hiddev->list_lock);
+	list_del(&list->node);
+	spin_unlock_irq(&list->hiddev->list_lock);
 bail:
 	file->private_data = NULL;
 	vfree(list);
-- 
2.20.1

