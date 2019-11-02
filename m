Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5364CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 08:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8F820862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 08:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cgalMXuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKBIuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 04:50:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:53987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfKBIuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 04:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572684641;
        bh=g6NSlVrdYozZKmLDMtTnXGfyrkAJufS1AfHzOLf/s+M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cgalMXuO5P7Q4QBYDwV8Rk4rYa8Zr/I83JcUR4URsomxP24BQ+XozR5uAazIWZx43
         rRGxZnR+4cPKh1zYuKVJxsTq+dRkToMlNZiZi/e295DsDlAKKozysGP9xKVya1MAab
         z2U/YLz9bVx0uWPo53lJSLsnD/htZS4g7FuWxJDs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.43.192] ([80.187.110.91]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1iIKWY1xcB-009dyo; Sat, 02
 Nov 2019 09:50:41 +0100
Subject: Re: [GIT PULL] parisc architecture fix for kernel v5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
References: <20191101202019.GA22999@ls3530>
 <CAHk-=whPiZSgzj_FtrDWbP1x6rssAQaD6t4zvwC_s9UbsOwM=A@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Message-ID: <fcc5e547-9512-e416-a640-0d8c1d50318c@gmx.de>
Date:   Sat, 2 Nov 2019 09:50:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whPiZSgzj_FtrDWbP1x6rssAQaD6t4zvwC_s9UbsOwM=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ayd2mbjpXRKCL8+qiqAUH9D9htmjCIA8oGZvRMJw82kZB1R3rzG
 TK5LSV4tf8pgSGBYQSdcnxibfzlYrj2kZHpsm2WjSXO9UJaHjm7lQKHirahldd4r8kZwqAC
 74x0H73GiEZMr9qxDZ2cTFzGmy/+vO+6C1H6jHIbJRQiNxXRzX7VaGJ0HBA15dMR3v2pOfA
 +pExvu800cBQUJo1oc/yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KGryRhUcfIc=:ciB7MouVYJuL3x6BCHzJ/3
 cRx8WIoj0yD40RUJD/ffw19eWqO620mnVg6EWJKHbJpHaKRoqKdIBYUjIpggTydIILVSWYEiz
 Yp7sJeIOS5NPWluZ1+INkQybwGjeD56MQUbE5FwYWgiQ6CBauffnZZQBVLCS6nBBF0woQHgVt
 aBXJBSN1w0pJAJ0632P2KayQTVEyj4YoXLK2YKUBKLwSRzAaTGjD7RTIOp2Y8jyL329wQaKq3
 W2PKAzOmU3xDENDH5srrrzPkon6kdm5fiQjYymm9RqYcmQJVcmLsqD62Y7VoekwsTbr0KLHiy
 pIZ5dsvWNnQc29Mfay19YIuW4zDKjSK32cls3TY1jX2iQDjT6Qdavk3CjZu4PRc6DbQZqI6aq
 F4+sTYM4RR2Yi4Wk99YWQ5WiBztAlQhw4bFXbbzNFMA4dfdikHYumYz5oUf30hfRTrWIKbUO6
 6IHaJvdlNYiQ8xpQ5qoaKYB51HAk/FDccC8j1mkcUUKL6O4W1IOk5+obVKS61ecFi0tJSqlgk
 e0ev6k5FjQoOefnVXQnt1aTRpeibWnb2wyAk9xP3acm9kAb/7RtBOhPhxXJiOPxVZs8lOF2ui
 Zb9orxwT8c7DFue2DyiN8643VMeWl4dwajLKGYXVk+MpXaMGRfmYr4GB+PedjW7XX3ARVbDYS
 IjCFJwdFwJjpXHDO3x+FBSQ2fsIBsBneRznNoUDps0NWxO/TqwK2mdkDNQENsAyqlyMi/76s8
 W0iBlIn/WM0pQwLO41JJRo/Q3WFddim5P19GThlX1CxF9B88cPn5Qz5ikUFRBvWa1BrP59Nbz
 rwNOil8P4RF7NoLVLOmj1PiknriiVF8H4RzwTgFjwYZBLOb/t+gkBjAtkdYRkB367tclGT28m
 96yB37r+JeCOMSSJ9sim+FRGwja9+g57q3l26yLrprgtQMPZsjH9uyZRM/shZU8c1oun2fz1c
 XVDjL5xc1wAU/bOtbL0PTLeuFhmBvRZyje/tZme3151MGDPUfyLDxI8nPyNONTGpdmLxqn4J4
 zNHx/XHs08qqXaQmTxJ8qO3A9Xk1xoyuLGpAZptwjIJLxxsjq9fmDZiKZjJI5AyKU5tFhbI19
 ZilZ9Rj0iVQmk2yHPTEGDceECxoG9HteRP9appFLc7LCGY1ntn/Xq3gnERG3EMaDYMVF/Omx7
 YYz0C3j4ZnmU/P5rwVOoMSK3iljNdRX2zejlPxH+djoWKcIy8nNSUmUIfIR50fcI6/r5CIBVe
 xGEcLOWNr1bZlaWXT6AUI8iG5zfGIF5oqkWTlJw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.19 23:17, Linus Torvalds wrote:
> On Fri, Nov 1, 2019 at 1:20 PM Helge Deller <deller@gmx.de> wrote:
>>
>> please pull a one-line fix for the parisc architecture for kernel 5.4 f=
rom:
>
> You do say "one-line fix", but I'd still like to see a diffstat for it.
> Pulled, but please check your pull-request script.

Oh, sorry. I deleted the diffstat manually by mistake before sending.
For the record, here is the changelog and diffstat again:
=2D---------------------------------------------------------------
Sven Schnelle (1):
       parisc: fix frame pointer in ftrace_regs_caller()

  arch/parisc/kernel/entry.S | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)


Helge
