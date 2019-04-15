Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207BC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477402073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="i87dFwty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfDOLQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:16:57 -0400
Received: from smtp89.iad3a.emailsrvr.com ([173.203.187.89]:40596 "EHLO
        smtp89.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726556AbfDOLQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:16:52 -0400
Received: from smtp36.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp36.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id EEF8C5411;
        Mon, 15 Apr 2019 07:10:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1555326626;
        bh=j+DHzsSJxQ+gYw/J6ALZI9lDN1nFeAyj5uJ+Cf22z8E=;
        h=From:To:Subject:Date:From;
        b=i87dFwtyaStogSMCfIosBpCAWm0TIkfqySEJ05yk5E1gRlqMsDJwOgp1WugVQRUlW
         I536BmKdSCvLdHzIYUqhuTOTbN0u2wn4HiyvnEyyybr97+VIOVatQQAGjS/G3dUJeS
         grzKzQs4aAZ0hL6nhOqC7t2SsZFHC9z2Jmchvcng=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp36.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 1C09C5407;
        Mon, 15 Apr 2019 07:10:26 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 15 Apr 2019 07:10:26 -0400
From:   Ian Abbott <abbotti@mev.co.uk>
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org,
        syzbot+54c2f58f15fe6876b6ad@syzkaller.appspotmail.com
Subject: [PATCH 1/2] staging: comedi: vmk80xx: Fix use of uninitialized semaphore
Date:   Mon, 15 Apr 2019 12:10:14 +0100
Message-Id: <20190415111015.8257-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415111015.8257-1-abbotti@mev.co.uk>
References: <20190415111015.8257-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If `vmk80xx_auto_attach()` returns an error, the core comedi module code
will call `vmk80xx_detach()` to clean up.  If `vmk80xx_auto_attach()`
successfully allocated the comedi device private data,
`vmk80xx_detach()` assumes that a `struct semaphore limit_sem` contained
in the private data has been initialized and uses it.  Unfortunately,
there are a couple of places where `vmk80xx_auto_attach()` can return an
error after allocating the device private data but before initializing
the semaphore, so this assumption is invalid.  Fix it by initializing
the semaphore just after allocating the private data in
`vmk80xx_auto_attach()` before any other errors can be returned.

I believe this was the cause of the following syzbot crash report
<https://syzkaller.appspot.com/bug?extid=54c2f58f15fe6876b6ad>:

usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=10cf, idProduct=8068, bcdDevice=e6.8d
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
vmk80xx 1-1:0.117: driver 'vmk80xx' failed to auto-configure device.
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xe8/0x16e lib/dump_stack.c:113
 assign_lock_key kernel/locking/lockdep.c:786 [inline]
 register_lock_class+0x11b8/0x1250 kernel/locking/lockdep.c:1095
 __lock_acquire+0xfb/0x37c0 kernel/locking/lockdep.c:3582
 lock_acquire+0x10d/0x2f0 kernel/locking/lockdep.c:4211
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x44/0x60 kernel/locking/spinlock.c:152
 down+0x12/0x80 kernel/locking/semaphore.c:58
 vmk80xx_detach+0x59/0x100 drivers/staging/comedi/drivers/vmk80xx.c:829
 comedi_device_detach+0xed/0x800 drivers/staging/comedi/drivers.c:204
 comedi_device_cleanup.part.0+0x68/0x140 drivers/staging/comedi/comedi_fops.c:156
 comedi_device_cleanup drivers/staging/comedi/comedi_fops.c:187 [inline]
 comedi_free_board_dev.part.0+0x16/0x90 drivers/staging/comedi/comedi_fops.c:190
 comedi_free_board_dev drivers/staging/comedi/comedi_fops.c:189 [inline]
 comedi_release_hardware_device+0x111/0x140 drivers/staging/comedi/comedi_fops.c:2880
 comedi_auto_config.cold+0x124/0x1b0 drivers/staging/comedi/drivers.c:1068
 usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
 really_probe+0x2da/0xb10 drivers/base/dd.c:509
 driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
 __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
 bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
 __device_attach+0x223/0x3a0 drivers/base/dd.c:844
 bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
 device_add+0xad2/0x16e0 drivers/base/core.c:2106
 usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
 generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
 usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
 really_probe+0x2da/0xb10 drivers/base/dd.c:509
 driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
 __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
 bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
 __device_attach+0x223/0x3a0 drivers/base/dd.c:844
 bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
 device_add+0xad2/0x16e0 drivers/base/core.c:2106
 usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
 hub_port_connect drivers/usb/core/hub.c:5089 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
 port_event drivers/usb/core/hub.c:5350 [inline]
 hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
 process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
 worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
 kthread+0x313/0x420 kernel/kthread.c:253
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Reported-by: syzbot+54c2f58f15fe6876b6ad@syzkaller.appspotmail.com
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/drivers/vmk80xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/vmk80xx.c b/drivers/staging/comedi/drivers/vmk80xx.c
index 6234b649d887..b035d662390b 100644
--- a/drivers/staging/comedi/drivers/vmk80xx.c
+++ b/drivers/staging/comedi/drivers/vmk80xx.c
@@ -800,6 +800,8 @@ static int vmk80xx_auto_attach(struct comedi_device *dev,
 
 	devpriv->model = board->model;
 
+	sema_init(&devpriv->limit_sem, 8);
+
 	ret = vmk80xx_find_usb_endpoints(dev);
 	if (ret)
 		return ret;
@@ -808,8 +810,6 @@ static int vmk80xx_auto_attach(struct comedi_device *dev,
 	if (ret)
 		return ret;
 
-	sema_init(&devpriv->limit_sem, 8);
-
 	usb_set_intfdata(intf, devpriv);
 
 	if (devpriv->model == VMK8055_MODEL)
-- 
2.20.1

