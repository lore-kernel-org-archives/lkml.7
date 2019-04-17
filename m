Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E2EC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E6020835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F93X7Oda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfDQFst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:48:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53483 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfDQFss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:48:48 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so2648324itf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 22:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fox/O+Kk3y7e1Ph8qLyYTZtLSePizPB0+Dl4N7GU+o0=;
        b=F93X7OdalbF+M7wC4KAAg8CPA6ogPPS2uAcEzwenoJ9rcle8xyJ1leJwhKKcnSXnpX
         jMb+htv5yBcMCEI4quEVUwIDMTcrXwPZ1CE9078mfXFEe5TWiFHlOnMX/ZVfGCDTOYZF
         a/o1Y85BumNTPnSLXzIvvZeaRCzH6q2QlZWaYu0rbXflv/5dUC8i2OMG52hsFujMNoDe
         bvZQ5PVCQZrDnlND0og4i20l5I7rV77mnckJ3wAE5ELDYaggms0Izs1MDRQw6RTMrU7f
         UiXf+QzfggbTZDZ6r0xUy2xpxLg3yFlJVXZJvHqZfL9uI3IKT4+7awkIOpRN7vNkc0Xy
         ky8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fox/O+Kk3y7e1Ph8qLyYTZtLSePizPB0+Dl4N7GU+o0=;
        b=mPy6d9ExohiqvM4EV1mm65AAb+l9LDAFjYqFqPPodSKz407j/Oodu/Jwc4aHfwDEtu
         P7l7BfoYTkTEXpRByOhvj8pZNNp4ScAT71TSiGgaWReTboEAlixlfgiibi2dBcRKBLOB
         /HLFOKaOSfLWFPdIHr2Y4G9Lv2GwvXBcMkc7JEfYYFbhQK4USncklFCUvRLAMiZObV5W
         ucOmSmm23vSv/lAS5IMF4CHs5yFuj68QrVIr3BL4tdAlvt2dNtECLk0kV53ArASBiodF
         vyWR86+3ZCWhbs1PFUszQeF2zSjWk8GVCdFfZRirfB9/K2jdFJRKS1BB4+zazRO/WP1/
         XkPw==
X-Gm-Message-State: APjAAAWjK1xx3QlCbiJUgCoScS2hd0SJhcx3aunWLLDmMLKhsKeKJSi1
        ta+/umbtE98KmaTqU6HM5S+2fQRW3Tl1JLtqHw==
X-Google-Smtp-Source: APXvYqw1Q7oX/a+INgbKYW5ru5p0KWRthBcNQSSwg+dDjO6DW2btc74qBkR5gLWFnVsYe1GrWI3wLj79fOkTfGbNWd8=
X-Received: by 2002:a02:6951:: with SMTP id e78mr53873370jac.132.1555480128160;
 Tue, 16 Apr 2019 22:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
 <1554703115-15299-2-git-send-email-kernelfans@gmail.com> <20190416190148.GM31772@zn.tnic>
In-Reply-To: <20190416190148.GM31772@zn.tnic>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 17 Apr 2019 13:48:36 +0800
Message-ID: <CAFgQCTso4L+Pxr-uMmCErM9fk4KMDcttcjSNWis9YbBVt-1MLQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel/crash_core: separate the parsing routines
 to lib/parse_crashkernel.c
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 3:01 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Apr 08, 2019 at 01:58:34PM +0800, Pingfan Liu wrote:
> > Beside kernel, at early boot stage, the KASLR code also needs to parse the
> > crashkernel=x@y or crashkernel=ramsize-range:size[,...][@offset] option,
> > and avoid to put randomized kernel in the region.
> >
> > Extracting the parsing related routines to lib/parse_crashkernel.c, so it
> > will be handy included by other
> > files.
>
> Use this commit message for your next submission:
>
>     crash: Carve out crashkernel= cmdline parsing
>
>     Make the "crashkernel=" parsing functionality available to the early
>     KASLR code. Will be used by a later patch to parse crashkernel regions
>     which KASLR should aviod.
>
OK.

> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Nicolas Pitre <nico@linaro.org>
> > Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/crash_core.c     | 273 ---------------------------------------------
> >  lib/Makefile            |   2 +
> >  lib/parse_crashkernel.c | 289 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 291 insertions(+), 273 deletions(-)
>
> And this is not how you carve out code.
>
> First, you do a patch which does only code move. Nothing more.
>
> In a follow on patch, you make the changes to the moved code so that it
> is immediately visible what you're changing.
>
Will fix it. Thanks for your review.

Regards,
Pingfan
