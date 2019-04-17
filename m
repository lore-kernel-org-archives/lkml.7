Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04ADC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF69C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPjjUbff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfDQEDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 00:03:11 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37908 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfDQEDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 00:03:11 -0400
Received: by mail-ua1-f66.google.com with SMTP id t15so7460981uao.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 21:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OeSDb76FNhCX0/esdhaT897EOeJUyp1UjRNovx9ZTJk=;
        b=LPjjUbffdmnWOijAdM/PiprjUruScHYJKJPEJvLACuMe71E/zOTgncbvh4rw8PUo5Q
         H1nDdBU+Rg0ePdQPrOs6TAxi39dXiYZPjjgGRlmOsfeRcFCIDLzIwEEb7e+sqLZhxXYF
         zrt6axKConEoFzSp5rjBvi50FHg+TYwjr84eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeSDb76FNhCX0/esdhaT897EOeJUyp1UjRNovx9ZTJk=;
        b=J4Q4mGvDQzYDHC2L96QmCfJarcgpeSaoZA34Sovrx7yUQNKqUJnGE6ghe2piM4SNAs
         f9ntwWjFMb94IKA7aRDWkLdwqfNYt8OIrhUL1qVRtOwhi+Q6ssI01HM1rQLdh4gNEbBB
         m05zUJ9NOU+LDxet9TWFGTF9OtIi2QKhKkresMOaTBxldx8tQvRpU7UaeeBGVDAA7sGj
         Ck17JruNfsHDxNZ0TpBoVtU7ffqNm2sk9hPvMO/6kLdpRDNULq7q5PSGzQKDXHc5QEJm
         aijkJV39GC6vnrO5wbx8pTWQ/iTrTKru65WPxUlrTK78BhVnPbIJ2UUvpI564InXMeU2
         u6Bw==
X-Gm-Message-State: APjAAAUgW2OxVkavSlbTHmdmEIi02A7F4jv6SlGUYJ890TVmX80D1ZwU
        H8UhrLYmzL4aeKLpkAK6szk9wveJ4lE=
X-Google-Smtp-Source: APXvYqzaJ7TGlx3ITSoU+PCza2x9w/PgRMQMT+T4qpvL+dZO+SXuTcBOU8RNoYMZDM7X5T+F0hTF/g==
X-Received: by 2002:ab0:2a4a:: with SMTP id p10mr22628070uar.90.1555473789368;
        Tue, 16 Apr 2019 21:03:09 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id c192sm47074358vka.10.2019.04.16.21.03.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 21:03:08 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id d5so7460421uan.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 21:03:08 -0700 (PDT)
X-Received: by 2002:ab0:a97:: with SMTP id d23mr26964819uak.99.1555473787484;
 Tue, 16 Apr 2019 21:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190415143821.GA46880@beast> <20190415170604.GA44415@lakrids.cambridge.arm.com>
 <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com> <20190416170808.GC54708@lakrids.cambridge.arm.com>
In-Reply-To: <20190416170808.GC54708@lakrids.cambridge.arm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Apr 2019 23:02:55 -0500
X-Gmail-Original-Message-ID: <CAGXu5jKJ4_uY45xJV_Fy=Q7cJzmJz9pZVRFJG0U-C3h95OiZzA@mail.gmail.com>
Message-ID: <CAGXu5jKJ4_uY45xJV_Fy=Q7cJzmJz9pZVRFJG0U-C3h95OiZzA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:08 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Apr 15, 2019 at 10:22:27AM -0700, Nick Desaulniers wrote:
> > On Mon, Apr 15, 2019 at 10:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > It would be nice if we could simply rely on a more recent binutils these
> > > days, which supports the generic S<op0>_<op1>_<cn>_<Cm>_<op2> sysreg
> > > definition. That would mean we could get rid of the whole msr_s/mrs_s
> > > hack by turning that into a CPP macro which built that name.
> > >
> > > It looks like binutils has been able to do that since September 2014...
> > >
> > > Are folk using toolchains older than that to compile kernels?
> >
> > Do you have a link to a commit?  If we can pinpoint the binutils
> > version, that might help.
>
> IIUC any version of binutils with commit:
>
>   df7b4545b2b49572 ("[PATCH/AArch64] Generic support for all system registers using mrs and msr")
>
> ... should be sufficent.

This appears to be binutils 2.25:

$ git describe --match 'binutils-2_*' --contains df7b4545b2b49572
binutils-2_25~418

Documentation/process/changes.rst lists 2.20 as current minimum for binutils.

Ubuntu's old LTS (Trusty, Apr 2014) has 2.24, and that release is
about to exit support this month.

Debian's old-stable (Apr 2015) has 2.25. It's about to exit support
when Debian Buster releases.

RHEL6 (2010) has 2.20. RHEL7 (2014) has 2.25.

It seems not unreasonable to require 2.25 at least for arm64 builds?

-- 
Kees Cook
