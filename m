Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAA8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D9C208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhxJ2cyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfF1CvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:51:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37944 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF1CvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:51:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id 9so1585829ple.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FR72I8Co0+MJGxYGED+5/dqb9dBV7h2vnmoy22KZs5Q=;
        b=IhxJ2cyQo1/nvunCFvFfS0lEbh/0091c04NKKkhNShMj9sWqyfADIGoFXQl05TpjYZ
         7j9A1FXpIIEdEwYze1FTKINBI27EiSaozaS7oQ9bNK1BFztQRxa22TtkmWEFmUKAQ+ZB
         Nzy0w3v1kP9zev1mkPZoA9lp3fLcgU4t6y3NmEjraSL8V+oHQ6LknVwFeNHupu+NLP73
         Q8YBHbhPZtOVyBiwviEQHq0703WzQ6nsqSlyYrcGslLgXO3uwcIsdDebNOqrEuhe0uPS
         29oPRFdsznFFLxhrSOb7M5UCeR5+K1sx5WNlxrRdHaRg5YW1mkMs3kIi/offf8HJ0AZ8
         ngdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FR72I8Co0+MJGxYGED+5/dqb9dBV7h2vnmoy22KZs5Q=;
        b=rj1gcqm7F+5yh+zJZd3nTapILy0PE09F1217YbJaWnn7PYICiJAOaz0orvSJCHWV0I
         yHkHw9R0SNOwNPuG6vOxfm9LuUFs1UhD51+fDCMyFZnjM2vDoN/AgQMSKgD4sPC97KvG
         Vq9tK0UZtG00V4yIWpb75I5mUE66p0AuCg7TT7KVUXpRpARU7GVKDfcr605FPW320S4+
         6mSyZCxFPoJrku7nDk8LZUc2V02/ZFLiR+yQrzfyP4k0lSktnxiq/Lx7dE8MQ8+cZB49
         P8nlvWwl2bz3JcRQXM39INsK0B1CjXwEMy7PmCXJObPT8ES4orA+V3WkSLOR+eh50rjp
         /RrA==
X-Gm-Message-State: APjAAAWlW8+jwC6VunRkA+aJRG14btg2V38Mqt305XUI2dQRRd18u56q
        C03DjLRtGkXSJSSoNnkzRxs=
X-Google-Smtp-Source: APXvYqzL32mC6au/7C3TzD/kwMbOVnb1DJlzl+HtOU7wDCsXVoSrKw2C4o6YPmea15yYB/y61C1tKg==
X-Received: by 2002:a17:902:868f:: with SMTP id g15mr8558096plo.67.1561690262921;
        Thu, 27 Jun 2019 19:51:02 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id b1sm457294pfi.91.2019.06.27.19.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:51:02 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/27] sound: ppc: remove unneeded memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 10:50:54 +0800
Message-Id: <20190628025055.16242-1-huangfq.daxian@gmail.com>
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

