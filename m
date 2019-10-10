Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91988ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5654F218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="BAilBDlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733147AbfJJHiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:38:10 -0400
Received: from mout.web.de ([212.227.15.14]:52717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfJJH0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570692351;
        bh=URPzwdq5QRFI0wpUi5CUlZE+boxu7v7c5HF0H21uNI8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BAilBDlmRAYd4TbEUOfa/WEwTV6TbW/TtlmRthHySaLcoMWxnnOjDamAS9IcRWASw
         YrD5K11r9npCsStaQ5/bYb1Edvtc5s+AuQDYA91jVYR13SHtJCfEfWgJw6QwdTqxeU
         DCrzvfcpC1NCBD/qPF0Bs9vFT5MlSlgBHhyaCblE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.64.254]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mbdf3-1iZAKp3hyf-00J36z; Thu, 10
 Oct 2019 09:25:51 +0200
Subject: Re: string.h: Mark 34 functions with __must_check
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel-janitors@vger.kernel.org, kasan-dev@googlegroups.com
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <20191009110943.7ff3a08a@gandalf.local.home>
 <ce96b27e-5f7b-fca7-26ae-13729e886d46@web.de>
 <CAHp75VdrUg6nBfYV-ZoiwWhu6caaQB8-FCSeQFH0GrBX33WhVg@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <359bd081-44fb-e9a7-8ba9-bafeeecebc25@web.de>
Date:   Thu, 10 Oct 2019 09:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdrUg6nBfYV-ZoiwWhu6caaQB8-FCSeQFH0GrBX33WhVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:foB/0idgGkWa2ab0un+ubrR3nFbOcepkKguwEx1GoSMNY40iXY0
 dALqet59vl0aVi2yt4YoqieTFH/m8MA8UZb3RmJFY0ZVkZicm77nKx6hTkrTwz4Uj4/RIPF
 9ybgAvIs/p1ln2/uyj3bim8I2YenqJrPhww9iXnVhtI6xi8lHASzHfcP4gJ16JqD6xkVICn
 +KI/+GO6xW59PMzfgH9Mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yz/aZJCbT+U=:EKBUuu5lulTyfCmit5Peel
 IUxccESV+IC43UOD5fjNXmc4aBfII6AqX2rhPQIXqXadVyol/a/EDBXeDv2PHi1z6TNadqYQ5
 8jlMAZamV79pO/Ulm46pR4ct9kjwSpQRHu9yDDYaDAkHrEYt+IIwIfTHGI4G1sYzy+ak0CAJp
 5WQjLFHowEpH1zFO3BG4t64awzXbPuuYmea5dt//AsdbEmBurwA87g9yZDa6VQc6K96KcnPmc
 /U2xm/9IyUliCk2R2M5dCbospDn0az1sjEWkNThlH8jbwtWLJrrDjJmk84oZEb+KPOR7KJmBr
 oUp55ZJRmqY4cyHpHX68D//Y425BaxbTrpzJn3IeR847yd4YCGBZcQQkT9g58PPz05NQs6bSR
 PTC/YlbpekvCbBRl8K/JWRNwcncGEiP8WvtRgIyddCx0GTV5WL1K7hImODC9fCw4lDtRX60K6
 5NPjbluQKZ1l1JRUubR3D79Of5iysDPJ7GkAI6q5gBsIM8bHaiEqEJC0o068cs1nPFSvmbhGv
 YW9hVxO8ujSWHMi63PMmHXJ+8WB/bj7O0xx+oKvFFAJgVs66LH8DOuuuYS89Foj7ISj4FohCI
 zDbL/pxt2jYrAYcCnLVaGrVlBphM7heXa1ktAGRB8LKhNeYYAaFZ5vtNEloQF7O6PbVV18t2S
 rB9CRH6kIXZ+0UXccQ1/uY9PUZ+u1LsbWakQiEqx9DGl9xUY++22tIJWlJkP63f3t/f58kfdz
 P3U+/uolPDVOZXzdGz/XqGUaRnGR65Zkofbf7ZrEeUABZBnsg8wTG90NRaAJwKy0piBdGukIU
 1aC+DtcE5zY/8YSYSVlwaDsm/GjXHqDdUEodyhhyTAquxOxldqf+g1gttJRwf95j9OxGJGPIn
 11NSzr1s/bSYIvPi9ihY9+jc17nYNmpQxQfefZISwt+faYTmBbK8k5/7wyAzOB89o5pOrIDKj
 r0FJKPgRZeTIv34PA9p24JwECjRwXZOOktf+F2p+IO8FB7PsjZlB81RK/7eqlb7O5SvQqhrqW
 zoRwB52QBq7MZ94MRoISh107ZyFyiV1SvWf0kiVX2TJasWN1s6ZWnhim5qOu+nM6zgkY5KtaW
 rPZM5qiL+uiLJrc2H/1CtZZ3Py5OIPvyP+UJQPal0AS7ZEjB8USM1uUGtIdExFegZ0putf63y
 D+9n+I5fC52jbW6Mbmd4sFhh7VkPAd1Cc1o2h09qWJiTO6I9eQSsorqZgEIjFBxn3BEkGbjQ2
 Z7M3jTLsPmyzKh9R8bnkkK75+kKdDZlG5PeDbAky4sMajm+TgocOgT4wS/vs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/lib/test_kasan.c?id=3Db92a953cb7f727c42a15ac2ea59bf3cf9c39370d#n595
>
> The *test* word must have given you a clue that the code you a looking
> at is not an ordinary one.

The proposed extension of function annotations can be tested also together
with this source file example, can't it?
Other system configuration variations might become more interesting
for further software components.

Regards,
Markus
