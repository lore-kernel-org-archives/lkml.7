Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59ACC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D5820726
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEywBp9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfKRHhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 02:37:20 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:46810 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRHhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:37:20 -0500
Received: by mail-pj1-f67.google.com with SMTP id a16so1233995pjs.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 23:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xe+Hh36CXezhILfUXHbWAftsPx9okk6we2CTbfEFf9s=;
        b=uEywBp9R7GGZbAzKwdAp8tFWJqgwu/JH5HVj9tW+e7xMxu2mtryi1sS83Qn0KWgBC+
         lQDxYX+Cnfc+47KD5MeyLaWjQgPPcxnck+6F46FzQ66bkSe5D5F0x/ho0I8lGxhGPKHP
         pyr9nhutvn48T1wCAqqwcGzEfpfaS+AF30BYjLvzn3CVSOfYk4UKpBRtA668JhpHltoM
         F7vIpSDC/GN6dWG/X3pLxhZ5HjV9hxCHb7xyssC8cGsKmApjJrtLs4eFWbQlGnc1GtTb
         NTq1LuL7BUNhRrsGbnja7MPBHr9MDRp8WzrX/eLwT1p/3sh1IFSMEK2rMUE2MkoY+csp
         kN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xe+Hh36CXezhILfUXHbWAftsPx9okk6we2CTbfEFf9s=;
        b=s9lxdGo5GOl00+OOpr61RMUjlaAm4ub4ABbZcImKAkldL475B3WaOFt517Yveoqtor
         siXrEBtJGht4uXuftGIkWikco3KQknJJvdmhfJTWMqPTI9OSYK5hhQJOML0tXjsfy8Qq
         j5OKq8CYEX5jsTtH4jlOQeyg3nwF+5AxJFstBkEJvg4euqde7C5uo+TN6PgSnBmjzZHc
         DlVE3RwcQOnLQM3UDTyP/E28RZ6nycKmFHgimV/i+geQfm6KMZp+BkskSeq12Lz4s9pG
         h42/HRyORdm7aN6sBnaO2q8WIP6moec2KH9UaoLxfClKYvM1a1slQr0rurpPusPgPmTr
         CCAA==
X-Gm-Message-State: APjAAAVEo1xZdogDtZBIODVqKv8YV6TKFCMXgKbBXSas+vA4JhSkslxy
        1Un6d+glzS4HMePjfdVzcHI=
X-Google-Smtp-Source: APXvYqxThCkDRP6EGlQmF9R4DC4kVnMAodv4rvCLvKrIbCeIrNU4+BLtKDrzVZu6CedepBM3wRJUKA==
X-Received: by 2002:a17:90a:ca04:: with SMTP id x4mr38341944pjt.103.1574062639600;
        Sun, 17 Nov 2019 23:37:19 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id ay16sm23001911pjb.2.2019.11.17.23.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 23:37:18 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: wm5100: add missed pm_runtime_disable
Date:   Mon, 18 Nov 2019 15:37:07 +0800
Message-Id: <20191118073707.28298-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call pm_runtime_disable in remove and
probe failure.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/codecs/wm5100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 4af0e519e623..91cc63c5a51f 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2617,6 +2617,7 @@ static int wm5100_i2c_probe(struct i2c_client *i2c,
 	return ret;
 
 err_reset:
+	pm_runtime_disable(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm5100);
 	wm5100_free_gpio(i2c);
@@ -2640,6 +2641,7 @@ static int wm5100_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm5100_priv *wm5100 = i2c_get_clientdata(i2c);
 
+	pm_runtime_disable(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm5100);
 	wm5100_free_gpio(i2c);
-- 
2.24.0

