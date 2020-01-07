Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EF2C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79E721744
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LKOp8zdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgAGQvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:51:40 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41011 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgAGQvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:51:39 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so49755908ioo.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O9KthzSBlV2h+WxdbZIT5o9+mFIwnqBIvXtaw9MUgzg=;
        b=LKOp8zdmoSum2UR+j4KJocdvPfwPzYAUWFgx40En05B55RlN2LgDg43eJLuLapRLmK
         jqrNDxbw2trUmEtrDNai+RkVQgpKizgdoa4rfhwfthH/qs7bhaVMvkZUw2S7yKbGk1BD
         3dIJc9t415O6oAKL1r4bKCgQAKdoXr+NZiV6BvFNYVFSpfHVs+VDdhjiineOgb8Hdi89
         d1jpo17hiVg9EhFt32rXBXwtRpzviOxZhOvs90q29oVgZ5RzC5CrYh9JOyS75lGq/fUf
         nfAQnhU+VyMc3zGWa/kRQYj9z8/v5yrMj7fJncIYFlNgxwuoQsfLWdkmMPq/lmMx3mhf
         Ohog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O9KthzSBlV2h+WxdbZIT5o9+mFIwnqBIvXtaw9MUgzg=;
        b=LRSZxiUgrCBqB1yN2DS5huNDYR9pDJ9XZsnjLaPq5UJLyYmuno20QhVAZlgiFrRRGk
         cTDYwBPFg0zhuZw3GsE6JJa1Wgtb5zKywe9PFf+QPVdUsQMWkD/Egh+ofXnaqAhVdrQ2
         u+e/dMDYSzsuIaT49D4o4UQNwdYLBgEnMA5/iDVwaza/Dwjw36YLWh2uflc6rNCmr9PE
         ef9i8kBM+4/eibuGut7L72rio78HmhTn4OiQa7EduAHKfVlxK09G+YAj23RW40K4DGN8
         z3CEoAPenhaRy2JanEqMSObSCQbiQxq/kxvA94Scy5KyvY7srs7UJMJudpvSp4MMxHor
         d/fA==
X-Gm-Message-State: APjAAAUlzZNo1vuTNuqmUxua+saIPMLRfrixm7Njy+y5+vwf8Y9E2EuV
        18llgPcmBn+kOUJrJajTGy0zHxspG1NEqx4AMytzUQ==
X-Google-Smtp-Source: APXvYqw6U32nWtNm+ttH4lxWAxYmZl94/E5Y2ndD4ZwTAE5serAfv2V2aHN5sspi0BBZhQYntyqX6V2MPHXIxjXT0oI=
X-Received: by 2002:a05:6638:72c:: with SMTP id j12mr416220jad.136.1578415897577;
 Tue, 07 Jan 2020 08:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl> <CACRpkdZ_TroKCAnDWiY-jPbe0NL+ingm1pMLQLPxT1Uh78kx8g@mail.gmail.com>
 <CAMpxmJXikLw0d1e1Eq7vVzoORz3utEBxfG6nRmkngLqezVqtuA@mail.gmail.com>
 <CACRpkdY2NXNrAk9VY18YDeQ2WDfDfAyi4mgW26JuTPHdEOE-uQ@mail.gmail.com>
 <20200107144455.GF32742@smile.fi.intel.com> <20200107144548.GG32742@smile.fi.intel.com>
 <CAMpxmJWkKPQYAE3_JdWVkdtSZLeky=bouOyyJ+c2ySMc+1LFyw@mail.gmail.com> <20200107155854.GK32742@smile.fi.intel.com>
In-Reply-To: <20200107155854.GK32742@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 7 Jan 2020 17:51:26 +0100
Message-ID: <CAMRc=MeFOeXxy=L0i1ckxnDJESTJAdgrP7t3sqR81zKxbMPGxA@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] gpiolib: add an ioctl() for monitoring line
 status changes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefani Seibold <stefani@seibold.net>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 7 sty 2020 o 16:58 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Tue, Jan 07, 2020 at 04:19:59PM +0100, Bartosz Golaszewski wrote:
> > wt., 7 sty 2020 o 15:45 Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
> > >
> > > On Tue, Jan 07, 2020 at 04:44:55PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Jan 07, 2020 at 01:50:28PM +0100, Linus Walleij wrote:
> > > >
> > > > ...
> > > >
> > > > > Let's try to CC the actual author (Stefani Seibold) and see if th=
e mail
> > > > > address works and if he can look at it. Or did you already talk t=
o
> > > > > Stefani?
> > > > >
> > > > > (git blame is always my best friend in cases like this, hehe)
> > > >
> > > > Recently I started to be smarted in such cases, i.e. I run also
> > > > `git log --author=3D'$AUTHOR'` to see if they are still active and
> > > > what address had been used lately.
> > >
> > > ...and another possibility to `git log --grep '$AUTHOR'`.
>
> > So if some module doesn't have an official maintainer listed in
> > MAINTAINERS, we should still get a review from the original author?
>
> If you asking me, I do it in a way of playing good citizen. It's not requ=
ired,
> but may give a good feedback.
>
> > KFIFO lives in lib/ - is there even an official maintainer for all
> > library helpers?
>
> lib/ is (in most cases) under akpm@ realm.
>

Once the first part of the series is in Linus' branch, I'll resend the
remaining patches with akpm in Cc.

Bart
