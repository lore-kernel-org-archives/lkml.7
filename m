Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E00C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF1621835
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewmmEAJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404285AbfITQfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:35:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40717 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfITQfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:35:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so3430247pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ut91GscP6XLibdVcHru7hVB6OigJ1obwmaUA419NO4I=;
        b=ewmmEAJggE6Gu5gv9nuWkGHEl7zAqQAL51IBQ+0JuOcXfc4aJFK0Pg0lW0R1RpwPtA
         NHBNZhy1VI5QGpzQFyOn+PQ+uymEEZ+ymNbNzbHXYFl5gzryMC/DMMmV6HNqXX/FkpxU
         h4G3O2UU33dZCH/lSqL3V/EfLtt3oRbfuV6bTpGgrIqefOlDFJdd/mSS4sJrFu+LWb4T
         +C9WIq7JJP9uU1E1d3D153qm3dqqq+w65cvTcC7EgBv/CGhiaqNEeYLna+qk1zHVOG08
         CUiUWaqT2L58txe5eAWCeMyuyutx0tiP11CzNW8Auzh6SmD1XfUeL9BkwOfGM4uXlxKz
         wEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ut91GscP6XLibdVcHru7hVB6OigJ1obwmaUA419NO4I=;
        b=pvaHO81+IDj/t9UT+f1as5AWQpv5WfDXw4HYmKZ5YSnGrdpv2tl7pNQWijHajKKurt
         BbuhgGOQsGI7mbhae0blWoZc9Ds8cWPuOjmxVArzW6dP4eqIyOIjHALZPiCn5b6QA/HD
         AMQoecRcNMD+zG/vgrjkkdjgTOJmPwXysQn+IfEaIJzYmrqH4/JxDiZMDMscn6jAYwKW
         lkPG3IpMkHlCXNvIJwznwoWbmOkD0EDM/HwYFYdSaqGXvFHm34aJLrblVbAwC7ZJ/8ad
         eLweyG7T9ZiwU89+nuBVa7JG0otpMCamyKqc4K6qP/KRQzd7xqiKXcV10b1qfGDa4ZVo
         38Qg==
X-Gm-Message-State: APjAAAXIZeIj8qGVAYTMGK30rpn3zf39uu1YExOpvQH9YuBT5KuwzS5q
        avSzTkFnNV9cYnqmT0oMWUqXnNltz2EUb13L+5asjw==
X-Google-Smtp-Source: APXvYqyclMRLHSpJm5RmBZhd2T6hJ6JBkUDAy5b6WWYCrTVqYKMdG4lpaeYsrmN2jjbgbq045mlPoSbQ7+GtMvBQ/cs=
X-Received: by 2002:a17:902:ff0e:: with SMTP id f14mr18119782plj.325.1568997317338;
 Fri, 20 Sep 2019 09:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com> <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
In-Reply-To: <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 20 Sep 2019 09:35:06 -0700
Message-ID: <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 9:27 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Linus,
>
> On Fri, Sep 20, 2019, 10:18 AM Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> On Tue, Sep 17, 2019 at 12:26 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>> >
>> > This Kselftest update for Linux 5.4-rc1 consists of several fixes to
>> > existing tests and adds KUnit, a lightweight unit testing and mocking
>> > framework for the Linux kernel from Brendan Higgins.
>>
>> So I pulled this, but then I almost immediately unpulled it.
>>
>> My reason for doing that may be odd, but it's because of the top-level
>> 'kunit' directory. This shouldn't be on the top level.
>>
>> The reason I react so strongly is that it actually breaks my finger
>> memory. I don't type out filenames - I auto-compete them. So "kernel/"
>> is "k<tab>", "drivers/" is "d<tab>" etc.
>>
>> It already doesn't work for everything ("mm/" is actually "mm<tab>"
>> not because we have files in the git tree, but because the build
>> creates various "module" files), but this breaks a common pattern for
>> me.

Sorry about that. I am surprised that none of the other reviewers
brought this up.

> On hindsight, I probably should have run this by you to get your feedback.
>
>> > In the future KUnit will be linked to Kselftest framework to provide
>> > a way to trigger KUnit tests from user-space.
>>
>> Can the kernel parts please move to lib/kunit/ or something like that.

I'm fine with lib/kunit/.

> I will work with Brendan and come up with a plan and send another request early next week.

Cheers
