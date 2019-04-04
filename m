Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83267C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C7B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369370;
	bh=BbJslJw2A8arY/D7VGkoQqi87TcgSVDRjo0Ue8XeHOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DBAzM8KzQ1J+se1mYBVVx+nV7u8/YbMT2R83oihcJ3TWN7hGYx80ZfyZSa2qewpEM
	 7USnVIdOtqALLEgansbk9YgM/OcZN3kCJhR/No6sDjtt3+E5/EPSeZmrObRoG+Gduv
	 QNAL9oCCvuZWc3ui7NEkeyu975PG0EBB5W0/4ObM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbfDDJQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387993AbfDDJQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A0920652;
        Thu,  4 Apr 2019 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369365;
        bh=BbJslJw2A8arY/D7VGkoQqi87TcgSVDRjo0Ue8XeHOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1V/nBh4lbpwbNJmV1nWJXPd9RDc1vL5RrivI8FfGcig1/KZ2LsAiRKxfpgYxcJkp
         fdOJ+TwqMoNMIJQcFmD3q8YPZ1t+KrF8Prc1HDmqU8b8GJatBfGOi4sH8DTx6XYQfk
         3FbN7npR402uJtllwBylZ9UCFondLxyWFKXFsXdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 196/246] ALSA: dice: add support for Solid State Logic Duende Classic/Mini
Date:   Thu,  4 Apr 2019 10:48:16 +0200
Message-Id: <20190404084626.050030033@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



