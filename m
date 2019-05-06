Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB275C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1CE2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155274;
	bh=gIPycv8dbcn1JC3zOTMxaLgrxP4VVdplls7mNHRinzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ABjBqnWcf1A8oiVKTSEEdCa9cO8N3xNuXeqslpPUj2RN65RlvuCa20m+YB+enB7YO
	 qpGoy84xSQjTTTKcbk7Ez6rgoNeZdZ63aCwPpHWb6sQgJBGhSIJxZFN8z6Ktp/P/Io
	 Ho8JG90QSe0nU84FW0QzKSMye+Mu+2s4Se80RjEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfEFPHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfEFPHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:07:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 481C32087F;
        Mon,  6 May 2019 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557155269;
        bh=gIPycv8dbcn1JC3zOTMxaLgrxP4VVdplls7mNHRinzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCmNzWNUc7uzzPuR3VCjw7I+hd7jaBr3SQCi0A2xFTJ/rkb3IompkjPx1exqOKJ+p
         B9XzLXU2O+gwVOaHef6MkuHM1bY1Jwe/48WGeAZzPOynr+BKp/OBEB3lzw1Hoabevb
         BOvaQmHciqG5rJU6YpTP6lVl4OLQWHXF2BwUo4Ek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "he, bo" <bo.he@intel.com>,
        "Zhang, Jun" <jun.zhang@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 27/75] HID: debug: fix race condition with between rdesc_show() and device removal
Date:   Mon,  6 May 2019 16:32:35 +0200
Message-Id: <20190506143055.631670523@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.287515952@linuxfoundation.org>
References: <20190506143053.287515952@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cef0d4948cb0a02db37ebfdc320e127c77ab1637 ]

There is a race condition that could happen if hid_debug_rdesc_show()
is running while hdev is in the process of going away (device removal,
system suspend, etc) which could result in NULL pointer dereference:

	 BUG: unable to handle kernel paging request at 0000000783316040
	 CPU: 1 PID: 1512 Comm: getevent Tainted: G     U     O 4.19.20-quilt-2e5dc0ac-00029-gc455a447dd55 #1
	 RIP: 0010:hid_dump_device+0x9b/0x160
	 Call Trace:
	  hid_debug_rdesc_show+0x72/0x1d0
	  seq_read+0xe0/0x410
	  full_proxy_read+0x5f/0x90
	  __vfs_read+0x3a/0x170
	  vfs_read+0xa0/0x150
	  ksys_read+0x58/0xc0
	  __x64_sys_read+0x1a/0x20
	  do_syscall_64+0x55/0x110
	  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Grab driver_input_lock to make sure the input device exists throughout the
whole process of dumping the rdesc.

[jkosina@suse.cz: update changelog a bit]
Signed-off-by: he, bo <bo.he@intel.com>
Signed-off-by: "Zhang, Jun" <jun.zhang@intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-debug.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index a90967cd4987..a0bcbb633b67 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1060,10 +1060,15 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 	seq_printf(f, "\n\n");
 
 	/* dump parsed data and input mappings */
+	if (down_interruptible(&hdev->driver_input_lock))
+		return 0;
+
 	hid_dump_device(hdev, f);
 	seq_printf(f, "\n");
 	hid_dump_input_mapping(hdev, f);
 
+	up(&hdev->driver_input_lock);
+
 	return 0;
 }
 
-- 
2.20.1



