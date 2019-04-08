Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB0FC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E76C20879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W71iU6HP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfDHTO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:56 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38111 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfDHTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:53 -0400
Received: by mail-lj1-f170.google.com with SMTP id p14so12292365ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yb2QTzhusxsvH9pJg14HyaDB+kuXzyas0sFtWi6B7b4=;
        b=W71iU6HPsihXgv5L1860WJPgZsLYvVkA8bOcaSeW3LrJJzYR4EOy37JnlTthbJM+7r
         GLeY8h9O1d33qj4U+Xf2H5p5QfnsHOfgS+KI1O3zKKeoPKjKvpu20jmxzR8qqDZAjmvZ
         0dfZmigx3CVIm+VDKrCrcgIlXck38eqjcZfPiqKmkXaJhbVeAqGsdsLMeq3+XriGQywv
         zQivVow0En7Z/WHG87A+zLeYP3TKfuRnkBGlENxnJ3GE5CGzv5UeyB3a6XPBmEnXYdDW
         pKROVmWG2fIRxDU8qnr1++VY5e7ob9ik18PUAh65SJlS1pDyNrd/gUPNRGnoV0abnoQo
         sDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yb2QTzhusxsvH9pJg14HyaDB+kuXzyas0sFtWi6B7b4=;
        b=kDH/Orgept8A3K91soV6C6dM9SRvrE+qrjeQSUEtdAsUGLt1CV8PyaJ22hmYhTukUQ
         lVkUDC8Yo3smTHEtUIimsHphg/rBvboJbRgvnyTcl47tDyBJS53GL++cqxiSj0dEIGt6
         qX63xyI6oC4Jtde66PCdXPb833ufb7taQ7ZSG+YZpr2M3zXygc+pf2RTUXLdhXo4ZcO2
         fgTgOvqLlVHecyLMzjIJTbU5IyJNK6hQ+93fuuYvkrh+vMYd+F6huXzqlQJQIpHbTeYX
         sk48iI9mtP+7F2PA06zD+3URAfx7POFkO6M9/fdkQT+cytnv+nZQjeo/zO6ObCXR5ZTL
         xVaQ==
X-Gm-Message-State: APjAAAVkaKhV5gwYEIXszEUgsHLef4+wHduHnEbS/5bnei3jeePe0vK4
        s7RgkYIaLH0Dz23iVutScq0=
X-Google-Smtp-Source: APXvYqw2ZLI2O8n1oUkMJzoNL4L8MydDi61RBfP9q0wk4PAkNxM5qXimFrLXJSNRoeRZh1ofDVtLbA==
X-Received: by 2002:a2e:5d56:: with SMTP id r83mr17094652ljb.74.1554750891111;
        Mon, 08 Apr 2019 12:14:51 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-222-95.NA.cust.bahnhof.se. [155.4.222.95])
        by smtp.gmail.com with ESMTPSA id r77sm6554494ljb.29.2019.04.08.12.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:14:50 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     yamada.masahiro@socionext.com
Cc:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] Coccinelle: kstrdup: Fix typo in warning messages
Date:   Mon,  8 Apr 2019 21:14:32 +0200
Message-Id: <20190408191432.1269-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'kstrdep' with 'kstrdup' in warning messages.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 scripts/coccinelle/api/kstrdup.cocci | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/kstrdup.cocci b/scripts/coccinelle/api/kstrdup.cocci
index 09cba54ed0cf..6d13d54a6ee6 100644
--- a/scripts/coccinelle/api/kstrdup.cocci
+++ b/scripts/coccinelle/api/kstrdup.cocci
@@ -76,7 +76,7 @@ p1 << r1.p1;
 p2 << r1.p2;
 @@
 
-cocci.print_main("WARNING opportunity for kstrdep",p1)
+cocci.print_main("WARNING opportunity for kstrdup",p1)
 cocci.print_secs("strcpy",p2)
 
 @script:python depends on org@
@@ -84,7 +84,7 @@ p1 << r2.p1;
 p2 << r2.p2;
 @@
 
-cocci.print_main("WARNING opportunity for kstrdep",p1)
+cocci.print_main("WARNING opportunity for kstrdup",p1)
 cocci.print_secs("memcpy",p2)
 
 @script:python depends on report@
@@ -92,7 +92,7 @@ p1 << r1.p1;
 p2 << r1.p2;
 @@
 
-msg = "WARNING opportunity for kstrdep (strcpy on line %s)" % (p2[0].line)
+msg = "WARNING opportunity for kstrdup (strcpy on line %s)" % (p2[0].line)
 coccilib.report.print_report(p1[0], msg)
 
 @script:python depends on report@
@@ -100,5 +100,5 @@ p1 << r2.p1;
 p2 << r2.p2;
 @@
 
-msg = "WARNING opportunity for kstrdep (memcpy on line %s)" % (p2[0].line)
+msg = "WARNING opportunity for kstrdup (memcpy on line %s)" % (p2[0].line)
 coccilib.report.print_report(p1[0], msg)
-- 
2.21.0

