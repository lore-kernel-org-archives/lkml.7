Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DFFC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2AC2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rr5duNX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfFRLoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:44:46 -0400
Received: from mout.web.de ([212.227.15.4]:55881 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729681AbfFRLop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560858269;
        bh=f365Vkn6sWr/poFBuZ54QTT4vy6mHZdUcafudWe19zE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rr5duNX2k08ma2Mlbolao+FG6mPUqmJCPgOHG59aQ6G4tx7IQIUT7t989mtUdhaFt
         cIe4NRkb5CK4ix3PdHC5hnpb7F+Ds1Pun3r9yif+RgsOG8DfeO+dwFVm4f7TOgBzci
         8y4OQ41jjz6dJet6DldDHL3/qodquNA1NRXsvKAw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.86.175]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lh6PP-1iRQnS0Vwl-00oXml; Tue, 18
 Jun 2019 13:44:29 +0200
Subject: Re: drivers: Inline code in devm_platform_ioremap_resource() from two
 functions
To:     Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
 <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
 <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
 <032e347f-e575-c89c-fa62-473d52232735@web.de>
 <910a5806-9a08-adf4-4fba-d5ec2f5807ff@metux.net>
 <efc38197-f846-142d-fbaf-93327c2669c9@web.de>
 <714a38fe-a733-7264-bb06-d94bd58a245a@metux.net>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8ae16eae-7bb9-3a82-000f-52e16aa1eee0@web.de>
Date:   Tue, 18 Jun 2019 13:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <714a38fe-a733-7264-bb06-d94bd58a245a@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KkA7Ndb2dGDW6kXHq6nLkPVqT6Y4OfPLeEcJ3O3mdz/hOPHVW9l
 iipikgoSNcxDNs1f8nmsa7f2N2POZe1LhguOjIKjaCoR4AMm5+3+q/yJX92hiu2UZvRkCAj
 uehq14PLu396jeH/0ijDHXzqrS9cptHkLPiAgq5Rtw0iSFs+JPF65YvGiQD8xojiXtNzEtY
 VaAQ5EN+XAeq2yF9tgnJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n+3DWs4yqzg=:QzABxMMMY/1KDjcOHg9SwO
 UjJTutFwwwMXcO8mD4zSz0HWUluxsN0nFCRYzK46M9mbI0T6xx2EG1Qeb/7cBI7EqeTnDD8aN
 T9sv9H11dN07LbNM+2LSGpn5Qwmh/gOe/jXqpn6uXPpEZnMNd4HF8LRWY0rL2Kd21THm0FPDr
 wRR8U5eSsf8NAShIgFkxh8Pt9DiAkGqKLIZY8wqTrwXyhmy53qvaNtAuvM2OWRpf1uRJjJajV
 7YGrJBul4mQ+dlDyuX1bo2C6yiuYJjXS700Rg0JcVVyJsaz/i0NVyUMk5kn5HQBpNwBWpz0qN
 LoReS+leNFNAOBZLz3FTbekS+0Pl/EEqMjyCf0yvapUSs4xzWWqU/DXbJ4jgX0ZzYXbVcvLO5
 bKeyCsjV4oulwgUn4AHPRcAowBW1rwhhGnCuNJpAEDu2XHI+J9e0fGDE/eaut8hfot4V9bk0Q
 HN5p3VbXoocK+pNh9Z96j+MJa3KMioCTSf/gUv9dOWVGO7Tm73o0dMEaNm2hXmNrWgux4K5+j
 +LH3XeY7USyvBVRhp3kJCPcqnbQkvDc39BXxXuCROVqX5m1HKaV+Jlwa4NIyQT2EwVWXtXP9A
 VpsYytNXxfzX7xQChbhHnG0mhi7NSuLh0JgeCudsHyrETIGb6as2EIyInqaV6NcXbBC7ODh1h
 sBNFXsoy1uEy1C4+x0jIj+JFZwUT4wyEz88OtvJvO3EBOykSd3w64+zbWdBzQhwIGLvjsGKzX
 TC3BhLrjozLNEyaqEeB2dkBv70ZFwueRZ+2ywANj7sV0wIeXS5TEy0KH2RPelNqBh1S/uf/Fb
 4bI02G+E/FXlXnp6NU8KVS3kNvQ9u6iBHVzyT9D1sOd5YUprQAAtxSidaV8ZaK484yDWbJnVB
 nCFZmcDp2KFI+eqL0RiTUypRgQLxE5YiOkHE4vgr01vXAE2BYY2cSjX8qi5YjWNYw0rtb9q39
 Isq67EO1glVgHcY1sVjrWEgqVUGUbx2e+QoUiD40FxzsQBYu25KmO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would you like to check the software circumstances once more
>> for the generation of a similar code structure by a C compiler
>> (or optimiser)?
>
> As said: unfortunately, I don't have the time to do that

I became curious if you would like to adjust your software development
attention a bit more also in this area.


> - you'd have to tell us, what exactly you've got in mind.

I try to point possibilities out to improve the combination of
two functions.


> If it's just about some error checks which happen to be redundant in a
> particular case, you'll have to show that this case is a *really* hot
> path (eg. irq, syscall, scheduling, etc) - but I don't see that here.

1. May the check =E2=80=9Cresource_type(res) =3D=3D IORESOURCE_MEM=E2=80=
=9D be performed
   in a local loop?

2. How hot do you find the null pointer check for the device
   input parameter of the function =E2=80=9Cdevm_ioremap_resource=E2=80=9D=
?


> Any actual measurements on how your patch improves that ?

Not yet. - Which benchmarks would you trust here?


> Look, I understand that you'd like to squeeze out maximum performance,

I hope so.


> but this has to be practically maintainable.

This can be achieved if more contributors would find proposed
adjustments helpful for another software transformation.

Regards,
Markus
