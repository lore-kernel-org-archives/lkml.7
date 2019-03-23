Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE434C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E482148D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfCWGPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 02:15:41 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:49006 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfCWGPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 02:15:40 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 133E8B483DC486D6D641;
        Sat, 23 Mar 2019 14:15:38 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x2N6FOOh076138;
        Sat, 23 Mar 2019 14:15:24 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019032314161028-6075699 ;
          Sat, 23 Mar 2019 14:16:10 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     yamada.masahiro@socionext.com
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr
Subject: [PATCH] coccinelle: put_device: reduce false positives
Date:   Sat, 23 Mar 2019 14:14:31 +0800
Message-Id: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-23 14:16:10,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-23 14:15:05,
        Serialize complete at 2019-03-23 14:15:05
X-MAIL: mse01.zte.com.cn x2N6FOOh076138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't complain about a return when this function returns "&pdev->dev".

Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
CC: cocci@systeme.lip6.fr
Cc: linux-kernel@vger.kernel.org
---
 scripts/coccinelle/free/put_device.cocci | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
index 7395697..c9f071b 100644
--- a/scripts/coccinelle/free/put_device.cocci
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -32,6 +32,7 @@ if (id == NULL || ...) { ... return ...; }
 (    id
 |    (T2)dev_get_drvdata(&id->dev)
 |    (T3)platform_get_drvdata(id)
+|    &id->dev
 );
 | return@p2 ...;
 )
-- 
2.9.5

