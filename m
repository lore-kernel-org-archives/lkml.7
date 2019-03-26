Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBDFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F2920856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="A9VeeXFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCZEBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 00:01:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44035 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfCZEBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 00:01:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so8483991wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 21:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFufxt99trQk1HrJ4DBQy+Tki5RtsOLE22J4daML9P4=;
        b=A9VeeXFqjsG81fFSUA9hMLPRtVGYZKYYzkZLKEU4RLZ3dHQhZYtk/mzXr0J/fMWwRd
         /X8MEpkRsr0FRmmfEjfmKMUBv+9d0zPL3TS4VbcR2Un6ePOYO75E8OOv1YqiyeABE0vP
         eZCSyI1TCvlvAupaiL03MdO/Z/H+4RugYJJLji2pN+CrGcp+XkRe079drkx054hpjTxf
         umvaGW3zh+S2PbfAXQ5rt1tQ/JmN7sIKtY9W+d+Q9iLkktCWEkxRzPeQuEla+/U7h36y
         uGRmDB6LHDCwhojFwJ7RKxFaZqilQdq7yG8nxgzcmaTVGVIOJLUHL3Z4+go3PXTPYDoq
         sYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFufxt99trQk1HrJ4DBQy+Tki5RtsOLE22J4daML9P4=;
        b=X8BOnVXBPWuP3IMV6CyGtTXkDBhbsE4GQscFD9Ul5tLs8xe546+Vgh3uHJoiQ/newY
         ca0EufrlcAZYJuXg5Ft36Vsbz4t74iSSl9iWFXnhy99kfZhzIw6Siy9rTYe2ZE82fMnN
         rps5UJePRH5eKKqYzAC6j0CAO7+F1ekNu4LY1fqb9ZWGq/dOzIbtMUNkZmUtqBTApnFK
         1lIe2n2atI3pEU8XNb3K9ITY7Wum/zEij5i/narJuVyhwrc7nk/L8D4e31wMwgauqT0t
         GQmj+J98eYq/3kXnAEGznfJyHx0rUx7eabCYfbfNCYR5CCgJAt42cw1aPgGz66NMLwn+
         zsPA==
X-Gm-Message-State: APjAAAUJdyb4Sd/TIBgmuOMgSUrtEq7RLdIrP3hYvzwb03aPAwuKmMrg
        sfyx/kmv8EYD6+Dg6q/lOZzZ0/XNghMgorG6hOYgrg==
X-Google-Smtp-Source: APXvYqymD/u0BO41fMRa6kBbI8PhOpFAubq3PkqMFeDFkLGxTdC2E1fTjoZ9HIDxgNLQQ0tQb2g6B1MVCbbodzSS1eM=
X-Received: by 2002:a05:6000:120c:: with SMTP id e12mr4272556wrx.187.1553572897984;
 Mon, 25 Mar 2019 21:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy2-CX729tVuuZzArswpFEC_OeRXhwXtCaiNe53AuzqdTw@mail.gmail.com>
 <mhng-8e00a3e3-5a69-4828-b7bb-2bf000199b48@palmer-si-x1c4>
In-Reply-To: <mhng-8e00a3e3-5a69-4828-b7bb-2bf000199b48@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 26 Mar 2019 09:31:26 +0530
Message-ID: <CAAhSdy2POcL2Y8VzULCHRa6cLKZ82GkEgXCgx_SoNZ1vMPvQjQ@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Always compile mm/init.c with cmodel=medany
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alan Kao <alankao@andestech.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 7:52 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 25 Mar 2019 00:01:45 PDT (-0700), anup@brainfault.org wrote:
> > On Mon, Mar 25, 2019 at 12:18 PM Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> On Mon, Mar 25, 2019 at 01:25:50PM +0800, Alan Kao wrote:
> >> > Hi Anup,
> >> >
> >> > Sorry for being late to the party.  I think one more thing should
> >> > move together with setup_vm():
> >>
> >> Ah, I wonded about that yesterday but wasn't sure.  Maybe notrace
> >> is a little cleaner?  Either way we should probably document both
> >> the mcmodel and notrace assumptions in source comments for the next
> >> person touching this code.
> >
> > The setup_vm() should be allowed to call other functions within mm/init.c
> > so let's go with file-level notrace (just like how it was done) for
> > kernel/setup.c
> >
> > I certainly add comments for setup_vm() based on all our findings so far.
>
> Sorry for being slow here, but this is the right approach: setup_vm is called
> before relocate, which means the page tables won't be set up correctly for
> absolute addressing.  We instead build setup_vm with medany, which causes all
> addressing to be PC-relative.  This is all a bit of a hack, but it's the only
> way we have to do this right now.
>
> You should be able to add a preprocessor #error to check the code model with
> something like this
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b379a75ac6a6..d6fde6af8d75 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -172,6 +172,9 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>         }
>  }
>
> +#ifndef __riscv_cmodel_medany
> +#error "setup_vm() is called from head.S before relocate and must not make any absolute references."
> +#endif
>  asmlinkage void __init setup_vm(void)
>  {
>         extern char _start;
>
> Marking this notrace is the right thing to do, as it can't call into any
> functions that aren't medany (there's probably other issues as well, since this
> is so early).

Thanks for the suggestion, I will add "#error" in v4 of this patch.

>
> Sorry I missed this the first time around, I wasn't paying enough attention.
>
> Can someone add instructions for 32-bit boots to the QEMU wiki?  It sounds like
> it's time to add that to the testing list...

To start with, I have send a patch for adding rv32_defconfig which is right now
"defconfig" plus "CONFIG_ARCH_RV32I=y"

Regards,
Anup
