Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08507C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AB8217BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889307;
	bh=BXTswtWIPDWU47T6Gqs0842q/jIjLHaV03OuOop4Qg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oWcWurxp4oYbir7mMgsoCahaME6Kp1LEVjPbngKpFcsyuN3m46kGOAUgb6En6sYsw
	 JxB6PTdF9jToGeXuFkVf1Gp63ze5B+cPFWtz9fHHV9ofDrTrSvTsNfCl/GYFJdVaFN
	 hJMwkrxHgTU+t5eDuaXdyjAh3V0Y3yCLHhK+ZdkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbfK0VPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387621AbfK0VPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:15:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4917A217BA;
        Wed, 27 Nov 2019 21:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889302;
        bh=BXTswtWIPDWU47T6Gqs0842q/jIjLHaV03OuOop4Qg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=03rXXew7kCVd9e1p/K7vsgD2sYESiB+z4/xUl1CzGw+fxcwpSoNtSfzQcBHb8miF9
         jLO6AsVAV/2JOPkuswB7CQ+GjHSugQ/sBsduFAhpQvbtXfqsi0EfBDufi0JeNzUWFH
         wkBLsOfmIKPbiaetsqYPwvhGlhrUgQTIZ2Fyu7SE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 52/66] ALSA: hda - Disable audio component for legacy Nvidia HDMI codecs
Date:   Wed, 27 Nov 2019 21:32:47 +0100
Message-Id: <20191127202732.747957000@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202632.536277063@linuxfoundation.org>
References: <20191127202632.536277063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 5a858e79c911330678b5a9be91a24830e94a0dc9 upstream.

The old Nvidia chips have multiple HD-audio codecs on the same
HD-audio controller, and this doesn't work as expected with the current
audio component binding that is implemented under the one-codec-per-
controller assumption; at the probe time, the driver leads to several
kernel WARNING messages.

For the proper support, we may change the pin2port and port2pin to
traverse the codec list per the given pin number, but this needs more
development and testing.

As a quick workaround, instead, this patch drops the binding in the
audio side for these legacy chips since the audio component support in
nouveau graphics driver is still not merged (hence it's basically
unused).

[ Unlike the original commit, this patch actually disables the audio
  component binding for all Nvidia chips, not only for legacy chips.
  It doesn't matter much, though: nouveau gfx driver still doesn't
  provide the audio component binding on 5.4.y, so it's only a
  placeholder for now.  Also, another difference from the original
  commit is that this removes the nvhdmi_audio_ops and other
  definitions completely in order to avoid a compile warning due to
  unused stuff.  -- tiwai ]

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205625
Fixes: ade49db337a9 ("ALSA: hda/hdmi - Allow audio component for AMD/ATI and Nvidia HDMI")
Link: https://lore.kernel.org/r/20191122132000.4460-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_hdmi.c |   22 ----------------------
 1 file changed, 22 deletions(-)

--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3454,26 +3454,6 @@ static int nvhdmi_chmap_validate(struct
 	return 0;
 }
 
-/* map from pin NID to port; port is 0-based */
-/* for Nvidia: assume widget NID starting from 4, with step 1 (4, 5, 6, ...) */
-static int nvhdmi_pin2port(void *audio_ptr, int pin_nid)
-{
-	return pin_nid - 4;
-}
-
-/* reverse-map from port to pin NID: see above */
-static int nvhdmi_port2pin(struct hda_codec *codec, int port)
-{
-	return port + 4;
-}
-
-static const struct drm_audio_component_audio_ops nvhdmi_audio_ops = {
-	.pin2port = nvhdmi_pin2port,
-	.pin_eld_notify = generic_acomp_pin_eld_notify,
-	.master_bind = generic_acomp_master_bind,
-	.master_unbind = generic_acomp_master_unbind,
-};
-
 static int patch_nvhdmi(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec;
@@ -3492,8 +3472,6 @@ static int patch_nvhdmi(struct hda_codec
 
 	codec->link_down_at_suspend = 1;
 
-	generic_acomp_init(codec, &nvhdmi_audio_ops, nvhdmi_port2pin);
-
 	return 0;
 }
 


