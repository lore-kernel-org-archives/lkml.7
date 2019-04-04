Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869E9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551ED206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371679;
	bh=k/7RpotmpYeu8ZGsKn1fM/FEq3wE/MteqVTnkaxpCLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FS3mvMTgCK60ndUFsOkKAsuvycyHlU/PKFRzvLNb7Mq/K7Z9xFyE304CcOpc9Jl/b
	 18/e6+yGvVHaUZf+5KaTsoZQUSTgpjdynZdVXnduIMzSaHsjp7N1CJ0tmDCHRNHpFm
	 xgksJnNur3TbG2CnWQIyjDA0b1WEzMT0CIdkJoIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfDDJyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729607AbfDDIw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:52:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A0E217D9;
        Thu,  4 Apr 2019 08:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367946;
        bh=k/7RpotmpYeu8ZGsKn1fM/FEq3wE/MteqVTnkaxpCLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdWFmkJ2jQCUSOOwRjijuUwo+jNLUrR2DANaxY9da8ssrowDP4460MfdWy2GGVcV9
         Kx2BmJFWtORH4rm5CdO9gB/AAeNV0ySGCM2F+p7WojLsv/MaUvmQjrCYbId/jHpiqA
         OHt+JZTK+60O2zdvzVD5vYfRCiwQU551aVD3D7RI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 56/91] ALSA: PCM: check if ops are defined before suspending PCM
Date:   Thu,  4 Apr 2019 10:47:40 +0200
Message-Id: <20190404084538.696495173@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d9c0b2afe820fa3b3f8258a659daee2cc71ca3ef ]

BE dai links only have internal PCM's and their substream ops may
not be set. Suspending these PCM's will result in their
 ops->trigger() being invoked and cause a kernel oops.
So skip suspending PCM's if their ops are NULL.

[ NOTE: this change is required now for following the recent PCM core
  change to get rid of snd_pcm_suspend() call.  Since DPCM BE takes
  the runtime carried from FE while keeping NULL ops, it can hit this
  bug.  See details at:
     https://github.com/thesofproject/linux/pull/582
  -- tiwai ]

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_native.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index e1138e70dbb3..f5eb10f8021c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1346,6 +1346,14 @@ int snd_pcm_suspend_all(struct snd_pcm *pcm)
 			/* FIXME: the open/close code should lock this as well */
 			if (substream->runtime == NULL)
 				continue;
+
+			/*
+			 * Skip BE dai link PCM's that are internal and may
+			 * not have their substream ops set.
+			 */
+			if (!substream->ops)
+				continue;
+
 			err = snd_pcm_suspend(substream);
 			if (err < 0 && err != -EBUSY)
 				return err;
-- 
2.19.1



