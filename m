Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27674C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC32229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nJdgpky0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfGYOsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:48:23 -0400
Received: from mout.web.de ([212.227.15.4]:59371 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfGYOsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564066095;
        bh=ZGc3+N0pW5ueN0sRPsYp230D9y2xvXwE0YZHGvxFPQg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nJdgpky0DzmcrVMRrzkes9pSCC2tyftGMPxk1EG3wGiVrlH7xrRcEn/rA6SDDJXXe
         U90No7l8TE4fFTVnF77h38Ft4kJxhen3v2YDU4Z3KYZ+2lKZ+65hGW6ayXxSoKy0zB
         UeVF1pLhJTnKlD3gVzu13FqCXXZzcvzSFjpbCwzs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.39.22]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnjRP-1iKWoK0Ubn-00htAF; Thu, 25
 Jul 2019 16:48:15 +0200
Subject: Re: [1/2] string: Add stracpy and stracpy_pad mechanisms
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Joe Perches <joe@perches.com>
References: <alpine.DEB.2.21.1907242040490.10108@hadrien>
 <7e489aa8-95ea-b3b0-9023-ba284212977f@web.de>
 <alpine.DEB.2.21.1907250847440.2555@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dc4cae24-ef63-ab04-ac93-23e3c9038827@web.de>
Date:   Thu, 25 Jul 2019 16:48:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907250847440.2555@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:VFsEeizNzPEBoWfAA9wqzOS2UGurRFAkG5Yt0/PiBVTB+dTTC7W
 pccK5WaluYdbjTq47c1E/riz7Y+3m7Uu/bGVty5pyc5Tv/eawoByC3EuIUoOngcCrGSCMhg
 R/jauKzqHXMpHqA9qzjST1UKwxhcwlQREjFqPzqauLazNrSsdTCyZJcCiqFUmKDUe5x+3Ng
 ZxMSq8/Ezy27XP178kFIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Te4bNh+wi2Y=:qV8HAQnDJQcpvIN7dPVcgR
 kpP/+DtQEaeJSpk2sOjwcUXiK+Y8JR0/loFNfkPn489grAFHmSxXNkjmgoacst8OIdFza9q7x
 +Z4XaWVHR1p1WmGrnqDz5MIk+hCecrNte/LtNsvRto/sDLS6fIe9O2VWRbXhyouFkKys2xgGB
 y3gZpXcPVDSILyvIAZRcM0WfXvTaCyzmQBxq7q2nRaaS7nwHZojbcpjqOPpih2SE/I55nUW9e
 kg42qaCsYN3fUiaXKANohcFMqsSt7RDF/ujvsvac0RkGyPuUVJPd40/HSp5cKtKiisPrP/l/x
 Za+oFVhfgzCSy4/nAu1f5/CSUT1DyPWbWmUryigvxBY7ndjMqdB0MiBYVvQf1AIaLw9uXHVUb
 OAQGPdMMQ0pK8gJedP70hKxhmsi+aYR2hJKV3wRb8eXpalZo+87f79tPU0xVjo8cEWcBh/PEP
 GkiEBTz+VQnbW3Aqp3GJsnBtaM2sjBH5SKXcPMoe9wy4O4HS1d/c8IClZijaVQ+sZV16rkt3T
 T+KXxIzBjauwWbP8Do0825XOsLlL0FqRo4yyKjSMmufazT0YQP8aF+R4kCM3om9o3vrIRjKSv
 mRLExFtrgWIQU7KBHFvRuv+eBkflIx2+u0NYLXYoLR7I0q+cvAQk6b6GO9e4+sqEFijercBbT
 k9xLDqkVDgRUpbpjd1Hu4IFMnpVeSTKQd0A2HwtJwJmzN4DWpTAJA2QwrACywB4lIVQUyAU1k
 /QAMw5zN9ecD/zvvrMrztkbNQcMX9ihB21bOFw4skizOB0zm6dSe01meT67f2lz/Y1bTUuksh
 ketc0u2vP0ULd/m1qWLxvWG9J1cD8dTOsJdnCYaNNTVwqjil61tU1rK0mhp7lCy5XsezI61ur
 iaNQ0CaMBxKKKTSACRvpJSbAJhv+bHIiPzB+DiivpJLiBJIAqlTEXREMuIRuJchofL5EiadDZ
 XAj3T4Lw1hUqClhLOVO1ttpOnoreFTBmPtnSVoe+yygfL6sZYPqT0s8VDx5HpXmZPaHufIWFX
 oMLETpXo9/EkILd/3qcO6OxGTUbUPjeLP6CmEDyWy0PNgNOKRZIclsPvCBlZyn6Wb3KJQ29rr
 IJM0Y4u70bqLChOpiNiGhDi3KxkS3Dgp6+i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Huh?  Rule 2 is important, to ensure that ths size is correct.

I assume that the dependency of the replacement on the data structure check
can become clearer.

Regards,
Markus
