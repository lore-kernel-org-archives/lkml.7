Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B93C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C076E222DD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKSVoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:44:08 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:37891 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbfKSVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:44:07 -0500
X-IronPort-AV: E=Sophos;i="5.69,219,1571695200"; 
   d="scan'208";a="412575413"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 19 Nov 2019 22:44:04 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4 v2] coccinelle: platform_get_irq: handle 2-statement branches
Date:   Tue, 19 Nov 2019 22:08:23 +0100
Message-Id: <1574197705-31132-3-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1574197705-31132-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1574197705-31132-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treat separately the case where there is only one other
statement in the branch, to be able to remove the outer
{} as well.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
v2: fix From and To (very sorry for the mistake)

 scripts/coccinelle/api/platform_get_irq.cocci |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
index c6ac755..7ac32ee 100644
--- a/scripts/coccinelle/api/platform_get_irq.cocci
+++ b/scripts/coccinelle/api/platform_get_irq.cocci
@@ -31,6 +31,25 @@ if ( \( ret < 0 \| ret <= 0 \) )
 @depends on patch@
 expression ret;
 struct platform_device *E;
+statement S;
+@@
+
+ret =
+(
+platform_get_irq
+|
+platform_get_irq_byname
+)(E, ...);
+
+if ( \( ret < 0 \| ret <= 0 \) )
+-{
+-dev_err(...);
+S
+-}
+
+@depends on patch@
+expression ret;
+struct platform_device *E;
 @@
 
 ret =
