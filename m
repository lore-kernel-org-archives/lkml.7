Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1660C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C293521773
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909355;
	bh=Jl0KP1gBPY46F7Qi5eYWw3hmLXbME6CJbG8G1cX4GG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sPLXA6iwFmuM1OmlykNNBaGwIALaNPp2FIPls20RuV4tNhRLy5d5CBleENJQ7Sk32
	 Foh1p573/nEk2yvTxcFg0Zy7yl0burGsOdN6VFo2Q/MAn/g5q1W5j6f8OkmaJKCeGw
	 Eb9MpHhqgoitXkwKLVUJSN0l5gwFSar/fmhoNs4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfC3B3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730848AbfC3B3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:29:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BC321773;
        Sat, 30 Mar 2019 01:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909351;
        bh=Jl0KP1gBPY46F7Qi5eYWw3hmLXbME6CJbG8G1cX4GG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v86s28Yb6KjrzIV3sVkDcswCYulyl9udSjJExrMtjwPjfSrsCNQ9wjWdT9UrmNdtr
         OS3IkHJCaJiHH9cPOeM5Qhj7kGWlvuOIpd56jVK0TbSbSYcQealIjW7DwFlqL6I+0p
         IL90+yHNLBCoy1I3ZIEAqSZ6ZiBTzgzkb6SEcq5k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brad Love <brad@nextdimension.cc>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/57] media: au0828: cannot kfree dev before usb disconnect
Date:   Fri, 29 Mar 2019 21:28:05 -0400
Message-Id: <20190330012854.32212-12-sashal@kernel.org>
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

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit 4add7104919f9e94e0db03e234caeadbfcc02ea9 ]

If au0828_analog_register fails, the dev is kfree'd and then flow
jumps to done, which can call au0828_usb_disconnect. Since all USB
error codes are negative, au0828_usb_disconnect will be called. The
problem is au0828_usb_disconnect uses dev, if dev is NULL then there
is immediate oops encountered.

[    7.454307] au0828: au0828_usb_probe() au0282_dev_register failed to register on V4L2
[    7.454323] BUG: unable to handle kernel NULL pointer dereference at 0000000000000050
[    7.454421] PGD 0 P4D 0
[    7.454457] Oops: 0002 [#1] SMP PTI
[    7.454500] CPU: 1 PID: 262 Comm: systemd-udevd Tainted: P           O      4.18.3 #1
[    7.454584] Hardware name: Google Panther/Panther, BIOS MattDevo 04/27/2015
[    7.454670] RIP: 0010:_raw_spin_lock_irqsave+0x2c/0x50
[    7.454725] Code: 44 00 00 55 48 89 e5 41 54 53 48 89 fb 9c 58 0f 1f 44 00 00 49 89 c4 fa 66 0f 1f 44 00 00 e8 db 23 1b ff 31 c0 ba 01 00 00 00 <f0> 0f b1 13 85 c0 75 08 4c 89 e0 5b 41 5c 5d c3 89 c6 48 89 df e8
[    7.455004] RSP: 0018:ffff9130f53ef988 EFLAGS: 00010046
[    7.455063] RAX: 0000000000000000 RBX: 0000000000000050 RCX: 0000000000000000
[    7.455139] RDX: 0000000000000001 RSI: 0000000000000003 RDI: 0000000000000050
[    7.455216] RBP: ffff9130f53ef998 R08: 0000000000000018 R09: 0000000000000090
[    7.455292] R10: ffffed4cc53cb000 R11: ffffed4cc53cb108 R12: 0000000000000082
[    7.455369] R13: ffff9130cf2c6188 R14: 0000000000000000 R15: 0000000000000018
[    7.455447] FS:  00007f2ff8514cc0(0000) GS:ffff9130fcb00000(0000) knlGS:0000000000000000
[    7.455535] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.455597] CR2: 0000000000000050 CR3: 00000001753f0002 CR4: 00000000000606a0
[    7.455675] Call Trace:
[    7.455713]  __wake_up_common_lock+0x65/0xc0
[    7.455764]  __wake_up+0x13/0x20
[    7.455808]  ir_lirc_unregister+0x57/0xe0 [rc_core]
[    7.455865]  rc_unregister_device+0xa0/0xc0 [rc_core]
[    7.455935]  au0828_rc_unregister+0x25/0x40 [au0828]
[    7.455999]  au0828_usb_disconnect+0x33/0x80 [au0828]
[    7.456064]  au0828_usb_probe.cold.16+0x8d/0x2aa [au0828]
[    7.456130]  usb_probe_interface+0xf1/0x300
[    7.456184]  driver_probe_device+0x2e3/0x460
[    7.456235]  __driver_attach+0xe4/0x110
[    7.456282]  ? driver_probe_device+0x460/0x460
[    7.456335]  bus_for_each_dev+0x74/0xb0
[    7.456385]  ? kmem_cache_alloc_trace+0x15d/0x1d0
[    7.456441]  driver_attach+0x1e/0x20
[    7.456485]  bus_add_driver+0x159/0x230
[    7.456532]  driver_register+0x70/0xc0
[    7.456578]  usb_register_driver+0x7f/0x140
[    7.456626]  ? 0xffffffffc0474000
[    7.456674]  au0828_init+0xbc/0x1000 [au0828]
[    7.456725]  do_one_initcall+0x4a/0x1c9
[    7.456771]  ? _cond_resched+0x19/0x30
[    7.456817]  ? kmem_cache_alloc_trace+0x15d/0x1d0
[    7.456873]  do_init_module+0x60/0x210
[    7.456918]  load_module+0x221b/0x2710
[    7.456966]  ? vfs_read+0xf5/0x120
[    7.457010]  __do_sys_finit_module+0xbd/0x120
[    7.457061]  ? __do_sys_finit_module+0xbd/0x120
[    7.457115]  __x64_sys_finit_module+0x1a/0x20
[    7.457166]  do_syscall_64+0x5b/0x110
[    7.457210]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/au0828/au0828-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index cd363a2100d4..257ae0d8cfe2 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -629,7 +629,6 @@ static int au0828_usb_probe(struct usb_interface *interface,
 		pr_err("%s() au0282_dev_register failed to register on V4L2\n",
 			__func__);
 		mutex_unlock(&dev->lock);
-		kfree(dev);
 		goto done;
 	}
 
-- 
2.19.1

