Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C452C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC2520866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFEUq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:46:26 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEUqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:46:25 -0400
Received: from orion.localdomain ([77.2.1.21]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFbFW-1hKqtC1H02-00H6CK for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019
 22:46:24 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: coccinelle: add check for uncessary double unlikely() calls
Date:   Wed,  5 Jun 2019 22:46:22 +0200
Message-Id: <1559767582-11081-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:L1n2lqdGm64IE3do6SEevgLTbxRcQoHrMmaj5ysk+UZ1wdLUZhE
 YV850rrwO/N9utDtuisme78P5eSdgNNvuoW8aBuCP5NtUjQNBvuWW66qRolp171o6HkSQGG
 VoYNd8iSmwp4AmMsX0r0gxxwoHyv/3U+EwnD1Tg30uCYdf/K70o2QJm8wDcNBIg2lpLuN5e
 SSfQVfapb+1TxsfQ7s0ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/8QNLfJPLZw=:8NM0uiJbC0fexLnoBN7BGx
 vrV1N+9LQodnzTuhqo8S6VbB2CPT4uUD6BaVYlfd2WWy/QAeEQynT3Tg8j3+B+JLBcHJuXH13
 eOGgp3WQlaZy32bTiOi5npYXRZNIwrOVOzAsneK10eOL0Yf5/H7WsEN5hV/G6El8SRBzkb1Vj
 vybYzv3vvysZUwCPmd0VdbO0CvFzqJwPi0Aa35KsHaobfAxsYBqiJGIWMgdnqB15yWq0YH42a
 ltQILimcookDCMCB1Unj37nk6cgJJlt3hdwn9n4NdYsS1t8SPH3Yktr5COZNHGNN+oITeZnZT
 pp9QZXDiuryJc03ia/HSR9zt6YOmnSFhy2m9QLa6EBPxjqPNVZo/AxHCSSc1smXa0+4BcL+LZ
 5aaXoTChsN+uBkC3hNiPG+EOZgtIpOzh3wow4BahkqOAcuk5vES5QNc5tuhPutzwpd/jt+wCX
 LaTEAXF1OhvpGg+q26pMzQ9QmIpH8ywUbbROe+boch2tIQhP7HrcvIh50sduJnAGT/ki4SqlJ
 v6r7pUIvdgImrEDR96fn1jWEdacQFrUxKollg+2n9hQfn7KR6kOocTfkKM69N8RasehW7GyGC
 gcKKu7DkkBaZVV/Q9241TqZjLdtQoyE3Jk+8vn5syuonCZW6s5Qa+OT94CTgejFGUZs8QmC02
 tRtbd/pjcrgfat5st9Pr58rVdpsYNl+oLHnrD5soyQE1lI8qTWnnOcEprEs0z46GIj0Uhafvm
 yL/7j//2ltFYwHpjL74ebb7waTNoAr59bTrAZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_ERR() and IS_ERR_OR_NULL()) already call unlikely(), therefore
expressions like "(unlikely(IS_ERR(foo))" or "(!likely(IS_ERR(foo))"
aren't needed.

This patch adds a coccinelle script that checks for that.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 scripts/coccinelle/api/double_unlikely.cocci | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 scripts/coccinelle/api/double_unlikely.cocci

diff --git a/scripts/coccinelle/api/double_unlikely.cocci b/scripts/coccinelle/api/double_unlikely.cocci
new file mode 100644
index 0000000..0b9bb3b
--- /dev/null
+++ b/scripts/coccinelle/api/double_unlikely.cocci
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// find unncessary cases of unlikely(IS_ERR(foo))
+// IS_ERR() already calls unlikely() call
+//
+// Copyright (C) 2019 Enrico Weigelt, metux IT consult <info@metux.net>
+//
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@@
+expression E;
+@@
+- unlikely(IS_ERR(E))
++ IS_ERR(E)
+
+@@
+expression E;
+@@
+- unlikely(IS_ERR_OR_NULL(E))
++ IS_ERR_OR_NULL(E)
+
+@@
+expression E;
+@@
+- likely(!IS_ERR(E))
++ !IS_ERR(E)
+
+@@
+expression E;
+@@
+- likely(!IS_ERR_OR_NULL(E))
++ !IS_ERR_OR_NULL(E)
-- 
1.9.1

