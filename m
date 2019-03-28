Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D19C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB075206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1PCO8U8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfC1H5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:57:43 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40035 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfC1H5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:57:43 -0400
Received: by mail-it1-f196.google.com with SMTP id y63so4524312itb.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 00:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZMwA7IgQqKL/rIBb/w+LBA8PXjjr60ib/zfWYkFbvGg=;
        b=H1PCO8U8C2YlBa/OyE6m8KjQo7NKnYJxuka6CpV/JGDC/4f3CgpFVe595r7BTx4RCD
         QyMap3S814G8XOLmjcsGbXnVAQm0tEzkSfWdw8UlkM7oVT2usfbg5KLfGPtwDtYJtcg2
         1RNuWBRhNEaEWUBCMPcv3x+2Z6bEtLRxbMgqfqYgcRLGt0/7aaAA7bTtWuYUK7NaDFm5
         OPXomXf2FtmcRhFol2c2BcMAVZdDxYU0fIdmQeOd1Ioh0tAjvsvzBJ0WlwlyFDQmx8X9
         TkJRxPX5SxPq8060gcWU/oj/6CCmk5YfBrZcjSvu2pqB5dc1im3uBdlkUAkVTxn7D/gJ
         U44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMwA7IgQqKL/rIBb/w+LBA8PXjjr60ib/zfWYkFbvGg=;
        b=qf5kW8fVZwdpro4SlRHvvFxijuDm+fs+DPE6RnHINdtTNrXPxIcXZeqNVBWVcdg4oL
         5jGVqVHav4rN2iZMIIOKJt/B6oITVfysBEoY4XpOZa3fe7xe1XFr7Vau/mEK27xByl8n
         1aLvI7baR2pATKI+Pm8LenmWfsKIQalTf69utnhmgpNomxyym2skH0D/uszCpX68xXJh
         AseNXh1MyBGrmM/1lhmB6ZZSynOegDDYgn8q0pi+EUF3EJX8oMvUBECO/6kLMibrglDr
         OrauaKlWbO5vDI9Si/9ntkPlCfNfq+ZjnAN/DdiAfEQEelrppAaAG1BPTlOFBqvKqmo5
         RUyg==
X-Gm-Message-State: APjAAAVOyGbNc3nkUlUVM4FyDo/OHBU6ZgDvVDG/ngZEaqOGquUmuQs8
        IHzj1AohGcppQ7TwjoDcqR6HWILCr+/biSA+EqmNVw==
X-Google-Smtp-Source: APXvYqx9Piy9g4b+h28Qe7uMxa1y0UfEnfQtkJFd9yZlLszRWWnqjGM1gh/s2V4D/3mvt/guuJZ0/26kCw5dTV5k+sk=
X-Received: by 2002:a02:ac14:: with SMTP id a20mr31235029jao.130.1553759862299;
 Thu, 28 Mar 2019 00:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190320130502.16667-1-rrichter@marvell.com> <20190320131607.vgst3r7ynha55ikw@rric.localdomain>
 <20190320152240.2eun63wqkbqmuqkg@rric.localdomain> <CAKv+Gu8ta4ZSKwcFGOaf7XCam29ZrHkNowDjfdCpfQas=Xo7Fg@mail.gmail.com>
 <20190328075510.svjbjdonrncrr73m@rric.localdomain>
In-Reply-To: <20190328075510.svjbjdonrncrr73m@rric.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 28 Mar 2019 08:57:30 +0100
Message-ID: <CAKv+Gu9iL+jeDF0VAxHsV-LBCcrzSjXJguKp9YhgQicce_acYQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Unify dmi setup code over architectures
 arm/arm64, io64 and x86
To:     Robert Richter <rrichter@marvell.com>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Marcin Benka <mbenka@marvell.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 at 08:55, Robert Richter <rrichter@marvell.com> wrote:
>
> On 27.03.19 19:53:47, Ard Biesheuvel wrote:
> > On Wed, 20 Mar 2019 at 16:23, Robert Richter <rrichter@marvell.com> wrote:
> > >
> > > On 20.03.19 14:16:07, Robert Richter wrote:
> > > > On 20.03.19 13:05:37, Robert Richter wrote:
> > > > > @@ -167,6 +167,7 @@ static int __init arm_dmi_init(void)
> > > > >      * itself, depends on dmi_scan_machine() having been called already.
> > > > >      */
> > > > >     dmi_scan_machine();
> > > > > +   dmi_memdev_walk();
> > > > >     if (dmi_available)
> > > > >             dmi_set_dump_stack_arch_desc();
> > > > >     return 0;
> > > >
> > > > After
> > > >
> > > >  [PATCH] efi/arm: Show SMBIOS bank/device location in cper and
> > > >   ghes error logs
> > > >
> > > > wents in for arm/arm64, we can unify the code. See patch below.
> > >
> > > V2 with the fix in arm_dmi_init() below.
> > >
> >
> > Could you please resend this as a proper patch? I am having trouble applying it.
>
> I just resent the patch. But this worked for me:
>
>  $ wget -nd -O - https://lore.kernel.org/patchwork/patch/1052718/mbox/ | git am -smc -3 -
>
> Not sure what was wrong.
>

Thanks. Not sure either, but I managed to apply it now, with
s/io64/ia64/, and Jean's R-b added.

-- 
Ard.
