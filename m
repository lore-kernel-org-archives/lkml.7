Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87703C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB6420659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkWr6o1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfGBIAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:00:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43649 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGBIA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:00:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so7283065pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kVJn0ak8nJav0mJz+WePNaFHoPDUWoH09AGm1fKXE0w=;
        b=SkWr6o1Zw3qYIi8uVIIaS5nkf8wnbDHV3CkdnT9vtcZkskv9hh6zJwcWotQrWOF6Ej
         RlEVi/ylQTOkxMtfS1bA1/F5kvneDfj2MPmbEfCHKora/2BrSV76aMfp3q+QSXpft+F5
         LwDPQadLm8vde+wCTY9M3nL0s56eTEonsK5UrOEQAU5lxKayWv1NZRdLT1W920eNvqX5
         Q/yytUjmiAl5DDllTHYITg+gtsYdxSUB8y2QpVoP/bYRobdFk9daaa3UUz4KqY4LU8FI
         cO6jMS4zVONxD063Xz65p0EnsTh8aoIif0qZqRbANHnx27SB6idK8x5yAyEgjA6VGHHk
         6zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kVJn0ak8nJav0mJz+WePNaFHoPDUWoH09AGm1fKXE0w=;
        b=R8EhpL5fb52Ub+qoRW0wP+rYc28d/khAy/7sE9aJO5oRy+xDYiI5Ubub9YHJ+VqZGg
         BMVyzsDCWG0JdrlaZze6Yjmu84YGO5FvBMhVLw3fr+oEvvn3EQW2g7stBgeBWF4kW+cJ
         3eSB7KohufJchx7WitSa6K0/v4nAA+Eprmhag1OI17qZ7kx1nPq9pl4oeT4hogONElGJ
         pLNdYnwPtI1QQ+LhxUBslnL8NBYdMvXNjnDk0OG1l2Z9hPhmKWfO0pTzKC47FVPcwfLS
         0Q/LWrbFB2ja6zaavO+2CJz+r/V/tPlgo68CVTjoh8D7ks3k/0z1nUcnnyu28XskOBib
         Wgig==
X-Gm-Message-State: APjAAAX6OAn8cl7GnF2g+cUS2PG2CWmtm8yC3s+V1fpR2ehO7EAGrM4N
        /zFhWjwGqw7JjZeeL/+mGqj4oUFKnR8=
X-Google-Smtp-Source: APXvYqzkiA/nMgQD7EGwLQrFg9jl9RwZxeLB+Lzy36hLmKD8GiaxIZOsCoTmsf3Ojdmb4ILmghcbmw==
X-Received: by 2002:a63:394:: with SMTP id 142mr21496362pgd.43.1562054428881;
        Tue, 02 Jul 2019 01:00:28 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id w16sm15914863pfj.85.2019.07.02.01.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 01:00:28 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 27/27] sound: ppc: remove unneeded memset after dma_alloc_coherent
Date:   Tue,  2 Jul 2019 16:00:23 +0800
Message-Id: <20190702080023.24770-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

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

