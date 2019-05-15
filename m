Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C49FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE63C20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="i9zSQxrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfEOHdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:33:52 -0400
Received: from mout.web.de ([212.227.17.11]:34271 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfEOHdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557905601;
        bh=JJRnUxLpmLOnvkqnmVRqeH+bTgp6DL14QPoCGcd5/1w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=i9zSQxrq5a1YrkU5wjo1ZWGPfvN2ZQVRLc1Y61lSvszZTOroIAUYdSwBzR4IGRNpa
         csWtgiPJ9Q8ZUmgQGn7F1tYvx310wm5UzyK+peRwwFFjLfmVjOMow16bWpEOgXMDlF
         N0pc7QdL/cHRpHXPBy87boJJRsleUbDNPSGlaEYk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.73.153]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6mPA-1gWWw90ziu-00wYQ1; Wed, 15
 May 2019 09:33:21 +0200
Subject: Re: Coccinelle: Handling of SmPL disjunctions
To:     Julia Lawall <julia.lawall@lip6.fr>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
 <112fa697-3073-1a95-eb5b-fa62ad9607fb@web.de>
 <alpine.DEB.2.21.1905142146560.2612@hadrien>
 <20b242a6-23a8-9b48-5cfe-c99df809dd24@web.de>
 <alpine.DEB.2.21.1905150811310.2591@hadrien>
 <1794c3af-cec4-8b28-a299-400b857f0644@web.de>
 <alpine.DEB.2.21.1905150908550.2591@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
Message-ID: <020c9629-fa44-170b-b2b0-baf3ba636a71@web.de>
Date:   Wed, 15 May 2019 09:33:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905150908550.2591@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZBncoswZG2haEWBwQHbrkFSGGeGJH9KOJiLWImJnbdwXxW13O6B
 IBwAJ8UNsWARmiSbdLVU2u7PsvEv2e1rSGIImh3y5ZWzCLJXVGL/MdKDW5olaDhjS898Cep
 nBbT38odOFEMFXWqHuSY31RzYfrCCPJEFXIXWXFtJO2D3o7Ykhie8DLKGgiFL+isZuyMTyq
 Hu8sB6MkG0SX//TkztJ7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7csCpvHAaKc=:uumiMR459AAoexpjBS44D7
 HOyT5wKmUHy7pJNGDd8TvZIICO95Rx4yELW0vwUq8ZAi+N0u2XI89Hd1so8TnZhrTQZJm2oAn
 Sq6fgqsCDENEkIJrUXyGIq5i6kFqLrAkk2j1I3B/8YmXdFOvHDlGbtD59OEMhmXgnZLRgFwC3
 HE1cghvamvWLLqadrl03I1S3dktzHSM8sJsM+o42X8Hokxw7gHFFKjsZxBAAvpSMIm5CKB3bi
 s/OZXdliuM90Yax4p7r4Q62uv/lT/UttQBZMZ/PtgKVAHUhc4yohHSW1cBN1gUxu0eHrmx8a8
 Oi9zxPCceGWpwtka+QAEaODsWTq80PWlhibwMUEwVrOUtEGSmhTwCoaKMWDJMVpfNz/FJf9IJ
 uUi/ay/pxRkysx30U7HmCIoKr/WJHTSENR0RE/R7ErL9DnwsUu/JvUwtFPPapheBOeSYdzN3H
 /qtFFvqW3j0GTWNtTQmzBmIHvsg8oJuYis02vrWUt16Dp48iRFe7cLMtpMr3bm734V8oFd59A
 uj+lfF31N0C65Gsao85KuicXGDsT8dx7UEdltXqVmw/zFLgaffBtbN4ZiQEhfvIqUKkmLBTDc
 fW4Q4y1CTvsIJhWQRbtar1Czp/7R5t8LCf/t88Dwe+2/QLj0J1lc9g4FVJvbu2f859bEyLUc9
 ybbcIRbX/lJi9zY0xxcE8trfXDVlVD5fO2blxRuNtpWlS1ZKfRIE36uFWk+HPv1M1ZuxzAWxC
 f1PxxKh5bz7ftx7qo3xUtY+ECrspVJlp6SO3uRuazB9W3oxPEK7LmItrCCmxfrcFGlbIq2BdX
 CwxxsYrWjlyk3syHCuOprC5eW68Zzgn3SLfwU9TvouVsWi8l7mXTcORDh87bjBwifhEG08A++
 WhQNxokXFAIMbSLxcr2TEnVZbAammGI5GuNpCela04cvtuO4akXdcMqDJzDpZBzjvVd458jrP
 z6hSCS7Dv4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Can different run time characteristics become relevant here?
>>>
>>> Internally, they should be identical.
>>
>> I got other imaginations in this area.
>
> You imagination doesn't matter in this case.

They might result in collateral software evolution.


> What matters is what the code does.

At the moment then =E2=80=A6


> It expands out disjunctions on expressions to the statement level.> So t=
he internal representation is the same.

Thanks for such additional information. Is it represented in the software
documentation (besides the source code format)?

How do you think about to increase the matching granularity
for this functionality?

Regards,
Markus
