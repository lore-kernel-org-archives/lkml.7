Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0670B20673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569249881;
	bh=/xY/+Y1KJgdlQoWjT1bCJhEKDRfQg6YydKvYHyp70HU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=i0viP1ZIUtmhxOe3c1g5Dt+qhgF+9qTaxtyEFJSbUOY5kLp/mhorz5WdcSV8he10n
	 8OwbMXtMFNJ4J6iqeZafooGRnT3ylh9rOm9WCZBCejlxsJ4F/t+u9W8V4razqG42z3
	 N3zgB6GFilGK/zQUJnIHHHorDbGSx/Hinco+vi3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440019AbfIWOok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:44:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44921 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437697AbfIWOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:44:39 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so33975574iog.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7IY3WfHR/RHwzLSdcAp2xrnv8k5NJEy3PyaVmfv4CDY=;
        b=NQ7ZNPV8IVbnPn1nKeczSvWdIziO7/LvkOpRdtfn7jjcfCmJd63EnpzPiyZak1/PA1
         PCepRjqBYRV249u0xy119RiiVRrbQnoewKvKDN2U/b/k/jXe+1AcSfJJemdKfTF/C3Ji
         rmsB1NgrpiBiQvGfWkKTemBKK4IGpSYPKY4A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7IY3WfHR/RHwzLSdcAp2xrnv8k5NJEy3PyaVmfv4CDY=;
        b=KrM7VbptcnneHsOCepF508MLVLJ10TA391UdquIxbl7bVfNndVhnt+FY+5dP4fY7O1
         33zBz9HEnjR8uSAsJnxHgxqG5qpSTglFxQyByIPBpnHMFx6jTZDfC46SYmX27OCsFwTZ
         kiA3GhVxh9vh0c8pUZl3DoSEHiL26vtMQwA4WaCvyqHJb9kJlCeeFCHkquyq6rsyk+ue
         fXJosX33Fvvl3XK1ojQ/HYJwjg64ZZQeoCJC1CWgj2cwhG3n2D5EKOaVOr8dkkDaKn66
         GBxwroSdUeTYcTSSup8hS6bvkJ/0wr1BcRqUO0w2/u8una7VjMvbJbvccsGroNwdia++
         BUVQ==
X-Gm-Message-State: APjAAAXxIH74bOHEFm1GzzT7y0qXQfjL00ZdNySSLb1xKjisGlyj2DvX
        ez0WE8oCLETXogp2tephnvhibw==
X-Google-Smtp-Source: APXvYqybAlJF5w6qEKsknpz6oEPoDndN/VoHitulS16OkFb0EfO8MLKYb6kdbgZ9Y3KL54FOS7PMgA==
X-Received: by 2002:a02:6616:: with SMTP id k22mr35837275jac.129.1569249878822;
        Mon, 23 Sep 2019 07:44:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a25sm6058452iod.62.2019.09.23.07.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 07:44:38 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com> <20190922115247.GA2679387@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0ab5da69-e4f2-8990-20f9-354461235581@linuxfoundation.org>
