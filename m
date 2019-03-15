Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7C7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B93F206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="a82Afbfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfCODox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:44:53 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:37810 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfCODow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 23:44:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id C19BCD24
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 03:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xo9kCS6MMyLS for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 22:44:50 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 92470D20
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 22:44:50 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id q184so6593098itd.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 20:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jPJXF2tGj3kFA5GSZyg+ChS60xhYGukjzP4tEiro0ws=;
        b=a82AfbfpE+dhqJ/9cmoNafieyT385EqzP6A7VexJl6+pGXAsCQk5hYXbq4zJAUFx5L
         wiyxP8iFK76T4ouTMl2m5XevgN+B9VcpU4x0hulDIxdayAQ6IN88kQuMK/6Tsnkusb0K
         5LFhh864PE70hvKb27zS3QEnGhU+0oKi3QfHtQ2JHTiEfdwhPP4NS0dvP2c8W5dYCML0
         YoPSVsqe6/uDZBAxvuV03lFltVFOdZTVNfPef7vdMxC8o2pE0xxkJOBF/5uim6cfzi4M
         yEaVhRSREqT9ogAclDnDwrhG/lNbVXTUFnbR6PGJL1vBr1kmPTzHtkVMdOPXnZ9N/3s0
         ORXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jPJXF2tGj3kFA5GSZyg+ChS60xhYGukjzP4tEiro0ws=;
        b=ebhorvpE67acwKvMe0dPyvVxw1m1/wazdZilh3ao8wYyN+CDp4+/aaIA7AaJmudtyj
         P3/+H0i7susuLRPnP5VeSBgqF3gKRtx0xFCVqEbrZZBoNhyfsNMEmWEo1cIQ5ek/3ZiH
         UEzMXKWxaqY+Af+nRksDkl+p+P1AqB+DGMj7n4QflGjJwCklOey2SRVjoZKhPHpwgUby
         KzHDCmzpDTV5CRRZ7iDZrHrShgQoNDOTFYce07FHh+vZppABHeh82ss6j/rRXkbTwTWb
         cX6e+v39YY84s69adtD2s4aOjaEVI59xM/Pi8p3/snWsZvEtbRt5NKHIff0ha95Y7U5s
         G6sw==
X-Gm-Message-State: APjAAAWY1z43pHNxkV/u/egIDBgkGU/68NTCn5dNsTL5ibbRtlKrs78w
        EoAVUHxIrIeFXdieHWdw2Er6sZ3L96mYXj/pTS+yxfG1js99vrkNsdJNw22bHFqywwbryrP3kzf
        fpqmrUk424Mvn+fdj6zUjXXQ1G6Sz
X-Received: by 2002:a24:6910:: with SMTP id e16mr774297itc.116.1552621490148;
        Thu, 14 Mar 2019 20:44:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz3btbXWaDjbuQoZrXdxSRXPLpbPv2kYOQRQeRXiY02LNQbY19BRQt5e2dIXSXy7fM3VdDTxQ==
X-Received: by 2002:a24:6910:: with SMTP id e16mr774289itc.116.1552621489855;
        Thu, 14 Mar 2019 20:44:49 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 5sm472268ity.40.2019.03.14.20.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 20:44:47 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound: soc-pcm: add a check to avoid NULL pointer dereference
Date:   Thu, 14 Mar 2019 22:44:15 -0500
Message-Id: <20190315034415.24085-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case debugfs_create_u32 fails, the fix frees memory and returns
an error to notify callers.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/soc/soc-pcm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0d5ec68a1e50..a7d88ed8ebb5 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1231,15 +1231,21 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 	list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
 	list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
 
-	dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
-			stream ? "capture" : "playback",  fe->dai_link->name,
-			stream ? "<-" : "->", be->dai_link->name);
-
 #ifdef CONFIG_DEBUG_FS
-	if (fe->debugfs_dpcm_root)
+	if (fe->debugfs_dpcm_root) {
 		dpcm->debugfs_state = debugfs_create_u32(be->dai_link->name, 0644,
 				fe->debugfs_dpcm_root, &dpcm->state);
+		if (!dpcm->debugfs_state) {
+			kfree(dpcm);
+			return -ENOMEM;
+		}
+	}
 #endif
+
+	dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
+			stream ? "capture" : "playback",  fe->dai_link->name,
+			stream ? "<-" : "->", be->dai_link->name);
+
 	return 1;
 }
 
-- 
2.17.1

