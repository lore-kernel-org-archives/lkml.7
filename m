Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D0C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E8020665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1N4c1Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfGOME3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:04:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41763 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfGOME2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:04:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id p15so15198398eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siKrRVKRpx7RpKSTXYP2AWsLiceVEcAiCzz2p78ubgQ=;
        b=a1N4c1NtrSMBmRxyDN1bt+aTDEXwAEcei9NMSHaK04P0PCKhOuIH5Rpew/9/xRWm23
         Js79ou5nQuSpYL2Uv1qlCrixRaHPYiWh9me97FNMBPo44li0Mw8G508ONYsF6C1rcpiq
         KAgn0CbtK+Q+ZetNMzH5J2QSfmcp2viSOMtgFq8zHeD04TiIQFVJJT7Z6rykkYLxLsi/
         nStP3afTeB3MmiAnfjsqtd4CzuiawatGLjQxhloRHnsklUW5PyPaU9+F3dOrYJiHbjWK
         iUN59zVgLNhIQK/7QMVFl5C8PWNoGqp72CB0gHxiVb7ax2bqGx6LLj79R3ENL18ksSbp
         y4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siKrRVKRpx7RpKSTXYP2AWsLiceVEcAiCzz2p78ubgQ=;
        b=XROjsRiLjfGNY3XCTKUPbZqgpMrvDNtbB7ciQsuHd6JMZj89HEYetyQp8BwQp17ajt
         THGQXPkKp+31Y/YSVEh3tpet3gBCKVTB6wm84TBb/kMzijPkaN9jyD1lem99G0DYM2Q7
         zBNQtlb8ZzQpzOapie4yX7mZFvwL+f29TDNgdvP+k3tmVhPNNkv6saQxDmQnjDDWAcyp
         7FAeIdvsZdIomDBLHBW2l6IwuUD+JpvYQAljLclAoxyXGEdPKiONqN4tL0hDo83H4fLD
         pKlxEmyGYxu+7V/gEP+T2yTruqbeT5hZO4msWDPeHDV61yMLCT6o+oIhPIboWfmz1SJy
         idkQ==
X-Gm-Message-State: APjAAAX3Saz7tckn5z4NWg50S3SsnU14v2pb/fT3OPYNxfWfRPaeZ1LZ
        eV7fP82TDf6ajSGevWHVwzMBS5Xucc1V/vf8ScynnuHd7xM=
X-Google-Smtp-Source: APXvYqxYOkBm5l+PzyLYC3OqADqTZgk+BGzUavRdvCPRgVE2Mz+iQK9V2RgZatHrYNkJ7UJkZR7pLKzfiPvQ0XuzAUE=
X-Received: by 2002:a17:906:fac7:: with SMTP id lu7mr19649721ejb.109.1563192266966;
 Mon, 15 Jul 2019 05:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
 <alpine.DEB.2.21.1907151020320.1669@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907151020320.1669@nanos.tec.linutronix.de>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 15 Jul 2019 14:04:15 +0200
Message-ID: <CAFULd4aHwv9+dkTtNLtNGHu=wmt62cZDkjr-vbCVzYftJbOpEg@mail.gmail.com>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop targets
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 10:24 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Uros,
>
> On Thu, 11 Jul 2019, Uros Bizjak wrote:
> > Recent patch [1] disabled a self-snoop feature on a list of processor
> > models with a known errata, so we are confident that the feature
> > should work on remaining models also for other purposes than to speed
> > up MTRR programming.
> >
> > I would like to resurrect an old patch [2] that avoids calling clflush
> > and wbinvd
> > to invalidate caches when CPU supports selfsnoop.
>
> Please do not attach patches, send them inline and please add a proper
> changelog. Just saying 'Disable CPA cache flush for selfsnoop targets' in
> the subject line then nada gives absolutely zero information.

Thanks for your remarks and instructions!

I'll send a new revision of the patch with expanded ChangeLog later today,
saying something along the lines of:

"CPUs which have self-snooping capability can handle conflicting
memory type across CPUs by snooping its own cache. Commit #fd329f276ecaa
("x86/mtrr: Skip cache flushes on CPUs with cache self-snooping")
avoids cache flushes when MTRR registers are programmed. The Page
Attribute Table (PAT) is a companion feature to the MTRRs, and according
to section 11.12.4 of the Intel 64 and IA 32 Architectures Software
Developer's Manual, if the CPU supports cache self-snooping, it is not
necessary to flush caches when remapping a page that was previously
mapped as a different memory type.

Note that commit #1e03bff360010
("x86/cpu/intel: Clear cache self-snoop capability in CPUs with known errata")
cleared cache self-snoop capability for CPUs where conflicting memory types
lead to unpredictable behavior, machine check errors, or hangs."

> > The patch was ported to latest Fedora kernel (5.1.16) and tested with
> > CONFIG_CPA_DEBUG on INTEL_FAM6_IVYBRIDGE_X. The relevant ports of
> > dmesg show:
> >
> > ...
> > < hundreds of CPA protect messages, resulting from set_memory_rw CPA
> > undo test in mm/init_64.c >
> > CPA  protect  Rodata RO: 0xffffffffbd1fe000 - 0xffffffffbd1fefff PFN
> > 1461fe req 8000000000000063 prevent 0000000000000002
> > CPA  protect  Rodata RO: 0xffff889c461fe000 - 0xffff889c461fefff PFN
> > 1461fe req 8000000000000063 prevent 0000000000000002
> > Testing CPA: again
> > Freeing unused kernel image memory: 2016K
> > Freeing unused kernel image memory: 4K
> > x86/mm: Checked W+X mappings: passed, no W+X pages found.
> > rodata_test: all tests were successful
> > x86/mm: Checking user space page tables
> > x86/mm: Checked W+X mappings: passed, no W+X pages found.
> >
> > and from CPA selftest:
> >
> > CPA self-test:
> >  4k 36352 large 4021 gb 0 x 81[ffff889b00098000-ffff889bdf7ff000] miss 133120
> >  4k 180224 large 3740 gb 0 x 81[ffff889b00098000-ffff889bdf7ff000] miss 133120
> >  4k 180224 large 3740 gb 0 x 81[ffff889b00098000-ffff889bdf7ff000] miss 133120
> > ok.
>
> These outputs are pretty useless simply because the selftest only verifies
> the inner workings of CPA itself, but has nothing to do with the
> correctness vs. cache flushing.

Please note that CONFIG_CPA_DEBUG also spawns a pageattr-test kthread
which remaps a memory page every 30 seconds. I was confident enough to
run the patched kernel (with CONFIG_CPA_DEBUG) on my main workstation
(Ivybridge-X, Fedora 30), already for a week without a single problem.

Uros.
