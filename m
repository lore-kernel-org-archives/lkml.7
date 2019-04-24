Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB9DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C3721905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126259;
	bh=aMgNFjSutd+iF37+J8Plm9tAFfwGDXZCS8O/VFi+SqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17K0kSe6OCgUa67mgv5QcIQaz8oPkCw+d455bnZ31p0i1HxZcNvgLIQNcdABp6m/B
	 Inexiq2eONUZ91Ft3qaBwTi352Kc0LmbTZrakaREjEI/uZie5Juo0nBJEGsY5LTWVn
	 +rmDQ8hE+iF/+uncAU2XhH0NbBY7iUxozDhP9SBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbfDXRRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388658AbfDXRRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:17:37 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E570221905;
        Wed, 24 Apr 2019 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126256;
        bh=aMgNFjSutd+iF37+J8Plm9tAFfwGDXZCS8O/VFi+SqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0aGOMSFEBsfwUycmyiQ/bFFJk5eH3eYbfnjfpbgdmuVB3g3Md2gZusjZPN9iuBng
         f98CYMkgeDNoOfEpnEFdQHhbFhYOHJ7Te/FELGsVAV/s/reLVn7DHBGXXcLRKoGpnM
         +NMUjGhnsJHQ2/XtOY/l2JW7Zay5NdaJpexqrlKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 045/168] ALSA: PCM: check if ops are defined before suspending PCM
Date:   Wed, 24 Apr 2019 19:08:09 +0200
Message-Id: <20190424170926.468925663@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 4d6f0f56d54a..252392abd1b9 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1342,6 +1342,14 @@ int snd_pcm_suspend_all(struct snd_pcm *pcm)
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



