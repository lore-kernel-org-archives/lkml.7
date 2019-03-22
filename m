Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF04C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FA52190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="obpaQVx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfCVWAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:00:38 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:44666 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVWAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:00:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 0209CD83
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:00:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S1zI7raL2VXe for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 17:00:35 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id C841E9BC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 17:00:35 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id s3so3229351itl.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 15:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DREenBGeb2liNGniFXIn4Bi6UT6pdWetqkymXzE3R9o=;
        b=obpaQVx6flzIXciyntjQjKi2pZGikvR1dVDJX1CluEPQFG8Lo423KzIzHePD3K+DaG
         mZFcfG91mM5426gZUPMFVoTHr+1oTtBlpbGRsCkx/0evnTdRHdXVpxXx7h3O2sJ3uJLa
         rEKW0cuCbXEW9+gNRgbWxGygcbd+BdXNEf7XNFJ8OzOnFIGpxz4RRLdjaqZtjHHLF0gU
         vh5M/m709+/wBr4ZqRACggIA1jSzh8HZBzSQl5Bv/lmkcTxyExd+Rl1eCNou2auG2IlO
         H73FXH4vqkhr8f4ycJ97zZNZJH97bK483NmJCz2fP0LhODhDjs3xIpjInm490n+FJv+Z
         9LYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DREenBGeb2liNGniFXIn4Bi6UT6pdWetqkymXzE3R9o=;
        b=Sce2xsaG/FjJxd8dtJ+DVaXYYMQHqql9kJgmFZv9uEZnJYUUOrOXwbvqmNM4odJbdM
         nVjCskovPmUhbXUruwONMn0ogMBitHlybq3Pa6rRYDFWsE7wmpO/Bn7vzjyPRLGFBoQV
         nCSNFAm6hflPc/sR6buaGsYMbpM313jZEmPvuENHpmAPRyhFcfcEMRn9noAHFk5M8nLK
         IQWVYzlFGQ+gbletBtQBGZO/R7zSvWa4893WdSLQyDQjicPb1fJvkeE1xnNtVDnUaM78
         Am4CFsnAS2sx+l+mriEAW2/1oMyVqs/8+7ty07h2azPKFFfZLRF5B7b3cG5QD0k+2JS3
         6Kww==
X-Gm-Message-State: APjAAAV4hY2drnJd/h57/xSbsaFfb8ZX7eYkbyJzoOeDj1VM/u8HuN1H
        S+ES87keQ119a+pJ+h/lVRTuz2lrEYB4arVlBQ2Z5CcgF1kPnVdNIx2m/cL5NxdVygq3WqTA6Nx
        XXFyY1GRT8if1NENH7ulZxHrz9+6z
X-Received: by 2002:a05:660c:1c8:: with SMTP id s8mr80677itk.20.1553292035050;
        Fri, 22 Mar 2019 15:00:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzv2j3x/LNbGSOAlG0RtJZpeO9iQSPfBJmboEWWvUgbtwhdO0pxIQl9iRUuXWcvHkGRqKNcNg==
X-Received: by 2002:a05:660c:1c8:: with SMTP id s8mr80659itk.20.1553292034835;
        Fri, 22 Mar 2019 15:00:34 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id 133sm890673itl.13.2019.03.22.15.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 15:00:34 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Barry Song <baohua@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ASoC: sirf-audio: Remove redundant of_match_node call
Date:   Fri, 22 Mar 2019 17:00:29 -0500
Message-Id: <20190322220031.13773-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike other drivers probe method, of_match_node return value
is not used or checked. This patch removes the redundant code.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v2: Move the signed by above the version change log
v1: A check is unnecessary as match is never used.
---
 sound/soc/codecs/sirf-audio-codec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index e424499a8450..e0af21050078 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -461,9 +461,6 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
 	struct sirf_audio_codec *sirf_audio_codec;
 	void __iomem *base;
 	struct resource *mem_res;
-	const struct of_device_id *match;
-
-	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
 
 	sirf_audio_codec = devm_kzalloc(&pdev->dev,
 		sizeof(struct sirf_audio_codec), GFP_KERNEL);
-- 
2.17.1

