Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05EAFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A84720872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390883AbfJPXWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:22:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41669 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfJPXWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:22:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so157342plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HsCb3Mo3Xna7EYoMwhTJhD9MwGz7SJTZ9CRewHqki9A=;
        b=Q0Kx9JeOMNVUkBPzSNv5QZZU1f4aIDPw8d1AHvxDbkZn918Ikj4/YOMB1uyCvXnJu2
         okw1jfABGV+FPbvUvZo6G+Wz04bXbrFlUQIFL0reKeEWt57yWgq8hXkbibrr+/LZzXp3
         SdlhTio/X4GNUg2pOuzET7+pY3KCW8C6eGy8V/pfDOx5YAI2kReiFIMxjB7e5vfQrjQu
         EMC5Jzy0PkB7NNJw3ssyM3o1m7mdBb76Foa3mIN4ShDwr2W6dpSwELdY/O1DR3hAqwI7
         Ol6BXi0OHIcZp7WwUWgmraWFqMJ+fM3IwWYgYp7fCKmcl5K07CpkmJ2Q1S3g1Thu0tCc
         mv2g==
X-Gm-Message-State: APjAAAW2HSFDu1hb5hTagl/2ehlZpmnn1nVZOt+qDREwxgaFk23yJkk/
        MLwHPFjAzSYSXUKF64EbK09KnA==
X-Google-Smtp-Source: APXvYqzC7/HZK7+EXjzcJodZ++wliiU8C+JhMyLSizkgklN8FOVzzDMtBBSarQIk1rdVlB0KCrwo5w==
X-Received: by 2002:a17:902:122:: with SMTP id 31mr749931plb.274.1571268119937;
        Wed, 16 Oct 2019 16:21:59 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 14sm167819pfn.21.2019.10.16.16.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 16:21:59 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:21:59 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Oct 2019 16:21:55 PDT (-0700)
Subject:     Re: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF is cleared
In-Reply-To: <20191008123943.j7q6dlu2qb2az6xa@willie-the-truck>
CC:     Justin.He@arm.com, Catalin.Marinas@arm.com, Mark.Rutland@arm.com,
        James.Morse@arm.com, maz@kernel.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, punitagrawal@gmail.com, tglx@linutronix.de,
        akpm@linux-foundation.org, hejianet@gmail.com, Kaly.Xin@arm.com,
        nd@arm.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     will@kernel.org
Message-ID: <mhng-dd251518-8ac0-40fa-9f62-20715d9ba906@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Oct 2019 05:39:44 PDT (-0700), will@kernel.org wrote:
> On Tue, Oct 08, 2019 at 02:19:05AM +0000, Justin He (Arm Technology China) wrote:
>> > -----Original Message-----
>> > From: Will Deacon <will@kernel.org>
>> > Sent: 2019年10月1日 20:54
>> > To: Justin He (Arm Technology China) <Justin.He@arm.com>
>> > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Mark Rutland
>> > <Mark.Rutland@arm.com>; James Morse <James.Morse@arm.com>; Marc
>> > Zyngier <maz@kernel.org>; Matthew Wilcox <willy@infradead.org>; Kirill A.
>> > Shutemov <kirill.shutemov@linux.intel.com>; linux-arm-
>> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>> > mm@kvack.org; Punit Agrawal <punitagrawal@gmail.com>; Thomas
>> > Gleixner <tglx@linutronix.de>; Andrew Morton <akpm@linux-
>> > foundation.org>; hejianet@gmail.com; Kaly Xin (Arm Technology China)
>> > <Kaly.Xin@arm.com>
>> > Subject: Re: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF
>> > is cleared
>> >
>> > On Mon, Sep 30, 2019 at 09:57:40AM +0800, Jia He wrote:
>> > > diff --git a/mm/memory.c b/mm/memory.c
>> > > index b1ca51a079f2..1f56b0118ef5 100644
>> > > --- a/mm/memory.c
>> > > +++ b/mm/memory.c
>> > > @@ -118,6 +118,13 @@ int randomize_va_space __read_mostly =
>> > >  					2;
>> > >  #endif
>> > >
>> > > +#ifndef arch_faults_on_old_pte
>> > > +static inline bool arch_faults_on_old_pte(void)
>> > > +{
>> > > +	return false;
>> > > +}
>> > > +#endif
>> >
>> > Kirill has acked this, so I'm happy to take the patch as-is, however isn't
>> > it the case that /most/ architectures will want to return true for
>> > arch_faults_on_old_pte()? In which case, wouldn't it make more sense for
>> > that to be the default, and have x86 and arm64 provide an override? For
>> > example, aren't most architectures still going to hit the double fault
>> > scenario even with your patch applied?
>>
>> No, after applying my patch series, only those architectures which don't provide
>> setting access flag by hardware AND don't implement their arch_faults_on_old_pte
>> will hit the double page fault.
>>
>> The meaning of true for arch_faults_on_old_pte() is "this arch doesn't have the hardware
>> setting access flag way, it might cause page fault on an old pte"
>> I don't want to change other architectures' default behavior here. So by default,
>> arch_faults_on_old_pte() is false.
>
> ...and my complaint is that this is the majority of supported architectures,
> so you're fixing something for arm64 which also affects arm, powerpc,
> alpha, mips, riscv, ...
>
> Chances are, they won't even realise they need to implement
> arch_faults_on_old_pte() until somebody runs into the double fault and
> wastes lots of time debugging it before they spot your patch.

If I understand the semantics correctly, we should have this set to true.  I 
don't have any context here, but we've got

                /*
                 * The kernel assumes that TLBs don't cache invalid
                 * entries, but in RISC-V, SFENCE.VMA specifies an
                 * ordering constraint, not a cache flush; it is
                 * necessary even after writing invalid entries.
                 */
                local_flush_tlb_page(addr);

in do_page_fault().

>> Btw, currently I only observed this double pagefault on arm64's guest
>> (host is ThunderX2).  On X86 guest (host is Intel(R) Core(TM) i7-4790 CPU
>> @ 3.60GHz ), there is no such double pagefault. It has the similar setting
>> access flag way by hardware.
>
> Right, and that's why I'm not concerned about x86 for this problem.
>
> Will
