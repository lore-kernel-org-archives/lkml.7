Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83B7C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55CF2080D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgAIWSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:18:40 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:59279 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgAIWSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:18:38 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mq2vS-1jSZJP0ovS-00n6Ym for <linux-kernel@vger.kernel.org>; Thu, 09 Jan
 2020 23:18:37 +0100
Received: by mail-qt1-f169.google.com with SMTP id w47so225934qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 14:18:37 -0800 (PST)
X-Gm-Message-State: APjAAAWP9ILqA70Cmrto0pJXDS+dcvTB5ByvYXOpVZTdasiJdJKflxKo
        oMNGjl43mFE3FDxM1R+e1YXKf5R1kajbuagOc/0=
X-Google-Smtp-Source: APXvYqyCldy0Ka9H3KPZOYA/NiPXlHDkyyuq1q6gfwdEk/9ehsfCQhAByOxz/z9x1AuUpDN4mQv3MJjohH3WzwWquts=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr9914629qto.304.1578608316155;
 Thu, 09 Jan 2020 14:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20200107214042.855757-1-arnd@arndb.de> <20200108102602.43d4c5433eb495cdbf387e9b@kernel.org>
 <20200109140202.fd5488a2ac02f81b25d83b88@linux-foundation.org>
In-Reply-To: <20200109140202.fd5488a2ac02f81b25d83b88@linux-foundation.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Jan 2020 23:18:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Cy_WwtJGLF96tXrqT=hYw50NHy+DbaW2=DEbf_iXUeg@mail.gmail.com>
Message-ID: <CAK8P3a3Cy_WwtJGLF96tXrqT=hYw50NHy+DbaW2=DEbf_iXUeg@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: work around bogus -Wrestrict warning
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Will Deacon <will@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7oQeWIkDz/xeONWkuH08TW/fhgCNfyEJenQmQnyYVH4ESAhCGcU
 dzQzGlyqwS1k/1JHHfR7VwQg1r3NVFJBeS8WOWgyb90wK74zrowzqSuYdYsEOWQRMkmm3sJ
 TxdGjg6SmrUmNCVfg2FNz4PjvHCWHG7mlHj7ItzyICJ4HlDDC2wCYQ7iRI+5zQxEh/nt2Qo
 uBRnn9p+ekYy96LdmOzoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xeCGWV+87QM=:eeAbxhyQGbIu/n2lATDe+3
 rmAQlG4BXJgII18JeC3jtH0cu1hsv3EMAye3YWhyft3wgbgb/PFYxFgVBlQqFDnKOKCszXwrP
 Wjs2qakO0CD4pz2Qh9v2QJ7iB069NQ62IGj7InAxxywuQkN6t8MP+EbUN/Md1r3iCTBsCcDlB
 Ddfsytr59FmRSUaZDK/+k6/qyn4g5cH+q+zUsJzso2QYJSLOj95vmrB9zJojM3wrS98emVY1N
 Dsae4zRYTXoJA3YZuIvMN7Y5iz4NFarvOfHeovCkCdizHs4zF7CGi9W+v2D2t2FF0sOZTkvYK
 D7khcPCOmcwHAqGLTxrmU4C9ALj3npDqHNg6GcgmdbsnuQdYISUzeoaJQIDX0akdPTm6O1fgM
 trrtlkQna4exF6RnQJTCMsaL+YnqDfgn/qADRtsTXiNuemnRwy67ZLobtPVkaI2FYtGjn9EK+
 NIx9glXKmMRHGyqAVD8/AbznHLBGGrm8/zhmjh8ixBCWEJsyezpuVRdSVvfOxi//FH1QQGs3Y
 fvZEgBoOQBpflTGejTVcg++2ojRLzgSluh1FMQdtjCRVzyxWja4w2qpH4PzgOTTSBfTkjr4gW
 +Rnc1y/tzAnfbDa94yIRrEq1Z3hDbo3a0bmFsx/Ye1B/uX7df/BvS2n9EBj6GR/HSQ41B/C3h
 S7Mu5CfnlScEPwXQZK3ECs8eKS+qFY143YmjQOWWncwyTKS9vzutIMUEau7OClS328G9nJGIc
 Ae5KYt5cNBy9FDku3WtoAZHvHdndvPlFvHPYuxkzv9wOf4/QUhJwjEQt+rabX51KmPrea8RF0
 X7mVBffFg0BrCS+c2L15jt/5tbSAuMfEEI1LxnCgIGyJ+bIs8ogb/TivzfB2f+/fHoG0Fto93
 /RIH7gVk9aN9KXsVtVXQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 11:02 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 8 Jan 2020 10:26:02 +0900 Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > Hi Arnd,
> >
> > On Tue,  7 Jan 2020 22:40:26 +0100
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > gcc -O3 produces some really odd warnings for this file:
> > >
> > > kernel/kallsyms.c: In function 'sprint_symbol':
> > > kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
> > >    strcpy(buffer, name);
> > >    ^~~~~~~~~~~~~~~~~~~~
> > > kernel/kallsyms.c: In function 'sprint_symbol_no_offset':
> > > kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
> > >    strcpy(buffer, name);
> > >    ^~~~~~~~~~~~~~~~~~~~
> > > kernel/kallsyms.c: In function 'sprint_backtrace':
> > > kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
> > >    strcpy(buffer, name);
> > >    ^~~~~~~~~~~~~~~~~~~~
> > >
> > > This obviously cannot be since it is preceded by an 'if (name != buffer)'
> > > check.
> >
> > Hmm, this looks like a bug in gcc.
>
> Yes, we're getting a lot of such reports.  I don't think current gcc is
> ready for this patch so I'll drop it, sorry.

I've been building with gcc-8 and got around 20 false positive
warnings, three real bugs
and a few files that introduce increased stack usage. I have sent
patches for every one
of these and have a clean randconfig builds again on arm, arm64 and
x86 (a few thousand
so far).

Most of the false-positive warnings are for understandable reasons and easy to
work around, the one above is probably the most blatant screwup by gcc.

My feeling is that we can deal with the warnings here and I wouldn't
mind getting
it enabled in mainline from that perspective, but there are two caveats:

- v5.6 is probably too early since we're close to the merge window and a lot of
  my fixups have not been merged yet

- I have no good estimate of how many runtime failures there will be.
  Oleksandr hasn't found any issues after running with -O3 kernels for
  a longer time, but any significant change to the toolchain likely causes
  problems for somebody.

        Arnd
