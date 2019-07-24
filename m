Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAF1C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A368B229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997099;
	bh=3UM0H3o54o2bU8QO/8kPbV2jWRDQASUUuouwQuvsfk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UJqINEjDIVpiLkMqWE6HlG6z/fr0lngVxxBeJTEQYwzfPNU1ghYK3IvFhwEigYMqo
	 MVc/gvhkqTKhsTpdqPrCOf4FO+r4i4rtHYGqJTJzWVFzlb8zqMd9P6s6kPJmkq693N
	 zsnCeljFCsu5yac4QvWMko2t2HXbWzQqky7wdzUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389617AbfGXTiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389603AbfGXTiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:38:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D57DD20665;
        Wed, 24 Jul 2019 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997096;
        bh=3UM0H3o54o2bU8QO/8kPbV2jWRDQASUUuouwQuvsfk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gk4juqUWQ4nKn1yRlQGVfzyKPVsav1ZuiL5o5VbLGD6kUqpvhqphPIMe/9rjJfsFb
         QMAVgCG23Goun14VwVmIjg85skKnevz7JBTDrsnZESTIFtx9JxmjtFRu19gPP4rZT9
         cqriVsUFT8g3cE65mtCc//zizUxAdNy1V4Uh2tu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.2 319/413] ALSA: hda/hdmi - Fix i915 reverse port/pin mapping
Date:   Wed, 24 Jul 2019 21:20:10 +0200
Message-Id: <20190724191758.706791299@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 3140aafb22edeab0cc41f15f53b12a118c0ac215 upstream.

The recent fix for Icelake HDMI codec introduced the mapping from pin
NID to the i915 gfx port number.  However, it forgot the reverse
mapping from the port number to the pin NID that is used in the ELD
notifier callback.  As a result, it's processed to a wrong widget and
gives a warning like
  snd_hda_codec_hdmi hdaudioC0D2: HDMI: pin nid 5 not registered

This patch corrects it with a proper reverse mapping function.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204133
Fixes: b0d8bc50b9f2 ("ALSA: hda: hdmi - add Icelake support")
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_hdmi.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2525,18 +2525,32 @@ static int intel_pin2port(void *audio_pt
 	return -1;
 }
 
+static int intel_port2pin(struct hda_codec *codec, int port)
+{
+	struct hdmi_spec *spec = codec->spec;
+
+	if (!spec->port_num) {
+		/* we assume only from port-B to port-D */
+		if (port < 1 || port > 3)
+			return 0;
+		/* intel port is 1-based */
+		return port + intel_base_nid(codec) - 1;
+	}
+
+	if (port < 1 || port > spec->port_num)
+		return 0;
+	return spec->port_map[port - 1];
+}
+
 static void intel_pin_eld_notify(void *audio_ptr, int port, int pipe)
 {
 	struct hda_codec *codec = audio_ptr;
 	int pin_nid;
 	int dev_id = pipe;
 
-	/* we assume only from port-B to port-D */
-	if (port < 1 || port > 3)
+	pin_nid = intel_port2pin(codec, port);
+	if (!pin_nid)
 		return;
-
-	pin_nid = port + intel_base_nid(codec) - 1; /* intel port is 1-based */
-
 	/* skip notification during system suspend (but not in runtime PM);
 	 * the state will be updated at resume
 	 */


