Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CF8C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E889820867
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121306;
	bh=BO2CMp99KgEKir43vyYmY/h5UcVrkGaXXS/emvzKtOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b2Z5Q2pP4kK/ctlr1JBt9h1mVRTT4uB59TvPy8XKl3u4oI7ZEubVdA/P/EijXwFf5
	 j1mPJZ2r6c0ZrQeDmK0chSnf1/H+SijADvpQ4XaxLVqNgfYnxZlzerVhkKKgyCOoDp
	 SDskuKLhfly6kLyGo4RGbQrnD/Lp8T3TCEPoiiKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393054AbfJCQsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388403AbfJCQsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:48:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B1F22070B;
        Thu,  3 Oct 2019 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121299;
        bh=BO2CMp99KgEKir43vyYmY/h5UcVrkGaXXS/emvzKtOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xomkuQvfJMo9Da05703w+F/wnfjWcQcyQyCgdRKiR6U0G80QTLhmt2YpUrWf9Amul
         SB+MHP6PsRt5DB9X69aLqiKR48BCE1KkNX3I6ydtUA1RXb2wl/GIdnWTcrsQjG8JS1
         neGH9Ziro+bAalI0Pz35e8w1cqX+OyYPENxCiV8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 221/344] ALSA: hda - Drop unsol event handler for Intel HDMI codecs
Date:   Thu,  3 Oct 2019 17:53:06 +0200
Message-Id: <20191003154602.162843134@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
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
index c380596b2e84c..36240def9bf58 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2616,6 +2616,8 @@ static void i915_pin_cvt_fixup(struct hda_codec *codec,
 /* precondition and allocation for Intel codecs */
 static int alloc_intel_hdmi(struct hda_codec *codec)
 {
+	int err;
+
 	/* requires i915 binding */
 	if (!codec->bus->core.audio_component) {
 		codec_info(codec, "No i915 binding for Intel HDMI/DP codec\n");
@@ -2624,7 +2626,12 @@ static int alloc_intel_hdmi(struct hda_codec *codec)
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



