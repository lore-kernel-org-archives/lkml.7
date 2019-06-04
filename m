Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3509224CE4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Vm6L7jiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfFDJIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:08:23 -0400
Received: from mout.web.de ([212.227.15.4]:33493 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfFDJIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559639284;
        bh=ETRve5vggXNZVMb7TbodxPApB4lLaMjH4ke8JjHZGo0=;
        h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
        b=Vm6L7jiIlA4KP2P6lchFeSt9c7QbgwIMqG5OebQxjFiRYllyHBR2COe5QVTlDbTkZ
         OdTfjciTG2AdUR69Ojd2KMCVVWqLY+Ee90KWMF7yY0zbcnkbPjKUinGk0AlqsgGab+
         VH5SyNhBd7bxbU7+CAcjvdstvY3o86RIsId0XWQs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.49.105.210]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKaDH-1hWi723k5n-001xlK; Tue, 04
 Jun 2019 11:08:04 +0200
Subject: Re: Coccinelle: semantic patch for missing of_node_put
Cc:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <201906041655048641633@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-doc@vger.kernel.org
Message-ID: <552e8e3a-918d-c1b4-c925-4e8fe7ddd307@web.de>
Date:   Tue, 4 Jun 2019 11:08:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201906041655048641633@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nXpqdE5vJdwVlnTqiz6tTXpojorB9/hO3jI/uQ7hdE3ecds67Xs
 clkPBsTlSYWLCPAiw9C36UjR9icrnjuar7f2VmD0HRKZ0rVqwtQXdO1DIK4jOCP+vdhS8HY
 ovnEsDwWmNkOycw0v0w31RhcumztIqDuZC+lh66TPMPCtj4K7ekINdz1g8OTk9k0tqLUSxk
 9G38X7ZpFbjiMCyHSmcZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SHkmWJH79ms=:J/OA+9CBs1gPLksUkIrA8j
 olcriVMj1qM/rl7sfdB0XnqdpT/mCONJTDPuOFm3v5r8LRpk+vErik40cejoAJGtGuoQ3KWzS
 vWn+DdYrw17b7amAwTsr4vlSNOGrqdSV+w8F1N8LKbEZUc01FmhjYWpoqCmHL+rkhTLur7eAs
 T0Is285B9HFLqYfptHkyvQaIM0fsxBm4lNMuDGKdZ5XgU4Kk0QxBF4Stf3urmzICwS+zAwgtF
 OQS6O0zWP6IiYKM65hspx3iNAT3tdy1klxG5Y19mxj2D2j3Az2xGV7ohW+ibclyFroa08tamL
 EoboshMg0wquzwSpU/yUoZUYX++PR+ll5hxzHVAsZDD1OqIxe7fyBcpvX0zJq1lYA42ZWtmvy
 O1YLOqWhrcz8OCs681KC6vqB3VpjvEQs388K5qD1IDt+UTbcT0NOtgktSXY4148Av9P7Di/Py
 qAmZyM0DMZ7yC6SlEQKiF6vcsh1c7VKgxNgwvvkWJb2rN4IabLxblCTqNjq8BKJNStnJEdd/5
 cT1xnUp+6mY7WwmQfjYGQzaOmq4PQOgHqH89aaBKpPNP6C2iyBtWQ77GynOJCmFPClBKfr3En
 VutPgjetU9lSHpvEZOTA1+KEkS5+AiNIkPEXF+iem2Q4rNZisnlv1gxZMrPjxmaXlDnL3+p1N
 ugZdJZJuj32OGIwjv/k10pASJ5vbEL2pnLN+A/SyIa0AyAuAidNUcie+Jb1tWqvCaeyEkT06k
 8UJnAJP8oTsMAhMBgpxTp64TMm3PZniZUSxC323pLhsUJSIVD6VKRFDN/av/dphU5BWLDFphd
 9NZZ0qXuB4MNETIJLT8RfRswgANlxNZrZZOybXHZrdgYdkP8s2GrO4sCCR90+1xJe+56ON65I
 OimS8NofDIOrVZO5WIouNUUO7kq1t4fYhJxUEaICkiHnYVmLW4ml4SKnUQNFznXcwrinSFflq
 VJq2ejT2Ew+pESkoSsDvX6UqHxv2SNIip2QQJqSLTHwhxejqVAyub
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Thus I imagine that an other documentation format would be safer
>> and more helpful for the determination of a corresponding API
>> system property.
>
> Our script will remove '* ','\ n','\t' and so on from the comments in th=
e function header
> and then merge them into one line,

* Would you like to keep this adjustment approach (for a while)?

* Will other data structures become nicer for the discussed data extractio=
n?


> so we can exactly match the target string 'use of_node_put() on it when =
done '

Thanks for this clarification.

Regards,
Markus
