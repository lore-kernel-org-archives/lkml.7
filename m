Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299B1C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCF2208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="SAQWgBXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfEMMxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:53:06 -0400
Received: from mout.web.de ([212.227.15.14]:37875 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbfEMMxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557751963;
        bh=y2y7OElzbIuCc8e50DADIwz3qUf6OcXN6Nj6UFcWx+0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SAQWgBXLEXI6MFBtWszJ6dQrO/Rhna9Epad3Uc4Ou6BByoz7Vb5Ch9zpx7N1Ljoba
         oT9jP7NiTZnqiJx8rRps7kz9+oe9E5NuDcAOz1+yCPfJSQbtRbxxBmS/Srt/+MiNHt
         7TygEA7fd0FlxDXW+C8N1AiCkKc6FkZjJoSS6CFs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MBY4U-1haaa50v5C-00AV3C; Mon, 13
 May 2019 14:52:43 +0200
Subject: Re: [3/5] Coccinelle: put_device: Merge four SmPL when constraints
 into one
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
 <6b62ecb5-ab88-22d9-eee2-db4f58b6d2ae@web.de>
 <alpine.DEB.2.20.1905131132250.3616@hadrien>
 <1c36d747-ac2d-0187-ddb7-d1a2bb18ddaf@web.de>
 <alpine.DEB.2.20.1905131350330.1009@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <43d331ae-c2d8-9853-fb5d-c03b7cadb9f9@web.de>
Date:   Mon, 13 May 2019 14:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905131350330.1009@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XdmXYs+UYgYAZWJf2zKtdXxfSq60sFHgdhA5RyZVsqkJ9LV2vsf
 9sauC/jPEkW2Hb8i4kxOGhwRtgtRClL+ls/zaS5/U0WC/z5rPGyQwkir/sgcVHXQghRba1Z
 7SP2kI2lKd/+Xvi/Nm/U56dDkEcVBA0PucQi1bpBnWUuEHKTpafaUQTS04pOuZe/Hv77zVc
 l3xerCsg7BiQ+CLRZWDJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Du7CXBKqlVk=:UEDcylr4JErz8NQU5N1QlN
 7h8K3WWHjsbV0y2lizc/Pss0VBFNSBtfbeoLydRjDLJmSMDvm6m1Xopl39nHMo3pL1kBFjzmK
 0FCmUl0qucmZhXv+KFDxC6rOhpTIEQXjMzR5X4O6pCgXaaqzL3TdsxPYIbaq28AxayyTf7ihB
 XkLnLNMTL90DVSoxIcp9CwY4Y8BBWR266N54MpBxY9nFecyftUUbxCX9q7aFMUeHauUlnrfjE
 jCl6PRrT/vOiqIbW4V/uRGP17ee4T21SpVnNnfUhqTWJN/a+f05y0OhOHK+uJGt6OeZwV1JeW
 /oohXkOqEKR3gYh5YAhy8L7L+J2NZ/IK3KNINyoXtYb2VgT406qHK7l5P0SlS6Y9d2eVAFCYK
 LkhxE/01O9SZ6ld7hiR8smp1ltAWoZ/ofNBdQy1wl2E9Ip8VHrkeWZUjQIEP6ifnwuxEZqd8r
 EWcBhCmxbN12iNzlD4zYi7sOBojw69Ht28cuqelUZleFa5u9z9ROxXFMs6iS7pGIoazCm8uxv
 JbFWzaEZ9EcwZmdEcC/OtRvz9QmMWUQSNQ7DjIdC3frUaD/I1CFXVMdE5J2jljAwWF7+WoAaC
 P3mZRxj/2mtNvTi+i9/NZEAm8fhA/WcuT0eS/y/n9lVS4Uevi/lfcNiqAObVpswGLhJ1DgdNr
 DiE7wsWzzTSQhu3qhnvInK2i/zRoU9QU8DSLttUFRZWc09A/Vsk6xg0B9eiZx3DtkEVbh9NBs
 ZwUAgz1x0dHOOm/BLRuFp6a3P0ZTjd1t+D0h7iXeeh13twFM7SEkBDRfrt4Vab6E5yET76TJN
 AZWpbn1NAhFBPHPBQ05d61a/GBAVa5LcVy9YNeja28oT0WuDKSgnuJ5OPYRhj6WC1g7gOcnPW
 mnCcSjlBufYhDE+ks1bWt5gNUCOlVqSugYKSYcgZV+ThlhUtcFktYowkE4yt+8/b3nbw0ZRXT
 vwjHctwg9Sg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I try to stress SmPL functionality in this use case.
>
> That's not the goal of the semantic patches in the kernel.
>
> The rule is fine as it is.

I am curious under which circumstances other software aspects
can become more relevant (as suggested).

Regards,
Markus
