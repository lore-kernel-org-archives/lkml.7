Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F82DC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D1E206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jQq+MOd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfD1KxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 06:53:23 -0400
Received: from mout.web.de ([212.227.15.4]:44965 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfD1KxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 06:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1556448782;
        bh=VcRprvV/dMaL6b3Dr3KhYBwaWsXl6uDkktmM6g6TuB4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jQq+MOd81HcRXs+gmolkLC/OvIBRjPVbJbBfEwoT126ddUbyjmPm9KI+9euQri1MI
         gWXojOppQy+Qr5Qyf2daQqUNN5hRgRjtq+RH+xW3B03MtTdc0XoFxeRj+ySXEhOdPf
         +V6XUQ6790iLY8MhVss2ctqdWDTvr0ETc5ZH0f10=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.181.137]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdVdS-1gukLU24RO-00igvN; Sun, 28
 Apr 2019 12:53:02 +0200
Subject: Re: [v3] ARM: rockchip: Fix a leaked reference by adding
 of_node_put() in two functions
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1556262488-21072-1-git-send-email-wen.yang99@zte.com.cn>
 <cee2ab03-d0b7-c9c6-acc3-d5aa28979e2b@web.de> <2816348.laE8LpYbrI@phil>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <43884c4b-8146-9a35-ae5d-40ab17a4a04c@web.de>
Date:   Sun, 28 Apr 2019 12:52:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2816348.laE8LpYbrI@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LiqUMfQkL4vkJ8ENQFBp13v/swVnwrCsfL/XdpaQ8TcSkcQ7+7V
 +ujNr3XlY4zoSMZwiA9se5Iu2X/3k/R5dCezy3tLp2XHh0T7fqs1srgysBHJq/RyTaUiR4c
 njXpACenskA91l5ss809rPg7Ziktp4djkYcSnn8wWeUvt4rlE++w++EH8U+2v9V0jLGdg3Y
 DKV333tXTAaJc+T6TlanA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UChUgs5536M=:OZEf0AtUNh4rntYP76Yehg
 uOX+ttZw0ccFOm8jDBj6Fo+w6azMAIOxb+dzYMKsq4gBsMue/4hVg2BlGTkNdkRxszulZsXsp
 iajZdn2CYuIeKTCAxtGleZ0p6KrWuE4VUEvjP6AoZGG1Mrdr2gVEEL55AEpML4ufTo0NJ5yRx
 ZwZQ21ytdXiW6iRuzF9DDa8MCVPN/WE2oBRubR7izEkIHPt1V/WIsd3yv+zTfW0q/FcOGD7SE
 YfViFjLL1PHZhGNEJ4M0Q0iFs5UuJWtigVlJdcVSeuMrA4D5oUauuuom/Fhph3YQPu0Jl02qi
 g4rsfZbI1eTci7CvKSkoY4HfEAjiGZM9nHCGIIE9pcSss8HYA7uVj+sY3zQSQvO102r7JFCaz
 Ov6744aUfEd5zJ9LDdbNDBBi2gqQjoK2aUsYbCgdWgR3anbY4lrWoqEKYcT4YlKLHy2EKEXzp
 /x4FxjqwjwJXseCbVFBj0g4N+oTRPNgTRGpxWv8X9O1WXMVdfDMfbV00DnFbFjJwVdsArbqdL
 NcdlEvI7LR8Fr7fy+uJXcbEpQ1ujPsRZgIc10cRqcZwFVUFTFHDQzzhg9rgmrcitECM2H32xj
 iM5GIqxUKMYMi3bjFw5lIZe4oP2SRKtrf/fg5g5gRRP1Ct6WwOlH60U6X0gPMj4K3lZ09nMvS
 Q8BmR7bkHrP50EPcSWRbpZrCeaKKyjYHq6Id2lAbqkeMJudyZ+xCw0xeQqREknv21XZb7AQdi
 Q0iOS8RO7R8L+F8mW0NULkuE1I4WOkjBJtpHBU/s7uFQmS+joDe83XiIPwtmfjEKwXcIAFToI
 ryDpq7Ix6IqyAQfANMtLhzSV0DFVOMuw8GxRrTgo34Yu37x2gkD5VneV0dThKtKzlQdpVnUAj
 J6JJlM47A0OW+zyit956ozTgP34SwLP10fRKjkN7PgAAUP9t4KAWSXvdiLpje574DCqpttQOH
 QgE5Z4jQ+YA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>   How do you think about to adjust the exception handling in these func=
tion
>>   implementations a bit more according to the Linux coding style
>>   (so that the addition of duplicate function calls would be avoided)?
>
> I actually requested not doing wild gotos for of_node_put calls,
> as it makes the code harder to read, especially when the "node"
> gets reused for a different node-source.

Does this feedback mean that you insist on another deviation
from the Linux coding style?

Regards,
Markus
