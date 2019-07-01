Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398ECC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBBE208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ovRJxmU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfGAILw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:11:52 -0400
Received: from mout.web.de ([217.72.192.78]:54339 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbfGAILw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561968678;
        bh=wgDX1wYEOylYk18m/X9V91bM17D7/7B0grmKP0RH4RI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=ovRJxmU+zGLSVqRgCM3+qCQy5/0fC90h4XIA711H2x6bLkaAVqXfiphbQnGotqq/t
         S4fX4MtkxCp19497Uy1LXQV1tzPtlxgvt9AVUmV1BcZq72qsVwifMzcTMX9EqHMrv3
         Sa9Rpy0KBepky9TOcHJcZC6fqlNhln+4bjILn7vo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.131.202]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwYs7-1ic5t30wL1-018OKI; Mon, 01
 Jul 2019 10:11:18 +0200
Subject: [PATCH v2] Coccinelle: Add a SmPL script for the reconsideration of
 redundant dev_err() calls
From:   Markus Elfring <Markus.Elfring@web.de>
To:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2744a3fc-9e67-8113-1dd9-43669e06386a@web.de>
Date:   Mon, 1 Jul 2019 10:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wfhsPM9QVsFV9655wDRYnl6JcqLrm+bTduMbCFrWPgjeIszwlj5
 6cQ7tYKnCVBe5d/7X3gqWwSoJjR+N8TgyuU6JDkqDw7RRulp2MO4QV2VCersbve6Q9yknG4
 zNv/llKZ70DNezmuS+YiDcb6ldkyl4lVej0AFpMDAwKPAtT7SDpFY88aVNXmOfEG88plWRb
 d64rxkDp/zarEqF1kib6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJ9EqWNcCfE=:xcrWN+c5Q1lkXIi+blKidM
 7emyeKe8pUAJAg9juycx57x1X7C55esQopZ/Mw5uH+MEFQOzH4mfjpTwIwSl/QtWmdH5hx22J
 lX85S40KZu6CfOU6GJ8mV4QyL2MuQY8y7aOArOxuYVwMebk7n6CWCu04/jwK5VTD+x83upLG4
 D+avZBX8FfjjKZ4bqQ/Vpk1IO2uPVgcMJ9YA1jA9VBkgVxO9jIQ0XbX8sWSpnkIUsFaTSBbsP
 Q55T8ZbCmBi5jmJ15QeSCZdHSKK3O68TuHue4okh6VO39LbloNn09wQcsw09BvsM9OiYL/8CH
 hERPuQadlkr6pnN8jRDraK1a5y3cWuea4FEc1hhoTXP9MxmFQR2cOCbFjqp17uUIuVSuq7gA3
 bAnOc6lKTN0o5tvpxTRjIi+1354Y8bGSqiz8bLtZoCLFeBjAkIGH5YZliSnkUKM/xl1GQoLax
 vzqtl9K3eUI65cM9P8B2VLj6+quJdiWYorTrqd8616+fZVlHe2m27jJz1U1ufkO9sKdxNAVso
 ApvNW7NJqJpbcqCzuSjs0oob9wYl1fVtNf99bIPKR3Iom1oBFGdXMdDOG200Tc2SwHwRSwWAr
 2DTja7Si+kmOPoQ7EMMd5KBeIrLXfsgNVa6YbdOt1KaLL3tHGj0IvxnkqjjHOOAU7i0qK6Io6
 a43D+UHDgYUk0WiuILzVOyTkPIIqeLugqHxMk+50sxHlqIUO+2myDsQUQBd1qpdFRmO9DWL+F
 zHfkyJLrU7R+rLNj7kDIPYjkCjdGhIuuFsxQ+T1dOEbOZDMsVeEriKTC9YNr9G9T5XPZASYTP
 l0VxHDKS8emXk3+EQzreCOITyIXsBGnIxmAvfsj+yfyojaRgiM40ZN0lOPOqbX8SnS2GjhWU5
 cRG5M9Sx0OLvhm/XkCQvWVCMMEeCla7FipRAR30yW6c+l4q7mb0djp9XWxPSy2G17X30Pdteb
 7O4+chsq6fuorkqNnrCQEjJHS+Zjnnp7M0oy2k9KH0FDV2w2QusovSTB535c/mFsZaRo36HvX
 0rHQAWHbXmjK6XN0nJGIkVS5ZJ0EnD8bN6id10jka6jmysh3HIIgQe6aAptFFGV2ixQ5UPMEL
 zFQdvrLTMXsyDMSPAm7eQWcsRoan4ItHQTI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jul 2019 10:00:39 +0200

The function =E2=80=9Cdevm_ioremap_resource=E2=80=9D contains appropriate =
error reporting.
Thus it can be questionable to present another error message
at other places.

Provide design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
Suggestions from Julia Lawall were integrated.

* Application of the SmPL construct =E2=80=9C<+... =E2=80=A6 ...+>=E2=80=
=9D
* Replacement of a return specification by a statement metavariable.
* Different coding style for a branch of a SmPL disjunction.
* Usage of a specific function name in two messages.

 .../coccinelle/misc/redundant_dev_err.cocci   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 scripts/coccinelle/misc/redundant_dev_err.cocci

diff --git a/scripts/coccinelle/misc/redundant_dev_err.cocci b/scripts/coc=
cinelle/misc/redundant_dev_err.cocci
new file mode 100644
index 000000000000..7998defb04f3
=2D-- /dev/null
+++ b/scripts/coccinelle/misc/redundant_dev_err.cocci
@@ -0,0 +1,62 @@
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
+ <+...
+*   dev_err(...);
+ ...+>
+ }
+
+@deletion depends on patch@
+expression e;
+statement s;
+@@
+ e =3D devm_ioremap_resource(...);
+ if (IS_ERR(e))
+(
+-{
+-   dev_err(...);
+    s
+-}
+|
+ {
+ <+...
+-   dev_err(...);
+ ...+>
+ }
+)
+
+@or depends on org || report@
+expression e;
+position p;
+@@
+ e =3D devm_ioremap_resource(...);
+ if (IS_ERR(e))
+ {
+ <+... dev_err@p(...); ...+>
+ }
+
+@script:python to_do depends on org@
+p << or.p;
+@@
+coccilib.org.print_todo(p[0],
+                        "WARNING: An error message is probably not needed=
 here because the devm_ioremap_resource() function contains appropriate er=
ror reporting.")
+
+@script:python reporting depends on report@
+p << or.p;
+@@
+coccilib.report.print_report(p[0],
+                             "WARNING: An error message is probably not n=
eeded here because the devm_ioremap_resource() function contains appropria=
te error reporting.")
=2D-
2.22.0

