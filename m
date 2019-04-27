Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8228C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC23208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfD0P1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:27:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33206 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727391AbfD0PPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:24 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2t-0000zO-BW; Sat, 27 Apr 2019 16:15:19 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2n-0004e9-U2; Sat, 27 Apr 2019 16:15:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Matthias Schwarzott" <zzam@gentoo.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.574446912@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 186/202] media: em28xx: Fix use-after-free when
 disconnecting
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Schwarzott <zzam@gentoo.org>

commit 910b0797fa9e8af09c44a3fa36cb310ba7a7218d upstream.

Fix bug by moving the i2c_unregister_device calls after deregistration
of dvb frontend.

The new style i2c drivers already destroys the frontend object at
i2c_unregister_device time.
When the dvb frontend is unregistered afterwards it leads to this oops:

  [ 6058.866459] BUG: unable to handle kernel NULL pointer dereference at 00000000000001f8
  [ 6058.866578] IP: dvb_frontend_stop+0x30/0xd0 [dvb_core]
  [ 6058.866644] PGD 0
  [ 6058.866646] P4D 0

  [ 6058.866726] Oops: 0000 [#1] SMP
  [ 6058.866768] Modules linked in: rc_pinnacle_pctv_hd(O) em28xx_rc(O) si2157(O) si2168(O) em28xx_dvb(O) em28xx(O) si2165(O) a8293(O) tda10071(O) tea5767(O) tuner(O) cx23885(O) tda18271(O) videobuf2_dvb(O) videobuf2_dma_sg(O) m88ds3103(O) tveeprom(O) cx2341x(O) v4l2_common(O) dvb_core(O) rc_core(O) videobuf2_memops(O) videobuf2_v4l2(O) videobuf2_core(O) videodev(O) media(O) bluetooth ecdh_generic ums_realtek uas rtl8192cu rtl_usb rtl8192c_common rtlwifi usb_storage snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic i2c_mux snd_hda_intel snd_hda_codec snd_hwdep x86_pkg_temp_thermal snd_hda_core kvm_intel kvm irqbypass [last unloaded: videobuf2_memops]
  [ 6058.867497] CPU: 2 PID: 7349 Comm: kworker/2:0 Tainted: G        W  O    4.13.9-gentoo #1
  [ 6058.867595] Hardware name: MEDION E2050 2391/H81H3-EM2, BIOS H81EM2W08.308 08/25/2014
  [ 6058.867692] Workqueue: usb_hub_wq hub_event
  [ 6058.867746] task: ffff88011a15e040 task.stack: ffffc90003074000
  [ 6058.867825] RIP: 0010:dvb_frontend_stop+0x30/0xd0 [dvb_core]
  [ 6058.867896] RSP: 0018:ffffc90003077b58 EFLAGS: 00010293
  [ 6058.867964] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000010040001f
  [ 6058.868056] RDX: ffff88011a15e040 RSI: ffffea000464e400 RDI: ffff88001cbe3028
  [ 6058.868150] RBP: ffffc90003077b68 R08: ffff880119390380 R09: 000000010040001f
  [ 6058.868241] R10: ffffc90003077b18 R11: 000000000001e200 R12: ffff88001cbe3028
  [ 6058.868330] R13: ffff88001cbe68d0 R14: ffff8800cf734000 R15: ffff8800cf734098
  [ 6058.868419] FS:  0000000000000000(0000) GS:ffff88011fb00000(0000) knlGS:0000000000000000
  [ 6058.868511] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 6058.868578] CR2: 00000000000001f8 CR3: 00000001113c5000 CR4: 00000000001406e0
  [ 6058.868662] Call Trace:
  [ 6058.868705]  dvb_unregister_frontend+0x2a/0x80 [dvb_core]
  [ 6058.868774]  em28xx_dvb_fini+0x132/0x220 [em28xx_dvb]
  [ 6058.868840]  em28xx_close_extension+0x34/0x90 [em28xx]
  [ 6058.868902]  em28xx_usb_disconnect+0x4e/0x70 [em28xx]
  [ 6058.868968]  usb_unbind_interface+0x6d/0x260
  [ 6058.869025]  device_release_driver_internal+0x150/0x210
  [ 6058.869094]  device_release_driver+0xd/0x10
  [ 6058.869150]  bus_remove_device+0xe4/0x160
  [ 6058.869204]  device_del+0x1ce/0x2f0
  [ 6058.869253]  usb_disable_device+0x99/0x270
  [ 6058.869306]  usb_disconnect+0x8d/0x260
  [ 6058.869359]  hub_event+0x93d/0x1520
  [ 6058.869408]  ? dequeue_task_fair+0xae5/0xd20
  [ 6058.869467]  process_one_work+0x1d9/0x3e0
  [ 6058.869522]  worker_thread+0x43/0x3e0
  [ 6058.869576]  kthread+0x104/0x140
  [ 6058.869602]  ? trace_event_raw_event_workqueue_work+0x80/0x80
  [ 6058.869640]  ? kthread_create_on_node+0x40/0x40
  [ 6058.869673]  ret_from_fork+0x22/0x30
  [ 6058.869698] Code: 54 49 89 fc 53 48 8b 9f 18 03 00 00 0f 1f 44 00 00 41 83 bc 24 04 05 00 00 02 74 0c 41 c7 84 24 04 05 00 00 01 00 00 00 0f ae f0 <48> 8b bb f8 01 00 00 48 85 ff 74 5c e8 df 40 f0 e0 48 8b 93 f8
  [ 6058.869850] RIP: dvb_frontend_stop+0x30/0xd0 [dvb_core] RSP: ffffc90003077b58
  [ 6058.869894] CR2: 00000000000001f8
  [ 6058.875880] ---[ end trace 717eecf7193b3fc6 ]---

Signed-off-by: Matthias Schwarzott <zzam@gentoo.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/em28xx/em28xx-dvb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/usb/em28xx/em28xx-dvb.c
+++ b/drivers/media/usb/em28xx/em28xx-dvb.c
@@ -1651,6 +1651,8 @@ static int em28xx_dvb_fini(struct em28xx
 			prevent_sleep(&dvb->fe[1]->ops);
 	}
 
+	em28xx_unregister_dvb(dvb);
+
 	/* remove I2C tuner */
 	if (client) {
 		module_put(client->dev.driver->owner);
@@ -1664,7 +1666,6 @@ static int em28xx_dvb_fini(struct em28xx
 		i2c_unregister_device(client);
 	}
 
-	em28xx_unregister_dvb(dvb);
 	kfree(dvb);
 	dev->dvb = NULL;
 	kref_put(&dev->ref, em28xx_free_device);

