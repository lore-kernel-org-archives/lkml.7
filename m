Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A611C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3181207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567811518;
	bh=fkR9sr6gxl3GSxL4t/PIfiDSXXyi7s97bAWj/nc2ggc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x43Rajt0vBrDT0eqRSdG/q8UDkoOWcfi3fwXXWTgKb7lFf2uHFPFYbbEuIk0UPkd5
	 BXgIA3pJw421RCLrtNzaHcP2SiaNQT9N/CfSNG+BvPB04Sm50Q9hv9s/FWJo0hH59O
	 hIp+FEqovsS5cZRveVJFULNsJRHEG70fPRqKYFc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392731AbfIFXL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:11:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46144 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390072AbfIFXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:11:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id e17so7406876ljf.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVhzLpIWXZ90kIidxYW+35qyD1SAOXRlNUtGI8jdg5U=;
        b=TF+zgTzArDfGwLcnkCUZZh0gUKKbEHb/QYG0xjNCbnoylW/Wbgl+TgCWehfptoGcu5
         0p5inpAsalRWuWvS7uaD1pCM6eWJ/0q3qCBWywmDC00OdRQLqVBUr9wR3VX+TNfEX4lb
         9tmjDb1UAbYO3UpakTVQz+reElFr1t84MNkqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVhzLpIWXZ90kIidxYW+35qyD1SAOXRlNUtGI8jdg5U=;
        b=PTOo7BRMiv2zRsDA1CP9ZVMKZOKk84qT0ZDqeEokd6vCwxbbxjLC/Ti6UMKZw4a2eI
         IvBjVUG27j4+s6dMJPrnTcBpeP8vTYGxrJpbNFtV/WpaP+wWRnk3sSTGU3NKXFS1/j7+
         2VorHmRop6ReK61G+Ud9zhEFcXltvSUYQo66veD7/uCrzRrarKgQrttj9rjhNKWhoVkV
         VTCmJkA7RLiANZQpvzoDiF5GhvIRwzitniNIaetYQ3Y1h7lVYfbwwgr3qHTkkOTB88nW
         1EaMsEjGZI9npAGOWcFlerC2WxJ1gCXgKWidEjQer+r/kGVmdqPcJWN1hz0hMtuEMzbs
         BNwA==
X-Gm-Message-State: APjAAAXhhsET4k3teYp2dmG8hIyh478HS6wOKayilzGLX5mX9xrNahIZ
        nSbd65RdX8ddQNZTfVdd9K59iilFO9M=
X-Google-Smtp-Source: APXvYqz8+MAlILwQ4y31uS02NRLKR8CPoOn5JATM3vvfB79cjw5dyltdTY9qsiQePD4+JgAmWxmMCg==
X-Received: by 2002:a05:651c:113c:: with SMTP id e28mr6751453ljo.184.1567811515026;
        Fri, 06 Sep 2019 16:11:55 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id b25sm1574012lfa.90.2019.09.06.16.11.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:11:54 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id l1so7420735lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:11:53 -0700 (PDT)
X-Received: by 2002:a2e:8645:: with SMTP id i5mr7177300ljj.165.1567811513530;
 Fri, 06 Sep 2019 16:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com>
 <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com>
 <CANiq72kyk6uzxS3LRvcOs9zgYYh7V7V2yPtAFkDwpHmyYcsz_Q@mail.gmail.com> <CAKwvOdkodVFxUr_Xc-qeUHnpxEmofENDhNdvCuiRzcGXQ54QkQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkodVFxUr_Xc-qeUHnpxEmofENDhNdvCuiRzcGXQ54QkQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Sep 2019 16:11:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+PD-+FEdKJuRVrrsgnFFLoAgU4Uz7tnohq_TgsEcNig@mail.gmail.com>
Message-ID: <CAHk-=wg+PD-+FEdKJuRVrrsgnFFLoAgU4Uz7tnohq_TgsEcNig@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 3:47 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Sedat reported (https://github.com/ClangBuiltLinux/linux/issues/619#issuecomment-520042577,
> https://github.com/ClangBuiltLinux/linux/issues/619#issuecomment-520065525)
> that only the bottom two hunks of that patch
> (https://github.com/ojeda/linux/commit/c97e82b97f4bba00304905fe7965f923abd2d755)

[ missing "matters" or something here? ]

If fixing two of the __section() uses in that tracing header file is
needed, then just fix all four there. I'm ok with that.

                Linus
