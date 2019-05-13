Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AA9C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C221208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Su1DQ2NT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfEMSEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:04:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43949 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbfEMSEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:04:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id t22so7148413pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpu18naFWlgtTqufqvjuipZH+1ZIKrnYEDY+wCZirDI=;
        b=Su1DQ2NTL5anOFs65/rIBxXZTXEmw2eHtb7eiE+YTTvQST56qZuh6L+lUHM54HCHg6
         wF17v5K5+kM0ua5oNZ6xvy5uvAm0PmxcGJ4qwqd3yy/PUy5S0hn6vJoOgakrwb/pvQZ9
         WDcaGPYblYCjO/Nh/QPaa2f95xL2tzmtH05870FPj4yihzKn0jnKb75Z2S2jTECeIitq
         rboKd2q9m7TXeuur6IJOrTWCl1NysaxceU30XbSe+iB3vRUw+YgdptfczQnNc2y5VTZT
         KtcEaaIMJ2AsI/vdD88Jbr3SEaHmVdE7kojintJ8JAsG9Y5KjcFUshPfbV5S6vhAL4su
         Q4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpu18naFWlgtTqufqvjuipZH+1ZIKrnYEDY+wCZirDI=;
        b=Wew7YnVBqZ1hs3ztY6ukEwR087YFwCXJL3drpnQ+32zOjA1j63xdaGD9jq3z+ApO3R
         5a0dnL2sjiT3b/f8XkrcnifHB/JG+ZKuSk82E7GEQk3Vh7E9LAOpgkrJxdXrycaofNgL
         lLJLfT6PPCSPeciCuYpN5S4OBjotySKu1csHA5pKELdH79SFh+Qo1z3o/w/IqTB1brnx
         giyyXDwQmR0JGn6+ynPD8I+la3rEos8BkGcb8tv678PdLOABvsB5pIfp2zAf+daHwNb5
         EO3uisLVFDek9yZrm9d0F3/KRQVHcUvpAteyEKzOZxpMhyIzAt1S9Bj3VpFemGNClBvl
         cR0g==
X-Gm-Message-State: APjAAAWDVsX6h1R3vVcfhuDjHB/LTid+COe0wN07inpcSwUYoSWzThNe
        9rG7POZnrsrwQLALtL3jgc5ubvj7QpA+n4l3cOazxA==
X-Google-Smtp-Source: APXvYqwVTW8vU6JAo+j/Ntm2ce8nBdARuG8R4ZkpRgVCALqgjtx2IHw8MNIMajSW9V4Q7dDl4BaUNklwtBOUm3wHgco=
X-Received: by 2002:a63:fd4a:: with SMTP id m10mr33504119pgj.302.1557770653814;
 Mon, 13 May 2019 11:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190509201925.189615-1-ndesaulniers@google.com>
 <20190511022458.GA7376@archlinux-i9> <CAK7LNARB_ds9-dF9n1jHD==JRWsnPYNGoKxLqb+FwKvTTC0bLQ@mail.gmail.com>
In-Reply-To: <CAK7LNARB_ds9-dF9n1jHD==JRWsnPYNGoKxLqb+FwKvTTC0bLQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 May 2019 11:04:02 -0700
Message-ID: <CAKwvOd=+h8oxyRwPPoHajXM_JicfZ3YV2rhw6Ee06xh5=82fEw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add script check for cross compilation utilities
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Hines <srhines@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 8:05 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sat, May 11, 2019 at 11:25 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Few comments below but nothing major, this seems to work fine as is.
> >
> > On Thu, May 09, 2019 at 01:19:21PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > When cross compiling via setting CROSS_COMPILE, if the prefixed tools
> > > are not found, then the host utilities are often instead invoked, and
> > > produce often difficult to understand errors.  This is most commonly the
> > > case for developers new to cross compiling the kernel that have yet to
> > > install the proper cross compilation toolchain. Rather than charge
> > > headlong into a build that will fail obscurely, check that the tools
> > > exist before starting to compile, and fail with a friendly error
> > > message.
> >
> > This part of the commit message makes it sound like this is a generic
> > problem when it is actually specific to clang. make will fail on its
> > own when building with gcc if CROSS_COMPILE is not properly set (since
> > gcc won't be found).
> >
> > On a side note, seems kind of odd that clang falls back to the host
> > tools when a non-host --target argument is used... (how in the world is
> > that expected to work?)
>
>
> I agree.
> Failure is much better than falling back to host tools.

It was probably assumed that the default case is usually not cross
compilation.  But I think we can add a check to Clang's driver where
`if target_triple != host_triple then don't invoke host tools`.

-- 
Thanks,
~Nick Desaulniers
