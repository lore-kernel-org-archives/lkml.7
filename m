Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75139C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3755320692
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UZLzI+22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395018AbfIGQlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:41:16 -0400
Received: from mout.web.de ([212.227.17.12]:35415 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfIGQlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567874446;
        bh=jkBQA4DLw0+UDt6az2KZdOlsXluulvG+gsfQmf1KZQM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UZLzI+22PdkhR31xkvtlaSyxZ50/l+a01kdHXYCqrSAXss2gyccTQcFeYrdsCFihs
         uscQ8fYBhg9MRrkV0b+SMy3jIou1GCDNYVkJBy14QlYZBvne8FqMa9FNqFc2xGDyQP
         i28AZvemQ3GYxR46ZJbtpFE5+TyKodduUzHKLupA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.16.142]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNjo-1iSWCM2IlM-00mdBl; Sat, 07
 Sep 2019 18:40:46 +0200
Subject: =?UTF-8?Q?=5bPATCH=5d_Coccinelle=3a_Reduce_rules_in_SmPL_script_?=
 =?UTF-8?B?4oCccHRyX3JldC5jb2NjaeKAnQ==?=
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <c8e0db8a-1f96-dac0-791c-43e2d1e1cf05@web.de>
 <alpine.DEB.2.21.1909071804090.2562@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <23823c18-9f22-e107-81dc-a03dbaf0e0b0@web.de>
Date:   Sat, 7 Sep 2019 18:40:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909071804090.2562@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6kW3bwLtOXgKvRKoOFiv+ruGVwXCpqPwdJdvzYqz21y+9jtP/9q
 LmDPPyF+TwX5Y8s+7ZG0dBVBucUmZKD1KG+g1eLlz8p04Yx+uhhMx/pzrw7mfdroEXUlp/D
 +kAhVwdHfDUN295v/MmcpGeZvUN3ZoOgWDqFxmsAXERwDFmJwneKpz6j4hTjtVN/icAslUo
 IoL7PFQ9RfAKK1RThT5Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7SS/SKdNJbM=:lPrhO7+lkTdjWxOfARAfcz
 G8ZnAO9DVLJhHbc9gRfCQtyGdHkiWqoBSSjJ23LF72PfxSW+PFP+LwWu4egl33F3MswGAAwq/
 PdXNxynEqjpWkV9gM88XN6zwWQwJfMADW7rOOfCNbklBfSfRLQPefiQV4tr/RtUx373QPR4n9
 HnlT3B1stw5UOTZ/ukxip7MeKZ0agIn5e9bDhMdHE+apYWYtHFiRFLxsZLT0XenhiLh8qzGlX
 zsIYrPS4ysvrowXgy+fHwSr7/iGcsTnND0QNOV6p3k9i/C3+s0edDYOgHkIhcN8PVt9ReAFiM
 U5Nu/FMHRrwQNjUuxJe8yArM4SZ00+/qrxMis15UGLsbwNK+Y1WaQhVzS75zfHV38vNLgUkLm
 jra9KmkK2rhMmHFaHc3BPpw6kmbXr98xdp2nAySoS1vwZjiVSF9714KCyHQ2auWO+f8b64axc
 u9JOhWiFc/Xfh9Pc+wlbxIXTbk+R/hVSxbGt1NrQxYO2HcglW0E7on0ghk3j/J/feocYMtrHy
 NC0Kd3psV0J2gO8ifOnRKlveZ7kpuQn2F4GJU8pks2TqBJGXQk8YE4p/dFBVxnHcIOrqSTuNm
 mrFDDs6VX8CfBn33gk2TOL/BbNSNuk3Hp1oT0BICs7OU+9NjlptZyBVt5rSqAmrFwlNaUwBER
 j19jfqtUQszCgfVMrAT8snHD8xpLwPOOsjX1BtzQxO+Rn8m/jh8iyEVjBRGE4722TVK2Ciz0E
 YaHurfrNFyPhl6HSchY3RVpEhkT+mH23cOfkRmLmmjHJK7nhfhjYXsZMduSHECikP25U8x+Yj
 Ek4aqz4gFHuJUGjlNTUQF+j/Zq492JiB+Kh1ZyqfCYo2AcB/FFXa8kkDh2m655eAy34P2gSWs
 UnthR/Z7MghVd0xj3kfbGyH2rd4Kc7JN3+TZZgQbYQ0R13RgQEnIPcB+CPPglOz34deH3J8Rj
 6nqYBKryzIqEat5q8Ne5JIZpcUobvrMyGL7ERn/NmOhg7bpMTwQSZgiatW/fE2o+gxIHOMAYt
 Jj1380c/m3iIrQwO6Wc5E0J7FEIdwX6fJRbpxEHL8a8U5NefEKranuQYXPGFEJQ/qqJZAIlTW
 b3AX+DeJla9jtMWJ2lw25TPmOMG10vnKBUehA+hhAHpUjakCfOHwbIhAWVZb2CY2UdsxWyG/0
 a9CeGPAZZk3676uv7AAKUDojACuZz3B5Y+fECmx/RopYyk3SPKSPbWb4xAP5syC7o6fcb/qpA
 CAhW7Vkup2zP142os
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 7 Sep 2019 18:30:32 +0200

This SmPL script contains duplicate code.
Thus reduce it to the required source code search functionality
by the means of the semantic patch language.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/api/ptr_ret.cocci | 61 +++++-----------------------
 1 file changed, 10 insertions(+), 51 deletions(-)

diff --git a/scripts/coccinelle/api/ptr_ret.cocci b/scripts/coccinelle/api=
/ptr_ret.cocci
index e76cd5d90a8a..f4b1ce4a06d0 100644
=2D-- a/scripts/coccinelle/api/ptr_ret.cocci
+++ b/scripts/coccinelle/api/ptr_ret.cocci
@@ -20,44 +20,28 @@ virtual report
 @depends on patch@
 expression ptr;
 @@
-
+(
 - if (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
 + return PTR_ERR_OR_ZERO(ptr);
-
-@depends on patch@
-expression ptr;
-@@
-
+|
 - if (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
 + return PTR_ERR_OR_ZERO(ptr);
-
-@depends on patch@
-expression ptr;
-@@
-
+|
 - (IS_ERR(ptr) ? PTR_ERR(ptr) : 0)
 + PTR_ERR_OR_ZERO(ptr)
+)

 @r1 depends on !patch@
 expression ptr;
 position p1;
 @@
-
+(
 * if@p1 (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
-
-@r2 depends on !patch@
-expression ptr;
-position p2;
-@@
-
-* if@p2 (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
-
-@r3 depends on !patch@
-expression ptr;
-position p3;
-@@
-
-* IS_ERR@p3(ptr) ? PTR_ERR(ptr) : 0
+|
+* if@p1 (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
+|
+* IS_ERR@p1(ptr) ? PTR_ERR(ptr) : 0
+)

 @script:python depends on org@
 p << r1.p1;
@@ -65,33 +49,8 @@ p << r1.p1;

 coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")

-
-@script:python depends on org@
-p << r2.p2;
-@@
-
-coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
-@script:python depends on org@
-p << r3.p3;
-@@
-
-coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
 @script:python depends on report@
 p << r1.p1;
 @@

 coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used"=
)
-
-@script:python depends on report@
-p << r2.p2;
-@@
-
-coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used"=
)
-
-@script:python depends on report@
-p << r3.p3;
-@@
-
-coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used"=
)
=2D-
2.23.0

