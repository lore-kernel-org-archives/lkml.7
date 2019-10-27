Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42C5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 18:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B92B20873
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 18:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDga/ALg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfJ0Sal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 14:30:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33998 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfJ0Sal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 14:30:41 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so7991513ion.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 11:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GBOGICALtPwpQfkNPfkezlntgQyagNPqrbCuHz6L7Es=;
        b=uDga/ALgD7JROjJVKy/BpQ24VesfuzXc2hvMTRzeG2s2CNGOnyNWgjEoR52ffxI22q
         3oFsSqfdGbnQaVqta0BQVVHPTo+b7aV2iIFtULHr1bzP9Ikti6SsNvVwr6E8mbxkx1xk
         BxwMdjYKpC1SLryjVjglWzH6Fj7rnGT8HsJW9syE/3nEBmgJJorM0Ic1qWuagk/DIMHT
         2Smt34x7H3IOeCeszuAs6x0xLFoa7NBWqzw1YfDHGGUn4VnTSZN9MxqRMaR3w/Woq8P3
         IyqOHfGrUocJx1iSOXKGeUb73u0SUct3zmJH34rIL82roPEwkKnqEuyPdlf6PZeha/hw
         2rbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GBOGICALtPwpQfkNPfkezlntgQyagNPqrbCuHz6L7Es=;
        b=OqpOJebkuEXiB4QV0ljchb2gnhY33TeTW62hddnO+sC7DM4kAX6IoaJxFcbJGsyi93
         4dYV6UcOJ8pLQxl8XyeQB/lKUvnwq83fRBPev3WKUZilYvuZPkLQOBLkt4TKaoDRp11v
         c3v7ZBprRFB8fIsV4bU3bODuuS/Qk716fVkNHBQ2/COi3A9cIs82+xcqjwVNaMw6/TvM
         qZWQzFNVyl9q9XchHH7IqSe/LvFgr63oMD2iGu4agArJ6Oxq+bN14d6ZlT4UnG3KhtFw
         4G9yOPxAdU+cAqc+nhvwNLyElhQB9JCoAUh1TvtMMJjRLZd6DVfNZRBNTcIY4uJVD8mM
         I3sA==
X-Gm-Message-State: APjAAAXvh+EYGBKf9y3qmcSs7QqeN+DRFpSmIn2XlNLCX3VL9q6qN3Mf
        h1d9ZN73O9skiDPtRdzeXJE=
X-Google-Smtp-Source: APXvYqzvo+HqAIYoP1gTDYfnuGy2ExLr+rNsa7f56B8AJkvgCeeNu5LEoi0pNv8AOaV54aFtsiDI8Q==
X-Received: by 2002:a05:6638:20a:: with SMTP id e10mr14306549jaq.27.1572201040594;
        Sun, 27 Oct 2019 11:30:40 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id o5sm1186769ilc.68.2019.10.27.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 11:30:40 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pci: Fix memory leak in snd_ali_create
Date:   Sun, 27 Oct 2019 13:30:27 -0500
Message-Id: <20191027183030.12677-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of snd_ali_create() the memory allocated for codec
is leaked in case of an error. Release codec if snd_ali_chip_init()
fails.

Fixes: f9ab2b1c3ab5 ("[ALSA] ali5451 - Code clean up, irq handler fix")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 sound/pci/ali5451/ali5451.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 6e28e381c21a..3ed07a18be4d 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -2179,6 +2179,7 @@ static int snd_ali_create(struct snd_card *card,
 	err = snd_ali_chip_init(codec);
 	if (err < 0) {
 		dev_err(card->dev, "ali create: chip init error.\n");
+		snd_ali_free(codec);
 		return err;
 	}
 
-- 
2.17.1

