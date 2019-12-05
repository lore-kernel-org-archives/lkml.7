Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561D3C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D5E20801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="GhB+Cp5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfLERKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:10:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40174 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLERKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:10:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so4481673wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcoTcF4iRuur8fj4ZxTucRs4Jlu4z0J4uMeCsvrPgA0=;
        b=GhB+Cp5GOFV9kdBjApIpdy8Oog116Zo+KvrUdUrw4aeA3NNowP+teHJw08qpODUq58
         Rd1X+kIkDOvrow7+B2HCFYOGogx9cRB4KrY8B0jO06HKDTfh95VhVbDwjHPotNILj0Wy
         mmmUvmsesOWiFMLwd/qFV67yUxuZ7fyFDpCWnbiGtCkSJ+wOS4Dm/UAAEELhj+toaQLk
         4btu6/ModWT2ApflPzcCOeDme6VbmOXFAyV9aI//qKfWt6+/fGDtuvYKug78C/KQqV5w
         /dp0NqUIDNdvLstMHXRKEomk7cttm1xW6Cvo8unmJUOEvMf8nGkTYba7xbOLPtho0aFv
         kChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcoTcF4iRuur8fj4ZxTucRs4Jlu4z0J4uMeCsvrPgA0=;
        b=WioBVMCLKc2HW3tAF8Hg+aM/WUUubbV0iwCaYp7CDTVWmEIin7JhP1xbMdnwfPeAM+
         ZAYHUnFKvboyRTe+YAuP+A+4lLklFfTgm55ZwqpFl1gKHltuVRN8foGB2/p9N1TD1/dc
         3m2+Jd4aINp3J7DCs3kxWwtyAR4aegRg4Z4fxC3M3oX9nB7NznBPphj3vJWKNWhfpo7d
         SfSbKizpaZSCF4Y6zs7Cd7Sj8mbVI7r407C+jUiLMDo5izFiBZ02GaYZP/GRI2+pVwAj
         Ey7Neh6MbsVVwoJrikCZykhHNqiUM4w2Sp2DvGHpr2eg2I5SqRW6OrEHSZB9xhHSs9oh
         1IUA==
X-Gm-Message-State: APjAAAWg28ilDmY1np7ZwRTuQYa1bWJ1LN9fahhBQeYMsU5CewJcq0sQ
        qG2Vrf/1eTV/O5OdCH86j1JnGs6kkrdj+0xuxzmpqA==
X-Google-Smtp-Source: APXvYqwCDsQjsFf4aCoujj4lgDcKz1RHdCiPDAZd2dsX4LRayTGzMnK+ZmkuGr5iNH8DVweFmWFtFB/IBrnXgzBpEvw=
X-Received: by 2002:a1c:9602:: with SMTP id y2mr6231625wmd.23.1575565810251;
 Thu, 05 Dec 2019 09:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20191205005601.1559-1-anup.patel@wdc.com> <alpine.DEB.2.21.9999.1912041859070.215427@viisi.sifive.com>
 <CAAhSdy1RQw3MVcVT5y1EHr72LDNADKRL5nO2E8OrzBi+tpuvtA@mail.gmail.com> <20191205164706.svarpjp2kdokl2pg@holly.lan>
In-Reply-To: <20191205164706.svarpjp2kdokl2pg@holly.lan>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 5 Dec 2019 22:39:59 +0530
Message-ID: <CAAhSdy3cMp8241Mcwb7tQCRd1LEzv9gKO2wyq8bctW86c0BVRg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add debug defconfigs
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 10:17 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Dec 05, 2019 at 10:03:34PM +0530, Anup Patel wrote:
> > On Thu, Dec 5, 2019 at 8:33 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > >
> > > On Thu, 5 Dec 2019, Anup Patel wrote:
> > >
> > > > Various Linux kernel DEBUG options have big performance impact
> > > > so these should not be enabled in RISC-V normal defconfigs.
> > > >
> > > > Instead we should have separate RISC-V debug defconfigs having
> > > > these DEBUG options enabled. This way Linux RISC-V can build both
> > > > non-debug and debug kernels separately.
> > >
> > > I respect your point of view, but until the RISC-V kernel port is more
> > > mature, I personally am not planning to merge this patch, for reasons
> > > discussed in the defconfig patch descriptions and the subsequent pull
> > > request threads.
> > >
> > > I'm sure we'll revisit this in the future to realign with the defconfig
> > > debug settings for more mature architecture ports - but my guess is that
> > > we'll probably avoid creating debug_defconfigs, since only S390 does that.
> >
> > We have a lot of users (Yocto and Buildroot) dependent on the Linux
> > defconfig. I understand that you need DEBUG options for SiFive internal
> > use but this does not mean all users dependent on Linux defconfig
> > should be penalized in-terms of performance.
> >
> > This is the right time to introduce debug defconfigs so that you can
> > use it for your SiFive internal use and all users dependent on normal
> > defconfigs are not penalized in-terms of performance.
> >
> > If you still don't want debug defconfigs then I recommend reverting
> > your DEBUG options patch and you can find an alternative way to
> > enable DEBUG options for SiFive internal use.
>
> None of my business (except that I watch threads with debug in the
> subject line) but why propose putting debug options into any kind
> of defconfig. If you want standardized set debug options to chase
> problems why can't they into a .config file rather than a defconfig
> file.
>
> In use it will look like:
>   make defconfig extra_debug.config
>
> That way you don't have to maintain two almost identical files that will
> inevitably drift apart.

This is a good suggestion. I will certainly try it out at my end and send
a v2 with "extra_debug.config" file.

Thanks,
Anup