Date:   Mon, 23 Sep 2019 08:44:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922115247.GA2679387@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/19 5:52 AM, Greg KH wrote:
> On Sun, Sep 22, 2019 at 01:25:55PM +0200, Ingo Molnar wrote:
>>
>> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>>> On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
>>> <brendanhiggins@google.com> wrote:
>>>>
>>>> Sorry about that. I am surprised that none of the other reviewers
>>>> brought this up.
>>>
>>> I think I'm "special".
>>>
>>> There was some other similar change a few years ago, which I
>>> absolutely hated because of how it broke autocomplete for me. Very few
>>> other people seemed to react to it.
>>
>> FWIW, I am obsessively sensitive to autocomplete and overall source code
>> file hieararchy and nomenclature details as well, so it's not just you.
>>
>> Beyond the muscle memory aspect, nonsensical naming and inanely flat file
>> hierarchies annoy kernel developers and makes it harder for newbies to
>> understand the kernel source as well.
>>
>> The less clutter, the more organization, the better - and there's very
>> few valid technical reasons to add any new files or directories to the
>> top level directory - we should probably *remove* quite a few.
>>
>> For example 'firmware/' was recently moved to drivers/firmware/, and in a
>> similar fashion about a third of the remaining 22 directories should
>> probably be moved too:
>>
>>    drwxr-xr-x    arch
>>    drwxr-xr-x    block
>>    drwxr-xr-x    certs           # move to build/certs/ dir
>>    drwxr-xr-x    crypto          # move to kernel/crypto/ or security/crypto/
>>    drwxr-xr-x    Documentation
>>    drwxr-xr-x    drivers
>>    drwxr-xr-x    fs
>>    drwxr-xr-x    include
>>    drwxr-xr-x    init
>>    drwxr-xr-x    ipc             # move to kernel/ipc/
>>    drwxr-xr-x    kernel
>>    drwxr-xr-x    lib
>>    drwxr-xr-x    LICENSES
>>    drwxr-xr-x    mm
>>    drwxr-xr-x    net
>>    drwxr-xr-x    samples         # move to Documentation/samples/
>>    drwxr-xr-x    scripts         # move to build/scripts/
>>    drwxr-xr-x    security
>>    drwxr-xr-x    sound           # move to drivers/sound/
>>    drwxr-xr-x    tools
>>    drwxr-xr-x    usr             # move to build/usr/
>>    drwxr-xr-x    virt            # move to the already existing drivers/virt/
>>
>>    -rw-r--r--    COPYING
>>    -rw-r--r--    CREDITS
>>    -rw-r--r--    Kbuild
>>    -rw-r--r--    Kconfig
>>    -rw-r--r--    MAINTAINERS
>>    -rw-r--r--    Makefile
>>    -rw-r--r--    README
>>
>> There's a few borderline ones:
>>
>>   - 'block' could in principle move to drivers/block/core/ but it's fine
>>     at the top level too I think.
>>
>>   - 'init' could in principle be moved to kernel/init/ - but it's not
>>     wrong at the top level either.
>>
>> The remaining top level hierarchy would look pretty sweet and short:
>>
>>    drwxr-xr-x    arch
>>    drwxr-xr-x    block
>>    drwxr-xr-x    build             # new
>>    drwxr-xr-x    Documentation
>>    drwxr-xr-x    drivers
>>    drwxr-xr-x    fs
>>    drwxr-xr-x    include
>>    drwxr-xr-x    init
>>    drwxr-xr-x    kernel
>>    drwxr-xr-x    lib
>>    drwxr-xr-x    LICENSES
>>    drwxr-xr-x    mm
>>    drwxr-xr-x    net
>>    drwxr-xr-x    security
>>    drwxr-xr-x    tools
>>
>>    -rw-r--r--    COPYING
>>    -rw-r--r--    CREDITS
>>    -rw-r--r--    Kbuild
>>    -rw-r--r--    Kconfig
>>    -rw-r--r--    MAINTAINERS
>>    -rw-r--r--    Makefile
>>    -rw-r--r--    README
>>
>> I'm volunteering to do this (in a scripted, repeatable, reviewable,
>> tweakable and "easy to execute in a quiet moment" fashion), although
>> I also expect you to balk at the churn. :-)
> 
> I for one would love the above changes.  And I'm the one that has to
> deal with all of the backporting issues that arise with stable backports :)
> 

I am exploring the possibility to move selftests to a better location
or add a git alias so it can be found easily. With the addition of KUnit
and future work that is planned to connect kselftest and KUnit, it would
make sense have selftests to be in a location that is better suited than
where it currently resides.

I have been getting feedback from some developers that they would like
to see selftests more visible and easier to find.

There are some dependencies (unintended, shouldn't exist) between some
tests and content under tools that might pose some logistical problems,
in addition to the churn of backporting.

I haven't explored "git alias" yet though. Since this topic of moving
came up, I would liek to get feedback on selftests location in general
and where would be a good place for it.

thanks,
-- Shuah

