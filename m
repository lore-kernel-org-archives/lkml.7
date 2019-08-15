Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3E5C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FB220644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuC4bGhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfHOTHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:07:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53473 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbfHOTHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:07:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id 10so2134954wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBsH6G8xDjPBbisE7eK6/VhgX2T7A81OIBqCI71i9iE=;
        b=ZuC4bGhBIxaw602HwL2nG7CszOYB/j/jg7zfW/vAtooqvzLSy5coyIVbfLXpdQJPOE
         hIr3vw5kp1le/bMabqLo04ZAZK2+XL4P3YbU7RtASqoVHIfD5BAxVhnNnVXn9baaDYtC
         QNcCtfCr1ys3MSbWF5pCajgJyRCqKzLjkZpWeI0S7O+AhohlUdJvq8Qgv8J+VOKLy+oN
         TTmJB0/xF0yZnPddTvSrzd50vIx9K60EQPN9vuJ/cYVTQ+ICDAG2qes8lpBSkdv4ZTXq
         dAUTfKPQPmQDdi3BPm14+sO5GPrEUrjZULshsKxox5FTAzCdJU+RT1u1y4hP70ZggfBF
         Ocfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBsH6G8xDjPBbisE7eK6/VhgX2T7A81OIBqCI71i9iE=;
        b=ku0+fU/BNuUi/+5lPAGh5quPT+xqKN1H139mJcL6KEaC2BBIpVbIZbiZ6e6q9RBJyW
         QkTWgM3x9EAMVq9NFaTQknmjOkNjomORTRjVvL1oMxwmT+mGjqQpC30awKgdO3JJmbZn
         AqBt9416SIdI/7POArMe97mhpZTsRZCE2JvILTrYa4MPMWsFTChBBTzuUH1flWr1q2EM
         m813XnHC7MwKUweyPsK+0JQCR7+tX8JJGqlYUqTIemBSweodZM2vWthDh7Oo9lrTaHbL
         OrGn+CUwPjN2Gxmm+Dq8oAuv8UsA2X4DHA9VNFDpqlfg0vCDhtr29dilO3wtYmbCKR4+
         vCtQ==
X-Gm-Message-State: APjAAAXhSWkHvz9u21ssZ9h9i1rs3oGKASaKCBms1TloN+afwJSCQ3Jm
        wZURCvUDILAFx5FFsDyPZvTF0in+obVq40gam3c=
X-Google-Smtp-Source: APXvYqzix+51pj/isYyBNzDTtniw3OSI93Yr9WWrLDxkyOFIqVAGlLrFW9olHXKW77n3t8voZ6YSbWP2ti34O5rcEj0=
X-Received: by 2002:a1c:f90f:: with SMTP id x15mr3934778wmh.69.1565896067843;
 Thu, 15 Aug 2019 12:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190607060049.29257-1-anup.patel@wdc.com> <20190607060049.29257-3-anup.patel@wdc.com>
 <alpine.DEB.2.21.9999.1907101703150.3422@viisi.sifive.com> <847fb8c879bbd2c3fd41dc1e428b3217253acebb.camel@wdc.com>
