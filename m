Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB88C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 15:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EB5208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 15:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="d2x1JE0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfL1Pkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 10:40:46 -0500
Received: from mout.web.de ([217.72.192.78]:52443 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfL1Pkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 10:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577547623;
        bh=YFMosZ3KSjH/9NQAwyfAzyn6J9r6yetoddXRUSTzSrE=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=d2x1JE0jM4GIDLAUndF8n6y2VLw0yjyqENCBdgehyxiiw5j/A9524BoW2xKCUWuwt
         Aau3mb8x28MpQ8XFUiR7GgItUQ6DNsEPgyTK8CexaEQvLJXPTDspd2UsEit3rSF4dY
         jOa3TcSs3MlJZXm7adeVaMyv6mHkGHVKskPfzn4Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.3.151]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgOCo-1j5U4v1VBu-00NeTt; Sat, 28
 Dec 2019 16:40:23 +0100
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20191226221354.11957-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: Warn about critical clks that fail to enable
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f3c9ba97-2058-a315-d00a-b2fb159cb888@web.de>
Date:   Sat, 28 Dec 2019 16:40:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191226221354.11957-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Cu9EAHDijdHP9sATOEASk+mpN8+JwxaKzV8XQV2jSSr4Zn9FgKk
 flurxrvvSKxFm1dLAxMYi2iUZJ4KNk6QA4S7T/8FvKMTBEQpjgUTPJ89O7BBsGUL56jUx3S
 OgLwiOxbLdGIY/VgOqWIUX91RoFCNuTbPKyK7ERo/yMmC0qf9s3bdHL9tESDrkZ/RBNZctu
 mX+Y73f1Mh3ShoefpESGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B+5ZSgloTkA=:cTzd9fXeJ52KFMOcY3Jw8o
 URgpjcGIUNfqAcyIwo56rWyKi5EH5Tg3rGaxNGQZ3SxtjaFVVBveCEyPTxSCNS8420+geeM+r
 X6+TIZvAN0NoZBo9aQ1P6/M4uPQ3dPV8hxToqbXdN7sYm426xYJqzxeEiPgd7GdUKCq2zS1pb
 oYw0d9FRv8sG9cvwQ5YgtHlJmjgs2xSeEZxvyc2GpYwkrVGKOM0ya+e5a9KZhJWHxdSMTfJg2
 gpBJYIKEeo71wKSwJmweGMEeixyp+ToyHZvxRMJXCboKf4aIemD+m8idMAXfZ9t/Yjh0KwQYP
 hiCmBRTjMKiDYuJqrpeSaZA+CZ15ivXwmG4WRd09Y6LgBSaXSdvakNeoT9pLeRnbZyH9gpTsW
 ZD4Irr8fUdQshoR8fJx9I/Hj810LfoelfDbPQZhFVozwKfzoJA0pt/QP0S0JqGX3/A+g9dxVN
 iOcmgHBGCA5EXA3qF5kvjtcE2NBx1vf5oc/hXCxboimqclsbqZCsUECcpyGFm29qknKDHS82o
 2gnv89xTHJ5RVFD9yFWlviU7WSc7xh3PfXZRRepBxlSB9HT78HUVvDPoZJKOa/ycO2lWn93Y3
 0UPeZzee0/iZ9ZllIeWIOl7cqF3VzPAbQWOL9u41JwZRYOwpM+xrEpwZn8LDkvwBZvY3J8ujZ
 qYsTWps8Sswr2Kl3+N3cYTAhZ7ZQXu/CrsWQsC0zSouHicv8z7H8NXhhE8KVusySYo8h3DRAw
 gjz/GjBSGgy7NNJXs1Br/12bcBiExrlrw9cIdl3H5/JKf0PkB5/biOvCoAXAsJpQzJ31ZdccB
 yjS9cq/ZFpRIshLIOZk6wD5qsNtoq4kauhWT9XR7wwYYvGfpnsL3QYVqdfzP4nZPb2MEedmfM
 JgR3Y+cq3SjqyuthahJP8PhX1rq8W2zOvA8qJiji0LHWNYqm+7rG0iOXSNOkzBii5pfp798Oj
 9RjeNaaNkj2e7N7Grc0Oy1A/Q51BGRMz1wYp3Pf/y4dPcZTYWR3wkxTfSTP8t/F8JdEm5jB+U
 1FGrGHrcH63UoY13S32QuKhQ8eTPRenW7bY3eoAFa2hC7UR3v2y+XQjhwW6u5/cxBvMt5eCr1
 gUbwiLlDn/0eYcYqwuHDTDcroIK5N8D2b6JvRkdO//bagbiuB5Tn0OFzX9bMLOnjh0o3O+Ja2
 Eh8W/yW/7LTNhvYAk2rvhMh7nFn0t9QxIjrvrRy837F6OX5jCcfkt6M+0Hu2GlvgfwiXIBdP4
 AFHa+fFr8n/xYbbAl7YONMNf/2hi1pHoHWWRPdPUfR6ujbBLFy6OQKjE1SFY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If we don't warn here users of the CLK_IS_CRITICAL flag may not know
> that their clk isn't actually enabled because it silently fails to
> enable. Let's drop a big WARN_ON in that case so developers find these
> problems faster.

Would you like to avoid an extra warning for failures with non-critical clocks?


> I suspect that this may start warning for other users.

Will this software development concern trigger any further collateral evolution?

Regards,
Markus
