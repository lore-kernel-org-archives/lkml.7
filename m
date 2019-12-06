Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F46FC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B03A24679
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS0AtrvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLFHwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:52:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46309 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLFHwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:52:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id k20so2365312pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 23:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esKX0yBbwLj9BsnY+YMN3L28an7nOLNJQ8QXI3FnKzU=;
        b=YS0AtrvRaVMqAcGjqYDM24aoRhvIQBb5zpqO21B2dashN30BhoiGKYcTzMXptoQ8be
         +bYlhz24lNesRSKIz7L37sCRkxl4dvWenJ7gZudcHO+/4dZb6OQfbVjU1em4N5vP3Q3E
         EsIb6yWdDsR7PVIhWldvmL4oh6A5VVI0QYzsTBMbbq5QvYaxUj2aKhSZw+iU4ZYN/pju
         A+GrNfKLEdAdylSd6t0C+sVlkgtm0KtQ8SmX1IIwK2s4cjCBucC7afYwYYQK6rvAKrgO
         x7au5ci0aBRsJ/Pc2BklcnSrzE3CG9mrIrPmrqTpf85XLbl4OY613dMHj/l6eUGGYb9z
         x1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esKX0yBbwLj9BsnY+YMN3L28an7nOLNJQ8QXI3FnKzU=;
        b=GWhskwW49EK1Vx8JozpBKNPibPf4AhX++3pbYnB+O11aXMPnwcniHg5FdIEwYc4hyp
         ftDIoBHziaxrFRHBPhUiOFpQw9VcLTEmbHAZl7UKCFxPfSUC0DR3osVivg8kGdQA2a1B
         mcggS1vYMFuGmrfEbnRfWLwFm67weYenBDczMsh4WVqhodIjXqlpEG+gDAtBTkC63rMI
         amU9KwUfUXWIqV5rFBxa0iGAbYOjlmYko7EZEe6pQv31YlgmXUglIsE7o1gNKD9RjWhf
         fFqNICLyjCxPQ3aAC02FYdeFh0keJdgIPFmQUTobPezcysr+F13CwLSMh+FLqfN3NVlm
         1iwA==
X-Gm-Message-State: APjAAAXzVmNtyBhV2VyG4eYe04wGB8V9YfWngRywxDB849YELp+2Qq36
        hGWA8/dZSthXmPfuhZL+slE=
X-Google-Smtp-Source: APXvYqzieekhi5Z9FrgATSh+2vmlOhNrw5UgkDFtuTD9b6TCthRMcpcYDkwr/oJAQcbClGxXIXJ+DQ==
X-Received: by 2002:a17:90a:610:: with SMTP id j16mr14296932pjj.85.1575618721583;
        Thu, 05 Dec 2019 23:52:01 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id 37sm12647639pgl.83.2019.12.05.23.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:52:00 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: cs35l32: add missed regulator_bulk_disable in remove
Date:   Fri,  6 Dec 2019 15:51:46 +0800
Message-Id: <20191206075146.18011-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call regulator_bulk_disable() in remove like that
in probe failure.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/codecs/cs35l32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 3a644a35c464..be8159bd8ec8 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -501,6 +501,8 @@ static int cs35l32_i2c_remove(struct i2c_client *i2c_client)
 	/* Hold down reset */
 	gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
 
+	regulator_bulk_disable(ARRAY_SIZE(cs35l32->supplies),
+			       cs35l32->supplies);
 	return 0;
 }
 
-- 
2.24.0

