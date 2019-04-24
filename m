Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD618C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC892089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117843;
	bh=/b87C1+TXFYYaPXiFZi5GfQL5lUidbvOhmod19WSh5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BNeKFP4QLVGUhYhishNKiXvIMjPh8aT6T3Obolhvae678Rc1by6Fe3A+X3qtr/XHz
	 dk166guFuIyn6RZ6Yh6ZHDoCeLCXG7dgf6ZCxh2Yb81jou90Zo7y+V7hqXubdE6/Kg
	 htom0WYsjwRA8yhUZWKCJtvu+JKLff1f6M6kY/xU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732964AbfDXO5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732539AbfDXOuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:50:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E6B4218FD;
        Wed, 24 Apr 2019 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117418;
        bh=/b87C1+TXFYYaPXiFZi5GfQL5lUidbvOhmod19WSh5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVd6qJQYmrrVE0jZEMEcgwMnaeknrqSnWtSi0XtBOA7C5jy14NGhNBXxPYOCmoYu5
         s8en3hMizuL3MTHkpEAfY2EyIya8VZrNYCMvF8JV8pp7yS4iBRJYdNHRfArADX4pQm
         byBdp4svc+M77jAmSYzwfoT9ZlR+k8sAQ4D2BpyU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "He, Bo" <bo.he@intel.com>, "Zhang, Jun" <jun.zhang@intel.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 02/28] HID: debug: fix race condition with between rdesc_show() and device removal
Date:   Wed, 24 Apr 2019 10:49:46 -0400
Message-Id: <20190424145012.30886-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145012.30886-1-sashal@kernel.org>
References: <20190424145012.30886-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "He, Bo" <bo.he@intel.com>

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
Signed-off-by: "he, bo" <bo.he@intel.com>
Signed-off-by: "Zhang, Jun" <jun.zhang@intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-debug.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index d7179dd3c9ef..3cafa1d28fed 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1058,10 +1058,15 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
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
2.19.1

