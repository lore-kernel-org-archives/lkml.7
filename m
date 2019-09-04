Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B28DC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AF9206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621085;
	bh=khsVp9cYfjAoDIzzdFzI30k+Zpgo/KBMB8i/V8V/Kx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VYY/RqmaVMdA2ha3V3srGqztNGcBWC9HuVuelpN9vyAfu7kEOFAGjiG3HXe0dNXFz
	 vaQBtPKGrfXkeXm8ISalMB3+5JcUpILh4zBCvINRNiSb/QQ0pdpMGR3ffmxnK4IrJQ
	 IEf3wo9LKoJNmBhDlQ6M1hQUGb6d74+08iXv8Ric=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390158AbfIDSSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388806AbfIDSLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:11:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DE9322DBF;
        Wed,  4 Sep 2019 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620705;
        bh=khsVp9cYfjAoDIzzdFzI30k+Zpgo/KBMB8i/V8V/Kx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YcR7kqhDX02s4ehywRrgZWCMZERdQqiIa52VRnp0wBVxSeX/r7GbjWjZ3QAyXyTgZ
         yBdMMUHrK4sHFcDRwCJPmorpOb0C5o1I5r45kFfWclbJHvgH8za+8Vp9yeXITrZq8K
         BN87+6Hw98Ee4WZWt+CEcSLp7JQX7nga8UV7UQNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.2 065/143] ALSA: usb-audio: Fix invalid NULL check in snd_emuusb_set_samplerate()
Date:   Wed,  4 Sep 2019 19:53:28 +0200
Message-Id: <20190904175316.613456974@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 6de3c9e3f6b3eaf66859e1379b3f35dda781416b upstream.

The quirk function snd_emuusb_set_samplerate() has a NULL check for
the mixer element, but this is useless in the current code.  It used
to be a check against mixer->id_elems[unitid] but it was changed later
to the value after mixer_eleme_list_to_info() which is always non-NULL
due to the container_of() usage.

This patch fixes the check before the conversion.

While we're at it, correct a typo in the comment in the function,
too.

Fixes: 8c558076c740 ("ALSA: usb-audio: Clean up mixer element list traverse")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer_quirks.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1155,17 +1155,17 @@ void snd_emuusb_set_samplerate(struct sn
 {
 	struct usb_mixer_interface *mixer;
 	struct usb_mixer_elem_info *cval;
-	int unitid = 12; /* SamleRate ExtensionUnit ID */
+	int unitid = 12; /* SampleRate ExtensionUnit ID */
 
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
-		cval = mixer_elem_list_to_info(mixer->id_elems[unitid]);
-		if (cval) {
+		if (mixer->id_elems[unitid]) {
+			cval = mixer_elem_list_to_info(mixer->id_elems[unitid]);
 			snd_usb_mixer_set_ctl_value(cval, UAC_SET_CUR,
 						    cval->control << 8,
 						    samplerate_id);
 			snd_usb_mixer_notify_id(mixer, unitid);
+			break;
 		}
-		break;
 	}
 }
 


