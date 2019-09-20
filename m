Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB65C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EE1207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbfITOZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:25:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36032 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388127AbfITOZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:25:04 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iBJqH-0004y6-H8; Fri, 20 Sep 2019 15:25:01 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iBJqE-0007th-Pm; Fri, 20 Sep 2019 15:24:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Fri, 20 Sep 2019 15:23:35 +0100
Message-ID: <lsq.1568989415.416974554@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 064/132] ALSA: hda/realtek - Fix overridden
 device-specific initialization
In-Reply-To: <lsq.1568989414.954567518@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.74-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 89781d0806c2c4f29072d3f00cb2dd4274aabc3d upstream.

The recent change to shuffle the codec initialization procedure for
Realtek via commit 607ca3bd220f ("ALSA: hda/realtek - EAPD turn on
later") caused the silent output on some machines.  This change was
supposed to be safe, but it isn't actually; some devices have quirk
setups to override the EAPD via COEF or BTL in the additional verb
table, which is applied at the beginning of snd_hda_gen_init().  And
this EAPD setup is again overridden in alc_auto_init_amp().

For recovering from the regression, tell snd_hda_gen_init() not to
apply the verbs there by a new flag, then apply the verbs in
alc_init().

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204727
Fixes: 607ca3bd220f ("ALSA: hda/realtek - EAPD turn on later")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/hda/hda_generic.c   | 3 ++-
 sound/pci/hda/hda_generic.h   | 1 +
 sound/pci/hda/patch_realtek.c | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5348,7 +5348,8 @@ int snd_hda_gen_init(struct hda_codec *c
 	if (spec->init_hook)
 		spec->init_hook(codec);
 
-	snd_hda_apply_verbs(codec);
+	if (!spec->skip_verbs)
+		snd_hda_apply_verbs(codec);
 
 	codec->cached_write = 1;
 
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -238,6 +238,7 @@ struct hda_gen_spec {
 	unsigned int indep_hp_enabled:1; /* independent HP enabled */
 	unsigned int have_aamix_ctl:1;
 	unsigned int hp_mic_jack_modes:1;
+	unsigned int skip_verbs:1; /* don't apply verbs at snd_hda_gen_init() */
 
 	/* additional mute flags (only effective with auto_mute_via_amp=1) */
 	u64 mute_bits;
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -831,9 +831,11 @@ static int alc_init(struct hda_codec *co
 	if (spec->init_hook)
 		spec->init_hook(codec);
 
+	spec->gen.skip_verbs = 1; /* applied in below */
 	snd_hda_gen_init(codec);
 	alc_fix_pll(codec);
 	alc_auto_init_amp(codec, spec->init_amp);
+	snd_hda_apply_verbs(codec); /* apply verbs here after own init */
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
 

