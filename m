Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10205C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDAD21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN24TkZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDFGL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:11:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38693 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFGL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:11:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so4207099pgl.5;
        Fri, 05 Apr 2019 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VMs1CYpo/0RK1Sdao0S2WvIYnQ1BE7whDsp5LVr2ATk=;
        b=dN24TkZUWfoRt9jt2rWs73PCWNngiDsO3W78dJf9BuvAh+k+n1vSfkmtoLT59hmG66
         jVIXxSDJZAi/iFbz1wNNREEX788sFhvvHIy1nZAi/4bN7q3otkxkK50z/FexBdV15QYj
         W8yCEta13aSBgeK5l/F4RzoGqfDtRdzmqJC62lsjHsc/2EzatzjU3vo34WCEY/g2Zeog
         8RJVy97tpBKbZI9nYRiFG/L+OBkm73VrXdJg1y2AgizkK2A4EXjjznRJ0WCmFu+utdXp
         284eq3tUrg04WO95cPA31e1ZDPZ7IzFCNFqLrADEVT4BmQG++fW8iYY4u/3BZWF/2vcL
         BAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VMs1CYpo/0RK1Sdao0S2WvIYnQ1BE7whDsp5LVr2ATk=;
        b=dJYKTVQl3KC/W4T53S3Klo40FeAYXY/lpYBKfaTzE2hrueEekNkCEABur0c4GFPu5N
         P3wswfoQ/wC4CIB7AMD27FIfaWn3ysX58EGHiT40/sI7IOOntRzT1QQLOqmDPPnVnwAi
         3hM7U9OYXTNqO/7OfwObsKCcFfrhY8mPIozMFuwBMdYcvfU5FCfh+0sn+hjjOV7SaHlS
         x4147gT7D/lqX0BRLp1XPbQ3aMExkSHLqms7pFLUL7sm6RCFEzUhItRjZYa6ueyPgOLg
         SK9mQSw95Ni9IPTWL87anvNrg2DYt4FQI4QdM/t6HhNqjN5BP8AMUNd6V8bISTK14irG
         Efgg==
X-Gm-Message-State: APjAAAWD+IkugeGeUx0kCg8Bod8iHPem5n/A88piCuEi6Zz96HDOVS9f
        rFqifMwZAlfIiXBK/XIqp0w=
X-Google-Smtp-Source: APXvYqwOqmaM6QXzclfbheEPWRdFL1BoEsuTei0JLiogK8DIIKN89ISXs71/lIHmUqGGh4c2T19QqQ==
X-Received: by 2002:a63:4f1c:: with SMTP id d28mr15751008pgb.144.1554531085129;
        Fri, 05 Apr 2019 23:11:25 -0700 (PDT)
Received: from localhost.localdomain ([103.77.40.121])
        by smtp.gmail.com with ESMTPSA id m25sm33069517pfa.175.2019.04.05.23.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 23:11:24 -0700 (PDT)
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     yamada.masahiro@socionext.com, Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr, bgolaszewski@baylibre.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, kernel-janitors@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] coccinelle: api: add devm_platform_ioremap_resource script
Date:   Sat,  6 Apr 2019 11:41:12 +0530
Message-Id: <20190406061112.31620-1-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use recently introduced devm_platform_ioremap_resource
helper which wraps platform_get_resource() and
devm_ioremap_resource() together. This helps produce much
cleaner code while removing local `struct resource` declaration.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---

Tree wide changes has been tested through 0-day test service
with build success.

BUILD SUCCESS 74ebaaca5d14d3d9b03e911f0b4995b78a4d60f0
tree/branch: https://github.com/himanshujha199640/linux-next  20190401-devm_platform_ioremap_resource-final
branch HEAD: 74ebaaca5d14d3d9b03e911f0b4995b78a4d60f0  Coccinelle: api: Add devm_platform_ioremap_resource.cocci

elapsed time: 385m
configs tested: 162


Stats:
916 files changed, 1028 insertions(+), 2921 deletions(-)

Note: cases where the `struct resource *res` variable is
used subsequently in the function have been ignored out because
those cases produce:

eg., drivers/bus/da8xx-mstpri.c

warning: 'res' may be used uninitialized in this function [-Wmaybe-uninitialized]

due to: 
	if (prio_descr->reg + sizeof(u32) > resource_size(res)) {

which seems correct as `res` isn't initialized in the scope of
the function(da8xx_mstpri_probe) and instead initialized inside:

   void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
                                                unsigned int index)
   {
           struct resource *res;
   
           res = platform_get_resource(pdev, IORESOURCE_MEM, index);
           return devm_ioremap_resource(&pdev->dev, res);
   }
   EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);


 .../api/devm_platform_ioremap_resource.cocci  | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resource.cocci

diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
new file mode 100644
index 000000000000..a28274af14df
--- /dev/null
+++ b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
@@ -0,0 +1,63 @@
+/// Use devm_platform_ioremap_resource helper which wraps
+/// platform_get_resource() and devm_ioremap_resource() together.
+///
+// Confidence: High
+// Copyright: (C) 2019 Himanshu Jha GPLv2.
+// Copyright: (C) 2019 Julia Lawall, Inria/LIP6. GPLv2.
+// Keywords: platform_get_resource, devm_ioremap_resource,
+// Keywords: devm_platform_ioremap_resource
+
+virtual patch
+virtual report
+
+@r depends on patch && !report@
+expression e1, e2, arg1, arg2, arg3, arg4;
+identifier id;
+@@
+
+(
+- id = platform_get_resource(arg1, arg2, arg3);
+|
+- struct resource *id = platform_get_resource(arg1, arg2, arg3);
+)
+  ... when != id
+- e1 = devm_ioremap_resource(arg4, id);
++ e1 = devm_platform_ioremap_resource(arg1, arg3);
+  ... when != id
+? id = e2
+
+@r1 depends on patch && !report@
+identifier r.id;
+type T;
+@@
+
+- T *id;
+  ...when != id
+
+// ----------------------------------------------------------------------------
+
+@r2 depends on report && !patch@
+identifier id;
+expression e1, e2, arg1, arg2, arg3, arg4;
+position j0;
+@@
+
+(
+  id = platform_get_resource(arg1, arg2, arg3);
+|
+  struct resource *id = platform_get_resource(arg1, arg2, arg3);
+)
+  ... when != id
+  e1@j0 = devm_ioremap_resource(arg4, id);
+  ... when != id
+? id = e2
+
+// ----------------------------------------------------------------------------
+
+@script:python depends on report && !patch@
+e1 << r2.e1;
+j0 << r2.j0;
+@@
+
+msg = "WARNING: Use devm_platform_ioremap_resource for %s" % (e1)
+coccilib.report.print_report(j0[0], msg)
-- 
2.17.1

