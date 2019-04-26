Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C26C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4746120673
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcPkp5gU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfDZDQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 23:16:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34869 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfDZDQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 23:16:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so950154pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 20:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=75bUcBNHjaJZII6bww2EYxwN76C3EUZYx1+fU/DnRBI=;
        b=CcPkp5gU/qroc+N9x3TtRsI7xvVqZ/G75uxGVA0gZVBZjFppPWxDlZaTY1/K4RIXJm
         rbzhHQfG36jGwJM+cIE7AJJanGrG0K7ytuxI8lhVyj5AwJOLPAemD7AO4136NXSVaPnl
         mJLJpZFq6GhTFFaHYZd3ZQag2lhG9nQyC7/4clwbCfxClsGdJEF7Ymu6EdJL6qDGDDjd
         Ui0g0JknfidgjZkemeHIRGtZxzr7Ob00XNnM7FFx0jINvzrh8wNTlSfXQV0XjORaTYHO
         uWAMXUsY+H2zp98nc1hnEvT1Dqmy49yx+0qnBQoxAONf5VEit8bI3mc6vTYoisWlGidl
         Ck0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=75bUcBNHjaJZII6bww2EYxwN76C3EUZYx1+fU/DnRBI=;
        b=D+hl0+OgoOzb6ROthF+e7xxMuoU0zh+8Z1b/Li1T56zR1M0elvKYePWMAcNr0Ze0H2
         1CQRs9/XsQlqbPQer7oanvJEXoHt5NjQ2NL4MJd+9OagghxB8RMPQXbJKW/LduHJdESs
         ngl1UhAWJeUZpDPIJTIvogUFILK74bQFUq/XG50lE7/9+YyACxlcgjExqk8VNJRkloV4
         5DwOAJn3RmWtxuGU6WSRdp0ET+ws8rsnnxG6HomHmToJRjXs26VDcwTr8sgrctDMtKYI
         cNaxHpXn01t8vkrxMcUhQp+xrAiBTqAyE75oyWlBMHHpiJDkBhYNDi7PI9uH+V56Cu9Z
         WSLQ==
X-Gm-Message-State: APjAAAWXDF1gZ29ymKPb79o0jUBIQcwoFyZ7Suk98KzMqU9LknomhIZC
        i3MVaFfZS8owNdUoFmPWw70=
X-Google-Smtp-Source: APXvYqx9WUSCNz1rlyqmqiLm1I+sQVA0dnmYo0iuDNFiEFzqZjbEjILpe2/Wvv8zEC+99jv1sIGj6A==
X-Received: by 2002:aa7:9306:: with SMTP id 6mr6543965pfj.122.1556248595105;
        Thu, 25 Apr 2019 20:16:35 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id s3sm17346432pgi.74.2019.04.25.20.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 20:16:34 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] sound: isa: gus: fix misuse of %x
Date:   Fri, 26 Apr 2019 11:16:24 +0800
Message-Id: <20190426031625.30420-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to long type and printed with %lx.
Drop the address printing.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/isa/gus/gus_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index 4ac76f46dd76..d708ae1525e4 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -306,7 +306,7 @@ static void snd_gf1_mem_info_read(struct snd_info_entry *entry,
 	used = 0;
 	for (block = alloc->first, i = 0; block; block = block->next, i++) {
 		used += block->size;
-		snd_iprintf(buffer, "Block %i at 0x%lx onboard 0x%x size %i (0x%x):\n", i, (long) block, block->ptr, block->size, block->size);
+		snd_iprintf(buffer, "Block %i onboard 0x%x size %i (0x%x):\n", i, block->ptr, block->size, block->size);
 		if (block->share ||
 		    block->share_id[0] || block->share_id[1] ||
 		    block->share_id[2] || block->share_id[3])
-- 
2.11.0

