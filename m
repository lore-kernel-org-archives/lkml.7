Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FF2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E10F218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MexKkzJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfCOQZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:25:05 -0400
Received: from mout.web.de ([217.72.192.78]:47969 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbfCOQZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1552667083;
        bh=hgZ1kib/VPQct5eX36HfUwogRGtwrOJizbKAY27gViE=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=MexKkzJnbI+hzB4xz6zF14p+nRZLKorw7dwUoabqX5et+RjdyO2YY8erajNAiZs4B
         G4O6qaykCLhQ2ZnzQ/nIwbE7jaoeRRDvuM+FpUPQnFGzhyXLr0ObISHOUs2zFRTBZf
         8FQUKXe6sHOqeNWyDmly0ImBtYRguTaNZxWEvVRw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.181.74]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Maamb-1hJtVi2WWP-00K6hJ; Fri, 15
 Mar 2019 17:24:43 +0100
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1552616681-17985-1-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [PATCH] coccinelle: semantic patch for missing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <01690c3e-ffed-7a9a-a900-f2e534fd0c11@web.de>
Date:   Fri, 15 Mar 2019 17:24:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1552616681-17985-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:shjokM8y6asbXIvmHJ9XHTathT+rA33yuBN3gW8sbYoPKzqMxQq
 ZrDaIOh+MRKLgG4Z8hRHEO+D6uecVu6Mvj7v1JbalWIGtEQQ5zRIECpYVMMMsWWFy9XoFtk
 OxuKsKmyQeg9wVijXIm3kN0ZDTaZLpxeNDKO/OES5cLSV6XmaKQXx4siGsqd/ojrAWNf2mu
 mT9j519zMeeC5SlKcmUGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JZHxbwjtiCw=:YoY4Lz/aYYuIWCDcDZniTT
 TVxgjfKflm3go4gGmhkUk7Je5d6+oBffaP6dvawBLKb7NGh7KsJG5ZL7d1i+VmoNfzyWeW6rb
 9e9uZfxQwpFi5KPmsWzIiw11lOgKGQKWIKNay7Nl+lmSUqrMTAvshl9DqxkhVnuwDcOZAdbah
 XOAxSfAmUvum0F54olqqQmm896n+BU10W48ZgWvTBNgBAKgz98d+GVJyIr877gEeNOGUFGBps
 Ef2z2TOamU6ZrlzyJHJiCG1UeI3CgtjlmXaJ4LH4I1odG1oM0GGEOnsFSNtLGQ4pPffVpeC3b
 PUamlbKyCy62DD5liiBM1ohwGoaF9dhH07KqcQnQOJHIW97onB7WqkZrAO4sWXZ570HmCgFGo
 C+jahhs6//uNP7mKoxfl79r0UaI3gZba5Ljg1hwW10hQ0mGDcihc/CE35UdRrjvqDV0+mqq+d
 tgZKltKMAqWGbWFlwh1HygBjpftncJV03ihDTUQEnGqaO8qS2/B3WqupJ9uOk0kW1yQHke6+D
 M2n3tTYIQwC+vncaCA3la+o8hXujGReUi3B9lTmhqkvRhrALOPhscaUKMq1bKDMqvaqg1peUt
 TUGBuISXtZ9gViT0SKoR3DgF0PE4dFn5yW/W1inHlLvKyA28YtbfGCns0bRs8wXQRgtcpDAvm
 DKJouUxfnPpzKoHA/y0AI/PxbaE/VmA9mc4rT/r+qC8OzXVMqkgaRD3b/2vFA1edfqYFnuKpM
 5sV2vcHmWo9qKvd+2YwCW46BfI0u4iXw2Y60mFW4Z8r/SCuQjKV+12KbI7W/SvYspV8OsCcE3
 vmnZFKWlBI8qJtCTu8nEMFaHzjUC5WloPrrHspfCREXNz8BYtUuEZJA7ZTHbLOWG0s3gZ7WqK
 bVOcIWV2fqRPMCqzjlQdRr8hSpqEf4EpDmzoXB6gv5MW7HfVdeQ2W2HL7PphcVjrRykNi8cAK
 vokF/Yv+Msw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/// Find missing of_node_put
> +///
> +// Confidence: Moderate

How much would you like to improve the situation around recurring software
development concerns for such source code analysis approaches?


> +virtual report
> +virtual org

I would interpret the provided SmPL code in the way that it will not gener=
ate
adjusted (patched) C code so far.
Source code search results will be presented by these operation modes.

How do you think about to exchange the word =E2=80=9Cpatch=E2=80=9D by =E2=
=80=9Ccode search=E2=80=9D
at affected places (and in the subject) then?


> +@r exists@
> +local idexpression struct device_node *x;
> +identifier f;
> +statement S,S1,S2;
> +expression e,e1;
> +position p1,p2;
> +type T,T1;
> +@@
> +
> +(
> +x =3D f@p1(...);

How do you think about to express any more constraints for this function c=
all?


> +... when !=3D e =3D (T)x

Will it be safer to add another exclusion for the initial assignment targe=
t?


> + when !=3D if (x) { ... of_node_put(x) ... }

I find the specification of this extra condition check questionable.



Should Masahiro Yamada be explicitly notified also for this attempt
to integrate another SmPL script?

Regards,
Markus
