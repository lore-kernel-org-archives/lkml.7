Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PLING_QUERY,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD81C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8932189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfH2RK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:10:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53664 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2RK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:10:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so4502255wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HpNYDE1F3tP7xvZy6HHQgQLZGRxzmgxL5p1Yz/TyyDk=;
        b=krinNXqi6tsfS8peQYdBHFAgmKdll1R6FlHPQg2gxwwYHZCUGg7EcOWyDa/zPci9nX
         PL5CRcdTOELlbDHXpMwgJQv/04htOARDgy2YGp2AZLs4a1Vn8ArN0pDl6IcO2LBJxY70
         Ul4TAhCLnIadtVXvgFu+A1DaLjYRbQsKzYuG8+XR4Gk+5XK0UOXIo9+S7YLR6CAKz5Nz
         Ckkji5uR0D0vC8Z2kiSqd1YJa7tKJbrGb+yM9C2jzDbaX0tlG4/Rlcgahmqxptt44T5h
         82awHxz7FOtyGmsApFtDIXQrkkZrcfEbt4o1EENm0iarv2GwrZ5Y4NziBfMom6AfcuF8
         NWXg==
X-Gm-Message-State: APjAAAVOrctnIXH8WTYfYm/oUTN0qRDX0ubDTPPIhHwYvLZXPTy2MAH8
        cB9KxCqdOd502BQdK01pO0ZN1kIdBLA=
X-Google-Smtp-Source: APXvYqx28paD2KyQUm43t2KjrNbTIZ44MCT11WvNWh7dxKbGOutx6mT8RF+VLi6rGpNbkU8IVDDPEA==
X-Received: by 2002:a1c:8083:: with SMTP id b125mr5664275wmd.100.1567098624277;
        Thu, 29 Aug 2019 10:10:24 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id g26sm2210892wmh.32.2019.08.29.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 10:10:23 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2] scripts: coccinelle: check for !(un)?likely usage
Date:   Thu, 29 Aug 2019 20:10:13 +0300
Message-Id: <20190829171013.22956-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190825130536.14683-1-efremov@linux.com>
References: <20190825130536.14683-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds coccinelle script for detecting !likely and
!unlikely usage. These notations are confusing. It's better
to replace !likely(x) with unlikely(!x) and !unlikely(x) with
likely(!x) for readability.

The rule transforms !likely(x) to unlikely(!x) based on this logic:
  !likely(x) iff
  !__builtin_expect(!!(x), 1) iff
   __builtin_expect(!!!(x), 0) iff
  unlikely(!x)

For !unlikely(x) to likely(!x):
  !unlikely(x) iff
  !__builtin_expect(!!(x), 0) iff
  __builtin_expect(!!!(x), 1) iff
  likely(!x)

Signed-off-by: Denis Efremov <efremov@linux.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: Joe Perches <joe@perches.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/coccinelle/misc/neg_unlikely.cocci | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 scripts/coccinelle/misc/neg_unlikely.cocci

diff --git a/scripts/coccinelle/misc/neg_unlikely.cocci b/scripts/coccinelle/misc/neg_unlikely.cocci
new file mode 100644
index 000000000000..9aac0a7ff042
--- /dev/null
+++ b/scripts/coccinelle/misc/neg_unlikely.cocci
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use unlikely(!x) instead of !likely(x) and vice versa.
+/// Notations !unlikely(x) and !likely(x) are confusing.
+//
+// Confidence: High
+// Copyright: (C) 2019 Denis Efremov, ISPRAS.
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+@depends on context disable unlikely@
+expression E;
+@@
+
+*! \( likely \| unlikely \) (E)
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+@depends on patch disable unlikely@
+expression E;
+@@
+
+(
+-!likely(!E)
++unlikely(E)
+|
+-!likely(E)
++unlikely(!E)
+|
+-!unlikely(!E)
++likely(E)
+|
+-!unlikely(E)
++likely(!E)
+)
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+@r1 depends on (org || report) disable unlikely@
+expression E;
+position p;
+@@
+
+!likely@p(E)
+
+@r2 depends on (org || report) disable unlikely@
+expression E;
+position p;
+@@
+
+!unlikely@p(E)
+
+@script:python depends on org && r1@
+p << r1.p;
+@@
+
+coccilib.org.print_todo(p[0], "unlikely(!x) is more readable than !likely(x)")
+
+@script:python depends on org && r2@
+p << r2.p;
+@@
+
+coccilib.org.print_todo(p[0], "likely(!x) is more readable than !unlikely(x)")
+
+@script:python depends on report && r1@
+p << r1.p;
+@@
+
+coccilib.report.print_report(p[0],
+	"unlikely(!x) is more readable than !likely(x)")
+
+@script:python depends on report && r2@
+p << r2.p;
+@@
+
+coccilib.report.print_report(p[0],
+	"likely(!x) is more readable than !unlikely(x)")
+
-- 
2.21.0

