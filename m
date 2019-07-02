Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76E0C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACDD20663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgopIKFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfGBPjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:39:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46240 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGBPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:39:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so555265pls.13;
        Tue, 02 Jul 2019 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6DLQuVdAB+70rPFj5zG0x4rnkj9q47LApr1XVz5BOE=;
        b=PgopIKFRfZ1qWxKPnAqU5VkGmfaq67TmEY3X0GmaeLT1gm8x++/HAJ5Izgz0yXmgTs
         E8yy2x8nrRsrrjOOM6GGeXaeRraFRGeM9uxaIRnjLu0QC7kwtoy+7ErBf9u7yd33BLdJ
         QEEtUHEnvoTDLh/fTD2zEvNIVP0paptLYOt86XE1y+dWRqWuDylJbYCGOm1dtIhq6uqv
         csTczpXKlIQpMzVl/ZjLzv6Ekyc3etNAJJun907ElKpeiGAarhtDpVLuP8FuJoUR7uYs
         JltsTnGrEb+ioYQLHFc58dl4tNxE7lSrAVIQBcuq7KBrFL+Uxg5kzdZ7eyno5P3uo9UP
         de5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6DLQuVdAB+70rPFj5zG0x4rnkj9q47LApr1XVz5BOE=;
        b=ZGuOiq+Ft/gXK8LHb2rkswhYnz+diguD10k05xJMd/JOMH7LhMLSRynOgmgIpEqdFA
         +17WwFKK/xgC87iepgcdYsf48Bb38jAzDbatVvbKyuGyhP02nOcQeDLdN0jCNhvlsmZU
         84rgboKKb/M7BrxfPSqJ/PM0xomJQzX8yaOG3x76cDzBxnuJMDC9dy7NjoYwtvi9Bj6K
         mzDpWlTc0zSMu+E3vmocDplL4gAX0ZkjbmWlbJovG22NNI8qrPgPQVkHCvFgo/3FHf56
         9oREV5T7B7P1eC1xiPFFSHUnvHXx6YzHbdroIR2BM7rB9KYB9Ea4X/cLlbnQDNphfXA+
         tznw==
X-Gm-Message-State: APjAAAUJhollPmm5tJjArPBwklOhC3ui++qqzFMOFppU+vVmPmpUkbar
        Ww5rnTTIyH/Zf8vtWYLvANrFM9XFYS/A5um8q9w=
X-Google-Smtp-Source: APXvYqwQrJ6U6eF4weXu7VkVhxDBAmzuhhaXGfIrqf9EklZIpTcCCG993qa0uULXx7ClNVWryt/7c0BjX6WeDV1LlNU=
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr36708263plp.18.1562081981801;
 Tue, 02 Jul 2019 08:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
 <20190626223851.19138-11-srinivas.pandruvada@linux.intel.com>
 <CAHp75VfMDpKyYnZkZw51dwcEt5neQwGuZUaB7yEFQW6fjRYCqg@mail.gmail.com> <CAJvTdK=S1vPGg9HZjUxJN2aXSfSXBDyYYLawONA0PP_yKvf19A@mail.gmail.com>
In-Reply-To: <CAJvTdK=S1vPGg9HZjUxJN2aXSfSXBDyYYLawONA0PP_yKvf19A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jul 2019 18:39:29 +0300
Message-ID: <CAHp75VfY+u4L85VncaLYFcoFwa0OzTo__ZKZGboRXmyQ50mCOA@mail.gmail.com>
Subject: Re: [PATCH 10/10] tools/power/x86: A tool to validate Intel Speed
 Select commands
To:     Len Brown <lenb@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alan Cox <alan@linux.intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 5:42 PM Len Brown <lenb@kernel.org> wrote:
>
> Acked-by: Len Brown <len.brown@intel.com>
>

Thanks!
I hope this is applicable for v2.

> On Sat, Jun 29, 2019 at 10:31 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Jun 27, 2019 at 1:39 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > The Intel(R) Speed select technologies contains four features.
> > >
> > > Performance profile:An non architectural mechanism that allows multiple
> > > optimized performance profiles per system via static and/or dynamic
> > > adjustment of core count, workload, Tjmax, and TDP, etc. aka ISS
> > > in the documentation.
> > >
> > > Base Frequency: Enables users to increase guaranteed base frequency on
> > > certain cores (high priority cores) in exchange for lower base frequency
> > > on remaining cores (low priority cores). aka PBF in the documenation.
> > >
> > > Turbo frequency: Enables the ability to set different turbo ratio limits
> > > to cores based on priority. aka FACT in the documentation.
> > >
> > > Core power: An Interface that allows user to define per core/tile
> > > priority.
> > >
> > > There is a multi level help for commands and options. This can be used
> > > to check required arguments for each feature and commands for the
> > > feature.
> > >
> > > To start navigating the features start with
> > >
> > > $sudo intel-speed-select --help
> > >
> > > For help on a specific feature for example
> > > $sudo intel-speed-select perf-profile --help
> > >
> > > To get help for a command for a feature for example
> > > $sudo intel-speed-select perf-profile get-lock-status --help
> > >
> >
> > I need an Ack from tools/power maintainer(s) for this.

-- 
With Best Regards,
Andy Shevchenko
