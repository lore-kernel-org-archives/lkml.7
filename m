Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDAEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66ECF222A4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sifSK6MU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfKSGc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:32:58 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43874 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKSGc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:32:58 -0500
Received: by mail-io1-f66.google.com with SMTP id r2so16721554iot.10;
        Mon, 18 Nov 2019 22:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NXaQYQk0g4GZrnX0H+C5/sQj56d3X20l4tE5DHhQOrA=;
        b=sifSK6MU7G+EcqYvJSuSa2S3hMP9SB6t7e29d7KHAyYYgBX4YqD7x0RtWHSqj7x64T
         UCnhKrr5Oiz+XULwu7eB1ZzOI6VyeAHiAbd+ovtLWxxuyjZjQERBAwrzjvdoMJrtvL2X
         OuCAUcEOqMXV21HuTt3LYU4PJ7a9/zwV0cPSFw8iKelRg6k0kRED6h1IpqHOT34kW5Dv
         V+F06IQt2Mi5Kauqgd6BFTTPOuzVSntsEr/Hz/LVi2r7g9MduWF7OaGr1l12AxH8Pw4y
         IkHXTj8+xHCrm+IKudRyf5hLWkkP4WKgN+znsqikOz7kNlhe0ebhtZo0RHJwK0BSQojS
         kitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NXaQYQk0g4GZrnX0H+C5/sQj56d3X20l4tE5DHhQOrA=;
        b=a2Un5RahC1mqd2Gs6JgWwjPkS0933A0sIw76uaTYsKRnOMosEW75Doel4hJgZ6SHkc
         sshPPWg+eycp32JRw7fYxzextrOqk6EEq0P3r/uttb7y8u77BW789T68M8hb3q6AiZyk
         8ucXosE2mxcZ0OGMys+nurGwWTuGM+T8cK4vOVxuTE9/y63lhBmU/2nNV4SGM1Wq2ydT
         e89O7FYLSGskLp66CddIOtuw5p682MNbXEVH5AYnn18HORBAKTL1a0KDihQGj34l7ozV
         Qlspe1RcG4yNGidNBZEIu5dMB1rFjBlefFQVHBu1S6TLwMmwRI/9bdebbEWdnhbWvUAs
         jPbg==
X-Gm-Message-State: APjAAAV3ERksv0YFuFjiw8s3TUzaCFY1HqJ4KkmTMqRALqyMESdwgVGi
        C7EsFls6eHHwf0pdzuSZ3nnPI7kDIniFi5KhhRkryFsZ/56Esw==
X-Google-Smtp-Source: APXvYqxsiN2r32tu6Vr3FT387ecd9RsbnxXZTJSYF8E4DcxZPX/OBCeKQumlgww/wRDUDEfuWrt3IfZaSkRqJ6CTjKM=
X-Received: by 2002:a02:b48:: with SMTP id 69mr17013960jad.25.1574145177173;
 Mon, 18 Nov 2019 22:32:57 -0800 (PST)
MIME-Version: 1.0
References: <1573459282-26989-1-git-send-email-bhsharma@redhat.com>
 <20191113063858.GE22427@linaro.org> <CACi5LpP54d9DKW63G5W6X4euBjAm2NwkHOiM01dB7g8d60s=4w@mail.gmail.com>
 <20191115015959.GI22427@linaro.org>
In-Reply-To: <20191115015959.GI22427@linaro.org>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Tue, 19 Nov 2019 12:02:46 +0530
Message-ID: <CAJ2QiJJOSspLKRh+jRB_o0o9nmeAsiFKzxGJ8R0pYPRM4iptmw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On Fri, Nov 15, 2019 at 7:29 AM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Bhupesh,
>
> On Fri, Nov 15, 2019 at 01:24:17AM +0530, Bhupesh Sharma wrote:
> > Hi Akashi,
> >
> > On Wed, Nov 13, 2019 at 12:11 PM AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > Hi Bhupesh,
> > >
> > > Do you have a corresponding patch for userspace tools,
> > > including crash util and/or makedumpfile?
> > > Otherwise, we can't verify that a generated core file is
> > > correctly handled.
> >
> > Sure. I am still working on the crash-utility related changes, but you
> > can find the makedumpfile changes I posted a couple of days ago here
> > (see [0]) and the github link for the makedumpfile changes can be seen
> > via [1].
> >
> > I will post the crash-util changes shortly as well.
> > Thanks for having a look at the same.
>
> Thank you.
> I have tested my kdump patch with a hacked version of crash
> where VA_BITS_ACTUAL is calculated from tcr_el1_t1sz in vmcoreinfo.
>

I also did hack to calculate VA_BITS_ACTUAL is calculated from
tcr_el1_t1sz in vmcoreinfo. Now i am getting error same as mentioned
by you in other thread last month.
https://www.mail-archive.com/crash-utility@redhat.com/msg07385.html

how this error was overcome?

I am using
 - crashkernel: https://github.com/crash-utility/crash.git  commit:
babd7ae62d4e8fd6f93fd30b88040d9376522aa3
and
 - Linux: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
commit: af42d3466bdc8f39806b26f593604fdc54140bcb

--pk
