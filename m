Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7598AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4640A2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582319;
	bh=x3Mi4ezUKPk706ty9nGyMs3+lbzbM3DzZvA6MPbL3UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2lXsVZJyMupc6O+uhgEj1pBJTICoIslMSyB2cJSfvkFy7WcB98nXd7i1spWP+M9VT
	 SBc50KL3/nndXCO3Z3kA5AWbn4KCaVhAG3tuI3oWFBUaA2XeOv5oDBJ4kGQzJGD/+n
	 bmAaD1iUKdHLoNSoIiVYJw7GTYwumb2Nk+yvprZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbfCZGih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732245AbfCZGic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:38:32 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40A42086C;
        Tue, 26 Mar 2019 06:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582311;
        bh=x3Mi4ezUKPk706ty9nGyMs3+lbzbM3DzZvA6MPbL3UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1vRJLrZ628Qn+pbdXUq8hzRwnJpky8er54lhkXttZLE/b/DOU4CiajIiaud0mxoc9
         pbGVUUCFrsVXUpPl+yn9uBN6BVxp/lZAY+O0SAOhGXbIM87IRNvlRniVHMq4FesGR+
         cTJQhdXP8/9B7MOTw/mFG//9ySXsTr1bMxo0TUI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 02/52] ALSA: firewire-motu: use version field of unit directory to identify model
Date:   Tue, 26 Mar 2019 15:29:49 +0900
Message-Id: <20190326042701.088533815@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 2d012c65a9ca26a0ef87ea0a42f1653dd37155f5 upstream.

Current ALSA firewire-motu driver uses the value of 'model' field
of unit directory in configuration ROM for modalias for MOTU
FireWire models. However, as long as I checked, Pre8 and
828mk3(Hybrid) have the same value for the field (=0x100800).

unit            | version   | model
--------------- | --------- | ----------
828mkII         | 0x000003  | 0x101800
Traveler        | 0x000009  | 0x107800
Pre8            | 0x00000f  | 0x100800 <-
828mk3(FW)      | 0x000015  | 0x106800
AudioExpress    | 0x000033  | 0x104800
828mk3(Hybrid)  | 0x000035  | 0x100800 <-

When updating firmware for MOTU 8pre FireWire from v1.0.0 to v1.0.3,
I got change of the value from 0x100800 to 0x103800. On the other
hand, the value of 'version' field is fixed to 0x00000f. As a quick
glance, the higher 12 bits of the value of 'version' field represent
firmware version, while the lower 12 bits is unknown.

By induction, the value of 'version' field represents actual model.

This commit changes modalias to match the value of 'version' field,
instead of 'model' field. For degug, long name of added sound card
includes hexadecimal value of 'model' field.

Fixes: 6c5e1ac0e144 ("ALSA: firewire-motu: add support for Motu Traveler")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/motu/motu.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -36,7 +36,7 @@ static void name_card(struct snd_motu *m
 	fw_csr_iterator_init(&it, motu->unit->directory);
 	while (fw_csr_iterator_next(&it, &key, &val)) {
 		switch (key) {
-		case CSR_VERSION:
+		case CSR_MODEL:
 			version = val;
 			break;
 		}
@@ -46,7 +46,7 @@ static void name_card(struct snd_motu *m
 	strcpy(motu->card->shortname, motu->spec->name);
 	strcpy(motu->card->mixername, motu->spec->name);
 	snprintf(motu->card->longname, sizeof(motu->card->longname),
-		 "MOTU %s (version:%d), GUID %08x%08x at %s, S%d",
+		 "MOTU %s (version:%06x), GUID %08x%08x at %s, S%d",
 		 motu->spec->name, version,
 		 fw_dev->config_rom[3], fw_dev->config_rom[4],
 		 dev_name(&motu->unit->device), 100 << fw_dev->max_speed);
@@ -237,20 +237,20 @@ static const struct snd_motu_spec motu_a
 #define SND_MOTU_DEV_ENTRY(model, data)			\
 {							\
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID |	\
-			  IEEE1394_MATCH_MODEL_ID |	\
-			  IEEE1394_MATCH_SPECIFIER_ID,	\
+			  IEEE1394_MATCH_SPECIFIER_ID |	\
+			  IEEE1394_MATCH_VERSION,	\
 	.vendor_id	= OUI_MOTU,			\
-	.model_id	= model,			\
 	.specifier_id	= OUI_MOTU,			\
+	.version	= model,			\
 	.driver_data	= (kernel_ulong_t)data,		\
 }
 
 static const struct ieee1394_device_id motu_id_table[] = {
-	SND_MOTU_DEV_ENTRY(0x101800, &motu_828mk2),
-	SND_MOTU_DEV_ENTRY(0x107800, &snd_motu_spec_traveler),
-	SND_MOTU_DEV_ENTRY(0x106800, &motu_828mk3),	/* FireWire only. */
-	SND_MOTU_DEV_ENTRY(0x100800, &motu_828mk3),	/* Hybrid. */
-	SND_MOTU_DEV_ENTRY(0x104800, &motu_audio_express),
+	SND_MOTU_DEV_ENTRY(0x000003, &motu_828mk2),
+	SND_MOTU_DEV_ENTRY(0x000009, &snd_motu_spec_traveler),
+	SND_MOTU_DEV_ENTRY(0x000015, &motu_828mk3),	/* FireWire only. */
+	SND_MOTU_DEV_ENTRY(0x000035, &motu_828mk3),	/* Hybrid. */
+	SND_MOTU_DEV_ENTRY(0x000033, &motu_audio_express),
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, motu_id_table);


