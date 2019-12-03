Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67104C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6B020833
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LKcdtz2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfLCUzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:55:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33281 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfLCUzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:55:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id l63so4546220ede.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 12:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrfqpdrRjwoZiFBHPvlWCSIImBTXrf4uvrPFjFxjWQs=;
        b=LKcdtz2dCG81ly/gmv1B2MsD85r4hQLPyL3BcXdP8OgAvXqXQ3SFH3EXG6D8Rn1EGx
         5SotKnQgn7N9Pl+QeGARf64JQNhbwmnURF3muYxzLGCRPTLEvM1Vy3mbNA9nxJZLq5EW
         UBh9ashGoCdUZU8WLTY3SjfxI5H7jicraZPlqtnXLsDsHA5APwb5sMkY6Rn6XCJ6kmBG
         GUrF03WFvW7Chd/iurLMWq9/cxmrW1WfAeJQG8Q9FPJ9BfeKcRhDYw660hyLue9Z5jjC
         85xzTbtD/0C9MAjLHLO7fdy4vZdqgfSonayKnJq+kpcLt/Oe2N1w3L6JQqQ+zu9O4LkN
         ba/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrfqpdrRjwoZiFBHPvlWCSIImBTXrf4uvrPFjFxjWQs=;
        b=BWJxuXHBY4lqQgY+544dJ2zQ+SKoJQM5oZGYhSrhxVLUV6oMPDTwAaqr+XotfzmKqO
         8ssPDGN5jQ/p/cJCLNiI7FUNxPUYTbhxfEsJv7UtnPo1UdBL++jWABwi+ZEtaaojj/y+
         N5TzeLe0PC1lXcmlK+jmgnfg/MrbaSiejmquJBmHxv/9uB65SpMnfaTJ19ar3taiKter
         PtczU/dtA7eDlpb3SnT6x6POsNFHDQy7nekj+bKJBRALcF50C/v3We+qFQiDIFzoxhJ1
         S/GxmYwwsDG0svXCm8mMW3WDENCzidG/1rBkRj2cv9W88Ywh9akdgLltzQ2Pz6MZ2xcr
         FWqA==
X-Gm-Message-State: APjAAAVtuAnvs8703JLySykcDgVBDadRi8Ig5Gjtn/9Uyo7MC891O3cm
        Lvef5MU5p0/OOKr4UO3XGLi9ofWZvAKpITtKXXwXVQ==
X-Google-Smtp-Source: APXvYqxbuZmKlFlMkZgJ6kaUVfY3/fnzZWPTuptargTqeX+obRHCvgiks/lfqff3ObT9USqQzkwn4SMCYuIF6Y9/DkE=
X-Received: by 2002:a17:906:4d89:: with SMTP id s9mr913056eju.268.1575406504645;
 Tue, 03 Dec 2019 12:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20191203204053.12956-1-longman@redhat.com>
In-Reply-To: <20191203204053.12956-1-longman@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 3 Dec 2019 15:54:53 -0500
Message-ID: <CA+CK2bBvoM5bb0q2Ha7-+_6Pt5Qx_Vptx7zs2cEYUVuU=vWt7Q@mail.gmail.com>
Subject: Re: [PATCH] x86/tsc: Fix incorrect enabling of __use_tsc static_key
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 3:41 PM Waiman Long <longman@redhat.com> wrote:
>
> After applying the commit 4763f03d3d18 ("x86/tsc: Use TSC as sched clock
> early") and the commit 608008a45798 ("x86/tsc: Consolidate init code"),
> some x86 systems boot up with the following warnings:
>
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 2599.853 MHz processor
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] static_key_enable_cpuslocked(): static key
> '__use_tsc+0x0/0x10' used before call to jump_label_init()
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:132 static_key_enable_cpuslocked+0x7b/0x80
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-154.el8.x86_64 #1
> [    0.000000] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
> [    0.000000] RIP: 0010:static_key_enable_cpuslocked+0x7b/0x80
>   :
> [    0.000000] Call Trace:
> [    0.000000]  ? static_key_enable+0x16/0x20
> [    0.000000]  ? setup_arch+0x43f/0xf68
> [    0.000000]  ? printk+0x58/0x6f
> [    0.000000]  ? start_kernel+0x63/0x55b
> [    0.000000]  ? load_ucode_bsp+0xfb/0x12e
> [    0.000000]  ? secondary_startup_64+0xb7/0xc0
> [    0.000000] ---[ end trace fc2166797a50a8e0 ]---
>   :
> [ 1781.404905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.000 msecs
> [ 1781.409905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.000 msecs
> [ 1781.412905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.000 msecs
> [ 1781.578905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.000 msecs
> [ 1781.973905] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.000 msecs
>   :
>
> In this particular case,
>
>   setup_arch() => tsc_early_init()
>                => tsc_enable_sched_clock()
>                => static_branch_enable()
>
> However, jump_label_init() is called after setup_arch(). Before the
> 2 commits listed above, static_branch_enable() was only called in
> tsc_init() which is after jump_label_init().

Hi Waiman,

jump_label_init() is called from setup_arch():
https://soleen.com/source/xref/linux/arch/x86/kernel/setup.c?r=11a98f37#911

 tsc_early_init() early init is also called from setup_arch() but later:
https://soleen.com/source/xref/linux/arch/x86/kernel/setup.c?r=11a98f37#1053

I think that the kernel where this problem is seen, might be missing
8990cac6e5ea7fa57607736019fe8dca961b998f x86/jump_label: Initialize
static branching early
Or some other patches from that series.

Thank you,
Pasha
