Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BC1C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB0422BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qdeLOGQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391522AbfGYMlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:41:07 -0400
Received: from mout.web.de ([212.227.17.12]:57725 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388609AbfGYMlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564058457;
        bh=Hw27FxLaYi5ffFA7g+fgj355c4ti6LrH7CfmS8MEk9g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qdeLOGQafB+Ou6qsfsfY7LYh8/+7RimVgyWMWxTmAjmpB0Qbq2quobID3j0ynhnOQ
         N1QNyJ5hZMJKAsln/N4b7+v0OyJkfG+vCwW3go6eQIFoUwnPtfjoIQMdTtBWmyec20
         FfCk8mCxQO+nlUr7qF9NuVLoTTn8M0ekoejJ3tYM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.39.22]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLxwG-1hl9vx1TFE-007oTB; Thu, 25
 Jul 2019 14:40:57 +0200
Subject: Re: [1/2] string: Add stracpy and stracpy_pad mechanisms
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
References: <alpine.DEB.2.21.1907242040490.10108@hadrien>
 <e3a37d93-0353-ebed-948a-991add184616@web.de>
 <alpine.DEB.2.21.1907250632500.2535@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <42a3af53-e349-6c5b-fa0f-0113fccbe9eb@web.de>
Date:   Thu, 25 Jul 2019 14:40:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907250632500.2535@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V8yVvRyx3HvDzlv9nkqUqzKC6COo35nwhRAN4A9IW4JgDZJcTPS
 tiXXpsTxxiB0bOUW4chfrdFgDxN/h888HSO2Qku7J2bgy6cUuMDhqN0i+tMH78rVRHqVJDZ
 dIYAU501zurwMCOt2+mX+1BiZophbENbzFApX8IxMHHQcPV/8g8gdlERcYg2nkxclMOdHVl
 NuY8iLkkZ9nvA0tMM5a/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fGkDaJ0qqIc=:2HcU0AiEzrotcPgaHLeu9V
 ni0RznqRBetURaKPY2VhUxQxk+B0h+TKeTnsaPJlD90/zuiI26c5CyDeVEeFD2I2BMxQbDIaD
 9DSCrACfhjVQxBJMSgVHf2YTkTgDzR21Sbrd2RgNpChERmjhvTZ6+y8e7pD624dgP7D7dS6Tm
 ZwzSLeMsDhHt73E1bXCqTXalc5y8mm3xPqAM1dbUF4Y6miqLKoXnsgUDzfNFt7upZA9hD32hH
 EDt+lmv9acVYIrBHPhZeMJw1xaekI19aJlZdqyfc0dlwjjVCnKK4g7CLAdEhACZ32Htqt3XtD
 tlTlRF6Kf4EzRJAZXpcMNjFNZUrjrtNcLEPbCSS0UxIOc/E2JxpUaMvVRHmJFxNOLNNDiWSlE
 HVfwpGrOmaQfh84mMHyvN0pfK5+uwOuT0+Tm/LP8v0Hh/Cyk+6Q7jPF5HExl6MImJtgr8IlEC
 QeRGvOcAVfPF7YZAJgbEV9uj8kQ426uhkb3kGMeVHFHOTU1UVDzCXE0JU41AgZ3teLATaowHs
 9/JI8xDiP1iZOfdeex9Vcr/YmR7ep6z38mP5Csf5MBkObq3IKCZ9c2RVY7hb16pwJBV2ue2pd
 8RMOaT1oWWLu9yOUft5CPpXVgCw3Xg6NKcuEzbHLSpoXDorHnDL4ibUARgnEcENKhECVqiab5
 Pwe2dIQTOU0Q4h7zFUT2VK8ArzhWxZ9lw7USbDsLTHWp/IjZAZEewLCSERcvOTnUFZLl11zoJ
 +8Ny0RiQRdQMpS3cva3Qp/Q3rqOhr+cDCyN/nbI7Frn/lv46fa+VMU24puYtlyQK+GY2aQ7XG
 aGO/J1VA1Bvy9EJ3GHAhsssI/xN+Vvu/2O44qsGVK+vxfgbuR+LxtQYCLrP21GBIQsndtJvXk
 FZAgSUrvRPvuyut3xSCRvLntcXZI1yEa9f2nsUXPlEgD61TjTnToKIWCadVm1TbCtVw0869rz
 P/gc9e8OzqCs4IARNQyPsHhLNId4iNvniPRf5VjG/QNgdDQJ0+JJikv75FboS8XZqCP3vYWJN
 rVcDqfBPn3c9cnQzEi+QlrGqddMJFaC69/XtO3luHoiGMJBzCb+Lp1I6RoWNIqrM/oxzykaoe
 l/zRleSATcqpt1vqrLhe3AwCXLta2GQqn4U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> @@
>>> (
>>> -x =3D strlcpy
>>> +stracpy
>>>   (e1.f, e2
>>> -    , i2
>>>   )@p;
>>>   ... when !=3D x
>>>
>>> |
>>
>> I wonder about the deletion of the assignment target.
>> Should the setting of such a variable be usually preserved?
>
> If it is a local variable and never subsequently used, it doesn't seem
> very useful.

Such an explanation is easier to understand.

* How do you think about the possibility that it was (accidentally)
  forgotten to use such a local variable?

* Your transformation can result in an intentionally unused return value.
  Would you like point any more source code places out
  where values are unused so far?

Regards,
Markus
