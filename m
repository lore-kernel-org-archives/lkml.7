Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9DFC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FAC218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htZKGSZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbfGWNkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:40:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37104 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390330AbfGWNk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:40:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so19174196pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jugRb2vt232DJ0Tf9bLWXh+Q8rg8VA+VLd86FZGf/5M=;
        b=htZKGSZgs7EAS6bHJHCCD1rlhs+g8kjPbkcAjHDjjnVRqUXoJ/Op7Nc8H/+IN4uKHK
         41NySenxDvpM4uOPOzcGBovI94jHxhaiHYI4P9ILZpM9swPw9CFPT9M3XoKf4auraunj
         cKxA4D0m1M3ZukOiqFvDsxYOmNYOOg3Ftv6DvBN9Gou3MP/QZPdwQtHmbtA+JDKLIV9b
         QfznGZ8dq7j44JmbcM48IYAldcSLRBcQ283zrv21VxAh9rNYiAvlbRQ36EP7Rk4DFvio
         pu3bzJcO6i/1PuOi20iHkvNQQPnsbhpLwIvXbOk8/vj8cF44m3BlwcGGDMSRyMS2jiZY
         lZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jugRb2vt232DJ0Tf9bLWXh+Q8rg8VA+VLd86FZGf/5M=;
        b=YWeVGjPRvogh072r2UKnduYvrvRfUZoF9ru5m7zJTwusnmwNQ6pikuPB02xgtxNjYw
         V7ificzo0lvyxwhaXCmoseYwDAsH8MenvDXFPZWm6f7NrdXDOvjA3lrxNSPf/H8o1XeZ
         GH3tjK6yoP/REqHH3O2yB8fccME5Oj20yS3YcrzOuu4wB42REJvvl9muscvJ1Nv6uhIV
         FrKwHg3BgbVLBQoy+e6tegx2JWSLVMSi6cEHshqxh6FyIc4ZOR5f1/4zSrsU5MeXmekx
         bRu7kWkTzDWwWDmM/WaAghlf1NkgGrsStFWxSggUrQJOvvEIqCiiY+FkNGiY6yeNn+1q
         jVqA==
X-Gm-Message-State: APjAAAXS7VQrEqG1YY/qX6J95EaMXH83Sw1D+9c+nyD42ZA9Rc2eXXG2
        Xc2UnNxk64J8lFIx+PNR16I=
X-Google-Smtp-Source: APXvYqy8VT8V/nFcsrgzWFDj6Z0IY9HPcv+uKoEjpRhDzmbL3rSCPKiqORlzVCMoErFHH2h5eRopMA==
X-Received: by 2002:a17:90a:9903:: with SMTP id b3mr81880307pjp.80.1563889226916;
        Tue, 23 Jul 2019 06:40:26 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id d6sm37813630pgf.55.2019.07.23.06.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 06:40:26 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, huangfq.daxian@gmail.com,
        tglx@linutronix.de, allison@lohutok.net
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ALSA: isa: gus: Fix a possible null-pointer dereference in snd_gf1_mem_xfree()
Date:   Tue, 23 Jul 2019 21:40:20 +0800
Message-Id: <20190723134020.25972-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In snd_gf1_mem_xfree(), there is an if statement on line 72 and line 74
to check whether block->next is NULL:
    if (block->next)

When block->next is NULL, block->next is used on line 84:
    block->next->prev = block->prev;

Thus, a possible null-pointer dereference may occur in this case.

To fix this possible bug, block->next is checked before using it.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/isa/gus/gus_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index cb02d18dde60..ed6205b88057 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -81,7 +81,8 @@ int snd_gf1_mem_xfree(struct snd_gf1_mem * alloc, struct snd_gf1_mem_block * blo
 		if (block->prev)
 			block->prev->next = NULL;
 	} else {
-		block->next->prev = block->prev;
+		if (block->next)
+			block->next->prev = block->prev;
 		if (block->prev)
 			block->prev->next = block->next;
 	}
-- 
2.17.0

