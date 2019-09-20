Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BECC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85B0208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569003307;
	bh=vLyiJJvz7ISbm3S2Sr0M4Bqq7lvAxI6bmYgf2YXrx5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1faruws2A5lE3BLLxvycSVhBZ+Ujg2ZnMZVNl0CV1w3Lw3t8BjZpstwgRPq+m6eb3
	 wAoJ/bISRVnP/juAjD5Jt8fkYL6QsqXbPigE3bt4EKnd/VKkz8CEAtWUsVoYOPy7st
	 CePVkgNB7/HeqVTFjGZ7KzU95DQqZ5Bq+5+lS2rM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406314AbfITSPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:15:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41274 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404946AbfITSPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:15:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id f5so7960039ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zt1SAAFEs8ODGQeBze+y3jkP3GGDWb6CUJZJ+mep9IQ=;
        b=BsWbLr4w/0GDvh9Ak8RFLIst3kS16o2QLFg9WZj4E50GhmHASYFPC7ui83Iczmw1Ri
         jYHP2sgVjW0qSCtVtqmf3H1cJVLPDAG+fC7X0/HxU15K1OFCjiu+JyzQZfy/KKGn1mHN
         dFhnS0YTcemB+7Lffoo7831CoRVoUMp47IEP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zt1SAAFEs8ODGQeBze+y3jkP3GGDWb6CUJZJ+mep9IQ=;
        b=Ws2sa3dtocwt+p8bVClV7Vdy1ezK995wJNX6Rcv6yD1iZLyIXc8ZYJRNvWhPbqJj65
         bqV1YO4tyWCXh8ioPrFJhItR4VCP1IuXMyoOGmjEQtwug9woqkBzO/MuHFXMaxpb/vAF
         M8vye8GY8SfurUm+4sioCMuqHUnmIfVm4nuGGdbN1W/NolnSLNb/D4x6IAiF7kDJNAp4
         xMHd3eBxlT29SyqRVrrByS+OJYyUJxj+m4acLVlevpJlRT+YcgwpygE0sWyLQAZ0k4hm
         hxwSO9e7c/syOkEGy0AC1Cd/ZOt/HiAnsdAAlYG/O5pdsoMU/snziVwN9ptnh8XWHGZ4
         T97w==
X-Gm-Message-State: APjAAAV2JfaCfRJYXT3AmJ6XhZkzPdAqDPASEDzYFKHL5kd9O0aYHgEb
        zqr2keB7xiYfOVsWoYlsRyg+DEG+7eU=
X-Google-Smtp-Source: APXvYqzWsTqh4jsx1LWgKJRADd9jaxoDqSYYlT2NX7QVgY/HIaGKV8+MpVecEcpNd2muWfsBtzKPbA==
X-Received: by 2002:a05:651c:c4:: with SMTP id 4mr7675030ljr.111.1569003303219;
        Fri, 20 Sep 2019 11:15:03 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o13sm604507lji.31.2019.09.20.11.15.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 11:15:02 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id r134so5655811lff.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:15:02 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr9438094lfe.79.1569003302026;
 Fri, 20 Sep 2019 11:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com> <CAFd5g46b1S5TZYGMP4F2f3Xhb1HrYTUFBOEK5gXuMBFEkzhZ3A@mail.gmail.com>
In-Reply-To: <CAFd5g46b1S5TZYGMP4F2f3Xhb1HrYTUFBOEK5gXuMBFEkzhZ3A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 11:14:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whr5K4ZH2K9pj=PZNWbiHfuz4noorjJa746_FOxLAgfxw@mail.gmail.com>
Message-ID: <CAHk-=whr5K4ZH2K9pj=PZNWbiHfuz4noorjJa746_FOxLAgfxw@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
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

On Fri, Sep 20, 2019 at 11:03 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Fair enough. On that note, are you okay with the `include/kunit/`
> directory, or do you want me to move it to `include/linux/kunit`?

"include/kunit" should work just fine for me. At least I didn't react
to it immediately when I had done my test-pull, and it doesn't change
any auto-completion patterns for me either.

[ We already have two 'k' names under include, but even if that wasn't
true, I don't type those names anyway so I wouldn't have had
muscle-memory for those two directories in the first place.

  Under include, it's "linux" (and to a smaller extent "asm-generic")
that I autocomplete. ]

            Linus
