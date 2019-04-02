Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0220C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B65320856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbfDBNnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:43:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43562 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731500AbfDBNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:10 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe3-0002oY-Ng; Tue, 02 Apr 2019 14:40:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdy-0004y7-5h; Tue, 02 Apr 2019 14:40:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Dara Ramesh" <dramesh@nvidia.com>,
        "Sameer Pujar" <spujar@nvidia.com>, "Takashi Iwai" <tiwai@suse.de>,
        "Mohan Kumar" <mkumard@nvidia.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.224314050@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 95/99] ALSA: hda/tegra: clear pending irq handlers
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sameer Pujar <spujar@nvidia.com>

commit 63d2a9ec310d8bcc955574220d4631aa55c1a80c upstream.

Even after disabling interrupts on the module, it could be possible
that irq handlers are still running. System hang is seen during
suspend path. It was found that, there were pending writes on the
HDA bus and clock was disabled by that time.

Above mentioned issue is fixed by clearing any pending irq handlers
before disabling clocks and returning from hda suspend.

Suggested-by: Mohan Kumar <mkumard@nvidia.com>
Suggested-by: Dara Ramesh <dramesh@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/hda/hda_tegra.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -253,6 +253,7 @@ static int hda_tegra_suspend(struct devi
 	struct azx *chip = card->private_data;
 	struct azx_pcm *p;
 	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
+	struct hdac_bus *bus = azx_bus(chip);
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	list_for_each_entry(p, &chip->pcm_list, list)
@@ -261,6 +262,7 @@ static int hda_tegra_suspend(struct devi
 		snd_hda_suspend(chip->bus);
 
 	azx_stop_chip(chip);
+	synchronize_irq(bus->irq);
 	azx_enter_link_reset(chip);
 	hda_tegra_disable_clocks(hda);
 

