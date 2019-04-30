Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90761C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DF12075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfD3GNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:13:10 -0400
Received: from mail1.windriver.com ([147.11.146.13]:58527 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfD3GNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:13:10 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x3U6CAK5017535
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 29 Apr 2019 23:12:10 -0700 (PDT)
Received: from pek-lpggp3.wrs.com (128.224.153.76) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Apr 2019
 23:12:09 -0700
From:   Song liwei <liwei.song@windriver.com>
To:     <alsa-devel@alsa-project.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Yu Zhao <yuzhao@google.com>, Mark Brown <broonie@kernel.org>,
        Keyon Jie <yang.jie@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LiweiSong <liwei.song@windriver.com>
Subject: [PATCH] ALSA: hda: check RIRB to avoid use NULL pointer
Date:   Tue, 30 Apr 2019 02:10:53 -0400
Message-ID: <1556604653-47363-1-git-send-email-liwei.song@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liwei Song <liwei.song@windriver.com>

Fix the following BUG:

BUG: unable to handle kernel NULL pointer dereference at 000000000000000c
Workqueue: events azx_probe_work [snd_hda_intel]
RIP: 0010:snd_hdac_bus_update_rirb+0x80/0x160 [snd_hda_core]
Call Trace:
 <IRQ>
 azx_interrupt+0x78/0x140 [snd_hda_codec]
 __handle_irq_event_percpu+0x49/0x300
 handle_irq_event_percpu+0x23/0x60
 handle_irq_event+0x3c/0x60
 handle_edge_irq+0xdb/0x180
 handle_irq+0x23/0x30
 do_IRQ+0x6a/0x140
 common_interrupt+0xf/0xf

The Call Trace happened when run kdump on a NFS rootfs system.
Exist the following calling sequence when boot the second kernel:

azx_first_init()
   --> azx_acquire_irq()
                      <-- interrupt come in, azx_interrupt() was called
   --> hda_intel_init_chip()
      --> azx_init_chip()
         --> snd_hdac_bus_init_chip()
              --> snd_hdac_bus_init_cmd_io();
                    --> init rirb.buf and corb.buf

Interrupt happened after azx_acquire_irq() while RIRB still didn't got
initialized, then NULL pointer will be used when process the interrupt.

Check the value of RIRB to ensure it is not NULL, to aviod some special
case may hang the system.

Fixes: 14752412721c ("ALSA: hda - Add the controller helper codes to hda-core module")
Signed-off-by: Liwei Song <liwei.song@windriver.com>
---
 sound/hda/hdac_controller.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 74244d8e2909..2f0fa5353361 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -195,6 +195,9 @@ void snd_hdac_bus_update_rirb(struct hdac_bus *bus)
 		return;
 	bus->rirb.wp = wp;
 
+	if (!bus->rirb.buf)
+		return;
+
 	while (bus->rirb.rp != wp) {
 		bus->rirb.rp++;
 		bus->rirb.rp %= AZX_MAX_RIRB_ENTRIES;
-- 
2.7.4

