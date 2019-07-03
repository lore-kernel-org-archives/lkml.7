Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BC0C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E368E2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJUvklVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfGCQcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:32:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40642 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfGCQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:32:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so1507719pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MCqMV61NT0BMmX6Fho6eWqPzt3K0aDZuWTbDCpVsXg4=;
        b=vJUvklVEWOje9plOQWmkgMd6LPxQbDPJiXUs7nd/tN99P4Fgce3N04lgxpoh2kvBde
         2Fwgt6TDdRpNjRxC2bNiJAn+mldjNvG8EoYiYLY88avJySuQiMuiV5e+52EbkBjbWqos
         iLdsSmcjump8t6f/u/yZJgTN4cIGxTWqIztSWthJTNriyvvAqwg6/zXwqE7z4/TJD7bU
         9tdy+9+WNRlojHWJBg/1F/BfaCDM0UGmvQ2h10e/p0SGrP/dWOQVEwu6gFRb80mfF8nJ
         ta+djES2kNC9DWqi9irBzFZmndX5aiu1AEIm4aXIt8Q+3c8HYlZby/pun8LKo0bXC2a6
         QI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MCqMV61NT0BMmX6Fho6eWqPzt3K0aDZuWTbDCpVsXg4=;
        b=O77O8fswlP3bB/EG1IE7/OtrkGzKjEGxOnTZOJzZPRcFeAXVI8dOIWtNQezuHp2rly
         X1Z0NO4cklZvEcoHbQY5IoPaGJ70RzwwkfWSTPWxts9GTTB+Nls7mN8NgDSw+NVV/p2S
         6pCfrn2OI9txAvZ7VF/mPxa1OVLKiqOhBl77TYfHbvr3uwVIoCrldY/9hVtEqklCH+3w
         QdO6neF7lAB92lJTEAmcwP6nyltbxLPwKn9MqOydhU3MIXypHzwzrTqu8qM0eswWY1xd
         /LwMOxPltBSlx5LrObeuLjyex7mrFf3157HYLW1F4SG+wZgedgiH7XPrvabpS2XVpiDg
         MnGQ==
X-Gm-Message-State: APjAAAUCvWGwpx7Eq/IdrwiOibigt8/5FJEdhajJ4oBVkVuOlTIvmG32
        11VPQMtdxEUXib3reuxBZ58=
X-Google-Smtp-Source: APXvYqx9GpVL2Bu58gTxRuCwso/86Y6z+4rkZRsGNZDYLI0KH5vJXcyuP5jqo5pqwCu+oDVe42pwGA==
X-Received: by 2002:a17:90b:8cd:: with SMTP id ds13mr13034487pjb.141.1562171538615;
        Wed, 03 Jul 2019 09:32:18 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id o12sm2270041pjr.22.2019.07.03.09.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:32:18 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 33/35] sound/pci: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:32:10 +0800
Message-Id: <20190703163210.983-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 sound/pci/echoaudio/echoaudio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index b612a536a5a1..35bd3e7c8ce1 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2189,11 +2189,10 @@ static int snd_echo_resume(struct device *dev)
 	u32 pipe_alloc_mask;
 	int err;
 
-	commpage_bak = kmalloc(sizeof(*commpage), GFP_KERNEL);
+	commpage_bak = kmemdup(commpage, sizeof(*commpage), GFP_KERNEL);
 	if (commpage_bak == NULL)
 		return -ENOMEM;
 	commpage = chip->comm_page;
-	memcpy(commpage_bak, commpage, sizeof(*commpage));
 
 	err = init_hw(chip, chip->pci->device, chip->pci->subsystem_device);
 	if (err < 0) {
-- 
2.11.0

