Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1FBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B4920818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRh9sxKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbfDJMmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:42:06 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33478 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbfDJMmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:42:05 -0400
Received: by mail-it1-f193.google.com with SMTP id v8so5450574itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 05:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60XcXPsm+dtKDfUFB9wye8yUy/nsmA6xuJqh8jSnVdg=;
        b=gRh9sxKEoQUM6WFgnq2G3tzQSF7a9XI4s8Czx9/Aevt0ZVjdnMdZmD1U7HZ4Gcwzh/
         3NUht8muq2dpA1PBE4Fs1r9nLdTOULuFwXYnWAaM2bxUbuHAHdnIqRVgmT8tklMvlG4c
         YTGqfL65xb7//Q+iZl7MnX7D7KAArdF8/GG7eS29MzPUBo8F4psbDbfJV6Y9aKSeRZIv
         Y5WYQlkc/iixNeO+jLYXqCimwz2vX/IwFMupc5hnTUsOtuHRFiJsGJxm/a/LSfSR3gty
         3J7TWsXaDUpDjfEircAAVAdAvgE+B6Ih4wbZJI7wKX/SKB+DJgg9nVWS2B4vuBk/9KCb
         kI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60XcXPsm+dtKDfUFB9wye8yUy/nsmA6xuJqh8jSnVdg=;
        b=qBEYUsIwRHLm9lllWZnOcJ9dLV4IQ4fFFmcSGDF4eSmHpkFYoDkc2oEbUgqlRv9mzY
         alE18hLtQ0VjRQux3uk7tVKemnlmfG4fPlx6Gp3zCOz68awdFwF6IIHfVtB6QTKSnOTC
         CNNjEYlz/SJPIlXuX7Qn+BeKsR5l3u99SnbdhpogchHYW59kX52GLlETmGhyeKfA70vJ
         jXmUybx/vwD61J+/LkxDiv70vEnHw9CM71LzsrHWJwmrdFFIxLMD6VRqUo5SqY4JuCG5
         ju6KUVCa8S+Ywf9+6502XjS9ZK7JdKhbijg/YEAP9+BtdFHFzZZ+4sVh3yPsyJaadzfF
         11pA==
X-Gm-Message-State: APjAAAV37eNTon8zUpFCiTvKggZyzwIZaKdfdfhsmQ/HLhlH9uJWG4DX
        L70KbhmAJ4OC3bQ296897A4pnK+zOxXCy4adMHKlKg==
X-Google-Smtp-Source: APXvYqxgjKZbsw/A+DqY/mGORXNTeBZm0FXSScUk7TecbsMfdkynCe1EQp4TdD+wTc27xyG7hNivYqgp/wX3cPf4heM=
X-Received: by 2002:a24:3d8f:: with SMTP id n137mr2876577itn.96.1554900124555;
 Wed, 10 Apr 2019 05:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000051e9c2057d31a563@google.com> <00000000000036a4a9058619dff3@google.com>
 <20190410002603.GS2217@ZenIV.linux.org.uk> <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
 <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
 <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
 <5c581e6eadc946b965e3138c9daffda75b1fba56.camel@themaw.net>
 <1f1d3b95189b6b8acfdf61dd05a804744791d313.camel@themaw.net> <20190410121159.GY2217@ZenIV.linux.org.uk>
In-Reply-To: <20190410121159.GY2217@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Apr 2019 14:41:53 +0200
Message-ID: <CACT4Y+bc=A=djKChMkJGwXYbZ7UXuxmRu5Z0Y1BEXAFH1-Z6Kw@mail.gmail.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 2:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Apr 10, 2019 at 08:07:15PM +0800, Ian Kent wrote:
>
> > > I'm unable to find a branch matching the line numbers.
> > >
> > > Given that, on the face of it, the scenario is impossible I'm
> > > seeking clarification on what linux-next to look at for the
> > > sake of accuracy.
> > >
> > > So I'm wondering if this testing done using the master branch
> > > or one of the daily branches one would use to check for conflicts
> > > before posting?
> >
> > Sorry those are tags not branches.
>
> FWIW, that's next-20181214; it is what master had been in mid-December
> and master is rebased every day.  Can it be reproduced with the current
> tree?

From the info on the dashboard we know that it happened only once on
d14b746c (the second one is result of reproducing the first one). So
it was either fixed or just hard to trigger.
