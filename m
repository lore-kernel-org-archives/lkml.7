Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6485ECE587
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994A4217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc5vafav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfJOHD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:03:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39324 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOHDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:03:25 -0400
Received: by mail-oi1-f194.google.com with SMTP id w144so15880125oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 00:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=13osAZM/TWZw15Dwa5x3pSEX72ZjaF18KaIgtXYzLRw=;
        b=Nc5vafavPRfAueLZxe8oXGABMAyjchteIl0+yQafBzUScmrKh4p8py+RbSHD7RD7bk
         BQ5G97XV01cN2dw1wm1Gt/2So185REO5m8W5nuvxBFgB3rRFzBvAWNYvzhyPBmNtZxCD
         NvS224G6UnEFc4AJtY36IlffxumsjrkXkpazPoNvxUj+mXMp09jGeKJs16HyOaexKaxs
         s/LA387At87pndv+F2yqZ0Aa0m1hMPw3q7ofqE2+1x3aKX6JLecU8ZrSPPceyCW2Ulj7
         WrUyjZBpbFNNaquz9OQQLCAdHauVLmE2R1nr30sqGsYX+qj1KKuVdAjjDpVHThhUA5lr
         3z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=13osAZM/TWZw15Dwa5x3pSEX72ZjaF18KaIgtXYzLRw=;
        b=OvGhMCZGnAMqx3CZRk5BFDlR5u4HYwHplCFmUe23T/FBgQzDXcMonC2YSQxucjzpGb
         QWA1uO79rYJzWA2UEFV2DNvtYZhJkBlD/jW8+g78EN5duHtpgdUvSUpqxm+r8IgyuOhV
         FPiHlVWlOMS4QcTUUXiIYnV9c40WRWjA0IUwi/N5PJLwmMSprmZZqM0NahLd194znIc0
         4wN6Sr8K/ASC3YZudDK3q59sYgRIrbx/FwUVv+YYhbQjO5c8j2lJRret4rhHaM5gME3N
         hNpmv+weN3aN/TNvIT++zIXg++ol/tJDHlO4HGFjExqfFNq6JTTw/prWFbp2SSH1cAmt
         inDQ==
X-Gm-Message-State: APjAAAV10POvZwviiV+Gyz44h1Xld2mzLQcxoaghesZJalamzCMGACk5
        Fll6jaeKZCVaxc+Ud4zLTN9h+ythNj4/omNZXVM=
X-Google-Smtp-Source: APXvYqxsrNuGZhuo3h3fPzYjCSKnATOshU1Z4AY/Ar7OdRgQ329oHWAUyF68V6pm3co4FNrmMc+Of5Z1ZqXfiq7gAeo=
X-Received: by 2002:aca:3641:: with SMTP id d62mr26021866oia.99.1571123004824;
 Tue, 15 Oct 2019 00:03:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:648:0:0:0:0:0 with HTTP; Tue, 15 Oct 2019 00:03:24 -0700 (PDT)
In-Reply-To: <20191015064801.GA104469@owl.dominikbrodowski.net>
References: <CAFjuqNh1=B7Ft6v7nzo3BW70EbAvK=Eko_4yqrJ4Z4N3w_Y+Xw@mail.gmail.com>
 <CAFjuqNjLJw8J0nU2oo8rDfDUBavHLC7D0=AAwM62tp6=kHHk-A@mail.gmail.com> <20191015064801.GA104469@owl.dominikbrodowski.net>
From:   "Michael ." <keltoiboy@gmail.com>
Date:   Tue, 15 Oct 2019 18:03:24 +1100
Message-ID: <CAFjuqNgxAuf+JTkWqhimDspzPd0+s5yGJro=Zi164uoxu4CmOA@mail.gmail.com>
Subject: Re: PCMCIA not working on Panasonic Toughbook CF-29
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, Morgan Klym <moklym@gmail.com>,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your prompt reply Dominik, I have asked everyone in the
discussion on Notebook review to gather the information required and
either post it there so I can reply or post it here in the list if it
is from someone in the CC list.

Also thank you for replying to us all and not just on-list, none of us
are subscribed to teh list so if a reply is only on-list none of us
will receive it.

Cheers.
Michael.

On 15/10/2019, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> On Tue, Oct 15, 2019 at 05:04:28PM +1100, Michael . wrote:
>> Good afternoon kernel developers
>> Please accept my apology for contacting you directly about this. A
>> small group of friends, some of whom are CCed here, have come together
>> to try and find a solution to a problem that originated with the
>> demise of kernel 2.6:32. First some background to the issue. We are
>> all users of Panasonic Toughbook CF-29 models (ranging from Mark 1
>> through to Mark 5). These Toughbooks have 2 PCMCIA card slots which
>> are used by a variety of people for different purposes. On the CF-29
>> Mark 1 through to Mark 3 these slots work without problem. On the
>> CF-29 Mark 4 and Mark 5 the last known kernel the top slot worked with
>> was 2.6:32. This has been confirmed all all major distros by most of
>> the small group of friends I mentioned earlier.
>>
>> Thinking it was just a kernel config issue I did some comparisons
>> between Debian 6 (Squeeze), Debian 7 (Wheezy), Ubuntu 10.04, and
>> Ubuntu 10.10. On all machines both slots functioned as they should
>> with Debian 6 and Ubuntu 10.04 but the top slot stopped working on
>> Mark 4 and Mark 5 machines on the next release with the next kernel. I
>> also tested Ubuntu 10.04 and 10.10 with the 2.6:32 and 2.6:35 kernel
>> and both slots worked with the 2.6:32 kernel but not the 2.6:35
>> kernel.With my comparisons I merged the config from 2.6:32 into the
>> current kernel for Debian 4.19 and rebuilt the kernel, no matter what
>> configuration changes I made the top slot still doesn't function on
>> Mark 4 and Mark 5 machines.
>>
>> This issue, and its apparent start, has been confirmed on all major
>> distro family groups. So this brings me, actually the small group of
>> dedicated Linux users who own Panasonic Toughbook CF-29s, to contact
>> you to ask for help in resolving this issue. I have some questions,
>> and I realise the 2.6:32 kernel is long gone now but I'm hoping this
>> is not a lost cause, what changes would have occurred between 2.6:32
>> and 2.6:33 that would have stopped the hardware working on Mark 4 and
>> Mark 5 CF-29 Toughbooks but not Mark 1 through to Mark 3? Would it be
>> possible to correct the problem so that the hardware on our machines
>> works as it should. While we are not kernel devs or even programmers
>> we are enthusiasts who love Linux and our machines and we are hoping
>> that together with you and the kernel dev group we can fix this issue
>> together.
>>
>> I have attached various tar.gz files with ls* outputs so you can see
>> the information we have so far. Thank you for taking the time to read
>> this.
>
> Is this with 16-bit PCMCIA cards, or with 32-bit CardBus cards? Either
> case,
> please provide the output of
>
> 	dmesg
>
> 	lspci -vvv
>
> and
>
> 	lspcmcia -v -v
>
> (ideally all for a working and non-working configuration).
>
> Thanks,
> 	Dominik
>
