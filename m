Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9735EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624B420657
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033778;
	bh=YfFCMiaaeWItTT6okyxb+dr4GuCK9/KKux8OQ4wMvZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ac/Crp88wf5OlsXgBWOQfbSk9U0McQGWORvNgyfVUz2rfv+UEs0uharyr+7GF9+oo
	 +uJL/0F4JUuZNYg3RIyxbGo9b5sM7hpdqJ88hpHjwjm+NgnYhBGVnYEDsqYsTomLZw
	 pipYgrd9nfvxKVGqYCsyw12tJc5kCnEFO+WMhbQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391162AbfGYFoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391143AbfGYFoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:44:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD7F22BF5;
        Thu, 25 Jul 2019 05:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033441;
        bh=YfFCMiaaeWItTT6okyxb+dr4GuCK9/KKux8OQ4wMvZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/liFIEtORyu2+kEWsPmeD+HCefTzSGeJhUbv5p3CmteiIe4sCbli1w0vEo3o/mds
         HfbalbI09N5+0WbOHcc/QXAHCnABir6D7PpnA6U/YWbRo6xZj1nhq3kwYSxAOdRVUe
         LrM23wyOxx54npFFnpsHle4JjpoqVMstXmNxVIOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 207/271] ALSA: hda/realtek - Fixed Headphone Mic cant record on Dell platform
Date:   Wed, 24 Jul 2019 21:21:16 +0200
Message-Id: <20190724191712.817117957@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit fbc571290d9f7bfe089c50f4ac4028dd98ebfe98 upstream.

It assigned to wrong model. So, The headphone Mic can't work.

Fixes: 3f640970a414 ("ALSA: hda - Fix headset mic detection problem for several Dell laptops")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7518,9 +7518,12 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
 		{0x21, 0x03211020}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x14, 0x90170110},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+		{0x14, 0x90170110},
+		{0x21, 0x04211030}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014020},


