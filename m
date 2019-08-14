Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B627CC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896B1208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802445;
	bh=AXKVkXAIcQuhseNRRg2NooujSMT+DJdgVYb/M/fIze8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c8AC7TvkQ1S9WuaVu6pTEQjIALDJ4sSohe+UqgRstxb+yjZdOzLIg4H6S75cFlAA/
	 kHGqQS4zjDiQ1SdiV2wGDwcLFW9OWL9C3ykhqRgFYIkCWhKYBsC+QVuRQl/tJlpv11
	 2tYZ3Y1zUz0T3PIbmskMAGamhKzV/0YQYGUi9qQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfHNRHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbfHNRHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:07:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1672084D;
        Wed, 14 Aug 2019 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802442;
        bh=AXKVkXAIcQuhseNRRg2NooujSMT+DJdgVYb/M/fIze8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwczplXK4/iaTxdz2CfqLj5R0e3nbmMGusCu6+lYDTc/GjBfC7Od4jVM4qJiCoeF4
         /UV+tf443zgPMVYnl1T4d+6KzvSQl0w3ylMey0Ry1LAQ02i1GaQj9xxWcZZhsnn2s4
         GD4xYyMV0cZGjaaJhGlj5nY8qIVNTjf3pDxK6BHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.2 128/144] ALSA: hda - Dont override global PCM hw info flag
Date:   Wed, 14 Aug 2019 19:01:24 +0200
Message-Id: <20190814165805.299046394@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit c1c6c877b0c79fd7e05c931435aa42211eaeebaf upstream.

The commit bfcba288b97f ("ALSA - hda: Add support for link audio time
reporting") introduced the conditional PCM hw info setup, but it
overwrites the global azx_pcm_hw object.  This will cause a problem if
any other HD-audio controller, as it'll inherit the same bit flag
although another controller doesn't support that feature.

Fix the bug by setting the PCM hw info flag locally.

Fixes: bfcba288b97f ("ALSA - hda: Add support for link audio time reporting")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_controller.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -598,11 +598,9 @@ static int azx_pcm_open(struct snd_pcm_s
 	}
 	runtime->private_data = azx_dev;
 
-	if (chip->gts_present)
-		azx_pcm_hw.info = azx_pcm_hw.info |
-			SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME;
-
 	runtime->hw = azx_pcm_hw;
+	if (chip->gts_present)
+		runtime->hw.info |= SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME;
 	runtime->hw.channels_min = hinfo->channels_min;
 	runtime->hw.channels_max = hinfo->channels_max;
 	runtime->hw.formats = hinfo->formats;


