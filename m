Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE41C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5F4218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFLU2B6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbfIRQno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:43:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36758 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfIRQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:43:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id k20so200093oih.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t1NUWOIEDN4E5RHYpcV10vWnfzYBGN03OoblQkMuGaE=;
        b=vFLU2B6oysAYmWSe71HyLxOsoHzg37qDGBwCjnyvUMO32SzG33ot6M1hbzm6vhUAKO
         1zqMWWyzXP5b3CUh2r1i5pNM1yrV6MCq7fqnr/GfLY0TTwZiXiSCLvZLhyM26n75358H
         gKZCTgqJTv8fhK0p3llTctYy0F5myEDxrmfBdRFGbixxE68t5Sj89yy5cJe8qO6+uwTu
         CamFg4ZDdYJ+V/5YoUvap/hq59xJgftM+UI/+FJir0jo2DSPzcaw6sK6YEsy5h2LfTvL
         ZB1jpS5w3iOWT2VQlngQm4UipBx51+CMP2PpjhVgb7dLB5qWOJZdcdk4dLpu8hq1PLEQ
         ynZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=t1NUWOIEDN4E5RHYpcV10vWnfzYBGN03OoblQkMuGaE=;
        b=H8embI7vADwOOvzjoKA5QGP52siFr7vSWxnwObq8SLUk4guz3TE1HgGZGN6jMHgDwa
         47kvPY536Gzrl1ohYHlMk69wK33h82c7j1HIk1kxPYeh0b6Bp5wpoCxrAW+qHFBFMS5k
         ONsxemuTMNXv2zb/j+ogZaJrN5ywR3oGChtB+9VEWbRlfKlOsAzYTM0qt214MeSusCgW
         fNqbGrMIYk3H4L1MySeq/xkc78AikLlVC0B+AB6qFzL1dkaMkZhCAP2nc5KqF+W3fHd0
         V3HLqNDDR7ybTTrRR6EbB/LAMMCkW9ZtnI86prwWKE3iCgXu5ijNwtK/3MPBWkGWXzC5
         Gvkw==
X-Gm-Message-State: APjAAAWLJbn65WR/7vLV6UmL29oTIPwrVtZ9pPb9BTWrZ2cqbB1+uRz7
        U2mrXUreoo4E6GRp2qldOF8=
X-Google-Smtp-Source: APXvYqz+284DQdiqICd7OIeRUsrgt3/mh6iKpnEc/vK9TL1b0uf4luKR8lwVFt8DUBcnBq7huRlpQQ==
X-Received: by 2002:aca:4fc7:: with SMTP id d190mr2867413oib.25.1568825022786;
        Wed, 18 Sep 2019 09:43:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id m67sm959336otm.9.2019.09.18.09.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 09:43:42 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2] x86/mm: Fix 185be15143aa ("Remove set_pages_x() and set_pages_nx()")
Date:   Wed, 18 Sep 2019 11:43:38 -0500
Message-Id: <20190918164338.31842-1-Larry.Finger@lwfinger.net>
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
v2 - Subject was messed up
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

