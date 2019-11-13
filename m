Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1381C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC272245C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfKMKCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:02:37 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:49543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfKMKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:02:36 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MnJQq-1i5QHX0JUK-00jKlY; Wed, 13 Nov 2019 11:02:35 +0100
Received: by mail-qv1-f47.google.com with SMTP id g18so548363qvp.8;
        Wed, 13 Nov 2019 02:02:34 -0800 (PST)
X-Gm-Message-State: APjAAAX7yCrHijEkYTtxKki5faVfaT/9hMAymSqjcuIPHR64yKFmaJRH
        IpWuhPwlb02Hp0Vjk5cyvF86Qz729PGdm0dEZQM=
X-Google-Smtp-Source: APXvYqxbIHpxk0EyGSyHb1LEOjNnUvGvKxcvxzDIdZZXuIRehWsSbAYkCnmOs9TK0Ul2nMncLZEPqfoW9Ge9/rMdXp4=
X-Received: by 2002:a05:6214:2c2:: with SMTP id g2mr1912289qvu.210.1573639353874;
 Wed, 13 Nov 2019 02:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-2-arnd@arndb.de>
 <20191112210915.GD5130@uranus>
In-Reply-To: <20191112210915.GD5130@uranus>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 11:02:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a03FRfTsXADH+xfLsWxCu54JXvXbb-OdyGXXf88RNP34w@mail.gmail.com>
Message-ID: <CAK8P3a03FRfTsXADH+xfLsWxCu54JXvXbb-OdyGXXf88RNP34w@mail.gmail.com>
Subject: Re: [PATCH 11/23] y2038: rusage: use __kernel_old_timeval
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        alpha <linux-alpha@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YIPfmykULQ1zK4fCM0+v3SRSEDJy816mv2/j4VwFYT5i34gtSMd
 QL4HmsWsze7QHJoImBkX5KB7kfJq+PtHLTvM1twH/jcq0NbUxIYfUzFeW9qSPEMTXggGIeu
 0IGmj3YVOAG3pVHWz4Ps4+zp4iek85QLXTAfKjuPTEQkankeP5MXMkC7D3JRZYIuX7rop7Z
 N5XvuOL9HU5Gn4ovyV9sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6TymcqjPZJY=:xKPDKgq+K9+YU+TaJA0rXF
 CNmz6Rc+4HzXN8jO3B9eQa/dtWoX8SvjrqNfLdyybDStmElrOOBG8dEe3KTAcFmbZxIctG6/u
 vaRFnmni5NbHjhUsUoC1p0pVNt222XcGY6EamNFesetUT9jHKacmd5zm7Kb4UDUs5g5YURFVW
 yXI1VP9/dlt0Ojugunnph8LDp+0jQtwDm82BUXjuKFts1+kgzwwaCDZdMAW2FI7ZgwKS/f9uO
 menFyYrp177LVpbgg5+i9OEtJoOdSES1vcBS/+ej1lMg01prJ+VwmIbT6Nz7PcaOCkHdsLnW/
 FwrABKkF1wkUOKA9qwm3d8eqfgmT12zaag6Veq4jJ4XQk75e+I/WXPQrcfe79P1+ZKeVZpHaZ
 hxTI1HccCsALBnzm6HLutwd/8XGgJ1pbbQqycff+ZSebSWRENCJMRtRQxY9q/5uPpWVhTiju+
 xzjQeY59qYB57E5kzfWl0eo+mVGLWCNtwBW0QRA6IYCz4qU0fPYFGeBV3YWjkRIwwsWLJUqkH
 yp/FTnjBiRF0WYNFG6w/4yz8XOAm4M5qPP9GuYa2ABQ5UiDvyL29zbnDIWJMSxKs1ruwg7Z2y
 3v+vKrCwbQo5qUjbLlzEmg+g9aAkH+215khbyjEfqqeTnR/ASIdgZhXirK+d6g+yZ+kMp+xwv
 pPwHom34YqKf8q16l6Zyfe0iWJ1lHOVWvciFrlgtQ0+nk/X2uf40N/vU+dWAkXyEUrMrLTPqJ
 zZf3fP0Uky4R35jBs0K9uXzM7spTJRkIL6xIRxdngfHNOY0NZUOmbkdyqiVa/jKF3Si3fp0BZ
 EKYf1waxLnfM2if9SLJAPwFGIEud+jslibyyQum3tnxdnhcjfQsB63Z0abHiQGJp9oHugMDtp
 sqISJpt2u+44RViAu/RQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:09 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Fri, Nov 08, 2019 at 10:12:10PM +0100, Arnd Bergmann wrote:

> > ---
> > Question: should we also rename 'struct rusage' into 'struct __kernel_rusage'
> > here, to make them completely unambiguous?
>
> The patch looks ok to me. I must confess I looked into rusage long ago
> so __kernel_timespec type used in uapi made me nervious at first,
> but then i found that we've this type defined in time_types.h uapi
> so userspace should be safe. I also like the idea of __kernel_rusage
> but definitely on top of the series.

There are clearly too many time types at the moment, but I'm in the
process of throwing out the ones we no longer need now.

I do have a number patches implementing other variants for the syscall,
and I suppose that if we end up adding __kernel_rusage, that would
have to go with a set of syscalls using 64-bit seconds/nanoseconds
rather than the old 32/64 microseconds. I don't know what other
changes remain that anyone would want from sys_waitid() now that
it does support pidfd.

If there is still a need for a new waitid() replacement, that should take
that new __kernel_rusage I think, but until then I hope we are fine
with today's getrusage+waitid based on the current struct rusage.

BSD has wait6() to return separate rusage structures for 'self' and
'children', but I could not find any application (using the freebsd
sources and debian code search) that actually uses that information,
so there might not be any demand for that.

> Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>

Thanks,

      Arnd
