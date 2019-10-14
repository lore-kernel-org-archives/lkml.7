Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED368ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D062133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571077533;
	bh=VAGThxL5pykYCd/rBB/7mEhxHk24LUdSzjBOjq0ZjpU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BkdYyo1OpcF/7+PkG/Bx6r7518LfRet9La6DxfRgCfKMUZ1530Mu3xiD4cYMsYEK0
	 q9xJ+XXg3e7lVWzTrT+yhTiliuYlGRgrL45Zh2pjkp0SyNLP8wSho7bfjeEx0dnEc5
	 AOwpRjprvqgxH2SXNn+zAJsQZ/thst2qPLmfQZ8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbfJNSZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:25:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37671 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731216AbfJNSZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:25:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id w67so12489121lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDuevqM/GLUJPGbOy3AGpp+bGYIu9uznq9tCzNOdVnk=;
        b=eFnO/9lpSVSXWLQ3fx0+ELMmNrsLtf3Hba4c2Es0a+hMIgo8BkTvA2g+XLL6ae5cuf
         eHpY4iHiQNdWJG0yCJ28JJvdlgzq74lQSbjKt6r0QLWzMfhv7g4BRu4JRX+xaJEXEY1R
         7khFc16C1Y9LdR7AcqZ12vycw+JbW4J+ln5j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDuevqM/GLUJPGbOy3AGpp+bGYIu9uznq9tCzNOdVnk=;
        b=CMe9qw+YlGBkSyEeP/O/pfo49ovgpZSNgAwrABAX94FeyRdeF2a6Hk4qjzipn+Z4Z0
         0BhSej/lNSuKwtROn6ZAKIcg/wVN924QyOmqwZiXQPExyIVBqVa4SLNx0rtiewacab4t
         LHTpCDiEapZYBmCE0o2wBUmVsRHGfd+NnjFQTMhwBUs2qO8l9koFXQBr6a4NJM22w1rh
         nsvR49IbnTfxdBONTs44gIMjvO8kAvrCvdSBpwhlf7vg4F35gkVCzCUGFNE5JzJx1HtL
         j9o3op//VjU9oB+B+Z5VTGL/kJ9FgbBA5B2q0f4vYGA3F285XK74RzCdYUiV9ovqbp2E
         nX9w==
X-Gm-Message-State: APjAAAVW3I00vmsNpPjzwv6oGgL058LuDFwZIM6xkRcIKZqm5XcrVrOc
        8OUZKQRmhng4utwcUMYkpe4t8+e5hoc=
X-Google-Smtp-Source: APXvYqx7UXVXyGg/ChOKI9/EBcSPDDsVDuPz45TwD/wfhUtE1OSdHVIu4m3gFzKsGMCFWp8gt5wETA==
X-Received: by 2002:a05:6512:514:: with SMTP id o20mr270464lfb.94.1571077527327;
        Mon, 14 Oct 2019 11:25:27 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id t10sm4448836ljt.68.2019.10.14.11.25.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 11:25:25 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id u28so12476796lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 11:25:24 -0700 (PDT)
X-Received: by 2002:a19:f709:: with SMTP id z9mr18323634lfe.170.1571077524617;
 Mon, 14 Oct 2019 11:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191011121951.nxna6hruuskvdxod@box> <20191011223818.7238-1-vgupta@synopsys.com>
 <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com> <c0979d98-7236-b7c8-bd40-173ee2e87385@gmail.com>
In-Reply-To: <c0979d98-7236-b7c8-bd40-173ee2e87385@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Oct 2019 11:25:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3WXpKJkcpgHkUMgLiX9UdXnXhSFzBd8vTWkKgFpz0+Q@mail.gmail.com>
Message-ID: <CAHk-=wi3WXpKJkcpgHkUMgLiX9UdXnXhSFzBd8vTWkKgFpz0+Q@mail.gmail.com>
Subject: Re: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if __PAGETABLE_PMD_FOLDED
To:     Vineet Gupta <vineetg76@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:02 AM Vineet Gupta <vineetg76@gmail.com> wrote:
>
> I suppose we could but
>
> (a) It would be asymmetric with the __p{u,4}d_free_tlb() changes in [1] and [2].

Your patch is already assymmetric wrt those anyway - you had to add that

  +#else
  +#define pmd_free_tlb(tlb, pmdp, address)        do { } while (0)
  +#endif

that the other cases don't currently have, so then you point to
another patch that makes the code uglier instead.

> Do you  prefer [1] and [2] be repun along the same lines as you propose above ?

In general, I absolutely detest how we have random

   #ifndef ARCH_HAS_ONE_DEFINE
   #define another_define_entirely()
   ...

which makes no sense and is ugly, and also wreaks havoc on simple
things like "git grep another_define_entirely"

I've long tried to convince people to just do

  #ifndef special_define
  #define special_define(xyz) ..
  #endif

instead, which doesn't mix up two completely unrelated names, and when
you grep for that function name, you _see_ all the context.

> Also would you care to shed light on my other question about not being able to
> fold away pmd_clear_bad() despite PMD_FOLDED given the pmd macros actually
> checking for pgd. Of all the people you are likely to have most insight on how the
> pmd folding actually evolved and works :-)

I think some of it is just ugly and historical, and confused.

In general, it should always be the "higher" level that folds away. So
I think the best example of this is

  include/asm-generic/pgtable-nop4d.h

where basically all the "pgd" functions become no-ops, and can never
not exist or be bad, because they are always just containers for the
lower level and don't have any data in them themselves:

  static inline int pgd_none(pgd_t pgd)           { return 0; }
  static inline int pgd_bad(pgd_t pgd)            { return 0; }
  static inline int pgd_present(pgd_t pgd)        { return 1; }
  static inline void pgd_clear(pgd_t *pgd)        { }

and walking from pgd to p4d is that nice folded op:

  static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
  { return (p4d_t *)pgd; }

and this is how it should always work.See "nopud" and "nopmd"(which
are 3rd/2nd level respectively) doing the same thing exactly.

And yes, pmd_clear_bad() should just go away. We have

  static inline int pmd_none_or_clear_bad(pmd_t *pmd)
  {
        if (pmd_none(*pmd))
                return 1;
        if (unlikely(pmd_bad(*pmd))) {
                pmd_clear_bad(pmd);
                return 1;
        }
        return 0;
  }

and if the pmd doesn't exist, then both pmd_none() and pmd_bad()
should just be zero (see above), and the pmd_none_or_clear_bad()
should just become "return 0";

Exactly what part isn't working for you?

I suspect part of the problem is exactly that we than have that stupid
confusion with some code checking "#ifdef __PAGETABLE_PMD_FOLDED" and
then making their own random decisions based on things like that
instead.

When you do that, the code ends up relying on other magic than just
the natural folding.

            Linus
