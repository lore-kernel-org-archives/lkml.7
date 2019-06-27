Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403A1C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C21205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlQMzQja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfF0Rk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:40:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36159 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF0Rk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:40:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so1592234pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FR72I8Co0+MJGxYGED+5/dqb9dBV7h2vnmoy22KZs5Q=;
        b=WlQMzQjaD6Aa5Vpx6UqUNwQtzaS+/ZnzexxXnYOYG0W1PYAgkbHfE2fYWoFKiBP7Zh
         LEPR/SVzaF7l+Q0m/o+UQebDcRzFIfpgkyImNv/KS4nJvxOsSaAT7aN30UUxwZLvkXsZ
         S9TZz5Czs4+GdrWidNougIDcp9M3vrswqrYypZU7hhTfV/t60PFVpiIsb9HBmx5S6jHd
         XYri7Ee2gAkIhLJZTONReWvn31bZfWiomRHF24DigS8uElaw1RZfJHUfP4/QS8fFGm3R
         OfXHhpgZfeWICB17eszaHC1hpsNgliz4hxuW3YOWDqR0CZKbTCr1WzSwm8Hs3BR1Oq1K
         EqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FR72I8Co0+MJGxYGED+5/dqb9dBV7h2vnmoy22KZs5Q=;
        b=FsYAMYWmosxmcznTIXcF87lcKKfSOUtBREO/Vmv2GdSAVyuVcNJ+5bvsgwUEDof8VQ
         SLEr+rClESp3F9sV/qhNymXp333mrlLiBYJR6OYASgHuRgmMH///fZSagmq6TGK6Yu9Z
         hvDfLPv0ga23DOJDo9Zb1otdVyWUppzejAg8GgammH7efZbN04GnqeesLiP7GWHIm1WC
         BdqBq0llbiYKQdkI0GXk9pihzpM8TrU6c0qVULa4LRbLYyvBBSVDIFG8944QiGH3VKpe
         ghh/wOnmDFX9v8ElYK1vHQaA6bOszz3y4x/PDP4pNJc6xjr+IOw4CVtSLYyRLxdCqakF
         KdGw==
X-Gm-Message-State: APjAAAXFlECeIY2EYpldteH/bFsKOB1R5TUfV4vWrJ12S16UH5ubPhxl
        kPn3/uaAAxJ0gpuAhINqczM=
X-Google-Smtp-Source: APXvYqyafuSdTGPVAkCNuqSoaQIqQdl9g85tFTYZqmB4WSXYWLjMlnD3sWyW3Lsdj+lZO711wPLnpQ==
X-Received: by 2002:a17:90a:9f08:: with SMTP id n8mr7522337pjp.102.1561657226195;
        Thu, 27 Jun 2019 10:40:26 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id o95sm1727758pjb.4.2019.06.27.10.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:40:25 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 41/87] sound: ppc: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:40:17 +0800
Message-Id: <20190627174018.4015-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/ppc/pmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 1b11e53f6a62..1ab12f4f8631 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -56,7 +56,6 @@ static int snd_pmac_dbdma_alloc(struct snd_pmac *chip, struct pmac_dbdma *rec, i
 	if (rec->space == NULL)
 		return -ENOMEM;
 	rec->size = size;
-	memset(rec->space, 0, rsize);
 	rec->cmds = (void __iomem *)DBDMA_ALIGN(rec->space);
 	rec->addr = rec->dma_base + (unsigned long)((char *)rec->cmds - (char *)rec->space);
 
-- 
2.11.0

