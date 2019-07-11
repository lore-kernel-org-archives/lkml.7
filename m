Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F306C74A52
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5448D20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="EW7GpK1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfGKM03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 08:26:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38987 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfGKM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 08:26:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so5620890edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJ6ZMdK4LYRloh1U7sELBo1v2NVDRc/ffgJQQZCOGw8=;
        b=EW7GpK1ypNgGxWDSTMOusRhBsnHaJj84KVn4gcs69/N7Uk7dXNGESNYBPBlBX4nMAC
         +zIFWunPSKy5J7VY1Y9C0q3D/5Dc/CU40NZ4BIFDBVGzcO2Ds0YruG2wTfBlz86+Nbjo
         z+i9dBBMWPgRi02j4HcZulKmeTzn1qyNlNrKDeYqkQ/ltfDkNb4rn8zVHh1pCmvJrX6c
         ZV4n9inovdSAot9aoSc/HNDfD4WlpxSQvSXv1y/wmJ+2gNyBk3qPttWksU014jdoWi7C
         kbHMTVoNVgEEuKb67O+BqKD0Gq08mOkhEgxIMU74FLyP8mwgdNa2L1L3Yavzsw8zemZj
         T+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJ6ZMdK4LYRloh1U7sELBo1v2NVDRc/ffgJQQZCOGw8=;
        b=NzBO0SRZcWTYX1D63DKAPOZ+kI9+B13z9H1fQvAj1NPjpFlm91hbNb0tifT6OZEiaj
         eK9MYBT0OKW8sqeB3yEpYy6LtF9DsDArvoKL5F7DQ0eC2xZEXOjQZoMMpiOu1VQpFB1Y
         FyiBWqa/5ZcksCGHgXlp4CuaJXob1HiskPHFgaoawIDrMDqbFPf9z7CdIj/zVMCjSeeg
         2WPpL+SNbwQlmYnnF9u9xEKwhZcLhDgCBilHZRRIMHpmRSj4ccoa3FnLHFUCnUw0roNA
         jVziJiPb4J3bmobUke2c7Cs++hsaYdM73udd4BEngGOPNaEAy+/k242vT8dBZS28qqFV
         xwsQ==
X-Gm-Message-State: APjAAAWyOAqYyTPHO6UP4V2JEp3p0y8bZZYa9dsG/v9Lc8nKv/VdtHkw
        Q/wOv7mT7SrM5EzDywqOMeJ7HprFn6qsZlgGEUY=
X-Google-Smtp-Source: APXvYqzugM5LpeBLacryDPFYq2IwvdgIhi4YgehBu0EhyKrAkLdubbVLjwgW6a31qe/LF/V0ieTCIyUKrLyCQynpEqU=
X-Received: by 2002:a05:6402:14c4:: with SMTP id f4mr3155357edx.170.1562847986892;
 Thu, 11 Jul 2019 05:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
 <CACi5LpNGWhTnXyM8gB0Tn=682+08s-ppfDpX2SawfxMvue1GTQ@mail.gmail.com>
 <CA+CK2bBrwBHhD-PFO_gVnDYoFi0Su6t456WNdtBWpOe4qM+oww@mail.gmail.com>
 <2d60f302-5161-638a-76cd-d7d79e5631fe@arm.com> <CA+CK2bA40wQvX=KieE5Qg2Ny5ZyiDAAjAb9W7Phu2Ou_9r6bOA@mail.gmail.com>
 <f9bea5bd-370a-47b5-8ad1-a30bd43d6cca@arm.com> <CA+CK2bBWis8TgyOmDhVgLYrOU95Za-UhSGSB3ufsjiNDt-Zd_w@mail.gmail.com>
 <93f99d54-9fe4-a191-4877-080ad78322bb@arm.com>
In-Reply-To: <93f99d54-9fe4-a191-4877-080ad78322bb@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 11 Jul 2019 08:26:16 -0400
Message-ID: <CA+CK2bCOeV=4+MZcZfScvTDZ8Not6qxEn1DKZKSwtJOvq-hotQ@mail.gmail.com>
Subject: Re: [v1 0/5] allow to reserve memory for normal kexec kernel
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     James Morse <james.morse@arm.com>, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Eric Biederman <ebiederm@xmission.com>, will@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 4:12 AM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>
> Hi,
>
> On 7/10/19 4:56 PM, Pavel Tatashin wrote:
> > On Wed, Jul 10, 2019 at 11:19 AM James Morse <james.morse@arm.com> wrote:
> >>
> >> Hi Pasha,
> >>
> >> On 09/07/2019 14:07, Pavel Tatashin wrote:
> >>>>> Enabling MMU and D-Cache for relocation  would essentially require the
> >>>>> same changes in kernel. Could you please share exactly why these were
> >>>>> not accepted upstream into kexec-tools?
> >>>>
> >>>> Because '--no-checks' is a much simpler alternative.
> >>>>
> >>>> More of the discussion:
> >>>> https://lore.kernel.org/linux-arm-kernel/5599813d-f83c-d154-287a-c131c48292ca@arm.com/
> >>>>
> >>>> While you can make purgatory a fully-fledged operating system, it doesn't really need to
> >>>> do anything on arm64. Errata-workarounds alone are a reason not do start down this path.
> >>>
> >>> Thank you James. I will summaries the information gathered from the
> >>> yesterday's/today's discussion and add it to the cover letter together
> >>> with ARM64 tag. I think, the patch series makes sense for ARM64 only,
> >>> unless there are other platforms that disable caching/MMU during
> >>> relocation.
> >>
> >> I'd prefer not to reserve additional memory for regular kexec just to avoid the relocation.
> >> If the kernel's relocation work is so painful we can investigate doing it while the MMU is
> >> enabled. If you can compare regular-kexec with kexec_file_load() you eliminate the
> >> purgatory part of the work.
> >
> > Relocation time is exactly the same for regular-kexec and
> > kexec_file_load(). So, the relocation is indeed painful for our case.
> > I am working on adding MMU enabled kernel relocation.
>
> Out of curiosity, does enabling only I-cache make a difference? IIRC, it doesn't
> require setting MMU, in contrast to D-cache.

Resend:

Thank you for suggestion. I have actually experimented with enabling
caches without MMU. Did not see a difference.

Thank you,
Pasha

>
> Cheers
> Vladimir
>
> >
> > Pasha
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>
