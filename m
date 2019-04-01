Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04280C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91192192C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138428;
	bh=9b6wRgHIBqOwL5eGj35lcu+K9b6mJRejPrStTRFdQrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qoqewYIPuAcnpLcZwapfjhAtz3isoI+Hl3O4ZdLQNSsnNptcBGjrCQIhC2XTNYg3t
	 bsDFQTJk/8ADlD5qFDESr3fQCotNor5wj0fuZdSj94y46GMkoBOog3bJpJhPwW8IHZ
	 DCfBkZKbFm5H3vNQLTgGl4clY88oUW9I85/3sI9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfDARHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbfDARHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:07:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0BA321924;
        Mon,  1 Apr 2019 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138426;
        bh=9b6wRgHIBqOwL5eGj35lcu+K9b6mJRejPrStTRFdQrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xk6x04IJA0LF9EPXZV4Rab9Uzfc7yTAoUnSUKaV7hy8NSBEq1CuA46lYswhHdYz5b
         xVadpOX+hR06yPUvj3AfKmmJh5LcrGs/cRy72czfEr9U2T/8KmNlPVNc6d33Rbsqpy
         Oi77KlxcIA7WzCO8P7GBNAmxaNBQiVQT+zWVfKSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 062/146] ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286
Date:   Mon,  1 Apr 2019 19:01:14 +0200
Message-Id: <20190401170053.909167964@linuxfoundation.org>
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

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit 667a8f73753908c4d0171e52b71774f9be5d6713 upstream.

Some Acer AIO desktops like Veriton Z6860G, Z4860G and Z4660G cannot
record sound from headset MIC.  This patch adds the
ALC286_FIXUP_ACER_AIO_HEADSET_MIC quirk to fix this issue.

Fixes: 9f8aefed9623 ("ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4660G")
Fixes: b72f936f6b32 ("ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4860G/Z6860G")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Reviewed-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5685,6 +5685,7 @@ enum {
 	ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE,
 	ALC225_FIXUP_WYSE_AUTO_MUTE,
 	ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
+	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6683,6 +6684,16 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC286_FIXUP_ACER_AIO_HEADSET_MIC] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4f },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5029 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6699,9 +6710,9 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
-	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),


