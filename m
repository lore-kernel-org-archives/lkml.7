Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8773CC468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB4A2133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922776;
	bh=Y/MmUWmGGIjCmfuFWhJg66qO9PN/97kVWghARl+RLgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=elY5FdNzswRYYGhlSDnWdDNox8UXaBFSB7H6dG5smqJZpv0i1AEwZHSM9x6lYHioS
	 7NqolosG1tNqsG/hSw/RI0nIG6BAd7rcilmnXwXW6NUVssOnW+xvu5LyHluFyJHQch
	 sh/jPUHwtKe7GFIv8ZWhhf0NTYu0omkRCAVkcba8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfFGPsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731806AbfFGPse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:48:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E212220840;
        Fri,  7 Jun 2019 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922514;
        bh=Y/MmUWmGGIjCmfuFWhJg66qO9PN/97kVWghARl+RLgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5OJSoXkIpd1KPTe8oTfDeTL2t9Szco9O7fpD55Dwlu6B4VdRBL7tZV8b3pdjznrg
         OpuSvbaicCmTfUfIddi+1WaaaA07ZYhLvXScnqP0bosVidwrXHcp4LQFiEmKdjHgB/
         u9RaOOOwxFwqI9TMAHn+TsBlF+sWbUrCMFlTPGe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.1 41/85] ALSA: hda/realtek - Improve the headset mic for Acer Aspire laptops
Date:   Fri,  7 Jun 2019 17:39:26 +0200
Message-Id: <20190607153854.261303474@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 9cb40eb184c4220d244a532bd940c6345ad9dbd9 upstream.

We met another Acer Aspire laptop which has the problem on the
headset-mic, the Pin 0x19 is not set the corret configuration for a
mic and the pin presence can't be detected too after plugging a
headset. Kailang suggested that we should set the coeff to enable the
mic and apply the ALC269_FIXUP_LIFEBOOK_EXTMIC. After doing that,
both headset-mic presence and headset-mic work well.

The existing ALC255_FIXUP_ACER_MIC_NO_PRESENCE set the headset-mic
jack to be a phantom jack. Now since the jack can support presence
unsol event, let us imporve it to set the jack to be a normal jack.

https://bugs.launchpad.net/bugs/1821269
Fixes: 5824ce8de7b1c ("ALSA: hda/realtek - Add support for Acer Aspire E5-475 headset mic")
Cc: Chris Chiu <chiu@endlessm.com>
CC: Daniel Drake <drake@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6166,13 +6166,15 @@ static const struct hda_fixup alc269_fix
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
 	[ALC255_FIXUP_ACER_MIC_NO_PRESENCE] = {
-		.type = HDA_FIXUP_PINS,
-		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
-			{ }
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Enable the Mic */
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5089 },
+			{}
 		},
 		.chained = true,
-		.chain_id = ALC255_FIXUP_HEADSET_MODE
+		.chain_id = ALC269_FIXUP_LIFEBOOK_EXTMIC
 	},
 	[ALC255_FIXUP_ASUS_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
@@ -7218,6 +7220,10 @@ static const struct snd_hda_pin_quirk al
 		{0x19, 0x0181303F},
 		{0x21, 0x0221102f}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1025, "Acer", ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
+		{0x12, 0x90a60140},
+		{0x14, 0x90170120},
+		{0x21, 0x02211030}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1025, "Acer", ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 		{0x12, 0x90a601c0},
 		{0x14, 0x90171120},
 		{0x21, 0x02211030}),


