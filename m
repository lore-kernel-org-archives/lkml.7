Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCA7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5DC2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="oMcV9Qsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfCXEQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:16:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36558 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCXEQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 00:16:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so5704854wml.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 21:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJcnT5dwTmgu7HoGHnOBrIOugHBvna1fMwqu9gN6KUk=;
        b=oMcV9QswJMr4ZCvb7NhJtyiTRvHaYDoT/4TqApGnGNwWRm8A9YhMU4e3xAplMrgSUk
         4De8lGuuSLM7i1grA60EJrztUVKpyiDPghGsgnddW8CUTDoXOG/6IpWzJ/dTLR1K4bwR
         hkQnPNyZMHo2picdY4834zqU6AEvjHubQJEiM4279qlgC+LgH5ZynNraTJLs1xjXRjBS
         qf0xYhEM1iTi6IiPD9SvnS0yQK//Q1lPOiuhYCasCj0hZMqRlV5OLghvADZA8NiFgSzE
         cCFcyVIKvkX1wd3/6XrYJxeP7deKokMwm0jWEoWwArSDxgH3GXs6fgTWFPvwk23fBOj8
         QMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJcnT5dwTmgu7HoGHnOBrIOugHBvna1fMwqu9gN6KUk=;
        b=anEm3Ht7ZmW/SbaXORnZApyjLJp6tTktyjUO0K6ONStZ4+7XzUTCwpKnH+KiJ8SMoI
         TaEUg5f+88T5IhGMbgfaVd2IsR5KZEEqL/Rej5saKq+Z7kKQR1NYvsnhGSIiU2boySFt
         hzedJgDui+6on4yFL6ujWSkVmStbbm1wAkIMKaiL/zyb5k8v3b0/HPUyfyLM2NCiiL0F
         yhaSGh0tRSCU+YTqm9SQLQpyqhAMjAi5HLP5RkalCdRirJiiZiOAUbUXzDWHueYx9N3o
         cXZfsYvmwWzEqxhWhs64kPIHIF4jjO/dMVnSFPW9uXONKV/VhZeaCRvXtvk6v9xObh/B
         tZPw==
X-Gm-Message-State: APjAAAXSz22O/FVbyqajD2oeeK8MMcclWu3FfGZEd2OuQATyaxww1qeh
        U4QYMYuhHeCENPfXkZhXHts++UQCmfVHGkyai8/5gA==
X-Google-Smtp-Source: APXvYqyyIo4eYKj4CBhjPwWjw0kMvGMe3WtrqZt3RZz5gU1YJxxpWdIocVLVISDA8VmuBE3htmn9PfWYtBTX7dNekEE=
X-Received: by 2002:a1c:700e:: with SMTP id l14mr6969803wmc.132.1553401006058;
 Sat, 23 Mar 2019 21:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190321094710.16552-1-anup.patel@wdc.com> <20190321094710.16552-4-anup.patel@wdc.com>
 <20190323154012.GA25149@rapoport-lnx> <20190323172421.GA14080@infradead.org>
In-Reply-To: <20190323172421.GA14080@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 24 Mar 2019 09:46:34 +0530
Message-ID: <CAAhSdy2chHhAUJ5DtmaqHS8LFuFuiwhmnsh9mmuKZd8MX=Bqkg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] RISC-V: Allow booting kernel from any 4KB aligned address
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:54 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Mar 23, 2019 at 05:40:12PM +0200, Mike Rapoport wrote:
> > I have no general objection, but I presume the patch will be significantly
> > simplified if the addition of 4K pages support will follow the removal of
> > the trampoline_pd_dir.
> >
> > That said, I didn't look into the details, since they will change
> > substantially, only some comments on the Kconfig part.
> >
> > On the high level, have you considered using large pages in setup_vm() and
> > the remapping everything with 4K pages in setup_vm_final()?  This might
> > save you the whole ops-> churn.
>
> That would be a great start.  That being said the current tiny memory
> RISC-V devices don't even have a MMU, so the kernel pagetable mapping
> isn't even relevant for them.  I'm just not sure adding more complexity
> in the early boot path for a borderline case (MMU and tiny memory
> with a tiny kernel image) is reall worth all the complexity.

It's not just for addressing a borderline case (MMU and tiny memory with tiny
kernel image).

We trying to addresses following issues in current code:
1. The current setup_vm() maps all possible kernel virtual addresses (128GB
on 64bit system and 1GB on 32bit system). The amount RAM present on
real systems might be much less so we should not have kernel mappings for
non-existent RAM. Of course, we don't know amount of RAM available in
setup_vm() so we have to split page table setup in two parts and do minimal
required mapping in setup_vm().
2. NOMMU kernel requires a swapper_pg_dir with identity mapping (VA == PA)
and without it we get boot-time crash so we cannot skip it for NOMMU case. For
NOMMU, the PAGE_OFFSET will typically be 0x80020000 (or 0x80xxxxxx). This
means swapper_pmd array (which uses -PAGE_OFFSET) will be over-sized
causing compile errors.
3. For both NOMMU with tiny memory and MMU with tiny memory, the current
setup_vm() is not allowing us to place kernel on non-2M (or non-4M) aligned
addressed there by causing memory below kernel to be wasted.
4. For MMU based kernel, the current setup_vm() is hard-wired for fixed 2M
mapping size. It will require more changes if we want to do 1G mappings.

The above issues motivated us to re-write setup_vm().

We are trying to make initial page table setup more flexible and robust so that:
1. We don't have any unwanted mappings pointing to non-existent RAM
2. We can have any value of PAGE_OFFSET for NOMMU case without the
page table arrays becoming oversized
3. We can create mappings of best possible size to get good performance
4. We can boot from any 4K/2M/1G (or just 4K) aligned load address

Also, the end result of all this is a much more readable page table setup code
shared between setup_vm() an setup_vm_final() where the differences are
abstracted via mapping ops.

Regards,
Anup
