Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7529C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A059D2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfCZIlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:41:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40195 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbfCZIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:41:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id w20so7077043qka.7;
        Tue, 26 Mar 2019 01:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsvXmJOm0pyAEzqJwh7QrRIEtsG70UpLjTLyzkR25QM=;
        b=inGHnAWdZEHqVyzAUkaVa09dLWCrDcQma/jIwKLkmdlzFZV0JFjHkNEYQatkdUn3MK
         CuIHcEaZopxd/nmqihAFHAzjIRPJu6oxonVrCAIXxFhiMd4CLM1qs/nvL9TXGhMvgY+K
         hzsJo5N6hhUXBrpkzZBXJSvPkRXP1IsuHuPi+PYq7iKF/bW9hg84QppRnc5WxsfNHdta
         JQBCvgVbVamPvTBFzUgvmzMW9Cy+G+57FolnWxE5mVuXFxIydohCUh5tM4sizyxzg0mC
         Q1+mLfHhWjVGdftptweKD3WkEhsP7XY+XYQoEc5o68roMYbhlDVW2kjQIoiYHVdm8vHZ
         rubw==
X-Gm-Message-State: APjAAAVlq05eoaMCMIjCmy0LkrUOUcVimpsX4d6nwcyKYgz5sm8Mk12D
        2N6ruv3Fldr7vJGn+dA8esN3lpcFN6DP5amtYhY=
X-Google-Smtp-Source: APXvYqzWbuWCanAHJozGrgBku0Nl3U4qpb5NhALU98xKcvW3XcvnqLpIieND44urCirxL5XGMyEfYrhtUAoIc81gmlU=
X-Received: by 2002:a05:620a:133b:: with SMTP id p27mr23057938qkj.173.1553589674188;
 Tue, 26 Mar 2019 01:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190325143521.34928-1-arnd@arndb.de> <20190325144737.703921-1-arnd@arndb.de>
 <20190325173704.mun2cj2ulswv7s3i@pburton-laptop>
In-Reply-To: <20190325173704.mun2cj2ulswv7s3i@pburton-laptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Mar 2019 09:40:57 +0100
Message-ID: <CAK8P3a1dVLdL_oM8iCGP1R0SG=4BrrsPSaTare5NN5WLxJb_Uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
To:     Paul Burton <paul.burton@mips.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 6:37 PM Paul Burton <paul.burton@mips.com> wrote:
> On Mon, Mar 25, 2019 at 03:47:37PM +0100, Arnd Bergmann wrote:
> > Add the io_uring and pidfd_send_signal system calls to all architectures.
> >
> > These system calls are designed to handle both native and compat tasks,
> > so all entries are the same across architectures, only arm-compat and
> > the generic tale still use an old format.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >%
> > diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> > index c85502e67b44..c4a49f7d57bb 100644
> > --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> > +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> > @@ -338,3 +338,7 @@
> >  327  n64     rseq                            sys_rseq
> >  328  n64     io_pgetevents                   sys_io_pgetevents
> >  # 329 through 423 are reserved to sync up with other architectures
> > +424  common  pidfd_send_signal               sys_pidfd_send_signal
> > +425  common  io_uring_setup                  sys_io_uring_setup
> > +426  common  io_uring_enter                  sys_io_uring_enter
> > +427  common  io_uring_register               sys_io_uring_register
>
> Shouldn't these declare the ABI as "n64"?
>
> I don't see anywhere that it would actually change the generated code,
> but a comment at the top of the file says that every entry should use
> "n64" and so far they all do. Did you have something else in mind here?

You are right, the use of 'common' here is unintentional but harmless,
and I should have used 'n64' here.

We may decide to do things differently in the future, i.e. we could
have just a single global file for newly added system calls once
it turns out that the tables are consistent across all architectures,
but I'd probably go on with the separate identical entries for a bit
before changing that.

     Arnd
