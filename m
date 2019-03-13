Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17C2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF252087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Pfr7fCud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCMKOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:14:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37588 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCMKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:14:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id x10so1219369wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AfYvZQ5c2FbUaV3jJlOcrjAVrValcJyPlFZlo9KQJI=;
        b=Pfr7fCud/iXp1o6WYd+Ln+UTWknMQR+9rSIjBN6ZHIWsqKGZ7Ud28FeTRPolTof3Xz
         c7pvGD5yffZegaPlakJQBGfGUK4NjFlSCQJlgQvmQWX6JfC/8S/QBE7wSHlLrQ0eXasK
         +Wm/t6gqIGI263B+yaGwewLdxZi8ZXpfSszDCGEAsKMXET3kF39OnHRiHShGYGz24PYh
         WpCS9M4YAaRqDi4MEOXkB8u3LBfd2PSa971kuFGDP2oV7tcIPMIosQQ6IRyrNfe5YF2i
         lwU5hyzRe+73sQ6QElArd8YVh8P1glJ525bUKcDhtdjW5zhvXj4tyy8F+81qDmTVrvEP
         I5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AfYvZQ5c2FbUaV3jJlOcrjAVrValcJyPlFZlo9KQJI=;
        b=ZLk3RZrUVNsGD85g6AGjhxrUaFIjMLqVPj0f4jNFVpNOb6V2lXUGWId3+8dZT/5I6I
         9X1yUUPSBbXMQGaBFAXu30VujfJLGeeR5BCK+Yb0UzLzCGh0T2/4lCxcCNSM7ZRQYEG+
         4KH0p7VzYIw5YXiBUjB+IFBqKJ31IpB/1JgPHB/6kkpZz44ZRIfoj4VCiO43r5czuguO
         IVGyERKUoU9xy3o2LhvN5zik5rnGbcs6d2V2nsgFmim0y09E663AcwTkORMaDVvc2K0K
         bUvV9IUTRCuSId9RywfqhmVPJWmlSONb9IkbZzaC5Hr1fvewf2D1VYul7HoyhDU6PRan
         J0ow==
X-Gm-Message-State: APjAAAUV1cUQZRFKmOUfQ8F1GeMwiMizENsMYtmS6V0r16Z8QvBp8Wzn
        LdNMlRPUtQJWs424gbxYC8ZR0FcnxOU=
X-Google-Smtp-Source: APXvYqyMDcS52LyKgR/xDz2doX9Gvp7JPtKQFvMgr6trrpPNKVA6m+gu0HR2+/iXzyv9SVQHUqHzEw==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr1576720wmg.136.1552472082209;
        Wed, 13 Mar 2019 03:14:42 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-27-140.w90-86.abo.wanadoo.fr. [90.86.252.140])
        by smtp.gmail.com with ESMTPSA id d5sm4702439wrx.12.2019.03.13.03.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 03:14:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] um: define set_pte_at() as a static inline function, not a macro
Date:   Wed, 13 Mar 2019 11:14:39 +0100
Message-Id: <20190313101439.7092-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

When defined as macro, the mm argument is unused and subsequently the
variable passed as mm is considered unused by the compiler. This fixes
a build warning.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/um/include/asm/pgtable.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 9c04562310b3..b377df76cc28 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -263,7 +263,12 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 	*pteptr = pte_mknewpage(*pteptr);
 	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
 }
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *pteptr, pte_t pteval)
+{
+	set_pte(pteptr, pteval);
+}
 
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
-- 
2.20.1

