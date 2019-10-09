Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDF7C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357CC20679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="eOyyii/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbfJISG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:06:56 -0400
Received: from mout.web.de ([212.227.17.11]:43635 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfJISG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570644378;
        bh=J7fJAFU0WNppZeYkcAIouM1fnT9CvFLDXzOYhHhXr0k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eOyyii/ErlKfknwwlNtga9/jRnrwVT0XKaCHox6jCqThp1ShZ2i5srYxseuOVWckf
         Q0FiRP0OejibNEbNIYKFK3TqdhlN1HouMNhJYFKlqeyeIleBvIDOKayfuS26wNtUKr
         MnrSb2J8bK4qmxN7BjgNOyKInNV0HqTMWqY1nnqI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.177.35]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LaCXK-1ho8Gt47FG-00lzXS; Wed, 09
 Oct 2019 20:06:18 +0200
Subject: Re: string.h: Mark 34 functions with __must_check
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <20191009110943.7ff3a08a@gandalf.local.home>
 <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
 <20191009122735.17415f9c@gandalf.local.home>
 <CAKwvOdkvgeHnQ_SyR7QUqpsmtMPRe1SCJ_XJLQYv-gvLB6rbLg@mail.gmail.com>
 <b8bdfb25-deb8-9da0-3572-408b19bb0507@web.de>
 <CAKwvOd=Jo5UkQN9A9rTJf0WtsxXNjaJ=jxf2gwHFdW8om-fbTQ@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e1859e39-22de-5693-cd75-bb67dcfe1212@web.de>
Date:   Wed, 9 Oct 2019 20:06:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=Jo5UkQN9A9rTJf0WtsxXNjaJ=jxf2gwHFdW8om-fbTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:mi+Kx8ZH8uoB1ivK9xd2iJxxpXbgnnp3Pg8J+2d9g0+pDPo8iFM
 r74qFM07vfjliJkzrr/+mYSH8G+jMkM8+2HECUJNsmXmLUUEqVPS9QWe7+GK+gNDfOlUV1b
 e7VEPAqEpwt7cP2AkGg2xVL2L5wAv4ANAFpJ2jByAkvUzNv+cyapYTXeY9ThcSsX+rUAtEd
 jrAW8KVOa0JXOdVI8zydw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oDX4w9mGaTc=:MZeAObWXddWU5pn8RAR58g
 KidCviW/XIj15u4HN758RefeYnKZdZcxREyYuX99Fta1sfLLc3oWRZg6B25Q2t2dAxad4bovL
 yDJptKKdQoLWIAQXdXz0GqM1Vrz8IFm9Kr43mSRFWwCOUgc2tpfNzeyzdl+J8IEFzzJz8cGqd
 5/vrqeP+hCtQcZF/bSsnN2Oe1/xOMmHms3bAcR3Si1WfFeu0UJfS4ccHZCoHxsZk6hSbr237e
 EtHI3JB3jN1L6kOGgTAfOArp0jBYdTgOL56JfavrhQKtwUHwSBLx16CuGs485P1YxUnmJ04xS
 l87LCQEUaUHPLpVy3eJdcrT+/rOpLXczuAQ7aa+oPMh3X3BAkYaQ2nNu8LtYuRoh0HJx7MczI
 8bcgVJQhCiiU0JWDmGahgE7lRN+8BOyYcU3Q/U42ZgegGmJey0TKLV3flFd6Tzp81JRGJNSfo
 H4IL01obzXfmNdaOkqswe1yfnnTt9CtGxnsgqsHz5sugyB3ifeVMgcD3wtQguyWznGiWsgAg/
 RX2tnhiZWdauebK8dl0GGBnnmXJZGR51ji4PRK8SLD/PsVJHNNO87CqGxDiJFSOQ3yCNR9lps
 y1wrXq9L1B6Nu8HpmdBqhJRetzwXNkxKrjTidfmz5s1NVJGyVyRDBkypzjtv/bi71OUbTuNlA
 R2j9QktjUp0X4YwSXfetYwraGTTpUIXbzPnONZnzrpof0EAx5spCaDd8rPYmz/PGrInEHWXaM
 +CCyFZKWRURxQqZhb+DWUmRYtWhfCWHHzNen72IvtgrBt75PfwkN+Nc5JaCD5RV72sW7pGKmV
 ZaBCPhgNMiZVB5goozk1t2ehNWmswSJnWy5WH2iMq63xDUgDqflq2DUf+Ykod9U6NkzP2rSXm
 pq3XDdr9SvWQOPitMyZHG63STYGyhdncC/AuL7JeegfaDwAOnf/kNiYmE4dstcZXr1Gbme6ku
 EjtWpM5ASDFFXWCt0lZNoOiQb9VRIfc9UBeWKEcMPi/6XSecmlJW74CDbYjjfT4mGmDfQkUxc
 HmI6uJBtq4UEZ/xUwGYCqjk6w1FnjoTG7hqqnCPYqkTHmP8SfU0muxKjNYaMwmJ5sPHa/S7j0
 dS7HdwvDIs+KRWYUprTZZrOQ/HveM26jShE/3H4KWhuEI+IGnxRF74OKtmen89s36yuLSWjTl
 832BTareGP57vF0EEvSSUw/gc3Mkk7P/ZmOKZvUuwmaZcNMsmXgtLoDcklfpgEzL3lisbHCI+
 LNWxcY5Fi2mFDDiE3nGZrW3jmBuvjEz3TVNotYobghk58TWn1i8uuW4EUkcc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I reviewed the functions here and believe the ones you added checks
> for all look good.

Thanks for your positive feedback.


> Though Joe's comment on the relative order of where the
> annotation appears in the function declarations should be addressed in
> a V2 IMO.

Would you be looking for a subsequent change also by the means of
the semantic patch language with which the (function) attributes
can be adjusted to the ordering that you would prefer finally?

Regards,
Markus
