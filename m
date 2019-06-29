Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D81C5B57A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 08:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10F9214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 08:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UC5H2Gnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfF2IgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 04:36:19 -0400
Received: from mout.web.de ([212.227.17.12]:37733 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfF2IgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 04:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561797360;
        bh=FbSJSMXHPnAlz0/Bg4By/65t5cyQvZuDWiA432ln34g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UC5H2GnbD/enRv/6CRF4z0LBxwZya82QF1ff69LYS7x7xPluno8iMhdk4E/zsGb21
         TGMUg/BXhPvRXSKwkdQVtr6FxBizHKgQ8AO+AwA0oxv7HLT4LQ2j95q7gbq3Ltipt3
         eS5QItT2BLlAi4TXLMrbpvL9kXQrMgS/knBr7plQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.176.71]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8Qtq-1iTD0s0H6Q-00vw00; Sat, 29
 Jun 2019 10:36:00 +0200
Subject: Re: [v2] coccinelle: semantic code search for missing of_node_put
To:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Cc:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org,
        Yi Wang <wang.yi59@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn>
 <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
 <76641efc-2e3e-8664-03b2-4eb82f01c275@web.de>
 <alpine.DEB.2.21.1906290947470.2579@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5b75be65-a205-ecd6-8424-e0b3384b21b1@web.de>
Date:   Sat, 29 Jun 2019 10:35:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906290947470.2579@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AyXXGYek5NqvBCp2FlWCupQhyIsRHY8QGsg7ZKLNjfTVv9dQnsT
 sS0gWrhCe8n/YdbaIXDaqf2Z6Q7ZphywHxY2I0qVpQF9+o/LkR6w0eqCw/2DeZY0Oo7IbVz
 4U/Pt0k3CtPEBk+7keZi5LXEPHnefpOGq9WQk86kwhn29H0KGdDevhAQn2IcOf5WxuL5wWE
 mf0ZqNn9RuM850nhm3sKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3qAJuQWmufk=:fq1GzgN0iop32YdR4pxKjB
 2m5hgQ9jO/71aMZPItYBeBdHcrdZ7GXHKO2/FGNGTp2HmTrv+iGFzR3rC2CcvvYoNLq5gcyTN
 FnK+NBp+UiMDBnEfkW9JkdoaZEJcvHpJCuvTYh6jJz19WxQAHx4WDWCy2By6//e4ybsmgGbnL
 01Q7M6K16HhHQPV/itmXov1JbE97CBU8iicOBMYSNivzW1hsrZNTNNdAQFKPq+xe2Haf+QMGR
 bADXXnsyydmk3ylb0YUEJksLHLPX2kqMqvh4fSQUl/X8Pjvx3ou6YfbcffBNCaWmR+36ml8zw
 Zb7a5EPy3Q2cILcRE6OvkTs0MRTJQTk+LmE1lN9ge8SLctT0ZmLQ5tswkbmeT7Wn7o0kMMBV7
 IObzXo0hLTI/j69mQWLP9rSGoIvru4vz1lewXEPPkPoO1Xdf8ORF/y7isx5kfgg9B0ljzQYr9
 wKAAf6F3vY3IAWNWFQ96eLpbsjL72IjsSlEO15IXfa4uXX9Kc+yLTpxpu6Lt1zx7uXzW4o+3u
 RFGPnKodZxxw+xMySo91tYI5iv/F+wD7PmikdQUqr0q5iIlbnZkQjxmMbvuIcTxRid5fkIq24
 lxm0fpiUXn0Ur5e7wYxVMhSR9sylYcQOZNwo1/p3Xz2CwUK7FkX/J6MekhhtbHVxSBCmrykWH
 Zye2ixwjrqjN2GAqVg9aje4afN7hVquQziHGmCqroqO4zxHM+XXeLcD1EZxtwynowd1CAtxZA
 oUDkIqXU+hrjlgLGNFDcaI885mV9oSAGQkvzq/zVFLm84OHMsJSR0Z4Hz12VQdvEWcWedjYjS
 0qFAcT2hpzes50aMl4mmq9lwaCeSiXEUfyb16SJgVR1sopZAeffBcWultJaE+rpO1qL4qWjNv
 91MSIk4KBS/es38PLPnBhj773pyeqzlN/FmhDT+o9WZl+Es5l4FvZVY+L+eVaj0epQz5Bj951
 seada+lJpwqoTpv7BxE3gWQ2mvH4hqPX05Y8nBqjWy4LTnGZc4N75CuVGyLJOBQJ3SvnA+0iT
 pfT1GUOLEd3HY1zCNrwcX/+n4zLGshwb8DyAF85B9MtBSndvJuB/XKYBblliEHdW9KhJWtwu6
 nGRmfqZ70phx0kgPPH+hXwvwglvRc77GPca
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> +if (x =3D=3D NULL || ...) S
>>>> +... when !=3D e =3D (T)x
>>>> +    when !=3D true x =3D=3D NULL
=E2=80=A6
> I assume that it was added because it was found to be useful.

We can get different software development opinions also on
this implementation detail.


> Please actually try things out before declaring them to be useless.

Further clarification of desirable software behaviour will help.
I dare to express doubts around the SmPL functionality =E2=80=9Cwhen !=3D =
true x =3D=3D NULL=E2=80=9D.

Would any more contributors like to share additional insights for the safe=
r
application of the semantic patch language?

Is a reassignment of such local variable an usual precondition for
the discussed programming concern?

Regards,
Markus
