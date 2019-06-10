Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C88C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94A120859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389274AbfFJKTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:19:04 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51363 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388685AbfFJKTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:19:03 -0400
Received: by mail-it1-f195.google.com with SMTP id m3so12375701itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+s1qLXCvqwzbr22mFErQyyk+3j3cdDsCDDkT5MoVVBA=;
        b=Z8RafCZCV8SviCu+3aWbBKyNPlXSVqufTjvpkuYyltZPcYLz/PyE9xRt3qIGlNXvUj
         rdAPTGr1Eo8V0WW87P78N8677Uqhhp3CMV8WpG3vmyVELGj8GC/1DSKei8xm0Z8YOloC
         SjCMkcsGw7jhXgwXlb4mgEqlDncCVz6OhiK2hgOEmgu8PMu2XTR5ZSAcEoINWfpUoCl9
         ilIU4ZJLngZ3TlwNBBeguWN/bLHHX/Shr1vPwSlNMxRJOFJdJL1XOo9OmhTm93i6ssgM
         E7ZA5uzANLo4h5yTEpUDU2dLuEW2ol4H2dxJUUZ5QJexfdlk+/Q9ojRZwVskSR5UT15R
         qRcg==
X-Gm-Message-State: APjAAAUSCyOC9D1fSLgFBncndffSufGGABGUuFDzqsc0BRYIKRHmVRj1
        dZakkH4Xcb2XBwgg12OTl9xwu9I5184y+e25mFSOfg==
X-Google-Smtp-Source: APXvYqwIYVHEchoiN3iU8hLMeRqlH6jgxgWM3uWpVEsXU8i/JxzUlHw6l3phxSZG4PLaVsxPmDEWS3xensFf792xlg0=
X-Received: by 2002:a24:2e8c:: with SMTP id i134mr13166926ita.9.1560161941664;
 Mon, 10 Jun 2019 03:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190610073617.19767-1-kasong@redhat.com> <20190610095150.GA5488@zn.tnic>
In-Reply-To: <20190610095150.GA5488@zn.tnic>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 10 Jun 2019 18:18:50 +0800
Message-ID: <CACPcB9f-sussXaOuOau6=CD85pS2KhcsknpJDQH_aEkwvLfvVA@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 5:52 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jun 10, 2019 at 03:36:17PM +0800, Kairui Song wrote:
> > With the recent addition of RSDP parsing in decompression stage, kexec
> > kernel now needs ACPI tables to be covered by the identity mapping.
> > And in commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and
> > ACPI tables to the ident map"), ACPI tables memory region was added to
> > the ident map.
> >
> > But on some machines, there is only ACPI NVS memory region, and the ACPI
> > tables is located in the NVS region instead. In such case second kernel
>
> *are* located - plural.
>
> > will still fail when trying to access ACPI tables.
> >
> > So, to fix the problem, add NVS memory region in the ident map as well.
> >
> > Fixes: 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI tables to the ident map")
> > Suggested-by: Junichi Nomura <j-nomura@ce.jp.nec.com>
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >
> > Tested with my laptop and VM, on top of current tip:x86/boot.
>
> You tested this in a VM and not on the *actual* machine with the NVS
> region?
>
> This is a joke, right?
>

Hi Boris, unfortunately I don't have a real machine which only have
the NVS region.
I did fake the memmap to emulate such problem but can't really promise
this will fix the real case.
So just declare it won't break anything that is already working. And
I'm asking Junichi to have a try as he reported this issue on the
machines he has.

-- 
Best Regards,
Kairui Song
