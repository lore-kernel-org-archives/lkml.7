Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B91DC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4061E218BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs48QVXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfKSI3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:29:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbfKSI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574152193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H20VJbl/HlqoZLKxB2eEkiVm9bjunStGFexdv/rH5Wg=;
        b=Vs48QVXHrQflHshwT1DFUeJMdekY7Ate9mEjEj+F9xVqJAYz/lWv+pHyDmWq3dL/NjH3Fp
        chRgM8Fce3ZL84VFvEzqmTWqPPlA6LQyStAUstFHHwMc/wCzrkKeZhuIdf6D+fN2tpn32T
        w/W0FSztz7bjhIVhLn5fQJ4VJSybKHI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-C0aWv3HMOP2V5-v_9qA-hw-1; Tue, 19 Nov 2019 03:29:49 -0500
Received: by mail-lf1-f71.google.com with SMTP id z16so4961254lfb.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 00:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdTt3n+0i729FTDReSuLECgSQ4aS+lT8YABUAIgw7M4=;
        b=l+iBJam32SmRAnnFb9xfKInZZdI7rghQPlHw5+XWvrhkGesfIL7gIQ+0U62IBZaf9n
         WbMey65S1tK53vobBUL0d7ibHT4BeAW2k7B2g9xPdnU9/bzSMdfhKaS20gnvUNZQh/xb
         LluCTKjXlOMxf7sES3aSMDNH067G6h+69+WC/P+KwcqPoD2mxYkJvPcHBC5D7/jQXpMx
         GAio4G+9zIXcD71cr9dxm+tNUxreITRHtDdeyN+7a1ThR/VDfWLBH4q3P3FDBC1Rh/Dl
         yRZzZFOWj13Ilr0BHP8y8wlwkqRcmOj6Ssn0T9rayB0eSnhlYTLSdouRhRgMBI5tKvoh
         GcLw==
X-Gm-Message-State: APjAAAUrP/ba+P26xn/2a9HwVDGetPBwIx0x25JlygNIInm/3Ekc1aIm
        F0NLKo0XUF2sYMGClJmUGeN0sEGns/5iVehXdB6YUA1T3Nfz9C3QukCsjNVv85yIAy+AFYRqbYM
        81hFFEqezbvWvqGMcDtHYFol6gzYExl7xqvgYFEkQ
X-Received: by 2002:a2e:98c6:: with SMTP id s6mr2467910ljj.235.1574152187804;
        Tue, 19 Nov 2019 00:29:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2IC2bHi8fy/d2SRNiTEi36NRc3i9RixIH7XOkwEMkhAxGronTJF+riz7NT7kg7+QIn9WK1oeS0ClHOZKD/g0=
X-Received: by 2002:a2e:98c6:: with SMTP id s6mr2467897ljj.235.1574152187559;
 Tue, 19 Nov 2019 00:29:47 -0800 (PST)
MIME-Version: 1.0
References: <1573459282-26989-1-git-send-email-bhsharma@redhat.com>
 <20191113063858.GE22427@linaro.org> <CACi5LpP54d9DKW63G5W6X4euBjAm2NwkHOiM01dB7g8d60s=4w@mail.gmail.com>
 <20191115015959.GI22427@linaro.org> <CAJ2QiJJOSspLKRh+jRB_o0o9nmeAsiFKzxGJ8R0pYPRM4iptmw@mail.gmail.com>
In-Reply-To: <CAJ2QiJJOSspLKRh+jRB_o0o9nmeAsiFKzxGJ8R0pYPRM4iptmw@mail.gmail.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Tue, 19 Nov 2019 13:59:33 +0530
Message-ID: <CACi5LpO_fvzDiXP9+QLga_B7kozRRnE9ix4Xa=xvNx1Kvci=3Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
To:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>
X-MC-Unique: C0aWv3HMOP2V5-v_9qA-hw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 12:03 PM Prabhakar Kushwaha
<prabhakar.pkin@gmail.com> wrote:
>
> Hi Akashi,
>
> On Fri, Nov 15, 2019 at 7:29 AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Bhupesh,
> >
> > On Fri, Nov 15, 2019 at 01:24:17AM +0530, Bhupesh Sharma wrote:
> > > Hi Akashi,
> > >
> > > On Wed, Nov 13, 2019 at 12:11 PM AKASHI Takahiro
> > > <takahiro.akashi@linaro.org> wrote:
> > > >
> > > > Hi Bhupesh,
> > > >
> > > > Do you have a corresponding patch for userspace tools,
> > > > including crash util and/or makedumpfile?
> > > > Otherwise, we can't verify that a generated core file is
> > > > correctly handled.
> > >
> > > Sure. I am still working on the crash-utility related changes, but yo=
u
> > > can find the makedumpfile changes I posted a couple of days ago here
> > > (see [0]) and the github link for the makedumpfile changes can be see=
n
> > > via [1].
> > >
> > > I will post the crash-util changes shortly as well.
> > > Thanks for having a look at the same.
> >
> > Thank you.
> > I have tested my kdump patch with a hacked version of crash
> > where VA_BITS_ACTUAL is calculated from tcr_el1_t1sz in vmcoreinfo.
> >
>
> I also did hack to calculate VA_BITS_ACTUAL is calculated from
> tcr_el1_t1sz in vmcoreinfo. Now i am getting error same as mentioned
> by you in other thread last month.
> https://www.mail-archive.com/crash-utility@redhat.com/msg07385.html
>
> how this error was overcome?
>
> I am using
>  - crashkernel: https://github.com/crash-utility/crash.git  commit:
> babd7ae62d4e8fd6f93fd30b88040d9376522aa3
> and
>  - Linux: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
> commit: af42d3466bdc8f39806b26f593604fdc54140bcb

I will post a formal change for crash-utility shortly that fixes the
same. Right now we are having issues with emails bouncing off
'crash-utility@redhat.com', so my patches sent to the same are in
undelivered state at-the-moment.

For easy testing I will share the link to my github tree (off-line)
[which contains the changes] as well.

Regards,
Bhupesh

