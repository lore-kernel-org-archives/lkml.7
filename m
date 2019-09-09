Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7B3C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE7F21920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="K0QNBmuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfIIKlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:41:31 -0400
Received: from mout.web.de ([212.227.15.3]:41111 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbfIIKlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568025658;
        bh=+znkmPRkHWBrP9h1CFsSocplDOAQTkovUhUtMQJFcXg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=K0QNBmuH0GKshFvBf3GlwJjWiTYyNgipTF4x1aFGZ4vvqhIlU6M3uGotRlHBxgPd5
         MJMvxy/ZnUv9MKbzeCIvSE8JdRUroTQ2ZXIOIQsBVhbbRyz0PgztWLlm3fj4OjxKWg
         jZmAcsMw0UhDWwessfMLbR2GulQlYp3cItoo+0do=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.134.163]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVtqS-1heigM0A5Q-00X5h3; Mon, 09
 Sep 2019 12:40:58 +0200
Subject: Re: Coccinelle: pci_free_consistent: Checking when constraints
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <9666134d-0ff6-81eb-b088-f0086a0e61b1@web.de>
 <alpine.DEB.2.21.1909081019020.3340@hadrien>
 <63e433b4-06cf-cecc-46e0-9f31226f71d0@web.de>
 <alpine.DEB.2.21.1909082149100.2644@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <lkml@metux.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
Message-ID: <2cafacfa-0401-87c6-2d1d-d249bbc497af@web.de>
Date:   Mon, 9 Sep 2019 12:40:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909082149100.2644@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tYGUd3TQEHNvjE6eGZjkPt9HbGSfIcmsT3406iJNSVgI4LMmIwN
 m8Lg+Io7iTpz5KVN8q0lFCEey0CIn/m/7ppIkPUpsvAmv8h0SiHQTLyOZb0OkggmzoHES4b
 hq/BAjg99StgjhfNmb66eNvLY77ecXaD3zOCvYJD2GouNiPUhxR3NUEGwXbMozD0z9fVctk
 qKGhvRwE/gyx3v6Z//Cgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rfhk9B49CKc=:sB/5mm9SkO+tEqNwTsJSkS
 gFdCH2n1Qagg7bAxm+V9CtnHe0GzwLxEa0Xe6t4T6kiNjIbqHzTaGt3ABraZ2sHCU3AWq0Idw
 2i9hKShfwhnc/jyoEdhsmfuYHEC1uj2/U5lEzqai3N/eqTMM6UeP+ZiL9NFviULCn0/GKPjo1
 VInINxVZji0AJyKBsl2ADaRMhx2pdM9407+rOdoXmot76wbsmr/2xV1Bhv5ld5/h8eP4AN1on
 xBoO640blYeoFtKjBgqFTVjqlLKgBKcFsBkMmdDqiraCAuPSJfiY02OUSiQrrgt+Sn2YrMVln
 F45sr1/SgVbHHGZG6xrfR2VxoVgevwdq4cYVr4D4PGmlZ484oxZA2Iufkx/vycG11R8ZF8EWb
 qV+Ff1f5iACfijvJKUiOHJuml4XnN8F2mPNtLmfFa+OZb6u8zNeqjwi46zjCsEM029wb4uzDX
 4vuGO26tPT7jNAQjZzOYZeR8MiDnOnvowcZQTJDDmYkJOsUII6QlO1GWgT6nS38Shjp2/ExZg
 AjnEuOfW/XzsK7FVwNNyF8L3WAjqE5d21iK6M7DpMzEqIow77//r+RP9NkFItJjXm44nmRSYk
 2SFXfLnukOMCb4wl8bKjEewcbBm9Ad2/ZQUhbMhaljoVZa06AtYHrrb7euqD28/TnKYul6sAm
 OieKIz3J/PaXkNRgw5G77TF0riX5Ya5OAmZUzzIB014gSqKJgkyxv1SfzVh6m/SC4GXmvw4BS
 RRqXjCpl4Oc12mLFwS9whpdfggg989nItx64z/Tq9qEQQsRk1AIzShPzn3L0psw6hgqkWelzS
 d0t7Fha0cxA3dvot9U7IRVg4i95sTZX8nmvST/dPbVvu76FmQZYpUpGruw+pRVLjWLM1uT95t
 Xn2FasGn6K50OrYpOlNl5IQIb5esgxI81/Yc0XNGGFlT5OycZlHPTkYK1OTPyk4M5xY56rzh3
 FQlhzKu2QFGpCtUonGv871AG4WIJTZhI9I/y2DqD3GfZh7RZv6ZKCm5W9ZgwYV/s1n1c3Mjap
 lbp1yVxPyQ1XjQzuV4jVCiXr1if9zNHqx4A/SlcdAG3fi381H9u/ak1O4kOB+pb7aayD3tzyl
 W9081ziJ0Qv/72Miv5tSLtwxaZ4Loov6NEf8JTpaJql3v66Hgx7eF28ISRVZ4F9aYeDIBt7kb
 kJS8b1jJo51jRMWd3C3Z0Rp3GQIunCn3haN3rfSiDzT7VNn34d5iuUICkfUvNM6rj3z28jqtu
 OjMYu5ya+mstqzmes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I just try again to clarify if the specification of a single function c=
all
>> exclusion can (and should) be sufficient also at this place.
>
> It's not sufficient.
>
> I explained why it's not sufficient.

Thanks for another bit of information.


> If you had made your change and tested it, it's at least highly probable
> that you would understand why it is not sufficient as well.
>
> You first reflex when you have a question should be to try what you are
> wondering about, not to head for the mailing list.

I got the impression that a few of our previous clarification attempts
pointed design possibilities out into other directions.

Examples:
* Coccinelle: semantic patch for missing of_node_put
  Response by Wen Yang
  17 May 2019 14:32:57 +0800 (CST)
  https://lore.kernel.org/r/201905171432571474636@zte.com.cn/

  https://lore.kernel.org/r/141163ed-a78b-6d89-e6cd-3442adda7073@web.de/
  https://systeme.lip6.fr/pipermail/cocci/2019-May/005809.html
  https://lkml.org/lkml/2019/5/9/99

* [v5] Coccinelle: semantic code search for missing put_device()
  Discussion contribution by Markus Elfring
  https://lore.kernel.org/r/b2f195e8-c3a3-f876-a075-317bb33496c6@web.de/
  https://systeme.lip6.fr/pipermail/cocci/2019-February/005578.html
  https://lkml.org/lkml/2019/2/15/412


> Please stop spreading misinformation.

I find the provided software documentation still incomplete.
Thus I hope also that the situation can be improved by additional communic=
ation.

See also:
  [v5] Coccinelle: semantic code search for missing put_device()
  Response by Julia Lawall
  16 Feb 2019 10:36:45 +0100 (CET)
  alpine.DEB.2.21.1902161036120.3212@hadrien

  https://lore.kernel.org/r/6c114d10-0d17-6f43-4c33-0f57c230306f@web.de/
  https://systeme.lip6.fr/pipermail/cocci/2019-February/005594.html
  https://lkml.org/lkml/2019/2/16/38


How will the software development attention evolve further around the safe=
 handling
of code exclusion specifications together with the semantic patch language=
?

Regards,
Markus
