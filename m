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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11655C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84192467B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG2d9ugx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLFHwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:52:55 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:32850 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfLFHwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:52:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so2410506pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 23:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kAJkkEoeN3MEGLHwJYyylmkvJRvoWmMXbreTxA7D7g=;
        b=lG2d9ugxobHRE41/kg5UWdt0/yE4MsppHo+FrDfzlbWQN240CcA9QpUdB3SQ3LGPIW
         FHvT7uruy43ruGMQXKstaoy8ymSo8ryl7KSqDmRj29NpfpOXlKcQPZWrl6dt8ALkkOZ9
         Zig5X8896xQgd+00Uoi/PyyvzDO08m+wsfWdIGLNg2+MAXX8sDplWJSkgGmADIRpEuPD
         lUhfMkSw4+Rn7J680wUJySL2nPtRwwNabx3qXoaws0M2oA6UZCiiSdzakhdpFF05Zt9l
         9/ms06dU6dNYtdFBV3TYOOo6NphX8GCXZRbW7xX025t/adrKwXjtamf1ErokL3M3h4w8
         1vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kAJkkEoeN3MEGLHwJYyylmkvJRvoWmMXbreTxA7D7g=;
        b=lf8W1POGj/2BkS/iIG87ULA9gl21vroNReB3hgaHY74P5NS3vD3yekuwrNmSjmRb6W
         ofz+wjYJ/R+EXLoGjRjDza3KS6AZGkR2/vF6hx7nbe6omlOsrdUAdUU28SWk9757HGf5
         kerf0Ccn3UE4jVV8r8Jb+w0wG9KRjbYDrhOHY6YK78ofQ/PwQ718agBAzfsbodBeWoto
         wUBYQD6+DTSaWasChahn1Wt/T6qqmOyrXVXVjlAAObEaXcwoNDjwciFRB2flZ8TnpslT
         0lGpD/greLHhw5qBsR/VxSKEjjzRR1Y2YWRQS3K9di5It/GDweFV7YidRGtOOeevgQuv
         wR2A==
X-Gm-Message-State: APjAAAXTjp0rIx3KhEDURO3/sNv4ZmSuDRSSiZBFoKIJFjGnkhsKiJkR
        Ig9HeLobxfJ3JMizHn/nEIA=
X-Google-Smtp-Source: APXvYqw3qlredLsb+GwlZ2m05paSNQl2kY1qLzfGL5YtxkQXqv7xVIAc82ovW1wqhDwKFuUPyJENJw==
X-Received: by 2002:a17:902:7084:: with SMTP id z4mr13014504plk.247.1575618774178;
        Thu, 05 Dec 2019 23:52:54 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id i16sm14491341pfo.12.2019.12.05.23.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:52:53 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: tas2552: add missed regulator_bulk_disable in remove
Date:   Fri,  6 Dec 2019 15:52:39 +0800
Message-Id: <20191206075239.18125-1-hslester96@gmail.com>
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
 sound/soc/codecs/tas2552.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 56671f21cfe5..0e19ec76aae0 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -616,6 +616,9 @@ static void tas2552_component_remove(struct snd_soc_component *component)
 	pm_runtime_put(component->dev);
 
 	gpiod_set_value(tas2552->enable_gpio, 0);
+
+	regulator_bulk_disable(ARRAY_SIZE(tas2552->supplies),
+					tas2552->supplies);
 };
 
 #ifdef CONFIG_PM
-- 
2.24.0

