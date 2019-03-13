Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742BAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8702075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kViNUMkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfCMSXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:23:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39530 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCMSXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:23:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id y9so2211545ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4GTls+Zv32EvF6vlpajRgSvLbqGR3r9e3OvYMfvjSMY=;
        b=kViNUMkc2o0pWuvL13BOJC98kvLDhNa3zcbfSXx+70MW8u+xaEAO/UkkEmdoXLKp5W
         vN4swx6xendVQjwpUwO3YSrcvf/gwTQviNGcUQHKwh+WPlb/5TO3MsocivmYhN4cNCxV
         2cWxQ3VxnVvqT3YcFoJr9jYRoYvU9KxzHzBpGHYiU8MDmvRYkyCCTX+TFA1ACOzd3HkT
         gAXgY5nsK/U69kNsOar6EQaFuL+NjLsarNdArmPahNWAM9TRrRvK/MG+ba5+rfoXaKWP
         ex2vTuzSwjuhKMuPaOfkOaJZyY4OSI6PmqHAFVcrI3ThHY8qATZmvFskoskVzojr+DA+
         b9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4GTls+Zv32EvF6vlpajRgSvLbqGR3r9e3OvYMfvjSMY=;
        b=Pe1yYv9MPUHN6l9cTHTGNSFeZ/qxhl5Qb/Hjw3TQR8yfvAbfN5G7Gy4O2ierfU4QA3
         GCubPjQ746Cz59og1kC0niL+PEoTvBjtgNSgy/aXI7CYRsoPdYL37FKUCfUUhRv82RZq
         +inXDRiAyPfbBxbuoO+gSXdF72HRQIzKqDzICXklpii+j0+pz0aTSixmX3AdIgK9/NsV
         44XsHowP2zqP27bMlGVyLvgOkcov+JpidEfyzVWcqx/Rg6DUKVQ2ACX0m3cz0JEUKtNO
         mICnTJ3jU0sDFzT2h6zHuxVj9ZaFeqwCf8HLzTfTz2nak25TWYnL+FnP8xR6K0T59fhi
         1k6Q==
X-Gm-Message-State: APjAAAX92YhlD0Z0qbNYOzGD+5KP7+6tcBGTszMc6bXezasYFunqXcRT
        vDliNJOIL9/n/E5WD8JkN2WmTyTPZcGYL3/XOsW3sOXO8r0=
X-Google-Smtp-Source: APXvYqz/82tvutr5oJvj7gLXQDBKzUtT/cXhRm7wwd4kDzNZs+9/hLcTVBaH5j/AWYIoUQR+A3TKOOCax5PCUo3Ux64=
X-Received: by 2002:a05:651c:82:: with SMTP id 2mr5393014ljq.39.1552501432235;
 Wed, 13 Mar 2019 11:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190312171034.530434962@linuxfoundation.org> <20190313144434.GA11117@roeck-us.net>
 <20190313151429.GB9719@kroah.com> <20190313175839.GA27267@kroah.com>
In-Reply-To: <20190313175839.GA27267@kroah.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 13 Mar 2019 12:23:41 -0600
Message-ID: <CAEUSe78M5sKMcXZAv1LfUVe4TRQS7s=XYD+kJxv7OS1mye5WAw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/96] 4.9.163-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        open list <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 13 Mar 2019 at 11:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 13, 2019 at 08:14:29AM -0700, Greg Kroah-Hartman wrote:
> > On Wed, Mar 13, 2019 at 07:44:34AM -0700, Guenter Roeck wrote:
> > > On Tue, Mar 12, 2019 at 10:09:18AM -0700, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.9.163 releas=
e.
> > > > There are 96 patches in this series, all will be posted as a respon=
se
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > > >
> > > > Responses should be made by Thu Mar 14 17:10:06 UTC 2019.
> > > > Anything received after that time might be too late.
> > > >
> > >
> > > Early results:
> > >
> > > Building x86_64:tools/perf ... failed
> > > --------------
> > > Error log:
> > > Warning: arch/x86/include/asm/cpufeatures.h differs from kernel
> > > Warning: arch/x86/include/uapi/asm/kvm.h differs from kernel
> > >   PERF_VERSION =3D 4.9.162.g605129
> > > builtin-trace.c: In function =E2=80=98perf_evlist__add_vfs_getname=E2=
=80=99:
> > > builtin-trace.c:2071:8: error: implicit declaration of function =E2=
=80=98strstarts=E2=80=99 [-Werror=3Dimplicit-function-declaration]
> > > builtin-trace.c:2071:3: error: nested extern declaration of =E2=80=98=
strstarts=E2=80=99 [-Werror=3Dnested-externs]
> > >
> > > Also affects v4.4.y-queue.
> >
> > Hm, at first I was worried about my backport, but if it hit 4.4 as well=
,
> > that's not my fault :)
> >
> > I'll look at this after breakfast, thanks!
>
> I can't even get perf to build without any stable queue patches for
> 4.9.y at the moment, nor for 4.4.y, so something is odd, or I just have
> too "new" of a system.  Let me go dig up a debian box to see if I can at
> least find a way to start to reproduce this...

Interesting. To add to the fun, just yesterday I tried building the
Perf recipe from OpenEmbedded and it failed for these combinations:
* 4.4.176 and x86_64:
|   CC       /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux=
/perf/1.0-r9/perf-1.0/bench/mem-memcpy-x86-64-asm.o
| bench/mem-memcpy-x86-64-asm.S:4:10: fatal error:
../../../arch/x86/lib/memcpy_64.S: No such file or directory
|  #include "../../../arch/x86/lib/memcpy_64.S"
|           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| compilation terminated.

* 4.14.105 and i386:
| In file included from util/libunwind/x86_32.c:33:0:
| util/libunwind/../../arch/x86/util/unwind-libunwind.c: In function
'libunwind__x86_reg_id':
| util/libunwind/../../arch/x86/util/unwind-libunwind.c:110:11: error:
'EINVAL' undeclared (first use in this function); did you mean
'UNW_EINVAL'?
|    return -EINVAL;
|            ^~~~~~
|            UNW_EINVAL

Other combinations that worked:
* 4.4.176 with arm, arm64, i386
* 4.9.162 with arm, arm64, i386, x86_64
* 4.14.105 with arm, arm64, x86_64
* 4.19.28 with arm, arm64, i386, x86_64
* 4.20.15 with arm, arm64, i386, x86_64
* 5.0.1 with arm, arm64, i386, x86_64

I'll try again the failing combos to discard a problem with the OE build it=
self.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
