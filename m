Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C0DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C612146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ZY/70cyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCSVaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:30:25 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:58632 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCSVaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:30:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id ADB8ECAD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 21:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uojhfqsbsJti for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 16:30:23 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 82A78CA8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:30:23 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id 186so100437iox.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 14:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EX4pqw/c5TCP6ECcP2pprXiQ6u4REcc6rmPecOQ4MHE=;
        b=ZY/70cyRyZ7VGkuHLBIdx9dDKddBnxI1jpDorq9iRxiafFBlaYvZJ5d6U2iRKvRhzA
         C5LuCMNbVc06HC+1sfmf+RkKODEkcGiHrLe8nAwppyR7z1q0HYWHga88wZrfdAco7ifg
         VdA5BFRBZxa7584eH2YVGf3yujaErQlGvL19BUzCqkPlcdar3anVjAjYfmjKz9ekpa0T
         H/OH6X3kb+Jhlr82AS7NXpz1sPnIxLf6tDF2/6UxGOk1DdOQV/+eRG5HZN/ng8GKzLbr
         MjTmVhRpOjAKd7ZuCqRdD4CLqWGFrLRVsymwProfR7SmkwRXybIn+lHZkj1iCvGr2U3z
         eJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EX4pqw/c5TCP6ECcP2pprXiQ6u4REcc6rmPecOQ4MHE=;
        b=SJS2Fp0gusdreBDpXnukdO3cekni9tyGD3HJwQxJgic7KEQRP5PyhJlw532H4gxDA9
         m4Fo8SDuimfMrsj+fRccaWmpUQ7+RJyxrwezzRtfjyhwWdWdfNEOcSz1qMjn5RiqevSp
         KcGgTAxnzEzUa/y9xww6SUYp8fggs4gMn43PsObGVKX+gkxM6TYHg9tytmXyFTmyowEc
         piJg3cvbhtDHHpTFGcIFW7cVdGNe3rkYkqcguOQ3V+IwNy49nU6EA/+wNVMp8Xd6NMDd
         p3ONXvNTAlCC5OHIInzItvg7FlWx6g0WaBBr4ioYeMOhIbkBkz1qlfX44ZTjIUVPUcCB
         BXKA==
X-Gm-Message-State: APjAAAWJ9aAFUBvFysodiwvDpCS6iG4hn+rvjgeELkO2pGdzQXSZmDt3
        GVYwhqLlWw1Q0SWq8lIYL8mmyjhrwEDQmDn2c22EQgrwEV9U9sPLLvu8VLK9yCy+tTzfsTgsKIj
        mVYqkkauN9U5JD3rJPJh3/w1SwbbQ
X-Received: by 2002:a24:77c2:: with SMTP id g185mr2847364itc.31.1553031023176;
        Tue, 19 Mar 2019 14:30:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrrNKXxsAgK/n4LEKBUJZmeugDiEqeP+Q9hnvwv571yoCQ9sCqUqVSSjNVnytzn2rfLUGamQ==
X-Received: by 2002:a24:77c2:: with SMTP id g185mr2847295itc.31.1553031022001;
        Tue, 19 Mar 2019 14:30:22 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id x25sm19802ioh.63.2019.03.19.14.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 14:30:21 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Barry Song <baohua@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: sirf-audio: Remove redundant of_match_node call
Date:   Tue, 19 Mar 2019 16:30:18 -0500
Message-Id: <20190319213019.19673-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike other drivers probe method, of_match_node return value
is not used or checked. This patch removes the redundant code.

---
v1: A check is unnecessary as match is never used.
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
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

