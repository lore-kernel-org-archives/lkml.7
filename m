Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9410DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D152083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902288;
	bh=4wnLEChiXVWzMJMpnRk5C4VblCkXoB3BuUIDJZLrIEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TMAXMB8/0YiaL/tX6bSFs64lgZAn7QdThL8GIey0YxYt5pWHlf81K/p3vtFmz3DQx
	 YS6pJCZbmUGfRV++ILcJ+FC01IsI2+joGIlmcbPwmohLOM07UtFlpvIYcMOeVcQjmc
	 FoZr0oVkMgnDOQuhZ1Xl5hVR1qHogWgoWbHX3oOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfCRJoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbfCRJan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:30:43 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6C732087C;
        Mon, 18 Mar 2019 09:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901443;
        bh=4wnLEChiXVWzMJMpnRk5C4VblCkXoB3BuUIDJZLrIEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cvn5Mg5D2wvoIVNBe4dPxSwihov9bNxjGH1x2SAhfNsz5vs3MtSUJ5zSwduSBxwDD
         yGIIhAxcGZZI97cJHEMNR8QZY6CNbg8azm0NBeMqKgJoaom3nm3mzznyIqnZIqWgYS
         aj5KNy2poRPf0j81uHOPMO2a8I/akQh64VElwOTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Ming Shuo Chiu <chiu@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 45/52] ALSA: hda/realtek: Enable audio jacks of ASUS UX362FA with ALC294
Date:   Mon, 18 Mar 2019 10:25:32 +0100
Message-Id: <20190318083849.204227053@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


