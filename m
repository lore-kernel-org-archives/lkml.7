Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD755C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C6D2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amoSueJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfDULsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 07:48:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34335 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDULsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 07:48:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so4567421plt.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 04:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vUJK3JN0jpEQ2IGfuvEC+5jJxjC4jBJIx1sRM9gLNws=;
        b=amoSueJFh7I89iAIsp0fL+NQ4c89Vf4wcELKlzMqSoIEBC4FEN/eaUD+CAt1j/Acf5
         qd+WpSk/0mHrbCcHbQI2mVmWgPkP7j/7AnznXO35pOFZRJURsA5symOu4BElYbLy8H6J
         trRBw8IrsUnQ7cl6+EUNzhJq2KKulx+A1VfOTZ/KJfTtblM6RuTGH72wNYEDtzJdMHFa
         VBALd7m1Wna9v/0ChDo5r1K/HRbJfWFz5jxsZ7TyHbRHkv38YWNvlA69OjmhLhIh+Xoo
         Zdf5G2vB7GVbgXOE16/q9+9+f43RgXH6DReIA2HZAIBIgva9E9u8wG1QWZSGaKxbFJjO
         IMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vUJK3JN0jpEQ2IGfuvEC+5jJxjC4jBJIx1sRM9gLNws=;
        b=nhFIZH8Tr4bhJxhowlLsexdc4bcFBVlcUG2BBqpYEqh8ciqmBg61h7CdstE94wvJp7
         iRB/BN0ATrX0Tr/o8vIiHHKP1bExLM7bkgZnbdVhvpqcFAoARXoWD1Grt1a3r3fioFUq
         MtXRp1CNtvjpaJALM7EFv9mT+UGizgsEparv0a4pycqU+JET7giF++/XR+cmH9N3y8NH
         8A+Rf2ZGWq5zVu22kmy/FHlNkplquEKWGM2ed9Pxf2oAEnUG1xWaNjtHye3MgcYbgHT3
         DA5ICeyxyJ/8B5Zx8LtTVN3Fn1BsTSmTuixDOcWZpp3S7Iq53J+hlL7Ko8qzZYAMQ/9H
         32aA==
X-Gm-Message-State: APjAAAWy0/j2dubHyf6w8vqmnKwWxXO5r+8+0N0LFJ+s2iXxT1w7t8jQ
        +RBnc39Jj//C9uKZ+cDZxqQ=
X-Google-Smtp-Source: APXvYqyIHf2kyFUrPTEUoitO9gCxy7jSV+pnletGWE/zD/+6w/q4hMjRD6IoOAs5WofHF8r3nFnpuQ==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr14832799pls.100.1555847333509;
        Sun, 21 Apr 2019 04:48:53 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id j16sm13642744pfi.58.2019.04.21.04.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 04:48:53 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/06] sound: isa: gus: fix misuse of %x
Date:   Sun, 21 Apr 2019 19:48:44 +0800
Message-Id: <20190421114844.20574-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to long type and printed with %lx.
Change %lx to %p to print the pointer.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/isa/gus/gus_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index 4ac76f4..63e790f 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -306,7 +306,7 @@ static void snd_gf1_mem_info_read(struct snd_info_entry *entry,
 	used = 0;
 	for (block = alloc->first, i = 0; block; block = block->next, i++) {
 		used += block->size;
-		snd_iprintf(buffer, "Block %i at 0x%lx onboard 0x%x size %i (0x%x):\n", i, (long) block, block->ptr, block->size, block->size);
+		snd_iprintf(buffer, "Block %i at 0x%p onboard 0x%x size %i (0x%x):\n", i, block, block->ptr, block->size, block->size);
 		if (block->share ||
 		    block->share_id[0] || block->share_id[1] ||
 		    block->share_id[2] || block->share_id[3])
-- 
2.11.0

