Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EFFC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176F721901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS7tR5zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbfGYCJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:09:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35987 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbfGYCJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:09:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so21874326pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 19:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r6xcP5bA0sOT1XKD434f1tzHJ1w8Z5pUhBurvR0md3Y=;
        b=OS7tR5zyV52UK8u0O/4vWdCPtirPj+DX3kR5Qgo2YISvEdfPqAmP6f7NJy+3klPmT4
         RfiJkeso73KofXRUuat2uX68lTB2nU+lTIoDsvW+XXbqveTSN22AxhIXfvTl1OPmEGOX
         DH3L7/9/XwY5TeTaDs6ABHYUM5FB1G0P87Pr1+h/ZEgE/aGHr9TSGUmLgFDYzYzqlESP
         1iAG/50feaU5Wpnt7JFSAudk6bjOxCwMgQE2p0Aw+aNMQHkFGspQpD8Jd1B6o/qaNIi6
         T5cdmRleLEqVXZqLsvnAhx+nQAuZlQQO0MSsTDOGkl5s4M6GF7nA2xY1Q2icg/YVFy96
         pCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r6xcP5bA0sOT1XKD434f1tzHJ1w8Z5pUhBurvR0md3Y=;
        b=TthDulgdbsCLs5/liA0/ESW7zj+VRc4WBoBtLPqB0D+HRJ7B2XkvQ+5WU3+2bdlGuQ
         34YFYl/bZIKj2VVRBlASuuXBqgLmXFXMY9FNxbFMScFwm8sUNv42JFM37SDrEAbEMpmh
         3z4ytJmLuTIbMyeADw1JozjwWK7fJtgkj1qeg/o83io7eMT7ApNjj1IHOPliY142SZ+u
         rp+46Y7KZNMVUHf7A7RGIUHqew6a1rAcMktuvYBeSPjqXga6KVOsGtdHod5Sr+i4II/s
         XwupmF8Slj1KcgUlMtjXZvu3HYgkhIXQu/QO/Mlr4xarZSF02MLjoTPTs0i/JPOe4JRA
         TzFQ==
X-Gm-Message-State: APjAAAWGxKb9fFRCylmIlQ+Z3KfNtYHhR7gXJYhZ+04AiWwjUZgF7buz
        0EmVnvIaDWx7L2Nevz/jVLUikUUcZqc=
X-Google-Smtp-Source: APXvYqy09Mds/SHzIx9nVdnz1Mx3LWHtzspmtN58tOrZhoceS+OUaqb+iSoiBuk9HxtsEaV20c2MbQ==
X-Received: by 2002:a17:90a:2430:: with SMTP id h45mr92683720pje.14.1564020569953;
        Wed, 24 Jul 2019 19:09:29 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id q1sm56990685pfg.84.2019.07.24.19.09.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 19:09:29 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ALSA: echoaudio: Replace kmalloc + memcpy with kmemdup
Date:   Thu, 25 Jul 2019 10:09:24 +0800
Message-Id: <20190725020924.7643-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using kmalloc + memcpy, use kmemdup
to simplify the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/pci/echoaudio/echoaudio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index b612a536a5a1..ca9125726be2 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2189,11 +2189,10 @@ static int snd_echo_resume(struct device *dev)
 	u32 pipe_alloc_mask;
 	int err;
 
-	commpage_bak = kmalloc(sizeof(*commpage), GFP_KERNEL);
+	commpage = chip->comm_page;
+	commpage_bak = kmemdup(commpage, sizeof(*commpage), GFP_KERNEL);
 	if (commpage_bak == NULL)
 		return -ENOMEM;
-	commpage = chip->comm_page;
-	memcpy(commpage_bak, commpage, sizeof(*commpage));
 
 	err = init_hw(chip, chip->pci->device, chip->pci->subsystem_device);
 	if (err < 0) {
-- 
2.20.1

