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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E368FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ABB218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7xWJ/l1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfGCNSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:18:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33114 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:18:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id m4so1258852pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Nj/3gkFpbOs8TwYJH6jtpLzU/5n2yTiUnG69zoLMmRY=;
        b=O7xWJ/l115TO6HXFLmdL4uE8BcJQnt35GkuZIG1XCxNxs6L3gacLowdoXt9u6WIYTU
         EOK/YOV+16ah1UKJoABmyB3IooXCj6oJmKCq71iviTUc/n4soQ8ou4F71QG1r51qVM3o
         m2wmULGU7CC+2UZeaFywAd7EDHv/BhfMgPyZMaA6WGTG9eGzhohXVDXB8pA4KJU+uJEp
         Y7YAuSrbuNzwa8wJ6eoAiCPBXhchYSBEf9q7wm4IWjG46Iypw1dd/Gdb1ait60ej7cGq
         RcvCGGyYLDADJmpZpT0fGNz+mg7/kVWybhffL95VOiLrOJD5Mtbo2VR7BrE1HF2c3bUz
         c7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nj/3gkFpbOs8TwYJH6jtpLzU/5n2yTiUnG69zoLMmRY=;
        b=YGdUrueVVgSxxD7zZBFkQoqA2xn8n/9MDeBAhUWya5OxmSoFbthUzDYeBv5IvugVxA
         lLgR2M0bA+hFPagtUBC24313ApodGH9qT86Iwc/tI59VqWHKCatrUotapYVEio2CPoIV
         Yv4Aj91NRCOAtvO+uttQdcb+3yeyzFVrv4uFWHWMFg5M+E/7DN6HKa57xe3pWJLO6KBZ
         /2FrEIRGjHlElPxNbJpcNEaut1YKzfSxlPBKK2sF2WCZVdjqHA2QlEL6f1U7bTZOqQFK
         yrisskbfR2uVJt4eFUtssFNW5Ym1Q2tYu+hqzv5LKzqVLvy8IJBhuLRUxGsWBfcESwP9
         r5Mg==
X-Gm-Message-State: APjAAAVQnrmkhHzceWvai2AWGZEUjwDI6RUr0wDmYAQpp2rHL+GQ61TS
        lAS9KrO+erNnOakR1BK8OpU=
X-Google-Smtp-Source: APXvYqyH8+m3SiHlSWz1oreEGq5P1R0Ctjbe5y1tP/RvYuh+7FEST3gsLwJwYp+LaRjpdoFD47a8WA==
X-Received: by 2002:a17:90a:21d0:: with SMTP id q74mr12981198pjc.12.1562159920457;
        Wed, 03 Jul 2019 06:18:40 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id s66sm3981430pgs.39.2019.07.03.06.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:18:40 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 29/30] sound/pci: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:18:31 +0800
Message-Id: <20190703131831.26013-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
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

