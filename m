Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5DDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2235820856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495718;
	bh=c7ZAd2AV/yp4LCIViPLn6jGQ3zJo7OK6ViAB11Kblik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iLFJmuvId0MHLQByRWV50y2RkzTn7Qirp/83i0qimB1IUBrVo6nk4KjEYcG22d1cm
	 d00XdudokJvAU6VaS9iHuIUFhqW64BjDWsNIz9Kh8KOZKhE7bhmTue8RjMdEcQt1x0
	 jzTBt8J+0kG5zsMhchIaBfsofXNsZcaAKMwa7Kv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390093AbfHVRl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391735AbfHVRXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:53 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7AD42341C;
        Thu, 22 Aug 2019 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494632;
        bh=c7ZAd2AV/yp4LCIViPLn6jGQ3zJo7OK6ViAB11Kblik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQ4IGVygmjK2GMf+RgMv5IR5qxd//NQdNfUyNaS02z/f7BQvd28nPNVmq1lhJO7Wt
         D8NI4grWJJiK74oNtKb4ntbqJnbY8XiYdC09O0Fp+qZc3FoUK5cu5rnM1aKhNYWkU6
         wNsKu8ntnXMNnccClJhY6XGtPJcO4gAGxhKk3+Mo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+62a1e04fd3ec2abf099e@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Hillf Danton <hdanton@sina.com>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.9 064/103] HID: hiddev: do cleanup in failure of opening a device
Date:   Thu, 22 Aug 2019 10:18:52 -0700
Message-Id: <20190822171731.370428664@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hillf Danton <hdanton@sina.com>

commit 6d4472d7bec39917b54e4e80245784ea5d60ce49 upstream.

Undo what we did for opening before releasing the memory slice.

Reported-by: syzbot <syzbot+62a1e04fd3ec2abf099e@syzkaller.appspotmail.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/usbhid/hiddev.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -330,6 +330,10 @@ static int hiddev_open(struct inode *ino
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


