Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309DBC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E44204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355595;
	bh=B9GtFRtEWiK9CJU4WrnSm69qgYni74dMOMcA3Fhh3K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFyoxU7dPkpc96VZV2t3LIQg9j2ETisNGm2w5fHUpjWFv4RcJ+eGaBMVwZXsimSs4
	 rZ3hCQXvf9vy4PCUFWquMGSFrgAut1EVUYlk6a1TCXqZGTAbtF/3hdUmN6HB5uhRPS
	 EWQ8/SXbk2eJzsM3qSnRrcgwTDHdN1V7F/lyhcdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390677AbfETMdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733069AbfETMdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:33:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C179C214DA;
        Mon, 20 May 2019 12:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355589;
        bh=B9GtFRtEWiK9CJU4WrnSm69qgYni74dMOMcA3Fhh3K8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNrMsFpVgzd4i+zoU+IOCfSqGttFBAwNPVzWfatgyMqVR4EmC9Ax1AeSEB04UVERO
         3D7qD3l0/LlBcdI7CX1tajGeHuyBAfysuWzlTRF/hqaAj3qOnWj+Uj60D/9Zrnfpr7
         RVoR1x6MGGqyKtK8WWZeMgiePjJwWLs1ynlcqhaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.1 051/128] ALSA: hda/hdmi - Consider eld_valid when reporting jack event
Date:   Mon, 20 May 2019 14:13:58 +0200
Message-Id: <20190520115253.224373942@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 7f641e26a6df9269cb25dd7a4b0a91d6586ed441 upstream.

On the machines with AMD GPU or Nvidia GPU, we often meet this issue:
after s3, there are 4 HDMI/DP audio devices in the gnome-sound-setting
even there is no any monitors plugged.

When this problem happens, we check the /proc/asound/cardX/eld#N.M, we
will find the monitor_present=1, eld_valid=0.

The root cause is BIOS or GPU driver makes the PRESENCE valid even no
monitor plugged, and of course the driver will not get the valid
eld_data subsequently.

In this situation, we should not report the jack_plugged event, to do
so, let us change the function hdmi_present_sense_via_verbs(). In this
function, it reads the pin_sense via snd_hda_pin_sense(), after
calling this function, the jack_dirty is 0, and before exiting
via_verbs(), we change the shadow pin_sense according to both
monitor_present and eld_valid, then in the snd_hda_jack_report_sync(),
since the jack_dirty is still 0, it will report jack event according
to this modified shadow pin_sense.

After this change, the driver will not report Jack_is_plugged event
through hdmi_present_sense_via_verbs() if monitor_present is 1 and
eld_valid is 0.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_hdmi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1551,9 +1551,11 @@ static bool hdmi_present_sense_via_verbs
 	ret = !repoll || !eld->monitor_present || eld->eld_valid;
 
 	jack = snd_hda_jack_tbl_get(codec, pin_nid);
-	if (jack)
+	if (jack) {
 		jack->block_report = !ret;
-
+		jack->pin_sense = (eld->monitor_present && eld->eld_valid) ?
+			AC_PINSENSE_PRESENCE : 0;
+	}
 	mutex_unlock(&per_pin->lock);
 	return ret;
 }


