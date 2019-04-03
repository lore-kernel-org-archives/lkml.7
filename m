Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DB0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66BF206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NnM5WxdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfDCIjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:39:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46052 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbfDCIjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:39:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so838893wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWuSY7tJ8t1gp+W6Vko8GNs6uuVCucr3GTT5NrKpIYQ=;
        b=NnM5WxdHORRPSE8oBRqknUrB9FXX3Vx/bVr0SHDpWDFAawooLTtKsIxd0l2DlXEv1U
         I8wGii689Jn+gtVhaX1W0nbB8hfreZR53Vdb5cumv9TN4zg0IKS0otrKXdPbf66KmQ4U
         pr1dqxZi/HmTfpnR1C9YERgbrSr8ccidMPNNE7NiYNyDzdQgZvGepQHz/CNl1ysxFPd1
         CsQ43Pz3UuT9QhqXqGNjtoUrivCdwzDcr1YPz0dnLk29pkjXp8KEjDDMl2EQ6irrlco2
         rR0xw3Ins4nbp+fFI5uL7qEwss9HEcLCYULrIF3XlitaK8h3VI+yd7lPWgc/nwka4Cxy
         g6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWuSY7tJ8t1gp+W6Vko8GNs6uuVCucr3GTT5NrKpIYQ=;
        b=fyyybCr1l6f+grCRkhZO8oqkzR/fjnzYQM/hEVjQapTjxBTFY1t2cOanQELXAl1IJC
         +RRok+u3w8Y2gQwPP0iOWEtIjSgmQIZZjAqO1fbiNzAd4396vbQXAm9eHhfbXbD7Na+/
         coFZriwONd0hDU31klmU0kt8SK8BN/Z8uO4TO26gO4hthZPRFIt8Ni/+/UBpyyznZOG/
         tGSXSa+Xg3ZTVarV91WEvQrKshp2jjW/Hlz44lmHKIWATHKA0Jo4gkw+jQjwoXNzJp9e
         gqSLx2NCc8hkdJ+GreIL7xkTuczCY/XcxD+qQlQEVigYQvqDPIEgBnkcsoJsYR4Qn4oM
         K8PQ==
X-Gm-Message-State: APjAAAU+ckRiSCe2kIdB25qOromel9Ue0uq+80AiiC2WxLoHJsq6sqUz
        DA6gQhTyLkyPhh26Wkw8tJ4cKFLycbM=
X-Google-Smtp-Source: APXvYqy1ypNk2TcNV1zVLdlIH96i21X0180yvn9dRbkELYVUji9X9RB37S87ZHZLqi2nDUmUUdpmFQ==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr51146262wro.2.1554280751674;
        Wed, 03 Apr 2019 01:39:11 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v192sm23655771wme.24.2019.04.03.01.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 01:39:10 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 3/4] um: define set_pte_at() as a static inline function, not a macro
Date:   Wed,  3 Apr 2019 10:39:01 +0200
Message-Id: <20190403083902.3975-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403083902.3975-1-brgl@bgdev.pl>
References: <20190403083902.3975-1-brgl@bgdev.pl>
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
2.21.0

