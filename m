Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E6BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10B320821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfDPVTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:19:37 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56331 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfDPVTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:19:37 -0400
Received: from [192.168.1.110] ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MOQyE-1hUCrY2CDO-00Pvzl; Tue, 16 Apr 2019 23:18:14 +0200
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet
 card
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <20190409144250.7237-1-TheSven73@gmail.com>
 <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
 <CAGngYiUTHZFFY=H7xXHzZnN4pS0jAqWBTrcw04hjf5S-ykxC9w@mail.gmail.com>
 <c1831703-a476-8870-0a5f-9060bda0f669@metux.net>
 <CAGngYiXx2eKR7DnHm9sNWVC+B1F2N6uUNXqZAq4rey2yjU1RyA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net>
Date:   Tue, 16 Apr 2019 23:18:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiXx2eKR7DnHm9sNWVC+B1F2N6uUNXqZAq4rey2yjU1RyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RGPLo8WHxqxhqmE3Mc+YjEr2v/x9cw42b/xKtJ0io9QhRAGNNto
 6JnAqbe6JtVzBaV/MW/lw2kH6K71VmnLlhgYJTVlrMAVDdI95ie9ZVz8F+kvvRj3wovXCTk
 KH0ntayGAXgnzrUE9eSZT0OaH7dezhY3CONiA0hrx9Iy7e7kkR9FvvVji6n2sBJhKTaEuEi
 R/BfrzYuWRJctPtWpRbMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zTW+RHD0ooc=:c/dsLFZuMsMQ2EiAOGUlM7
 B0OwAhDbwry1OvnG/11cPx9CLuaEX5Eu+o6n3PotkOpQPSFKgXhPrqa/HXaWyk9tst3mHXLRG
 rtCMaJwLkdxauQmpxwqEq6AHUrHNTpH+5R83uEoZrrB+aTsqRItACO0ZukjIYZf1gfMgoydmt
 ATfxU7kTjhGZr60Qj0ISJyyzbA2N9zxKivEK9jemd1Tz3MvP2MDjBRBQLHwAzfkFFZYV/Ktc3
 JLe/Oifjb1TE6hHqcOF2oKNI6lMgMbSoFVlHXcregAH9MJLt7OmtPwIGl0VH8DAPKjxs8O2ZM
 o0CoUGH2AezjTBw6p9U+vePUUNIEkQBdLT2fTn8kym2WUYTTOdo5IT51l2GE5b6/MzxQyozVt
 EXi98kB3ObI+niL9sFyGPPhjzD3jCn2SqG9w3kbG0/30dvAi1lP1g0YVJdX/PL9x7HyN9sZgY
 Suh5vTZxo531sGIKpAHFN+F8k4DcuuQ5aFCQ4j1ziviQkOIGBbRswK4w4tb0LUac2UxEHgtCc
 V+fEpwTDtal0wO9HLuj1JEOfvDyFTmbhQAOqNGcNKogojyO0Hvchen9XLkceVkjj6gFbbEnBQ
 VsM8Bb3zPoerJqxS5J5UIGnMrwZHEWmpbu8ZPAIDvarndTig6DPl5QXkc262LjSwcsM9yrJ8y
 ejoDokJasgK/ocNhM4jgkg7WpK4tmiSfU6PSJ+u0bcT8zRC5lxOoOXQQzWIIs9grck9KF1eGD
 HtfbQiP26eh7kR7lCdLP9EiHCFXJ1UsKPOPvP0GyC16fQsSas/lLWcqzPt0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.19 20:56, Sven Van Asbroeck wrote:

>> By the way: any special reason for doing this via device instead of
>> socket (like we have w/ can) ?
>>
> 
> A fieldbus_dev device communicates with its controller through a section
> of shared memory (process memory). It just felt more logical to model
> this as a device which acts like a file. When you read/write the file,
> you read/write the process memory underneath.

Yeah, that sounds logical. By the way: could we also mmap() that device?

Okay that's just a purely academical idea here, but I'm curious whether
that would make a notable difference in performance.

Yet another question: does each fieldbus_dev instance talk to exactly
one plc process memory, or can there be many ?

Having separate device nodes per plc process memory seems a good idea
for finer access control (via chown+friends).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
