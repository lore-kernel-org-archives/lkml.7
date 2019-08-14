Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDEAC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CED8206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803419;
	bh=Cot4NZC9zpqgEWzvcE10GWPQszsfudXCBDIx+BzIz9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ESX9YHnT4fwWxTMrUD2vcyXtGS2Xu27Mmy0g/iNi1Q6e2FUl3Cv3nva2ah0MME7r4
	 aBgiAK8Y1JxJGLqIJWqbEPgmDjzfgy8rjdI+II6fFxs/qApMk8+sE9fN9pmfP/U3Dx
	 6lHmT42pW76XkkqXrv5ZhSHLA89erbTZ3nR0oOao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfHNRHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfHNRHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:07:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 075402186A;
        Wed, 14 Aug 2019 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802439;
        bh=Cot4NZC9zpqgEWzvcE10GWPQszsfudXCBDIx+BzIz9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqXsTYJ+8N9qqTxbeCyKUura3dS9MpuTdSty/PV+IrOo5spnG3JzKU0zJYTpyfBOZ
         NB+UdMVgSMnyd+ZdxjS5bim9EMULaQprGlTBrhvUnVDMbO3LDCMEsY1CCFXIBt8VnV
         JLSz402v6MjCbnmQuP7wBS+TM35XmYAEWFgZGv8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.2 127/144] ALSA: hiface: fix multiple memory leak bugs
Date:   Wed, 14 Aug 2019 19:01:23 +0200
Message-Id: <20190814165805.249493983@linuxfoundation.org>
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

From: Wenwen Wang <wenwen@cs.uga.edu>

commit 3d92aa45fbfd7319e3a19f4ec59fd32b3862b723 upstream.

In hiface_pcm_init(), 'rt' is firstly allocated through kzalloc(). Later
on, hiface_pcm_init_urb() is invoked to initialize 'rt->out_urbs[i]'. In
hiface_pcm_init_urb(), 'rt->out_urbs[i].buffer' is allocated through
kzalloc().  However, if hiface_pcm_init_urb() fails, both 'rt' and
'rt->out_urbs[i].buffer' are not deallocated, leading to memory leak bugs.
Also, 'rt->out_urbs[i].buffer' is not deallocated if snd_pcm_new() fails.

To fix the above issues, free 'rt' and 'rt->out_urbs[i].buffer'.

Fixes: a91c3fb2f842 ("Add M2Tech hiFace USB-SPDIF driver")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/hiface/pcm.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -600,14 +600,13 @@ int hiface_pcm_init(struct hiface_chip *
 		ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
 				    hiface_pcm_out_urb_handler);
 		if (ret < 0)
-			return ret;
+			goto error;
 	}
 
 	ret = snd_pcm_new(chip->card, "USB-SPDIF Audio", 0, 1, 0, &pcm);
 	if (ret < 0) {
-		kfree(rt);
 		dev_err(&chip->dev->dev, "Cannot create pcm instance\n");
-		return ret;
+		goto error;
 	}
 
 	pcm->private_data = rt;
@@ -620,4 +619,10 @@ int hiface_pcm_init(struct hiface_chip *
 
 	chip->pcm = rt;
 	return 0;
+
+error:
+	for (i = 0; i < PCM_N_URBS; i++)
+		kfree(rt->out_urbs[i].buffer);
+	kfree(rt);
+	return ret;
 }


