Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD0BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C30233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495262;
	bh=9DPX3KSIliTFiRsyLG+ikS6pltUNT9tRg+QaBVPlITA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yby8o7TOZinQi3xjW/3pi7lag/5M2DnSZZAaIqWvaItl8G6hzOC9KLPEE+1PWhi/G
	 6RLl+OCIV9ffoRam2Q6mip1aXl0ABFPAVuBwxK3ro2TrTWyZx2e3W1LCL+0fjUxlUn
	 tmstzWObhP9RMq0L3H0rbVqMihUaazbds57YEwco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392767AbfHVReV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404400AbfHVRZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:23 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE4E206DD;
        Thu, 22 Aug 2019 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494722;
        bh=9DPX3KSIliTFiRsyLG+ikS6pltUNT9tRg+QaBVPlITA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CP9m+jxqi+bHuCdxR3Ck0YIu+xr3eatQb4ivJbFPN0sp01ehGgvQrHJCxdxSmEC9d
         7zbkXohyBshjkw2ECq/p4d++USGUTkYY8pPIy/uegkw+GNHzGUcfPY6j9TO8l9Ux+v
         y1RL+E523h7YwxomkISHMEpPJeiuhYZc2lUoguY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 11/85] ALSA: hda/realtek - Add quirk for HP Envy x360
Date:   Thu, 22 Aug 2019 10:18:44 -0700
Message-Id: <20190822171731.561759150@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 190d03814eb3b49d4f87ff38fef26d36f3568a60 upstream.

HP Envy x360 (AMD Ryzen-based model) with 103c:8497 needs the same
quirk like HP Spectre x360 for enabling the mute LED over Mic3 pin.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204373
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6851,6 +6851,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP G3 mini", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x82c0, "HP G3 mini premium", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),


