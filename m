Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9582AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628092084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="S24lGq+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfDKJuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:50:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36849 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:49:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so5828763wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lskeiD7dYXGZh6H4CIGCeljLwENv8dVYuEzMPa3oMsM=;
        b=S24lGq+OG8UWPyXbCw2g+x+VvINi8uh2qwCGn0rK9DEaz1V09UHVfWFMSHnQnZwd7P
         dFvMm4qGhaaCoBhBPBf2/gvZhGrdgqsciuJ1pdAe8Pgz120qmLksBx7NTFyNH+5+IuBe
         BC/ODCH2/4cTuFXbv8Ygsvn7OKeUkeebJ/yV3FKc19Ln4A3+q9PbnhnU4s/Fe9TTj6rE
         9EytLIe14aHCj0k6vyDDCFXY34kZnEsEwZ58eBItfhZLz5rGFsFx42z8O8fAVKs23I2n
         9FaH+L+fXdxCew/j2HWNUuXXgCOTLY0yn7M6g2X+q6THBOnKZUAUWPmt1JJb7zYyTkOX
         qNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lskeiD7dYXGZh6H4CIGCeljLwENv8dVYuEzMPa3oMsM=;
        b=Dya7VXllN2afVvVdz1JPTK9ym1sqpB1ARLBxRpBZ/ZDwPX3Qx/Q7nT7GmzbEvbzO9o
         2LSEeudPvUvmEOj8mTEkI/wXr0fBX7AeERYe8fDLrx5yQTV95VqWJS/YG09rFUk/i/Dg
         I51hFZMJcEbe2jreyo4nDMWHJSSgx1eFwSQSbH++R4JOGZvc56LMsjmP3gkM5U9UwlVb
         VDNxPrUrrYM7ICVIKEvBCCeijvx9x/3Jl2/FmiBpyHp/aFa631Otg8N0QFBU7Td30em6
         aUNhmKtQa0ggloNLtlxiCTwaooJQXOtxx/cWEwSv6mRwA5Pc84axiv9pL6+JI/0BlBNF
         NZnA==
X-Gm-Message-State: APjAAAVM3b0XJ87TW51vPqQXQK9oKGK9MVjYloPIfOtzO6RRtYtzd73E
        5QBDOQkEMf6ctiqOVwtGZsNyNQ==
X-Google-Smtp-Source: APXvYqwN/IK8l+a2AZq81bvRsj5vx2Vbw/Z6P0AT2q7xO9o7Ip7kSJQdF9SDQK1Px8Zq2W2Y/DkT6A==
X-Received: by 2002:a05:600c:2309:: with SMTP id 9mr6213095wmo.52.1554976190645;
        Thu, 11 Apr 2019 02:49:50 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s10sm6434066wmh.0.2019.04.11.02.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:49:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 3/4] um: define set_pte_at() as a static inline function, not a macro
Date:   Thu, 11 Apr 2019 11:49:43 +0200
Message-Id: <20190411094944.12245-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411094944.12245-1-brgl@bgdev.pl>
References: <20190411094944.12245-1-brgl@bgdev.pl>
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
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
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

