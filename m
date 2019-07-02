Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06472C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEF221473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562039848;
	bh=L1T9vadujQemuCe6io/7BtgNH3TRPGtppwYc+XpbUQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KMY3YMF4BFDujCv2FP9o7E+cxTfZlLnbIqMbNDPWdhAEmBQ7wLk4QCcnAd9NoSeZ0
	 OK1FyW8Iau+dYLW029WILX9RPspBO6oJEf9hSk2EJSNduochYegz/ZPaZGW52g7/LZ
	 /aqQTCPiuDLSBEBiFK5PcN5EKueLFC3cL4nHUz+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfGBD51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfGBD51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:57:27 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC64621473
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2019 03:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562039846;
        bh=L1T9vadujQemuCe6io/7BtgNH3TRPGtppwYc+XpbUQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UVDNPuJK8jueGxfNA28fxE6dMOqxO1CNy/tMzdD3A8r+4d1h33rPIsl4Idr3XCT15
         2lpk9a1+RPFseyZs9+SdbG420apBOHS1bQcjNkC8uglQk4E90Suc8XNjqpIHinQ6+A
         FWGkol+1OBqU18/EWjHM76OEii4cE2EbmzZ4r8qQ=
Received: by mail-wr1-f52.google.com with SMTP id n4so15973976wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 20:57:25 -0700 (PDT)
X-Gm-Message-State: APjAAAUA5yVjjamJyiEf0ZXSaf3uaFkR9PC23hCYfVG8q9teqELTVJ01
        4t6yMhtt53rqSXnnqxjD2qU1fTjY+1xraQW2LupShA==
X-Google-Smtp-Source: APXvYqzu4ramvap8WjONzCBZxEAuG35b53nwbaf+EQIAPJkFgHcIFeMDFA7DO1JX04G9jepZ2a/LwZnWYWjxddXNVbI=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr20006121wrj.47.1562039844606;
 Mon, 01 Jul 2019 20:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562035429.git.luto@kernel.org>
In-Reply-To: <cover.1562035429.git.luto@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Jul 2019 20:57:12 -0700
X-Gmail-Original-Message-ID: <CALCETrVy_GUKJ9_oYWc6jk2gTs-PEj1Z0LMA0XQLx8EvzOu2Ww@mail.gmail.com>
Message-ID: <CALCETrVy_GUKJ9_oYWc6jk2gTs-PEj1Z0LMA0XQLx8EvzOu2Ww@mail.gmail.com>
Subject: Re: [PATCH 0/3] FSGSBASE fix, test, and a semi-related cleanup
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 8:43 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> In -tip, if FSGSBASE and PTI are on, the kernel crashes if SYSENTER
> happens with TF set.  It also crashes under if a non-NMI paranoid
> entry happens for any other reason from kernel mode with user GSBASE
> and user CR3, e.g. due to MOV SS shenanigans.
>
> This series fixes the bug.  It also adds another test to make sure
> we exercise SYSENTER with TF set regardless of what vendor's CPU
> we're on, although the test isn't needed to detect the bug: the
> single_step_syscall_32 and mov_ss_trap_* tests also trigger it.  And
> it compiles ignore_sysret out on IA32_EMULATION kernels -- I wasted
> a couple minutes while debugging this wondering whether I was
> accidentally triggering ignore_sysret.

I forgot to mention: even with this applied, the x86/cpu tree is not
ready for prime time.  The fsgsbase test case fails on released
kernels and crashes on x86/cpu.  I haven't gotten to the bottom of it
yet.  The test code looks a bit dubious, but that doesn't necessarily
mean the kernel is okay.
