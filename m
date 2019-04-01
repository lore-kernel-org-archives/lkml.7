Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFA5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF17920883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138954;
	bh=Qs0KXR25RG6hxXiK198jcRLnqLy9AQ7i1mVy0yq3mi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y8/M1IWKOfa3I3KzKgi30/dRZQyi2UP3zS/ouH1r3q2XWwGdgvFPc1Nq60+TUJXBo
	 Amfnbr+gDtyxzcC4KmDPXmhOLEf9y2mxhP+ZLm/cT5njgEYPmczIgIUWAUA1PTirMz
	 uhQqX2J1vX9NX9slcE2ytZZUXJZATkMCotbXLgVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbfDARPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730936AbfDARPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:15:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30FB206C0;
        Mon,  1 Apr 2019 17:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138946;
        bh=Qs0KXR25RG6hxXiK198jcRLnqLy9AQ7i1mVy0yq3mi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJhIQpj/WBKyemL8DiK7gvTnZCDXZHk7xHm/6gH4q7CafDvY5eKH4/lVybjSc8nv2
         0+RtznI5whoKxlqWRRCeV9BlYf0rXLbbae0XlnVZmJPF5Cp5+UFGVgxvOdH2EWd/A9
         UOAbB4DMjcbrv4wr3sR0u+pZ7nMVJqdNzIriDBYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 066/134] ALSA: hda/realtek: Enable ASUS X441MB and X705FD headset MIC with ALC256
Date:   Mon,  1 Apr 2019 19:01:42 +0200
Message-Id: <20190401170050.680945178@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

commit e1037354a0a75acdea2b27043c0a371ed85cf262 upstream.

The ASUS laptop X441MB and X705FD with ALC256 cannot detect the headset
MIC until ALC256_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5617,6 +5617,7 @@ enum {
 	ALC225_FIXUP_WYSE_AUTO_MUTE,
 	ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
 	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
+	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6603,6 +6604,15 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE
 	},
+	[ALC256_FIXUP_ASUS_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x04a11120 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7237,6 +7247,10 @@ static const struct snd_hda_pin_quirk al
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x1a, 0x90a70130},
+		{0x1b, 0x90170110},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1028, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
 		{0x12, 0xb7a60130},
 		{0x13, 0xb8a61140},


