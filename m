Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7842C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF902192B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138438;
	bh=uDTJBJdLZB4Ge3FiQXa0hB4M5MH7tL847LJ61yWAO10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cpF7fd1V/I+G6yjOfmGnxZ/tQyeqpq5xdp7qxMrudwf+emAmRjwuYeTtEK3NBcQ3M
	 k9SsLKD78e61cKMTgrSMAjSL7bB1m/y2C5DBEqb0qjE0ouxsN2Ia0gaW9jEnW3cUh4
	 E36EnAhZveil06W3jYveRSVGqjUQHhRtsoNjesf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfDARHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbfDARHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:07:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E9921924;
        Mon,  1 Apr 2019 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138432;
        bh=uDTJBJdLZB4Ge3FiQXa0hB4M5MH7tL847LJ61yWAO10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s12Qn6oAJiiuaJfEKg80gBJxBzS9b3b6fWueh7qNAS3kmMaSAHmJdZnNAedai8Zr+
         YqqtuFuTiMutlQsUK38bgx22IK78liW62c8azbnfC9vryOOGTyIz3VQJ4HtY9DqLMk
         fZYj95tMurEKe0KLUAtLWAO/HDu2TEHbm3sukDO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 064/146] ALSA: hda/realtek - Add support for Acer Aspire E5-523G/ES1-432 headset mic
Date:   Mon,  1 Apr 2019 19:01:16 +0200
Message-Id: <20190401170054.075720346@linuxfoundation.org>
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

From: Chris Chiu <chiu@endlessm.com>

commit c7531e31c8a440b5fe6bd62664def5bcb6262f96 upstream.

The Acer laptop Aspire E5-523G and ES1-432 with ALC255 can't detect
the headset microphone until ALC255_FIXUP_ACER_MIC_NO_PRESENCE quirk
applied.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6710,6 +6710,8 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
+	SND_PCI_QUIRK(0x1025, 0x1099, "Acer Aspire E5-523G", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),


