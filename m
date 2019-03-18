Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8EAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29472075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902086;
	bh=CNRdJesMUkkC2LY4GqMPLCKRncWFesSSQaR6UYqpwm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=edqJzEQdLN4l7MJfjTt2f2kePJKb162uibqHeJbxMn5KIEIdAI3dnq4gouBenDjkF
	 GcZQb4MwmC9lW9UXK2wSuIDuPGsFojTEZbFRzTGQYXR+TpFTEpnvARj59tBWeLwFI7
	 9YOhwAXAJki2d4S42DL06tdpwwp2kHouMVu/mEHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfCRJeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfCRJeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:34:04 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF6DC2087C;
        Mon, 18 Mar 2019 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901643;
        bh=CNRdJesMUkkC2LY4GqMPLCKRncWFesSSQaR6UYqpwm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2Lva46mPINGaz9VoIL4/CjcxBHREBj9EJP6UT819zEtAZICYoYZ8znHxDMP7UTbm
         9fSgD26TEV49nz1ryKN4TBA99qZe22CK9uw8Asm/Id4v/jHnqdxF1Tzg+cmeZINnoK
         eDEDwhakCSOsb2ekAGRVSzq1MGFPpZDk9RyD9Zgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Ming Shuo Chiu <chiu@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 43/52] ALSA: hda/realtek: Enable audio jacks of ASUS UX362FA with ALC294
Date:   Mon, 18 Mar 2019 10:25:40 +0100
Message-Id: <20190318084018.604227408@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit 8bb37a2a4d7c02affef554f5dc05f6d2e39c31f9 upstream.

The ASUS UX362FA with ALC294 cannot detect the headset MIC and outputs
through the internal speaker and the headphone.  This issue can be fixed
by the quirk in the commit 4e0511067 ALSA: hda/realtek: Enable audio
jacks of ASUS UX533FD with ALC294.

Besides, ASUS UX362FA and UX533FD have the same audio initial pin config
values.  So, this patch replaces SND_PCI_QUIRK of UX533FD with a new
SND_HDA_PIN_QUIRK which benefits both UX362FA and UX533FD.

Fixes: 4e051106730d ("ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Ming Shuo Chiu <chiu@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6692,7 +6692,6 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
-	SND_PCI_QUIRK(0x1043, 0x14a1, "ASUS UX533FD", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
@@ -7308,6 +7307,10 @@ static const struct snd_hda_pin_quirk al
 	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_SPK,
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
+		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_SPK,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
 		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,


