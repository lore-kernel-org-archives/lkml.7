Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E2BECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA1321721
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="V5mdnIjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388895AbfJNTaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:30:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42865 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbfJNTaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:30:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id y91so15783841ede.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIlGWH7wshAdmQPQnvh6IPOGbDUQee/fBcMupsDy2Yg=;
        b=V5mdnIjnioWkVjrobG6tmEwjoXrFCBzemiMo18PIPiiNQFechVzXynv20H09Z+wndl
         OMqX6Yvcbob/cCOW/HG7f+QsYKt1sMYEfs2EFuygO5szJ1B3msXMCHsy/JdKCHLvtdDG
         yFYg55ufHy0FmyPgxHM2IyS7eIYsDknKnfTvLW9jQ9xkR2+IurjnFSi+osyTiNd7iBK/
         T/IS0M0tgeJpEOPuyaLXLT4tCCOb21zqZxeF5WUng4uAud/yRJr3y0xK3U15B+AH6Qhg
         gmgiPhyccTZth7D5jiiRTsjpxts8hf36+Fy3OW7clcAbGbSEJVHIJfIzSZEKBs2+cK5d
         HpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIlGWH7wshAdmQPQnvh6IPOGbDUQee/fBcMupsDy2Yg=;
        b=EXKC26XrksWt8DALShdu2U2QkbBLgrh5j70HuPNga5i9GQ46fFBNTG/5gER/FXdw/y
         PiE5qyOl2wY1aBi7BWVVenInOZfaZwbo1Fqq9DEo918495kC1wENQ9gFrdqY9gPUUV+V
         CNCV4MiL9UQ8lqdG4p5i9TTNKAeGUy8rxTuscrtH+L/2DQhiAV64Rawwuj4ysHThyjEP
         wwC+3u6zxOahc6SpC4xh/lWmwC9MvXl3yztFTR4VSh7FY5x+ExPxThZctv6UTS/yNe9I
         EX4OtBCYe3JwnBtaW7CW7E8nVja+TMQcnzyqSocqPchc8ixgY83Hc+gULK/n6Si/gVsN
         J0mA==
X-Gm-Message-State: APjAAAVuM54krrCdl2vsrJGkWAlOUtJChzPkIRlojwItHsIH489nkKeB
        VdJqOglSEaNqF44yz2C6z/ytoygY48qNeAbT5lE6Qg==
X-Google-Smtp-Source: APXvYqz3tIhyaGsZu4/lfjFbR9DxFhIt0sseQX6CsiNmmunhKYf+FnIGntsN+/O5mKhxIu232qNcvhzgmMK19NiaHWU=
X-Received: by 2002:a17:906:2cca:: with SMTP id r10mr30792016ejr.108.1571081409709;
 Mon, 14 Oct 2019 12:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-15-pasha.tatashin@soleen.com> <f1c50a5f-103e-e6d7-e93d-e873a169833e@arm.com>
In-Reply-To: <f1c50a5f-103e-e6d7-e93d-e873a169833e@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 14 Oct 2019 15:29:58 -0400
Message-ID: <CA+CK2bBU3ZkTRP8VuS7zwKLPBa+4nSdirq_ss7_aODoLe2iucA@mail.gmail.com>
Subject: Re: [PATCH v6 14/17] arm64: kexec: move relocation function setup and
 clean up
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > In addition, do some cleanup: add infor about reloction function to
>
> infor ? reloction?

Typo. I have fixed commit log. It meant to be "info about
arm64_relocate_new_kernel function"

>
>
> > kexec_image_info(), and remove extra messages from machine_kexec().
>
>
> > Make dtb_mem, always available, if CONFIG_KEXEC_FILE is not configured
> > dtb_mem is set to zero anyway.
>
> This is unrelated cleanup, please do it as an earlier patch to make it clearer what you
> are changing here.
Ok.

>
> (I'm not convinced you need to cache va<->pa)
>
>
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index 12a561a54128..d15ca1ca1e83 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -90,14 +90,15 @@ static inline void crash_prepare_suspend(void) {}
> >  static inline void crash_post_resume(void) {}
> >  #endif
> >
> > -#ifdef CONFIG_KEXEC_FILE
> >  #define ARCH_HAS_KIMAGE_ARCH
> >
> >  struct kimage_arch {
> >       void *dtb;
> >       unsigned long dtb_mem;
>
> > +     unsigned long kern_reloc;
>
> This is cache-ing the physical address of an all-architectures value from struct kimage,
> in the arch specific part of struct kiamge. Why?
> (You must have the struct kimage on hand to access this thing at all!)

Because, currently only one physical page is used in order to do reboot:
control_code_page; this is where arm64_relocate_new_kernel is copied.
So, PA of control_code_page is used as a handler. But with MMU enabled
kexec reboot, a number of pages are allocated for reboot purposes,
they contain page table, arm64_relocate_new_kernel, and el2 vector
table. This is why we need handlers. control_code_page is simply one
of the pages that can contains any of the kexec reboot specific data.

> If its supposed to be a physical address, please use phys_addr_t.

Done that, also changed dtb_mem to phys_addr_t.

>
> >  };
>
>
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index 0df8493624e0..9b41da50e6f7 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -42,6 +42,7 @@ static void _kexec_image_info(const char *func, int line,
> >       pr_debug("    start:       %lx\n", kimage->start);
> >       pr_debug("    head:        %lx\n", kimage->head);
> >       pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
> > +     pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
> >
> >       for (i = 0; i < kimage->nr_segments; i++) {
> >               pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
> > @@ -58,6 +59,19 @@ void machine_kexec_cleanup(struct kimage *kimage)
> >       /* Empty routine needed to avoid build errors. */
> >  }
> >
> > +int machine_kexec_post_load(struct kimage *kimage)
> > +{
> > +     unsigned long kern_reloc;
> > +
> > +     kern_reloc = page_to_phys(kimage->control_code_page);
>
> kern_reloc should be phys_addr_t.

Ok

>
>
> > +     memcpy(__va(kern_reloc), arm64_relocate_new_kernel,
> > +            arm64_relocate_new_kernel_size);
> > +     kimage->arch.kern_reloc = kern_reloc;
>
>
> Please move the cache maintenance in here too. This will save us doing it late during
> kdump. This will also group the mmu-on changes together.

OK, but I think we should do it in a separate patch. I assume you mean
this code to be moved to load time:

177         /* Flush the reboot_code_buffer in preparation for its execution. */
178         __flush_dcache_area(reboot_code_buffer,
arm64_relocate_new_kernel_size);
179
180         /*
181          * Although we've killed off the secondary CPUs, we don't update
182          * the online mask if we're handling a crash kernel and consequently
183          * need to avoid flush_icache_range(), which will attempt to IPI
184          * the offline CPUs. Therefore, we must use the __* variant here.
185          */
186         __flush_icache_range((uintptr_t)reboot_code_buffer,
187                              arm64_relocate_new_kernel_size);

Is it safe to do? We do not know what CPU is going to be executing
kexec reboot for us at the load time.

Pasha
