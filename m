Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC000C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0732208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554165802;
	bh=s/stWospmmZEnYk2B722eqev90ya5RvTogKTl6p/ZH0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=grIea4+wSx2Mc83HPaYnizgViPP2clKA+gHk/0eG6j7BO1W1NzH1W65ptdYRLJAL0
	 bCn25c3srXjFqmrN32ClEOlSLnfXdKShQRQtx9pV9DTg5r3F9cedED62rayGIZTJf9
	 DmpRpWU9LvSY4RtZWCcgBO8NJgpOBPgG5OAG2OY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfDBAnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfDBAnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 20:43:21 -0400
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A0920883;
        Tue,  2 Apr 2019 00:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554165800;
        bh=s/stWospmmZEnYk2B722eqev90ya5RvTogKTl6p/ZH0=;
        h=From:To:Cc:Subject:Date:From;
        b=IN6BG6shkT7wVXjuePTNMr5FrdldwXCT/eGWkG7qwddGiVdHYonWo3Y6RMObQakSp
         qzHTVdx8LuMuimUQ7LapfSXEdVKrPvwfCgZA28kslWfHwpCUf3uwmpsMt0YyaSjhdf
         KGaGOBsogQXKXfOuy0F1e1rcn4RHVU7gRc5EhSm4=
From:   Shuah Khan <shuah@kernel.org>
To:     mchehab@kernel.org, hverkuil@xs4all.nl
Cc:     Shuah Khan <shuah@kernel.org>, keescook@chromium.org,
        niklas.soderlund+renesas@ragnatech.se,
        sakari.ailus@linux.intel.com, colin.king@canonical.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] au0828: Fix NULL pointer dereference in au0828_analog_stream_enable()
Date:   Mon,  1 Apr 2019 18:43:17 -0600
Message-Id: <20190402004318.30309-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix au0828_analog_stream_enable() to check if device is in the right
state first. When unbind happens while bind is in progress, usbdev
pointer could be invalid in au0828_analog_stream_enable() and a call
to usb_ifnum_to_if() will result in the null pointer dereference.

This problem is found with the new media_dev_allocator.sh test.

kernel: [  590.359623] BUG: unable to handle kernel NULL pointer dereference at 00000000000004e8
kernel: [  590.359627] #PF error: [normal kernel read fault]
kernel: [  590.359629] PGD 0 P4D 0
kernel: [  590.359632] Oops: 0000 [#1] SMP PTI
kernel: [  590.359634] CPU: 3 PID: 1458 Comm: v4l_id Not tainted 5.1.0-rc2+ #30
kernel: [  590.359636] Hardware name: Dell Inc. OptiPlex 7 90/0HY9JP, BIOS A18 09/24/2013
kernel: [  590.359641] RIP: 0010:usb_ifnum_to_if+0x6/0x60
kernel: [  590.359643] Code: 5d 41 5e 41 5f 5d c3 48 83 c4
 10 b8 fa ff ff ff 5b 41 5c 41 5d 41 5e 41 5f 5d c3 b8 fa ff ff ff c3 0f 1f 00 6
6 66 66 66 90 55 <48> 8b 97 e8 04 00 00 48 89 e5 48 85 d2 74 41 0f b6 4a 04 84 c
9 74
kernel: [  590.359645] RSP: 0018:ffffad3cc3c1fc00 EFLAGS: 00010246
kernel: [  590.359646] RAX: 0000000000000000 RBX: ffff8ded b1f3c000 RCX: 1f377e4500000000
kernel: [  590.359648] RDX: ffff8dedfa3a6b50 RSI: 00000000 00000000 RDI: 0000000000000000
kernel: [  590.359649] RBP: ffffad3cc3c1fc28 R08: 00000000 8574acc2 R09: ffff8dedfa3a6b50
kernel: [  590.359650] R10: 0000000000000001 R11: 00000000 00000000 R12: 0000000000000000
kernel: [  590.359652] R13: ffff8dedb1f3f0f0 R14: ffffffff adcf7ec0 R15: 0000000000000000
kernel: [  590.359654] FS:  00007f7917198540(0000) GS:ffff 8dee258c0000(0000) knlGS:0000000000000000
kernel: [  590.359655] CS:  0010 DS: 0000 ES: 0000 CR0: 00 00000080050033
kernel: [  590.359657] CR2: 00000000000004e8 CR3: 00000001 a388e002 CR4: 00000000000606e0
kernel: [  590.359658] Call Trace:
kernel: [  590.359664]  ? au0828_analog_stream_enable+0x2c/0x180
kernel: [  590.359666]  au0828_v4l2_open+0xa4/0x110
kernel: [  590.359670]  v4l2_open+0x8b/0x120
kernel: [  590.359674]  chrdev_open+0xa6/0x1c0
kernel: [  590.359676]  ? cdev_put.part.3+0x20/0x20
kernel: [  590.359678]  do_dentry_open+0x1f6/0x360
kernel: [  590.359681]  vfs_open+0x2f/0x40
kernel: [  590.359684]  path_openat+0x299/0xc20
kernel: [  590.359688]  do_filp_open+0x9b/0x110
kernel: [  590.359695]  ? _raw_spin_unlock+0x27/0x40
kernel: [  590.359697]  ? __alloc_fd+0xb2/0x160
kernel: [  590.359700]  do_sys_open+0x1ba/0x260
kernel: [  590.359702]  ? do_sys_open+0x1ba/0x260
kernel: [  590.359712]  __x64_sys_openat+0x20/0x30
kernel: [  590.359715]  do_syscall_64+0x5a/0x120
kernel: [  590.359718]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/media/usb/au0828/au0828-video.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/au0828/au0828-video.c
index 7876c897cc1d..106a49da39f9 100644
--- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -758,6 +758,9 @@ static int au0828_analog_stream_enable(struct au0828_dev *d)
 
 	dprintk(1, "au0828_analog_stream_enable called\n");
 
+	if (test_bit(DEV_DISCONNECTED, &d->dev_state))
+		return -ENODEV;
+
 	iface = usb_ifnum_to_if(d->usbdev, 0);
 	if (iface && iface->cur_altsetting->desc.bAlternateSetting != 5) {
 		dprintk(1, "Changing intf#0 to alt 5\n");
-- 
2.17.1

