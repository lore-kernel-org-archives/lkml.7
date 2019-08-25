Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PLING_QUERY,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DEAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C852082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfHYNFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 09:05:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39408 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 09:05:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id i63so13301476wmg.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 06:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/j+2bGL/nR+i9Xm5hiU1Y/6lXm9nJXiz/ro+F+BnBt0=;
        b=cpyYSURFXmj2NG52iJu9iQgLZBCuImYIB+0SkdZ6Q19JUfD2NdXvHGRJgf4JpLJHUH
         NrLO2NWNfwY69ShjbZ0gtCqszzWWCKSfssc7hYn3hNKC5AJ5Lfr/MqEybF3vS1VI3Q8X
         03GbUy6oK0tZXT0wHD4bbTZvmeROI2FGXL+c87Uk/t/IqXvCt7hHcr4COSYLtEjKuihA
         vLeQJzhtVM/kzQ+UVYG9bMWYGpxu67qVTNJfl2jjA9Ooo5jcd69p/n8hWuQQ2M7QrnHU
         80vhJFkrHL3O0/tv9KolIwjdpxoLHZ93uFNFYFU37JRA36z9bSc5itp3K80bVA9nNClY
         ZSvQ==
X-Gm-Message-State: APjAAAXBOdnYqbQ48em9CWTmt622RbCGk53a+jUr2005dJvYE053JARn
        2JDehLG40x5bnzvLgMQsDps=
X-Google-Smtp-Source: APXvYqwT6gMVyjhN0x+oIOzBbXWH6yz//sR5MVtNewxVeq845H2nwYkZ3oSdJuaWlok+hvoWqQYU4A==
X-Received: by 2002:a1c:8187:: with SMTP id c129mr15897769wmd.32.1566738347190;
        Sun, 25 Aug 2019 06:05:47 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id z12sm7832841wrt.92.2019.08.25.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 06:05:46 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     cocci@systeme.lip6.fr
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] scripts: coccinelle: check for !(un)?likely usage
Date:   Sun, 25 Aug 2019 16:05:36 +0300
Message-Id: <20190825130536.14683-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds coccinelle script for detecting !likely and !unlikely
usage. It's better to use unlikely instead of !likely and vice versa.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/unlikely.cocci | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 scripts/coccinelle/misc/unlikely.cocci

diff --git a/scripts/coccinelle/misc/unlikely.cocci b/scripts/coccinelle/misc/unlikely.cocci
new file mode 100644
index 000000000000..88278295d76a
--- /dev/null
+++ b/scripts/coccinelle/misc/unlikely.cocci
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use unlikely instead of !likely and likely instead of !unlikely.
+///
+// Confidence: High
+// Copyright: (C) 2019 Denis Efremov, ISPRAS.
+// Options: --include-headers
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
+(
+* !likely(E)
+|
+* !unlikely(E)
+)
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
+-!likely(E)
++unlikely(E)
+|
+-!unlikely(E)
++likely(E)
+)
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+@r depends on (org || report) disable unlikely@
+expression E;
+position p;
+@@
+
+(
+ !likely@p(E)
+|
+ !unlikely@p(E)
+)
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING use unlikely instead of !likely")
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg="WARNING: Use unlikely instead of !likely"
+coccilib.report.print_report(p[0], msg)
+
-- 
2.21.0

