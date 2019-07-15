Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F7EC73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AFF20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOCrqFCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfGODRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:17:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39730 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGODRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:17:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so7549075pls.6;
        Sun, 14 Jul 2019 20:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6MHHoTlJEAE6sY1Ks3ufUvy8PVNDBt/S9EU1VSQMB80=;
        b=cOCrqFCKlG3Qdf6tYXfJkHSO1hHYfdbgFCUmFjwhcw3g0S1zeO23SK6KtHVV0vRLkd
         cy6uGVr+U9OOzqUTADmADe9DKioO8Ya9VqBwSJuRIFD+ey8DIcSgibt09Bb0Knywo99p
         bSTinnenAfQImtXq7d6uO+CHw1wm5fKP/ggyx+qeNLDqCF6WY5RgyXhFFI6FWVXSQ5DJ
         1Fk+UixgNvsCZTlPv2gVK933vPoJZd+0tJomqLbZz0hVTRC2L8ZEl8yJZqmJuPwUJs/w
         IbFXPHkciCV0SKKbNqUZzLnWNV6VwyCsHuHx6ZbNEderDR0v/mhuzoqId1cmdgIehE8U
         dPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6MHHoTlJEAE6sY1Ks3ufUvy8PVNDBt/S9EU1VSQMB80=;
        b=QEzDgbJtXoZ/lAF2BqKvvWXGmnSZMSnYIIe7vDwhMxaRBWBxU56uyQ+AsYJlstKgAd
         DUIEwRC8Ca2q5DRJFhCcljUvtz3QU8SqL50wt6cFgGiQtpdKozFejTv7pMb7IVNm0o9e
         O0/G/fc9gX3T2Bcyw8ZZSKf0jlTEB2HUflGfsdJuQwt32EzpvY3LtGQHMO1o1RY0hII0
         a4J0krD2Jf+JkYxWevPzxo5hj3Annk/+B06lZu1323auhp3/60V58YeOW4xPTR/EFljq
         k5f1tgBtmrKaJeiDNOtPBJufz9w5s/O8ST98TJmKEGwnXG3CUZNEm2tH2I3jeEtvLF8E
         vXqg==
X-Gm-Message-State: APjAAAX6oRNEAJl6MQ6vOsT+qM9ZPE7vkszQG7O/Yz1KbVnkGERHQnIk
        Ba6eUzyLy4vfr36h/oHMHxgZkiULv7o=
X-Google-Smtp-Source: APXvYqwVU3ngvo8DIy0+pFETDxRpEirnPifQJuWMFIsp5ljzulU4CxzGZggXzQNZqJounQbmmVEmPQ==
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr25675778plt.255.1563160628223;
        Sun, 14 Jul 2019 20:17:08 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q144sm15545084pfc.103.2019.07.14.20.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:17:07 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 01/24] sh: mm: Remove call to memset after dma_alloc_coherent
Date:   Mon, 15 Jul 2019 11:16:54 +0800
Message-Id: <20190715031654.6223-1-huangfq.daxian@gmail.com>
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

 arch/sh/mm/consistent.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 792f36129062..b09510adfae9 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -58,8 +58,6 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	memset(buf, 0, memsize);
-
 	r->flags = IORESOURCE_MEM;
 	r->start = dma_handle;
 	r->end = r->start + memsize - 1;
-- 
2.11.0

