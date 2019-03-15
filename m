Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0A9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E0421872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfCOCY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 22:24:28 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:23546 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfCOCY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 22:24:28 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id CE52A2E56648D56CFF59;
        Fri, 15 Mar 2019 10:24:24 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x2F2OG0C097582;
        Fri, 15 Mar 2019 10:24:16 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019031510245239-4956102 ;
          Fri, 15 Mar 2019 10:24:52 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Julia.Lawall@lip6.fr
Cc:     wang.yi59@zte.com.cn, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] coccinelle: semantic patch for missing of_node_put
Date:   Fri, 15 Mar 2019 10:24:41 +0800
Message-Id: <1552616681-17985-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-15 10:24:52,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-15 10:24:01,
        Serialize complete at 2019-03-15 10:24:01
X-MAIL: mse01.zte.com.cn x2F2OG0C097582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking for places where there is an of_node_put on some paths
but not on others. This SmPL checks that there is a put of the
same data elsewhere in the function, so perhaps that will
alleviate the concern about puts where they are not needed,
while still making it possible to find the ones that are needed.

Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Julia Lawall <Julia.Lawall@lip6.fr>
---
 scripts/coccinelle/free/of_node_put.cocci | 57 +++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 scripts/coccinelle/free/of_node_put.cocci

diff --git a/scripts/coccinelle/free/of_node_put.cocci b/scripts/coccinelle/free/of_node_put.cocci
new file mode 100644
index 0000000..6a29830
--- /dev/null
+++ b/scripts/coccinelle/free/of_node_put.cocci
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Find missing of_node_put
+///
+// Confidence: Moderate
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@r exists@
+local idexpression struct device_node *x;
+identifier f;
+statement S,S1,S2;
+expression e,e1;
+position p1,p2;
+type T,T1;
+@@
+
+(
+x = f@p1(...);
+... when != e = (T)x
+if (x == NULL || ...) S1
+else S2
+... when != of_node_put(x)
+ when != if (x) { ... of_node_put(x) ... }
+ when != e1 = (T1)x
+(
+return x;
+|
+return@p2 ...;
+)
+&
+x = f(...)
+...
+if (<+...x...+>) S
+...
+of_node_put(x);
+)
+
+@script:python depends on report@
+p1 << r.p1;
+p2 << r.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+			     "ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line "
+			     + p1[0].line
+			     + ", but without a corresponding object release within this function.")
+
+@script:python depends on org@
+p1 << r.p1;
+p2 << r.p2;
+@@
+
+cocci.print_main("acquired a node pointer with refcount incremented", p1)
+cocci.print_secs("needed of_node_put", p2)
-- 
2.9.5

