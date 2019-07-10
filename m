Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240E6C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA9D2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LEi6/Pje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfGJP5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:57:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33112 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfGJP5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:57:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so2694276edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZgPHxQSyDYYtNmHA3/wZ3DRhIFFkShs7w2jP3T5tpc=;
        b=LEi6/PjejGkEIcti1eTkHdTyR2J5jxYV6psjYv6r+R4rq9PfMgiJvyz3sGPckQrQjf
         lbugIKfybDu0Y7zKpFpaEvuHTT2l8vGEYy0HOBao0Cd4zR061ANMYJt6m/w7HHj6E1tb
         ocYgs+QcC8JNjAUstT+ETcrq/OJtYTOLtc1b+S24v+b0gwp3Hyivo1pqM/mbRS6+5jdh
         WnlzF7qZHETDtcyr28wnUTIMG2EIZHypwQqXV3z2p5ZjOi9Gv2nhDxwzoWBiIcs2kcrW
         xTtxPMaM5lL20VjS6uVfPnp7Rlbf/WgAjHAi1S0bhstA9g1OCdvgp9kI3SWayKUOO6zT
         WtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZgPHxQSyDYYtNmHA3/wZ3DRhIFFkShs7w2jP3T5tpc=;
        b=Q+dBTnH8DqBK/chR23EIq6jUQwTTPOuRccMbr00C35yN3cQx9I0B6+Pa7wXXOg7e75
         lq7P1/bk28dHwwFju6/vEpcNhtN0MwoJFwsU29zRfnf96aJVpIYXrBxoJ26K1Cbv/ztq
         veTusLQvE4olWCLg/NkUMtprCRZUkmc+Wa5UvIQ+Gr2UgSZ6MR+Iz6VifKGi/g+Gtg+s
         QYo1YOuY4dmmlJp84/kdu8Wxf+s0Uj7cFblsVEMPMdGA6uzyGytaoArILQHnrvi+BRQ7
         RnC9B1khY0VYoDcoZ4Imwy9o68WSLndQaGODXXkVj8P4CPuRM5ioL7OHSfejjdunPEoX
         Kk+g==
X-Gm-Message-State: APjAAAXbCnOSI0YL7jZiFSW5GhP5vJwF9tL1hbD/0SdfSHas9RYuQ6vD
        1YJp7XxqZuhhoW17IG0V6YhbYMA5VFJ5s/ybZ67zeA==
X-Google-Smtp-Source: APXvYqw7x9BGSNLqWpKAPyh4/6mWWF6JBu/hcFz0l/xjgqeQSiFxs1kaM3mPVPaebQipBv1gm8i9kkO9aBNr+FGCS6c=
X-Received: by 2002:a50:a4ef:: with SMTP id x44mr32799017edb.304.1562774220761;
 Wed, 10 Jul 2019 08:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
 <CACi5LpNGWhTnXyM8gB0Tn=682+08s-ppfDpX2SawfxMvue1GTQ@mail.gmail.com>
 <CA+CK2bBrwBHhD-PFO_gVnDYoFi0Su6t456WNdtBWpOe4qM+oww@mail.gmail.com>
 <2d60f302-5161-638a-76cd-d7d79e5631fe@arm.com> <CA+CK2bA40wQvX=KieE5Qg2Ny5ZyiDAAjAb9W7Phu2Ou_9r6bOA@mail.gmail.com>
 <f9bea5bd-370a-47b5-8ad1-a30bd43d6cca@arm.com>
In-Reply-To: <f9bea5bd-370a-47b5-8ad1-a30bd43d6cca@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 10 Jul 2019 11:56:50 -0400
Message-ID: <CA+CK2bBWis8TgyOmDhVgLYrOU95Za-UhSGSB3ufsjiNDt-Zd_w@mail.gmail.com>
Subject: Re: [v1 0/5] allow to reserve memory for normal kexec kernel
To:     James Morse <james.morse@arm.com>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 11:19 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pasha,
>
> On 09/07/2019 14:07, Pavel Tatashin wrote:
> >>> Enabling MMU and D-Cache for relocation  would essentially require the
> >>> same changes in kernel. Could you please share exactly why these were
> >>> not accepted upstream into kexec-tools?
> >>
> >> Because '--no-checks' is a much simpler alternative.
> >>
> >> More of the discussion:
> >> https://lore.kernel.org/linux-arm-kernel/5599813d-f83c-d154-287a-c131c48292ca@arm.com/
> >>
> >> While you can make purgatory a fully-fledged operating system, it doesn't really need to
> >> do anything on arm64. Errata-workarounds alone are a reason not do start down this path.
> >
> > Thank you James. I will summaries the information gathered from the
> > yesterday's/today's discussion and add it to the cover letter together
> > with ARM64 tag. I think, the patch series makes sense for ARM64 only,
> > unless there are other platforms that disable caching/MMU during
> > relocation.
>
> I'd prefer not to reserve additional memory for regular kexec just to avoid the relocation.
> If the kernel's relocation work is so painful we can investigate doing it while the MMU is
> enabled. If you can compare regular-kexec with kexec_file_load() you eliminate the
> purgatory part of the work.

Relocation time is exactly the same for regular-kexec and
kexec_file_load(). So, the relocation is indeed painful for our case.
I am working on adding MMU enabled kernel relocation.

Pasha
