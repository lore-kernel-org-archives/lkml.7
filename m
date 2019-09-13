Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE5EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37833206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380118;
	bh=FSEVT/+1VHTgLO2+uI/kzL9mJ+RtrS330/6onc1ZT9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cY39hX8FD8diaN1wO0qQTTiZpkuV/7ukkJgx6Rgd4RPyHUwnzNt6xkwYbRkSIlN29
	 Wjbvg1Cj8VseDSuNUcl7Wk7nqz5dUDuNhxR0EQ9G8MbtlC/4oQHHKA1thzSQgL1Esm
	 uqsd9XJ/nqsijPrQpAjKBLBb8YyUiaesDWAocR/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbfIMNIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388092AbfIMNIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:08:36 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68CEF206A5;
        Fri, 13 Sep 2019 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380115;
        bh=FSEVT/+1VHTgLO2+uI/kzL9mJ+RtrS330/6onc1ZT9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+OQTT1k3KUl1ggJ4O5+AuRIGJqP4a3nCHh19Z5lxR1BFsBfI1eWNWsSo/euzdDwb
         7InkkRxe0PImDmgRkJMqd0h52JQZcJ+WHXfR7H9VJttKqIqxf8ZhQWuWMsiiW3/B/m
         LUWyuyJ6DCzNTDOH7sRIO9+mgIFX8pH5SPnRNbHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 2/9] ALSA: hda/realtek - Fix overridden device-specific initialization
Date:   Fri, 13 Sep 2019 14:06:52 +0100
Message-Id: <20190913130426.454304938@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130424.160808669@linuxfoundation.org>
References: <20190913130424.160808669@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_generic.c   |    3 ++-
 sound/pci/hda/hda_generic.h   |    1 +
 sound/pci/hda/patch_realtek.c |    2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5826,7 +5826,8 @@ int snd_hda_gen_init(struct hda_codec *c
 	if (spec->init_hook)
 		spec->init_hook(codec);
 
-	snd_hda_apply_verbs(codec);
+	if (!spec->skip_verbs)
+		snd_hda_apply_verbs(codec);
 
 	init_multi_out(codec);
 	init_extra_out(codec);
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -236,6 +236,7 @@ struct hda_gen_spec {
 	unsigned int indep_hp_enabled:1; /* independent HP enabled */
 	unsigned int have_aamix_ctl:1;
 	unsigned int hp_mic_jack_modes:1;
+	unsigned int skip_verbs:1; /* don't apply verbs at snd_hda_gen_init() */
 
 	/* additional mute flags (only effective with auto_mute_via_amp=1) */
 	u64 mute_bits;
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -772,9 +772,11 @@ static int alc_init(struct hda_codec *co
 	if (spec->init_hook)
 		spec->init_hook(codec);
 
+	spec->gen.skip_verbs = 1; /* applied in below */
 	snd_hda_gen_init(codec);
 	alc_fix_pll(codec);
 	alc_auto_init_amp(codec, spec->init_amp);
+	snd_hda_apply_verbs(codec); /* apply verbs here after own init */
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
 


