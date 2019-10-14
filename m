Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D806ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A10920854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571074905;
	bh=YYSRFuWjjjO9Dv0wsRR/bvBjolbFH4cIWD41bw1dJHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Dy4OAZcTxbEEcoGNXJ5XtKQXPsRBjyprZRkjzCznaLpvr6NN+1QZ8JHp20FrlQBX1
	 ma/ASQlllw31GBgBN0fSEeFJWvLc4brwAqhP1nPsWvCpXxf8ZMC14dHdFjJyq6vhd4
	 GEJKGF56s7hWO12k0JhfroJoqCmB3UH/sXf0JYN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfJNRlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:41:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46908 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbfJNRln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:41:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so12356617lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P799DeurAv7knAP/9jFPDE4m8m+46TvvpHN93XfkDjE=;
        b=HWWymbYdZnWtJmHwFOmPF1ZzJDaTOeayFZ5PwgDvPf6UmwnVngK8F0WL6ftDpUBt65
         6CA7fbK/RfBrDC+lGkPSzKjf3Py8iCvGuqPRh2kQkkDM55QsR1au+xiI2Z52IW4rOkCn
         s1q1W19Sc+umQVIDvAwB4blHAjaZuSeemBQjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P799DeurAv7knAP/9jFPDE4m8m+46TvvpHN93XfkDjE=;
        b=Su7v4yc7CHe6HCWzpLTwmRTR9GVdxMv72VGrWZXPaw2+7X/HIVMdBnjPn4F2SJ51Y1
         APuWqMzTcCmcMS9vYBlcPRokQM/dED7mxL3rDg+XOXiwrBmfZRpEqnu13PHfHJ72AVCn
         zcS0/+AB6KpGcxZTQ+gMtXR05OJQbx+0iJBX2xuLmDPQ4MAo3VQ0H2Ytm/fe8+wDRNuV
         j7eTtlqaxSOUhDGy/+WAUSnaCExI8UiKJNSqsvfYx48gbHLGnnxgYiQpiMByN/DenIjn
         uIgoReMd3xCgf/7twFueBA5FBkneUngOqM6iouys+CWW/Ufj2zMbltMKSB0SicycviFO
         jNGw==
X-Gm-Message-State: APjAAAXHSWRUbK/6p35vaSIBSHZ6FggVw47pVyzngzj73bSXyds7miDa
        UEfW6K4yM+8+A7FZLAkwUYNeRnuRvnM=
X-Google-Smtp-Source: APXvYqx/sJHftL73nww4DAGr2NubKEPgazEl6bzRBdv7auQfdgJqAthBGcYdSACuHtbcJOoiwubMuA==
X-Received: by 2002:ac2:5a5a:: with SMTP id r26mr10309532lfn.70.1571074901311;
        Mon, 14 Oct 2019 10:41:41 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t22sm4377264lfg.91.2019.10.14.10.41.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 10:41:36 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id l21so17497218lje.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 10:41:35 -0700 (PDT)
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr19334971ljc.97.1571074895188;
 Mon, 14 Oct 2019 10:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191011121951.nxna6hruuskvdxod@box> <20191011223818.7238-1-vgupta@synopsys.com>
In-Reply-To: <20191011223818.7238-1-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Oct 2019 10:41:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
Message-ID: <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
Subject: Re: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if __PAGETABLE_PMD_FOLDED
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 3:38 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> This is inine with similar patches for nopud [1] and nop4d [2] cases.

I don't think your patch is wrong, but wouldn't it be easier and
cleaner to just do this instead

    --- a/include/asm-generic/pgtable-nopmd.h
    +++ b/include/asm-generic/pgtable-nopmd.h
    @@ -60,7 +60,7 @@ static inline pmd_t * pmd_offset(pud_t * pud,
unsigned long address)
     static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
     {
     }
    -#define __pmd_free_tlb(tlb, x, a)          do { } while (0)
    +#define pmd_free_tlb(tlb, x, a)            do { } while (0)

     #undef  pmd_addr_end
     #define pmd_addr_end(addr, end)                    (end)

and just rely on the regular "#ifndef pmd_free_tlb" in
include/asm-generic/tlb.h?

Completely untested.

              Linus
