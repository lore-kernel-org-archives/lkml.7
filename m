Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126FDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE7621905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126576;
	bh=RztbIozVo0PRzL2pERKy1Xxzfw+CJNXeJBMpxDAGFkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dfsAQhhsTrSkKGGyi/awkOTau9WNURASeQugON8kPlsSm466gdhhTx1+bit3/WthA
	 bAPnzrrNfAIBLvi6KbByzP/cXCzUjyzwTHtaOAwKuueVEqBDK+2pqMFDiki3a0IlsB
	 GgUQNLfgI3Sj0VnhLDJeKclZb4FieHU++TChmITY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389435AbfDXRWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389399AbfDXRWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:22:52 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B053020675;
        Wed, 24 Apr 2019 17:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126570;
        bh=RztbIozVo0PRzL2pERKy1Xxzfw+CJNXeJBMpxDAGFkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVHN/i+z8xPvIil4owTXBMZPkoNpa1Gh1GN5YwlKlUipMlIzQjpiNIlKaAu1PBl2m
         HicYtpCRS00lQ8byqeweXEXQArh5AJnfYlsl6k/st67+fiFXKHTxEuynPbmnlzRD/O
         5nPhGc43sKiH1kmratxs3/2xzOuNgd+DMW3/T1YY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+cf4f2b6c24aff0a3edf6@syzkaller.appspotmail.com,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.4 155/168] staging: comedi: ni_usb6501: Fix use of uninitialized mutex
Date:   Wed, 24 Apr 2019 19:09:59 +0200
Message-Id: <20190424170932.318286412@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

commit 660cf4ce9d0f3497cc7456eaa6d74c8b71d6282c upstream.

If `ni6501_auto_attach()` returns an error, the core comedi module code
will call `ni6501_detach()` to clean up.  If `ni6501_auto_attach()`
successfully allocated the comedi device private data, `ni6501_detach()`
assumes that a `struct mutex mut` contained in the private data has been
initialized and uses it.  Unfortunately, there are a couple of places
where `ni6501_auto_attach()` can return an error after allocating the
device private data but before initializing the mutex, so this
assumption is invalid.  Fix it by initializing the mutex just after
allocating the private data in `ni6501_auto_attach()` before any other
errors can be retturned.  Also move the call to `usb_set_intfdata()`
just to keep the code a bit neater (either position for the call is
fine).

I believe this was the cause of the following syzbot crash report
<https://syzkaller.appspot.com/bug?extid=cf4f2b6c24aff0a3edf6>:

usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: string descriptor 0 read error: -71
comedi comedi0: Wrong number of endpoints
ni6501 1-1:0.233: driver 'ni6501' failed to auto-configure device.
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 585 Comm: kworker/0:3 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xe8/0x16e lib/dump_stack.c:113
 assign_lock_key kernel/locking/lockdep.c:786 [inline]
 register_lock_class+0x11b8/0x1250 kernel/locking/lockdep.c:1095
 __lock_acquire+0xfb/0x37c0 kernel/locking/lockdep.c:3582
 lock_acquire+0x10d/0x2f0 kernel/locking/lockdep.c:4211
 __mutex_lock_common kernel/locking/mutex.c:925 [inline]
 __mutex_lock+0xfe/0x12b0 kernel/locking/mutex.c:1072
 ni6501_detach+0x5b/0x110 drivers/staging/comedi/drivers/ni_usb6501.c:567
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

Reported-by: syzbot+cf4f2b6c24aff0a3edf6@syzkaller.appspotmail.com
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/ni_usb6501.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/staging/comedi/drivers/ni_usb6501.c
+++ b/drivers/staging/comedi/drivers/ni_usb6501.c
@@ -527,6 +527,9 @@ static int ni6501_auto_attach(struct com
 	if (!devpriv)
 		return -ENOMEM;
 
+	mutex_init(&devpriv->mut);
+	usb_set_intfdata(intf, devpriv);
+
 	ret = ni6501_find_endpoints(dev);
 	if (ret)
 		return ret;
@@ -535,9 +538,6 @@ static int ni6501_auto_attach(struct com
 	if (ret)
 		return ret;
 
-	mutex_init(&devpriv->mut);
-	usb_set_intfdata(intf, devpriv);
-
 	ret = comedi_alloc_subdevices(dev, 2);
 	if (ret)
 		return ret;


