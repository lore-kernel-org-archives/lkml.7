Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E18CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A6B21A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119650;
	bh=zBxVPzYCD7UuRRjQOdsujnRC9GxFPolPRqm3UoNedZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vny4OKtv1r45Jw0TcylRFrInXJJh25QElAASBmPvD5yBdx/Qlhc7MJL9y0S/TSs1a
	 OpTyZqyYlD0xOSV9FW+0qOHzdZ+6EHxf7WgUDqFWIda7bc+m8TGaFaOe/7xnKMNMNo
	 FnhkupCnrqW1vTFWyATOb6+RV1SknHFUXNYLNnig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390001AbfJCQUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389982AbfJCQUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:20:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF452054F;
        Thu,  3 Oct 2019 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119644;
        bh=zBxVPzYCD7UuRRjQOdsujnRC9GxFPolPRqm3UoNedZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BhSapKyojx+TWIr6eHqiOCQQ4zC/9Z6BrHNB50H2KKF+GZAQJFTluO1FpOWjKlFfz
         /vV07nNkmHNzKIzj+463W0VhZkQFccFldZhw7sri5c9IYeqvNeoST4ZXx4BZaMVIWV
         9pv7nDudrZ0I/f/8nvAy9F16aNnNEwnZ7vx2rpt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 140/211] ALSA: hda - Drop unsol event handler for Intel HDMI codecs
Date:   Thu,  3 Oct 2019 17:53:26 +0200
Message-Id: <20191003154519.222129595@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit f2dbe87c5ac1f88e6007ba1f1374f4bd8a197fb6 ]

We don't need to deal with the unsol events for Intel chips that are
tied with the graphics via audio component notifier.  Although the
presence of the audio component is checked at the beginning of
hdmi_unsol_event(), better to short cut by dropping unsol_event ops.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204565
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index e4fbfb5557ab7..107ec7f3e2214 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2583,6 +2583,8 @@ static void i915_pin_cvt_fixup(struct hda_codec *codec,
 /* precondition and allocation for Intel codecs */
 static int alloc_intel_hdmi(struct hda_codec *codec)
 {
+	int err;
+
 	/* requires i915 binding */
 	if (!codec->bus->core.audio_component) {
 		codec_info(codec, "No i915 binding for Intel HDMI/DP codec\n");
@@ -2591,7 +2593,12 @@ static int alloc_intel_hdmi(struct hda_codec *codec)
 		return -ENODEV;
 	}
 
-	return alloc_generic_hdmi(codec);
+	err = alloc_generic_hdmi(codec);
+	if (err < 0)
+		return err;
+	/* no need to handle unsol events */
+	codec->patch_ops.unsol_event = NULL;
+	return 0;
 }
 
 /* parse and post-process for Intel codecs */
-- 
2.20.1



