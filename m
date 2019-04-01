Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA71C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B50421929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138413;
	bh=bbu2JN35SIJoIm3Z972s24aiFMLemy7G7H6w+Y8cVcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KLNHwlBlQ0js2NbbZRq2eBiNbwFDwKe9rvTdvcITGgjpyOcrIPeEUlRqk9AqqDri+
	 rpTOcip3HdZKHFBL20FYWDvfBciUKO9it/LYczryz9rj3drHZJFwlpRYCez95FRFi1
	 hAdT7UqmMvn4F6tiaTfyn5oGDlAXEPkXQNhf8Vwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfDARGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbfDARGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:06:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAAD121925;
        Mon,  1 Apr 2019 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138407;
        bh=bbu2JN35SIJoIm3Z972s24aiFMLemy7G7H6w+Y8cVcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3yRDmpCUppIdC6xJzGClII2sKLiR3coaZmm9ZCnr22XLw2ygwqUSAooSAoGQoLmg
         GXFPGcgOcH9IDnA6bMp9+oTC84VGwIR/MfeezD4gu7g/W6p4Qq4RFdkKj+y/slQSSF
         8mmZjN7Umwlhqnu7h54TzS6YsjMtQX847zXt5PVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 058/146] ALSA: hda/realtek - Fixed Headset Mic JD not stable
Date:   Mon,  1 Apr 2019 19:01:10 +0200
Message-Id: <20190401170053.583838889@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Kailang Yang <kailang@realtek.com>

commit 10f5b1b85ed10a80d45bc2db450e65bd792efaad upstream.

It will be lose Mic JD state when Chrome OS boot and headset was plugged.
Implement of reset combo jack JD. It will show normally.

Fixes: e854747d7593 ("ALSA: hda/realtek - Enable headset button support for new codec")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5519,6 +5519,26 @@ static void alc_fixup_headset_jack(struc
 	}
 }
 
+static void alc295_fixup_chromebook(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		switch (codec->core.vendor_id) {
+		case 0x10ec0295:
+			alc_update_coef_idx(codec, 0x4a, 0x8000, 1 << 15); /* Reset HP JD */
+			alc_update_coef_idx(codec, 0x4a, 0x8000, 0 << 15);
+			break;
+		case 0x10ec0236:
+			alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
+			alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
+			break;
+		}
+		break;
+	}
+}
+
 static void alc_fixup_disable_mic_vref(struct hda_codec *codec,
 				  const struct hda_fixup *fix, int action)
 {
@@ -5672,6 +5692,7 @@ enum {
 	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 	ALC255_FIXUP_ACER_HEADSET_MIC,
+	ALC295_FIXUP_CHROME_BOOK,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6648,6 +6669,12 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC295_FIXUP_CHROME_BOOK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc295_fixup_chromebook,
+		.chained = true,
+		.chain_id = ALC225_FIXUP_HEADSET_JACK
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7060,7 +7087,7 @@ static const struct hda_model_fixup alc2
 	{.id = ALC255_FIXUP_DUMMY_LINEOUT_VERB, .name = "alc255-dummy-lineout"},
 	{.id = ALC255_FIXUP_DELL_HEADSET_MIC, .name = "alc255-dell-headset"},
 	{.id = ALC295_FIXUP_HP_X360, .name = "alc295-hp-x360"},
-	{.id = ALC225_FIXUP_HEADSET_JACK, .name = "alc-sense-combo"},
+	{.id = ALC295_FIXUP_CHROME_BOOK, .name = "alc-sense-combo"},
 	{}
 };
 #define ALC225_STANDARD_PINS \