In-Reply-To: <847fb8c879bbd2c3fd41dc1e428b3217253acebb.camel@wdc.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Thu, 15 Aug 2019 12:07:11 -0700
Message-ID: <CAEn-LTpz_iL0Ts5GG9J6oESN76DcjBaNs-Oz-c9CcpbmRiN5Sw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] RISC-V: Setup initial page tables in two stages
To:     Alistair Francis <Alistair.Francis@wdc.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:57 AM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Wed, 2019-07-10 at 17:05 -0700, Paul Walmsley wrote:
> > On Fri, 7 Jun 2019, Anup Patel wrote:
> >
> > > Currently, the setup_vm() does initial page table setup in one-shot
> > > very early before enabling MMU. Due to this, the setup_vm() has to
> > > map
> > > all possible kernel virtual addresses since it does not know size
> > > and
> > > location of RAM. This means we have kernel mappings for non-
> > > existent
> > > RAM and any buggy driver (or kernel) code doing out-of-bound access
> > > to RAM will not fault and cause underterministic behaviour.
> > >
> > > Further, the setup_vm() creates PMD mappings (i.e. 2M mappings) for
> > > RV64 systems. This means for PAGE_OFFSET=0xffffffe000000000 (i.e.
> > > MAXPHYSMEM_128GB=y), the setup_vm() will require 129 pages (i.e.
> > > 516 KB) of memory for initial page tables which is never freed. The
> > > memory required for initial page tables will further increase if
> > > we chose a lower value of PAGE_OFFSET (e.g. 0xffffff0000000000)
> > >
> > > This patch implements two-staged initial page table setup, as
> > > follows:
> > > 1. Early (i.e. setup_vm()): This stage maps kernel image and DTB in
> > > a early page table (i.e. early_pg_dir). The early_pg_dir will be
> > > used
> > > only by boot HART so it can be freed as-part of init memory free-
> > > up.
> > > 2. Final (i.e. setup_vm_final()): This stage maps all possible RAM
> > > banks in the final page table (i.e. swapper_pg_dir). The boot HART
> > > will start using swapper_pg_dir at the end of setup_vm_final(). All
> > > non-boot HARTs directly use the swapper_pg_dir created by boot
> > > HART.
> > >
> > > We have following advantages with this new approach:
> > > 1. Kernel mappings for non-existent RAM don't exists anymore.
> > > 2. Memory consumed by initial page tables is now indpendent of the
> > > chosen PAGE_OFFSET.
> > > 3. Memory consumed by initial page tables on RV64 system is 2 pages
> > > (i.e. 8 KB) which has significantly reduced and these pages will be
> > > freed as-part of the init memory free-up.
> > >
> > > The patch also provides a foundation for implementing strict kernel
> > > mappings where we protect kernel text and rodata using PTE
> > > permissions.
> > >
> > > Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >
> > Thanks, updated to apply and to fix a checkpatch warning, and
> > queued.
> >
> > This may not make it in for v5.3-rc1; if not, we'll submit it later.
>
> I'm seeing this failure on RV32 which I bisected to this patch:
>
> [    1.820461] systemd[1]: systemd 242-19-gdb2e367+ running in system
> mode. (-PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP
> -LIBCRYPTSETUP -GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS
> +KMOD -IDN2 -IDN -PCRE2 default-hierarchy=hybrid)
> [    1.824320] Unable to handle kernel paging request at virtual
> address 9ff00c15
> [    1.824973] Oops [#1]
> [    1.825162] Modules linked in:
> [    1.825536] CPU: 0 PID: 1 Comm: systemd Not tainted 5.2.0-rc7 #1
> [    1.826039] sepc: c05c3c78 ra : c04b5a74 sp : df047ce0
> [    1.826514]  gp : c07a1038 tp : df04c000 t0 : 000000fc
> [    1.826919]  t1 : 00000002 t2 : 000003ef s0 : df047cf0
> [    1.827322]  s1 : df7090f8 a0 : 9ff00c15 a1 : c072166c
> [    1.827723]  a2 : 00000000 a3 : 00000001 a4 : 00000001
> [    1.828104]  a5 : df6f8138 a6 : 0000002f a7 : de62a000
> [    1.828534]  s2 : c072166c s3 : 00000000 s4 : 00000000
> [    1.828931]  s5 : c07a2000 s6 : 00400cc0 s7 : 00000400
> [    1.829319]  s8 : de491018 s9 : 00000000 s10: fffff000
> [    1.829702]  s11: de491030 t3 : de62b000 t4 : 00000000
> [    1.830090]  t5 : 00000000 t6 : 00000080
> [    1.830392] sstatus: 00000100 sbadaddr: 9ff00c15 scause: 0000000d
> [    1.831616] ---[ end trace 49a926a1a5300c00 ]---
> [    1.835776] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    1.836575] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b ]---
>
> Does anyone else see this?
>
> A simple revert of this patch on 5.3-rc4 fixes the issue for me.

Yes, I do see those in Fedora/RISCV build farm every morning, but with
riscv64 and 5.2.0-rc7 kernel.

You also seem to run 5.2.0-rc7 kernel.

fedora-riscv-4 login: [178876.406122] Unable to handle kernel paging
request at virtual address 0000000000012a28
fedora-riscv-7 login: [17983.074847] Unable to handle kernel paging
request at virtual address 0fffffdff5e14700

david
