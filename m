Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD957C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC94120673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TD4qocmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfFUJh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:37:57 -0400
Received: from mout.web.de ([217.72.192.78]:50139 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfFUJh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561109844;
        bh=kT4uxcn8PVrD/eGpDIX0oHe4BUNKCY9msva6hg3SIZQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TD4qocmgEZ9An9idJU6ffuqI+DiOJf8r3XHj1NmfILGML2HXRs16i8WntIYUY/Y76
         HgSbUSodbag7XqyEEUN6fjq2485zpYom/Cx2zJ+qaJBcFILN22A45P1Zu7Rxvq3ozF
         sk2tjfzaseCibihOgoEkzC2LzF7LzLPFiPevg69Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.156.129]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MeBHO-1hxb7C2OCc-00PwYB; Fri, 21
 Jun 2019 11:37:24 +0200
Subject: Re: Coccinelle: Add a SmPL script for the reconsideration of
 redundant dev_err() calls
To:     Julia Lawall <julia.lawall@lip6.fr>,
        kernel-janitors@vger.kernel.org
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
 <alpine.DEB.2.21.1906202046550.3087@hadrien>
 <34d528db-5582-5fe2-caeb-89bcb07a1d30@web.de>
 <alpine.DEB.2.21.1906202110310.3087@hadrien>
 <13890878-9e5f-f297-7f7c-bcc1212d83b7@web.de>
 <alpine.DEB.2.20.1906211119430.3740@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <452fc5f1-bcaa-c9a5-9600-0278594e5e6f@web.de>
Date:   Fri, 21 Jun 2019 11:37:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1906211119430.3740@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8f5MELeKAQ6fkJTLdIoQ0KIBVHR3p4OOBUaOuQL4n/k98RiXtfW
 YZ0gWEI1IfIrsKBkYs3Jy6ei2qt486abpEigUrAS2X1u5F4E4N0MHTe8X540a69EoLd+3gc
 1wKkAxff5BQwxxpMLv44cnE65RtmWjcL+bJlEr1aqiQ4ctqMVjjPQuVeM7pT7rSCGb9CMkb
 +wpPdcLsTkY4kfYX6JhVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sqgGBKnD12Q=:Pp0Ad7XgaZj64+RPjLsyyJ
 0Tvvi++5nK9tPWgycnibOzu9cFL0hRl61crF5I6l8C878ulaVfpBqqmhS0kmSMlXYd+co6r9u
 M4/EZ2JNmpi3es9bBxJSyppumjuwe7+dJamGV3MYKmpNhCqNhox62aMBGbCDl7GZJdFQRZi9J
 4Bwl2qYDeA4XSZ7Q8QudcMZcYUFgZRqvAcV8U0xE8tN6DdM88eVRu5+anftW+Nhi+jrRLuX6Z
 8HREhNZEM15UFiwcexH7VvxEFp3xFwgr5YK613RSUUY5Nfm/uq+LGfAYrdojdUZl8yaGeqMZ/
 Tn8e6Mc/4+xSTe/4UXy8CnymxROrXtMr/J/YHHphFOYeEwRJBEQ2RB6S9db6nlL7cfWRXXGMO
 6QH2Uf2Uo0N95Ie33Q3hLv3zHPepisHNDE9qBxhoiKtgD1NnrafWn+mXCSqVbEVrGIs0NlolA
 +OCaPpNCI2jeUy30v6i6+Jnd7msjg1kNOBteEgncO2gQpuiq/p+EgKEbLS2Gdxd9RTrt7NwjJ
 Un+tgbx9dfZsTPZsxieiFIKLIuDqLACInS8o0jpzQvd2GzhR4BeIHJ3OFkjum8VFkU/nDxh/I
 DtWdWCqYuCOF7Ce0Q3r8v4DDscA+95vQNWWmArI+jQBs/OTT3v8/V8X5jpzQlcWWHUGcFbKeJ
 bbjyY/x0TKrTxZPFbD67cMai/z3ZTKthYFHbz5kOehm3ByohEjur3lazXDsOZXtOlh9aeSIPp
 RXmnKjitmkepS9SEnuQ56TUjIdB7X43frc/p/pDoqhp18e8/y+aIwCJMBTOqiFHbuUzl/tmkj
 yp7MJzYqBDbeqQOBkJtXMpxpZXSUDkGgiFiQ9nRy4en+Ty9H1n0fOabJo4Hw+rh94jYlS1GHV
 oZdcbI4wqZe4/Jkrfq1rVk49rqNNehuSAYBuciX06tDyMXcIeGG+z31y2OSUXYH0AuAdROTat
 jfOz3H2fyQ5gTqcK1Jz/lrDVNB4CqqQoOwZikilDDrypRTGpsUGBo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I still don't see the point of specifying return.  Why not just S, where=
 S
> is a statement metavariable?

Do you find the following SmPL change specification more appropriate?

@deletion depends on patch@
expression e;
statement s;
@@
 e =3D devm_ioremap_resource(...);
 if (IS_ERR(e))
(
-{
-   dev_err(...);
    s
-}
|
 {
 <+...
-   dev_err(...);
 ...+>
 }
)


Will any additional constraints become relevant?


>> Would this approach need a version check for the Coccinelle software?
>
> Why would that be necessary?

I guess that the application of SmPL disjunctions for if statements
can trigger development concerns.

Regards,
Markus
