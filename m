Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA001C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 12:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5845120866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 12:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sXOwvzl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgAEMNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 07:13:01 -0500
Received: from mout.web.de ([212.227.15.4]:56725 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgAEMNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 07:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578226059;
        bh=JxTq37E6uZfsQi4LUu+0+xkHkcpBGQS5vpN08OxUAV4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sXOwvzl95A3pwO9Get4x8is8LqePZnuFEjGE2B85NZdnBD/bGLSxjIVTv/XM0Tj+A
         L81Y4gwr/9MMykNmrdfE0tRWFp7USWLEH89Q9A7bgs9dMPwgwwdKtCtgpmxRmsbm+j
         mVmFIEAAEtL0j2AxBKxalEI0JjYTunAiN4r595wE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.187.152]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAvVk-1iy0rP068S-00A0Xv; Sun, 05
 Jan 2020 13:07:39 +0100
Subject: Re: coccinelle: semantic patch to check for inappropriate do_div()
 calls
To:     Julia Lawall <julia.lawall@inria.fr>,
        Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200104064448.24314-1-wenyang@linux.alibaba.com>
 <21e9861a-5afc-fd66-cfd1-a9b5b92b230b@web.de>
 <alpine.DEB.2.21.2001051139010.2579@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ac9f19ae-252b-32ce-0bd2-170ecc0ea14e@web.de>
Date:   Sun, 5 Jan 2020 13:07:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001051139010.2579@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Qi9lT95j7uYztE56MTV7Nko6/6Qq7VRygIuQKAWkh6OcM18ZjV
 jXxHXMbn7Z3iL9YRKZ7ITB0fzk/URFexccQdKDBh90eB67TEf4OuE0fZPdq+iIPiFxBQ9wR
 JSaq4craPrT4msHb1l/JxQ3+3YAO+3m6yHtRbqbhrdRD5q/ixGYiP0OoTG4Sqjam3XI6bb8
 bTyt3ImlWsZ1TtB7EnVnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xtrxNb4uJCM=:w/ihnkGs0Y6XP5LCicpAZ1
 W6SCMdFyA7WcwQklFvgPJopp9XdLdXiu//2InDXWBmunCgQ9scIkRZihYtBlZ55oac9PnplJo
 XTf8ClIIvnKn+5YDO1uWUlymK8v1noo0k0ioqMzJMzWiAX2hOPazsakd/MbaMdgWuqolb/mqT
 a8PKxsUNs3O/ioeGsZ+lP+oIYDWeZLgvEkY+pedJt2QMvCmE6+JZ+aL8wPQXerEgUHxNhd9QX
 Xc4r0DweQXg8TWDZAvfaEl5DTYEMAlDnRwMrJCYfQk0LJ1Xjz0Feuyy3zosqoS5xyAGtPNxfn
 6a0XjKWkIpYquiTzM+bpxxgxhXeRhTobsW2aSTDoFBboJg4Pllp9xP9+pjYNN5kcaqEq79gYK
 W2opiHWb+hU1vL942dR9Gt6e5CzRO9XGVrP+YEI/4BakYtEmflJPGZ5HfZCjssnVAFe736q6G
 IfB4WuL52RoE767/Hq3BqOFv8WRMnCAzpBVijYAS4e11i3azmN6rABShgVBCHf10Lx/z9q2OE
 gJxih+KDWTFr3SlLMUxwCGE2P3ZuTdUuhogvt1UbiMnxy/QPY9MyD1FDWY3oI7nlGrF3bgxYk
 r4xhUrAtg/IjVizydkywtYt9YahYaWg+td5HhwKDaSNN6OxsAaop3VvtZolA6cBqH3txtbeag
 PBXUMlGHwYTd25DmkACI+6XqI1JOuRgeDRS2ECNuR5twfFTLElUYQG3BVDKEKRiVbUNuI0RxO
 Lihd2wDNnJAmKNDlTD9hX/+gTK2aZcxsa1D2sesb97tQaq7MscoUZXjrfbGWnRzKvHl66A9xC
 tipfV/gDZ42rJ1BCEQG/kcVCUMSJ1oJYZfdEj6e+7zyM4gEElTC1Uo2SRC2IkyP1GwDUVRsZn
 CqGG4AmFjGoJncri89/fDBj4jBO/OYt6Eey4fATkUDmNMlOTP7PsAZypEKa/v5dvecEa6F+VL
 s0EiH9JusSGNMBcTQ430wHy/INUsI3IKtjWrb/NMYgv7caavJUk/yitl4fXn8szH7iLd1Kn8y
 gbwWJfgJt19q3x1coQDZrx9SC9Gtg2qwk4CI/c2T7QqRWOrbEr/TNxlNNAScgwZC3ptHt1u71
 Ar6uggv30oJ90A8iSIFkAW/qe0gQImzn1XvmV8xgeUuRjTyxwhOBRmXV/kD7v0lvFB3IX+DW8
 +Y7V/1gA5laKUHH6Pd29ZZfeBWthvjWKln7Acf6Y6YzvGAiK14rwS2Iz8Tkj9XwbTU97jdC36
 YDgFaQ3WAxQ7hIx5DiJkZ2UvjXyI9BAaj4FIuEXJPhU+fomOmDdh5n3YXlxg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +(
>>> +* do_div(f, l);
>>> +|
>>> +* do_div(f, ul);
>>> +|
>>> +* do_div(f, ul64);
>>> +|
>>> +* do_div(f, sl64);
>>> +)
>>
>> I suggest to avoid the specification of duplicate SmPL code.
>>
>> +@@
>> +*do_div(f, \( l \| ul \| ul64 \| sl64 \) );
>
> I don't se any point to this.

Can such succinct SmPL code be occasionally desirable?


> The original code is quite readable,

Yes. - I dare to present a coding style alternative.


> without the ugly \( etc.

I wonder about this view.


>> Please improve the message construction.
>
> Please make more precise comments (I already made some suggestions,

Thus I omitted a repetition.


> so it doesn't matter much here, but "please improve" does not provide an=
y
> concrete guidance).

I guess that Wen Yang can know corresponding software design possibilities
from previous development discussions.

Regards,
Markus
