Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E861DC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB746215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wMMj8W01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfJCVvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:51:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36823 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfJCVvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:51:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id j11so2141112plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 14:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1kLHx9hv/uJrNQB6ahsx1gOt2otfNUWLEU9WGV5Q6w=;
        b=wMMj8W01v0c6TBX4YKoTsjZXCHhuvsim3OX99DX8f1E4V2zWBe1sm2HcSU89S4dOjN
         1PgrJSlIJ9BcM7WWCgbrFJ3W/+rBDIuXdNADs+mpQJ4qK1Oy1+143AylzqaZXowCsi5Y
         46NAJayqxluDFriZNGmeN+Rokj+fB/vLXI7+nwkuZFGasXnmMRytVLW5jDwnjouAtXPt
         DPSTLiqvVyuWE4ZnFzgp9G98tThA/3YyIXsd8DwtulGKG1aGwxLkNPRY4IvRUm8SK0Y7
         m4VU3k5vjbSi0rcrbbQk20k75A1/ObNlQJKSvvO7uTTMdIxU6Vp72tFZQAVCBcfnQ//z
         f8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1kLHx9hv/uJrNQB6ahsx1gOt2otfNUWLEU9WGV5Q6w=;
        b=hZWTsMS/jmO5Hli3wwe5hQdSxcOrnqFDNLyu4JSrmPPSxVFXKxu8IWF3J8uPsYGOh8
         YhvRPUoz+slvgUGbRUp+v9C4+F2ghYR93B6JK4e9MdYhYEVYrWx5CRW1nNP26jV++oHV
         9HYEjYe3tY5sICW/lhsZMQ8LhrBUaewXEej+AJNNk2o1tGHdIkq2kQVqLZv+GdAOG7az
         dTlhC3wlbb7+KSGbd+Ux1N57+jX4FylttZumclkrBjAk9A7NVG/ZGp8SpsNYOyLj4lzp
         DL5DBrhYGT5w9aBOXCLcpXYxbOhcxGBYJUIPNPAV5WYi6kojnDaXNmYZQ7cWW7u1ngG3
         shog==
X-Gm-Message-State: APjAAAVxuroRdjiu4aDE/tOSh5w47UUvAxCaG0Cu/2dmWG0CmlEbzLlA
        kP4iovhb80gVfWx/q7v8z5i9udJlTvbIcMF460Yo8w==
X-Google-Smtp-Source: APXvYqw9MGIP2qFWRcdt/2BFhkRt7r9d2GKSY8mVi8jppDndhl/UlLNYHSE6Z3rRmjSuRnw4bEgrKNZzGLaqOx5Hhgs=
X-Received: by 2002:a17:902:bb87:: with SMTP id m7mr11548031pls.179.1570139467569;
 Thu, 03 Oct 2019 14:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191003174838.8872-1-vincenzo.frascino@arm.com>
 <20191003174838.8872-3-vincenzo.frascino@arm.com> <CAKwvOdmhyVHREHvyB0wL2GfMsE8GcJ1Ouj_8ifrR4hU8kBYukQ@mail.gmail.com>
 <20191003204944.6wuzflqkjdpawzvp@willie-the-truck> <CAKwvOdm4ccfhXDDSKXgdN4qkn2NHwAHKCwRV7OqLEG_PQj09vQ@mail.gmail.com>
 <20191003205931.d3vp4bh7wdu4oe7u@willie-the-truck>
In-Reply-To: <20191003205931.d3vp4bh7wdu4oe7u@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Oct 2019 14:50:55 -0700
Message-ID: <CAKwvOdmMMXOG_GH6-+9iJ=2-+BA-Fg+o+33nyh5m46Rh63FBdQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] arm64: vdso32: Detect binutils support for dmb ishld
To:     Will Deacon <will@kernel.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 1:59 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Oct 03, 2019 at 01:56:39PM -0700, Nick Desaulniers wrote:
> > On Thu, Oct 3, 2019 at 1:49 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Thu, Oct 03, 2019 at 01:18:16PM -0700, Nick Desaulniers wrote:
> > > > On Thu, Oct 3, 2019 at 10:48 AM Vincenzo Frascino
> > > > <vincenzo.frascino@arm.com> wrote:
> > > > >
> > > > > Older versions of binutils that do not support certain types of memory
> > > > > barriers can cause build failure of the vdso32 library.
> > > >
> > > > Do you know specific version numbers of binutils that are affected?
> > > > May be helpful to have in the commit message just for future
> > > > travelers.
> > >
> > > A quick bit of archaeology suggests e797f7e0b2be added this back in 2012,
> > > which seems to correlate with the 2.24 release.
> >
> > Cool, thanks for digging.  Vincenzo, can we please add that to the
> > commit message?
>
> If this is the only change, then I can add it when I apply -- no need to
> respin just for this! (although I'm also writing this to remind myself :)

Yep that's cool with me.  Feel free to add my Acked by tag to the
series as well.  Thanks for pursuing this Vincenzo.
-- 
Thanks,
~Nick Desaulniers
