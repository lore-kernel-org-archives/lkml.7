Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEE1206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FGryzSjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfCODsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:48:42 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:41992 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfCODsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 23:48:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 84611CCC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 03:48:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U-Hsc39NBSjM for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 22:48:40 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 59FC2CB5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 22:48:40 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id h3so6612728itb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 20:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oMKu+yH69lY0kihDW0JQrJ+0LUJCXHUenEltqAHy3WM=;
        b=FGryzSjBxzUoN34iU58EtIEA2ZCZdtF+24u623mJ3qg5rbTf7Yr86LtHj388BdD3gY
         JzdrL1UC5fXZXS/3Dvjjhn+rUPOKJ/ZMGQdFJ2guFZlNC7uZ7bd3mGhtJ12vkrqjSwZ5
         Fs56DR2BICtuvaZiGimlSjKzl2GIFtzI1j9oTB7pmupWmem8d73PMz34PlypcT//jHIK
         /1JHsBg8/JlYTVzyhCFqiTV+xvKctmkUpXteP+U3Eou1iHwwLED7eNAi6va+da+WVixW
         ff40Ir0uI28OtAqDwzT5Vy7pCZRpnUMPEeoX7M8gDcYHGI1wVD3OwvMwMy/2qeR0DI5P
         l+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oMKu+yH69lY0kihDW0JQrJ+0LUJCXHUenEltqAHy3WM=;
        b=FFzAhkp6+hlW+59d3GeB+4KzTY+iNYhd6Nv/BpPHStAPTftjtaZ7sZZ6zFRlFNTTJc
         OJIdgs7tbUmnnfu0PjqDp7ef70rDfBTgr7Qjp6Zg3VUqR/g7BeOvAM+ChoStd4L/Zn76
         KpN2zTr8cnhnhBSXNA1+ELAKFQ1l6p5ZxVaCA/ioB5YVb84DmTlceVrCYQk9X+orfJSJ
         e05mYx+AAPMMUT1Wxr/jHiGkp0ql3imseymsINPbNgX7wo8+iLtL0icbfxgeklQ+Gynh
         JVyWyV00F70L0FEDp2LiwfAk7nfXgWKe5+iJDGhbdyt8lQWJXSbh4ojShQaeFrAd5dX8
         nHHg==
X-Gm-Message-State: APjAAAWKBK1e2CEc3HU+DcdVNLiS8YZbQiy+KnDKaRFHy4XK30sylLQv
        RGrF4s82W0J6LyXo1SXaaT6SDzmnjTVFeBJ2nsZo884lKChIz0CdpMqulzSegs2jANum9UhJgC8
        WFDeDlvGoJ77v4f0yqzKG1TEh1pui
X-Received: by 2002:a24:d50:: with SMTP id 77mr667557itx.139.1552621719227;
        Thu, 14 Mar 2019 20:48:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzZEzTwNSszVj4Ho3OIN9fKjNgeytTFDSfR4J2Wogi239ZI7JGd+4qh+Pd4i47CruHjFVP/7Q==
X-Received: by 2002:a24:d50:: with SMTP id 77mr667541itx.139.1552621719005;
        Thu, 14 Mar 2019 20:48:39 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id y2sm457588iob.44.2019.03.14.20.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 20:48:38 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound: rt5645: fix a NULL pointer dereference
Date:   Thu, 14 Mar 2019 22:48:32 -0500
Message-Id: <20190315034833.25037-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kcalloc() may fail and return NULL. The fix returns ENOMEM
in case it fails to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/soc/codecs/rt5645.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9a0751978090..f842775dbf2c 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3419,6 +3419,9 @@ static int rt5645_probe(struct snd_soc_component *component)
 		RT5645_HWEQ_NUM, sizeof(struct rt5645_eq_param_s),
 		GFP_KERNEL);
 
+	if (!rt5645->eq_param)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.17.1

