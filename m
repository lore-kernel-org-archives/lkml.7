Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0090C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4CF206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XutUicq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbfFTRhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:37:02 -0400
Received: from mout.web.de ([212.227.15.4]:59185 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfFTRhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561052217;
        bh=6ABCqgrNckGfVod4g9nc/CDSQ2u7KfwMvXsjxDVsW30=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=XutUicq+hpaeNQ2QBWVgHYs7HcdMUkOb6RzWn2JIL0z1WspbzqFl0YEqBM070qIiu
         rjwzpZT3FCEO8I44aKlw+E1fnFBLBvOuCfLBbeA1hHNYYbXT2TmNVDBEhBUgs2esiv
         DHGvQ4UnOQU3s/21SJiqYV8OgS2tIHDkhN00jEbk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.128.109]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUEoU-1i3pDy1Z3a-00R3Y2; Thu, 20
 Jun 2019 19:31:00 +0200
To:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] Coccinelle: Add a SmPL script for the reconsideration of
 redundant dev_err() calls
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
Message-ID: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
Date:   Thu, 20 Jun 2019 19:30:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vFxa6NtbOwXDi9mrX1xEx5OTYjttZSWjmZO5m1ggnwUeVy6wgxl
 PxePf3+FKdpeV421gsigNFcSUAdLU4bYE0StXPbWzgN1xn7lBHkVX3aK39y37ULkh2aDTsx
 gerFcvcTp9OWZf+oz9t/70jDbU2nvDCpvYymEjh0c7saJ2TLFu/H4MwFa8t14uYgxqu1LgK
 5RBcGI+dCUEIym+m6qbCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AoCkKZjM5oY=:RQFBISEft/yVryamYYe46m
 7TgQ/2lKmp6vnCpUjKdlLc7azdXp5pyUgC7hdGDEMuKjkbEqKJctVYfJz9SpQhENoH27X99Of
 uxvapMjQDJolUM6u+aSQZ+eyDYVJrdaCQlX0sJF2/dG37CM9JIjMb4dX/lapgLnyo5avLqHNd
 U3ghT+5L+ii1QMCF9lukLX8b8pnp/OY2fM5/h8hHxaBwIprGtbWAeufdiToAy6QAfDTUeSe1X
 8n7A+2WjuHttEfJtQlnFEt1ZA2DgYT1bkqzME8RIdi5yzdK9YQo30JUWA20ad1AHI1M/rMU3a
 pfodEZzRU5kvLfjjjpymYRbm9WAZQAq4UkDV0vRfdaKJkUrncK+fgnJtRuM8aWOjmUEYRzM+o
 oRTCH/+Y04c3/slq8UgVC1VO27Yg6lQpTuxerDa1dQZn3s/aWzXjbfUxc34j7DJBOfv+d6yi+
 A1BHI5r3MTlceerN7YAL7e1IT+bkGfkhuVlCawoWBnqQBOVg4oDz+Pqal4Une/g/l9GisKIGa
 ebML6ezqnkADEdCvUZH/IVA7V0siaFU1sCFq4k7bhYV/HBOqhsL4X/SFJejWz7UyNDJrJR/Ma
 W6Po/bTCoaxgBqUwQcT8nep3o3r/uaXijUUyV1BDobOGEi2+C9mq6L5z48j+fyOUrapXhx3Ew
 8fuZqIkhNxLisJW4JIGy7i3nzQ24r8FDILlyFJZEbFC1DTkq5Y02lqwuBMfVPisKQTBqE2RaX
 ttopAxy57y+h1sZO6mwRcQnHrj02YTfW9qI7O8xBA1xzhUgaAV8SSGkOnpVNloYHMAAnLI+6k
 o6iTSa2HOtaHeHaqskFpLoLc9kGFUXfp2WPY7cA3ACcDEnFTC0IJ+YaCMvk/OmU8IjYhLBUAs
 4BXia6fEmfGXoEDTj0vkRSCUV5nSrov124YdMs574wBv9xCJJlXaSA/BAvGgN9GH3YDuFB9+O
 UFEDSj5VWBCTt3kFKNY9jzHUcEnAZaNgnBH46xQpcfkWG1Io9Bkgi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 20 Jun 2019 19:12:53 +0200

The function =E2=80=9Cdevm_ioremap_resource=E2=80=9D contains appropriate =
error reporting.
Thus it can be questionable to present another error message
at other places.

Provide design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../coccinelle/misc/redundant_dev_err.cocci   | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 scripts/coccinelle/misc/redundant_dev_err.cocci

diff --git a/scripts/coccinelle/misc/redundant_dev_err.cocci b/scripts/coc=
cinelle/misc/redundant_dev_err.cocci
new file mode 100644
index 000000000000..aeb228280276
=2D-- /dev/null
+++ b/scripts/coccinelle/misc/redundant_dev_err.cocci
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Reconsider a function call for redundant error reporting.
+//
+// Keywords: dev_err redundant device error messages
+// Confidence: Medium
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@display depends on context@
+expression e;
+@@
+ e =3D devm_ioremap_resource(...);
+ if (IS_ERR(e))
+ {
+*   dev_err(...);
+    return (...);
+ }
+
+@deletion depends on patch@
+expression e;
+@@
+ e =3D devm_ioremap_resource(...);
+ if (IS_ERR(e))
+-{
+-   dev_err(...);
+    return (...);
+-}
+
+@or depends on org || report@
+expression e;
+position p;
+@@
+ e =3D devm_ioremap_resource(...);
+ if (IS_ERR(e))
+ {
+    dev_err@p(...);
+    return (...);
+ }
+
+@script:python to_do depends on org@
+p << or.p;
+@@
+coccilib.org.print_todo(p[0],
+                        "WARNING: An error message is probably not needed=
 here because the previously called function contains appropriate error re=
porting.")
+
+@script:python reporting depends on report@
+p << or.p;
+@@
+coccilib.report.print_report(p[0],
+                             "WARNING: An error message is probably not n=
eeded here because the previously called function contains appropriate err=
or reporting.")
=2D-
2.22.0

