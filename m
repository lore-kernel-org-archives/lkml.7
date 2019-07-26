Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02E6C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDA7218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Bp1MCjWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfGZGQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 02:16:56 -0400
Received: from mout.web.de ([217.72.192.78]:48605 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfGZGQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564121808;
        bh=FrcG3p04fIitLIwigeGwouiENcjUSoUx3KXHO3QV4Us=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=Bp1MCjWbyUuKhcEuvrsmhyMGgn8WPLfMXcB3jWlD4nSLl0LJ8gWBIXbGmtww4qMwE
         TMvIAu4cqTqOuK10pR3RkwSyTV8XZ5rDT0d72nZcTnc1UStciBzkJoCqqVrOslWyF/
         JMK3TlA/jyD4RlwudJU6VItjbNIg1+3qvrGrcA0g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.64.49]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7KZO-1idkzp44vO-00x3Bf; Fri, 26
 Jul 2019 08:16:48 +0200
Cc:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Joe Perches <joe@perches.com>
References: <alpine.DEB.2.21.1907251747560.2494@hadrien>
Subject: Re: [1/2] string: Add stracpy and stracpy_pad mechanisms
To:     Julia Lawall <julia.lawall@lip6.fr>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7a0c4d94-5d35-589f-18b0-f872e74aeb45@web.de>
Date:   Fri, 26 Jul 2019 08:15:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907251747560.2494@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hbcGm1Ak31Ab9v0h76YAREy7FxvswT4BbJPXAdG5YgUY+4ZRwCY
 atE/36u/mRwbHNS9sVp1+xIaHIn+brp8FYa53Ux+lvzfVatzWq5TJx6Hbm4SKLzhAlxpOVo
 +QIXO4roQiPkEfpX21MlHdztQLpFaAf3hRk1Z1HJjMa3le18R3q0jEdRmW+QyFzxG865+si
 ez2L6PB2hPN5Ou11ajfAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1e659nt4ySQ=:a+a+EgutKMssEJYppze6fv
 TXBKCaiGL6LulQQ6woBS8kTye9yZaie4B/uwMOUmZtomgpRGku4v2P7sheouK5XpC/tQPzP+/
 tN3Xhc7FHgO92bCNt6VPX/HUhLE1lwSgGQaHVRxYD3EncRfuclL033losnmuPzuannIueLK3N
 /NQgBdtHW4KWtikjy5JhxLtvNRlNLwaw+MwyuBz6v+cliuBUsijABkcEiMLWDVIP+/Ms/X89j
 lqydnbtAjXffv1hIXO9zroIq6tE9pTwnwhniK0t6KYXaPoJJcZKSFhJAjAQdpx+FCw0gkJaXU
 Ci/6hdtwXBco7M+FCOEbQYo9KGz/Qdfs0HwOC9enGzZu6n4+D8QiAZaosC6UF+cPpqLsB2uRm
 UKB4VkZ9ZpwkKQO6LrovEi9/cMHrxm0vqzS1Z6R3q3eJsWlq8oFI22dXC03jBEU4EmSA5D3es
 szFfL1mR5SjjSfcj67JOmRuBprEsuPV2+LXeXezrBxF9utnvXK8Nh5q8FMsXWd92xjOsAiINi
 RzGJNyhL0o72CeNBebOe40Lhl/mZ5FYXF6OGlVHXtNrA52nP6Amwx78rs0Y0+n6kDrHQMmn+c
 97RzhZuoFy2ezKP9D7PuI+9f5UpWVJaFDVPJ1Wz20EeLrXZLFFNA++zETPnnXQAkOvTDfrcAR
 xM36mKMNpwc1iGknP8nTeoD0ZCamXSVGllmHDV1FnCFd8d4Y438mu93HeyQbwQPiPlY17X+p4
 baE4eqpWe1Z8ZIeKA/N1plnR5z1mqJtRQztTeiDoLkVPe62Gp80NUOiTHXc7VmwcyeX0vkT/F
 oqUgm9M5O9Bu3NM4WR0sYO0msUkyxgeYoUPKAyf4COLBf38AaXwRVv9b158v2230fZrqDaT4f
 yPQ4n1hu0P8WGQCibcELfq/dIKH8ojDh+E0fH/Cesx8PZix4r1aVfIlXjXuO+nxNYb88Fl7op
 trk53YrNMgHbOtUf+687U2Dp3DxuI+vftHo8oxC2gs9OdaXCsoC8WMcM8YJMOqvXUWSh022yY
 GXsYEm1iPDLNxfSYWg+Wo6VhnUJmRPUZZlbu9qwboiGlWigChhcdVqO/h7HrOaUJ/pc9Vw943
 LgymgiVBO86RykCmAExkkAlKMItSnzgbX4A
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The rule now properly checks that the third argument is the size of the
> first argument.  This made a small reduction in the number of results.

Thanks for your SmPL script adjustments.
Will deviations from this restriction become more interesting?


> \(strscpy\|strlcpy\)(e1.f, e2, i2)@p

Would you like to take the function =E2=80=9Cstrscpy_pad=E2=80=9D also int=
o account for
source code transformations with the macro =E2=80=9Cstracpy_pad=E2=80=9D?

Regards,
Markus
