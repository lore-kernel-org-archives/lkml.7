Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769E6C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49871218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmonKP/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbfIRQlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:41:31 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41691 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387625AbfIRQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:41:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id w17so136988oiw.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qrA0I51nqSHQF/EhS1sFB5J+Y7INQcShDzYLT1Gw8Y=;
        b=LmonKP/C8WHmsEFsaFJI9iEmPoNsmYPqiAZiNjl4XOHZSG83WLPYujKX0H1bO8T2mX
         tYC8nPL/6tY3r1OejPhkhwvjj/nBe96r8YaPTmRauQ+s2FLD2LIuScp4/YVGVKHqIrbQ
         vqMu5O8LHIUHNiBx7d3af0W2IoE7jk9ceAT0ndSD1Ii/ik4EhaST73Zy9LGanQbhdwJe
         0+7Aek5390oW+RNnCPImF+IcPAGDjBcHSoORgq7eAanAsYysZXxO5BTEzxRVP8j/if31
         JTA9XoOMYqzniJqa9DarDv4EujmMZKt+vHB+0ppt9YaPI2bmVBlnK4Fzf1uhTGhsBhQf
         oC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=3qrA0I51nqSHQF/EhS1sFB5J+Y7INQcShDzYLT1Gw8Y=;
        b=QsoP2KxXgq5wePqB5DR7ZEiOmCcuuf1n5Kd+Of8XZM1Dj9OkkG+Wh9wjKOiviVGJ1h
         59NVvlCZypcLWA2khOrtKrmYCP1uPY46lQ+UM5v/p5gzjAVp/k0Tqf34W1VU9n+HRbWQ
         fOCRkdkZXVLoQLgaZ4EPOWcJbYUzgfIUJEr25+bFflIfILNSQPsDBOYlTUpKyYRM942X
         pzePMdiqATn0GzmIgYRaLdQ2ErydVI+7c5g18jmJv1pIL4HtgiP+90yDWGivcVragTkJ
         nBQbeg56psIbRHcPVJ11Xv/2BjKT4e9Eqd/q5L4JWXBo76nVwWkWAvfEY+Lrh7r3ZLRK
         xxig==
X-Gm-Message-State: APjAAAWrU3ieh4/s29oWm3WTZbMzfN2nhS4nTmTQlWkGXnzQIdMYUVkq
        7nJeim4a79/X8OtD7zfAEvc=
X-Google-Smtp-Source: APXvYqyHpCjtq/i8Xz0ChUJZ2mZphp2hyUy6oFZjJeCui/3cvEY56mH818DTffB5uQbkIeF3JCfXOQ==
X-Received: by 2002:aca:b388:: with SMTP id c130mr2983302oif.27.1568824890201;
        Wed, 18 Sep 2019 09:41:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id i10sm1840272otp.80.2019.09.18.09.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 09:41:29 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] x86/mm: Remove set_pages_x() and set_pages_nx()
Date:   Wed, 18 Sep 2019 11:41:21 -0500
Message-Id: <20190918164121.30006-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 185be15143aa ("x86/mm: Remove set_pages_x() and set_pages_nx()"),
the wrappers were removed as they did not provide a real benefit over
set_memory_x() and set_memory_nx(). This change causes a problem because
the wrappers were exported, but the underlying routines were not. As a
result, external modules that used the wrappers would need to recreate
a significant part of memory management.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: 185be15143aa ("x86/mm: Remove set_pages_x() and set_pages_nx()")
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 0d09cc5aad61..755867fc7c19 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1885,6 +1885,7 @@ int set_memory_x(unsigned long addr, int numpages)
 
 	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_NX), 0);
 }
+EXPORT_SYMBOL(set_memory_x);
 
 int set_memory_nx(unsigned long addr, int numpages)
 {
@@ -1893,6 +1894,7 @@ int set_memory_nx(unsigned long addr, int numpages)
 
 	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_NX), 0);
 }
+EXPORT_SYMBOL(set_memory_nx);
 
 int set_memory_ro(unsigned long addr, int numpages)
 {
-- 
2.23.0

