Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F113FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34FC206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714243;
	bh=yMITNGy/kMorXgfHSGTSNJD45OsqYKrkmRgAgPDkwgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ihwd8wABim17J3pXVJjTado17W67qgh+7bgMhZpQ4Qo8dx+LykJW7GCizY/YV8o1
	 osN2DA0Goh4OjClOukvrTND7iLqKpOaCKMmqQKnmQhrrOMIAK6QeP7ChmFcDBwzkZ1
	 StRbhp7dNrW5bZzMFtZuw5hr/Wkon1wUjtqDn248=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbfC0TRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388414AbfC0SIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6273521734;
        Wed, 27 Mar 2019 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710130;
        bh=yMITNGy/kMorXgfHSGTSNJD45OsqYKrkmRgAgPDkwgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RY7cmsCEEDX/l6ZnIN0V8a31dY3boT0k7CNgBJrzQQSNlXtKl/PGKpq/dkyuHW5+i
         IhTqH6jDTKA1i7El2Qst5I8ZJjZIM0QURSFMp3m63C2nb9O41Pty5gK6jNkUxjqcA8
         n0yDyuHXcHyxt8vE6zBlVEOy/rDPbBPFGge0L74Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 208/262] ALSA: dice: add support for Solid State Logic Duende Classic/Mini
Date:   Wed, 27 Mar 2019 14:01:03 -0400
Message-Id: <20190327180158.10245-208-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit b2e9e1c8810ee05c95f4d55800b8afae70ab01b4 ]

Duende Classic was produced by Solid State Logic in 2006, as a
first model of Duende DSP series. The following model, Duende Mini
was produced in 2008. They are designed to receive isochronous
packets for PCM frames via IEEE 1394 bus, perform signal processing by
downloaded program, then transfer isochronous packets for converted
PCM frames.

These two models includes the same embedded board, consists of several
ICs below:
 - Texus Instruments Inc, TSB41AB3 for physical layer of IEEE 1394 bus
 - WaveFront semiconductor, DICE II STD ASIC for link/protocol layer
 - Altera MAX 3000A CPLD for programs
 - Analog devices, SHARC ADSP-21363 for signal processing (4 chips)

This commit adds support for the two models to ALSA dice driver. Like
support for the other devices, packet streaming is just available.
Userspace applications should be developed if full features became
available; e.g. program uploader and parameter controller.

$ ./hinawa-config-rom-printer /dev/fw1
{ 'bus-info': { 'adj': False,
                'bmc': False,
                'chip_ID': 349771402425,
                'cmc': True,
                'cyc_clk_acc': 255,
                'generation': 1,
                'imc': True,
                'isc': True,
                'link_spd': 2,
                'max_ROM': 1,
                'max_rec': 512,
                'name': '1394',
                'node_vendor_ID': 20674,
                'pmc': False},
  'root-directory': [ ['VENDOR', 20674],
                      ['DESCRIPTOR', 'Solid State Logic'],
                      ['MODEL', 112],
                      ['DESCRIPTOR', 'Duende board'],
                      [ 'NODE_CAPABILITIES',
                        { 'addressing': {'64': True, 'fix': True, 'prv': True},
                          'misc': {'int': False, 'ms': False, 'spt': True},
                          'state': { 'atn': False,
                                     'ded': False,
                                     'drq': True,
                                     'elo': False,
                                     'init': False,
                                     'lst': True,
                                     'off': False},
                          'testing': {'bas': False, 'ext': False}}],
                      [ 'UNIT',
                        [ ['SPECIFIER_ID', 20674],
                          ['VERSION', 1],
                          ['MODEL', 112],
                          ['DESCRIPTOR', 'Duende board']]]]}

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/dice/dice.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index ed50b222d36e..eee184b05d93 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -18,6 +18,7 @@ MODULE_LICENSE("GPL v2");
 #define OUI_ALESIS		0x000595
 #define OUI_MAUDIO		0x000d6c
 #define OUI_MYTEK		0x001ee8
+#define OUI_SSL			0x0050c2	// Actually ID reserved by IEEE.
 
 #define DICE_CATEGORY_ID	0x04
 #define WEISS_CATEGORY_ID	0x00
@@ -196,7 +197,7 @@ static int dice_probe(struct fw_unit *unit,
 	struct snd_dice *dice;
 	int err;
 
-	if (!entry->driver_data) {
+	if (!entry->driver_data && entry->vendor_id != OUI_SSL) {
 		err = check_dice_category(unit);
 		if (err < 0)
 			return -ENODEV;
@@ -361,6 +362,15 @@ static const struct ieee1394_device_id dice_id_table[] = {
 		.model_id	= 0x000002,
 		.driver_data = (kernel_ulong_t)snd_dice_detect_mytek_formats,
 	},
+	// Solid State Logic, Duende Classic and Mini.
+	// NOTE: each field of GUID in config ROM is not compliant to standard
+	// DICE scheme.
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_SSL,
+		.model_id	= 0x000070,
+	},
 	{
 		.match_flags = IEEE1394_MATCH_VERSION,
 		.version     = DICE_INTERFACE,
-- 
2.19.1

