Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890F1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6512B20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwiFVOfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406126AbfITSDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:03:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40338 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404970AbfITSDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:03:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so4249578pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gK7kFLJe+pM89NjvKeQysWtwG3wZP2z0shQlpPgl6kc=;
        b=EwiFVOflf5tzAjLqNkK3kkR2ysUXxv9oOWKndBskClph4lBmFow0TUyh0OW70Tf1LA
         3sqRYb1itMAANSwVXP9quVThTLYXt6as2NrjFlCBa/UpyP6b3MUcc9dldLuRtdMvJttG
         IXgf4TWginlBB9JHhLKQ/Ky12mHyer+ga2coApvwKRvJ+fR6GMYn9PTi9I/1LMdosGod
         yclpg+pcZ3nufYzw2NnvqdDnuvVuCXOEeu/ISAlEbgiUquYhy7XcnXJFkRH9qzzHeeCM
         +rJ6Yews23RtwbT0XQ9j+eTMn+gzcI7SiFLLDUMH0QYpwlgnzoR4GCy+Kj5C/g9QcDQ5
         +Ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gK7kFLJe+pM89NjvKeQysWtwG3wZP2z0shQlpPgl6kc=;
        b=rzqgfDNhy1B+oh8hmsuMqCR2LEuBKjpkwhTLzk/D948P0VI0ffQUdSCfOFaLDq6OvZ
         RZA2nlRh1afA+tDxW7mYmKD7t4rvK9E0K7hdavOzy0XX4T/OyYnd81XaJQrjs6xBFuHR
         rryBk3xfEyvrslk0x6bWez67D+sUfyBQCrJ98pm25sqR5ScCCq2VoDlHEmb7mM3pZkQX
         QZKGDxl66bkW/hC/ASZeDBHt/fArbkLKaZt1e+8kHFZbOIL9Yk4MP8kjnOjE+CaBzzEL
         YOeiYJCIr+F0CwX0JbWgRlkUAdi7nqN35xr1SwzEYnaLXYt+xf4EhtTSvG+YqiaadAmx
         cZPg==
X-Gm-Message-State: APjAAAVJIVRHvzq5jtBm6GtSa8MIVox5WNb2Qc9YU+aX2DL4UrzmrY64
        5V8OPWFQIkejIbKU6luZT7hA4DkGsWGNIaumGtc82Q==
X-Google-Smtp-Source: APXvYqwQ6zY3sPwWOcDv/uKjCDg+PYqCQgJ2T63SPJEPykY4u6DfT4CzWnJz8PL3/OlZX/U61dOcPMzA+WJ+zSxMy2M=
X-Received: by 2002:a63:d901:: with SMTP id r1mr16637421pgg.159.1569002624707;
 Fri, 20 Sep 2019 11:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com> <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
In-Reply-To: <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 20 Sep 2019 11:03:33 -0700
Message-ID: <CAFd5g46b1S5TZYGMP4F2f3Xhb1HrYTUFBOEK5gXuMBFEkzhZ3A@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Fri, Sep 20, 2019 at 9:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Sorry about that. I am surprised that none of the other reviewers
> > brought this up.
>
> I think I'm "special".

Heh.

> There was some other similar change a few years ago, which I
> absolutely hated because of how it broke autocomplete for me. Very few
> other people seemed to react to it.

Well, it's good to know I'm not the first. :-)

> Part of it may be that the kernel is almost the _only_ project I work
> with, so unlike a lot of other developers, I end up having muscle
> memory for kernel-specific issues.
>
> Auto-completion was also one of the (many) reasons why I hated CVS -
> having that annoying "CVS" directory there just always annoyed me.
> There's a reason why git uses a dot-file.

Yuck. I have never used CVS myself, but the dot-file approach seems
much more natural to me. Then again, I have been using git pretty much
since I first started programming, so it's hard to say that I am not
biased.

> So I just have issues that perhaps other people don't react to as
> much. And aggressive tab-completion happens to be a thing for me.

Fair enough. On that note, are you okay with the `include/kunit/`
directory, or do you want me to move it to `include/linux/kunit`?
