Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A03C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1015420850
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 07:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lUZnuFAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGGH4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 03:56:21 -0400
Received: from mout.web.de ([212.227.15.3]:59177 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfGGH4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 03:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562486174;
        bh=RZuegKnQZBE0fRTCBplZrfIRKxZU10eJaftbP6wky/A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lUZnuFAf8hFeJAY3ZyqkhJzybuE8E+QcWqweNzIH/RBtxKmQ76JT+i+C3o7u6th54
         yRqay5CoXC4xhTjO2VzIFXQd55UvrWg/Cy2N9dK0TK7CbUhSfrYwP/XEq1+jqUcTlh
         v9V6wYpFP3THAlrARhyQxis1b7G9wsuydEmlHBqA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.61.32]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZliY-1i5YWJ3J4Y-00LU0L; Sun, 07
 Jul 2019 09:56:13 +0200
Subject: Re: [PATCH] mfd: asic3: One function call less in asic3_irq_probe()
To:     Al Viro <viro@zeniv.linux.org.uk>, kernel-janitors@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <01f6a8cd-0205-8d34-2aa3-e4b691e7eb95@web.de>
 <20190707005251.GQ17978@ZenIV.linux.org.uk>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4b06e2fb-a0ba-56e5-b46b-98e986e6f2fd@web.de>
Date:   Sun, 7 Jul 2019 09:56:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707005251.GQ17978@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k7mpQjf5K+BT5ovyDPDaVPMQEr3jIaPICBqQc5fK5UoEPEm8Joz
 YvyIac+o+OTi6oyAvLmR2x/7dhRSzUlVhqP02x2PPJ6FytescEQWXWcCOqC4FG01Eap88PY
 ih4MTz2Ru43N7VnOgjaBDSybhiCJV8ZhS0JJKtHjNZhrrVWU00/LCmWt8Hq6UHNRcsMsxfo
 iVrTRhseeEtI4MODdzaXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kt8Xuw84ONE=:8nKHQDex1imEGHmpxyZ6P1
 AiPZmFD3/420gQJ8KjdKgJQceE8od7uKOWYU8D01JJEeB7/R5IzsX5g2NG7m7Y9AlNxHrBWh5
 XVdO2/ARkj5TGjTbE2d3ik0REqo5oR9lVXE+jcBN53P75ssOsC5QhA/3CYxbyzobQ1tiSZfQ2
 DX3lfmzkI3qehhSq6SMcGZmDyY5gwZtFV3HfxObJgbqhTLijVGd1JJPelljnVj943cyXxvRHk
 +nffHXhj9TTkmsk0in9kHTY2OtclhOSGEyLZ4jHiZnhnoOdJuocgnLuIfwIna8zhBbgp3r1zL
 yOfB4tWS8EB+vL1Tvw1ANTmI/BIlA8W6XPsJHq0Q1da7A/0JpC1xYVfGr2tStOgwJjjMViQ61
 L+zlNFq9tVplmjea0BpOt7qVlpe0FaeftWJolDBcDkZurT4S2YD/6yIZXXIGndWvghpzFfDnc
 wSaHO5Ru/n/tq0B/PBkOOzTteBWm1iQ+CXzWJTy3WHFWXuHS0hak/MV1aS9CoW85UBGltqXoQ
 0w43JoK4xxN6XnVnu0MbdZ2Q/Y8z7HmWwO1jMulihD7TAMvoRF306hyal2WlJVCz377qAsZVz
 xC3QEJwu93flFE7TfYEN2pEUAUgCP2ej6pBC+dopfhVYYL8lOxkA6fxwOM4lotJNnFbSE2hLV
 OUGa+wAwu6+58zLQrvOGlgi/ulakf6ak54l4r9uxNWrhofzFYIiJt6WnXKKirepB0B6lPypja
 H9F4rXiZVSRAYw/VfymdoLJNNAwVxa/y3fpsxVmLkm7vHWd5QJV9vQhrZCRZ9jNyDPMbRiAmj
 edfXYr5YcA7T4UYylXK0s3dsnNvzth5s2fciWuibkWATSvWVHSqT06vZWtHS8I00tkyxjNHsV
 sfRRkxHJJ0QmaKH+zorXWQC7VLy0YICHPTNipG1irD/oqFkZ9GxY85YNjedo1pCUgJF+6TVWo
 wjWPdZY1Up97RghPXxv4xfPhU4lzykwHB5UOcCyY1ez03mt9MjUcMrJz3OOslxXRzE7w3aYIY
 18pDizdcoHjHDcf1Zqj9zfDJgFi5VgqmtJBxK3yJ56ezEyqCmH9vkBTe88hc1R+3vMAbNatDR
 /h71IvKQHZ9LKCyznhicTPcP+kQsFwzbc6r
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Avoid an extra function call by using a ternary operator instead of
>> a conditional statement.
>
> Which is a good thing, because...?

I suggest to reduce a bit of duplicate source code also at this place.


>> This issue was detected by using the Coccinelle software.
>
> Oh, I see - that answers all questions.

Obviously not so far.


> "Software has detected an issue", so of course an issue it is.

The mentioned development tool can help to point refactoring
possibilities out.


>> -		if (irq < asic->irq_base + ASIC3_NUM_GPIOS)
>> -			irq_set_chip(irq, &asic3_gpio_irq_chip);
>> -		else
>> -			irq_set_chip(irq, &asic3_irq_chip);
>> -
>> +		irq_set_chip(irq,
>> +			     (irq < asic->irq_base + ASIC3_NUM_GPIOS)
>> +			     ? &asic3_gpio_irq_chip
>> +			     : &asic3_irq_chip);
>
> ... except that the result is not objectively better by any real criteri=
a.

We can have different opinions about the criteria which are relevant here.


> It's not more readable,

This is a possible view.


> it conveys _less_ information to reader

I guess that the interpretation of this feedback can become more interesti=
ng.


> (the fact that calls differ only by the last argument
> had been visually obvious already,

Can the repeated code specification make the recognition of this
implementation detail a bit harder actually?


> had been visually obvious already, and logics used to be easier
> to see), it (obviously) does not generate better (or different) code.

The functionality should be equivalent for the shown software refactoring.


> What the hell is the point?

I dare to point another change possibility out.
I am unsure if this adjustment will be picked up finally.

Regards,
Markus
