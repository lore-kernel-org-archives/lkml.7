Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD1DC31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A9C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfFRPbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:31:14 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:43016 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbfFRPbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:31:13 -0400
Received: by mail-qt1-f173.google.com with SMTP id w17so9424317qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 08:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enVeaDd9KA1FhkBFIcyRHmn1gPk9Dn42G5cz03oOzOw=;
        b=WlQhDiy5r2TgAdy/PEfiRLrSBa3v7ra8/croHxIValHSi33FepF+RxnGadm9ta2CnI
         pEo2TUoaO5FwiVa9kZVUHfauOafxAxyzQZiYnkgEnD15eFSErktLdzXMtOlYntjVm3t4
         IVfyMRApDCPiiVXyCLOcGI2R2qz8AjYrPLIH4a4nXc4kh1TvoJ408BYkYPm0MULk18Cx
         ZaBOX9RuIj6ykEvz1lm89PoPwyoPQlcLXg/w6FzBb6F5EXKYr8wABBzFzZCaMg84b1BN
         aMemsnvQ4aktE7095l07zRimY2Htl+QsEGqlO7sVI4BpAHB4bgJ6amJ952XLbth2de9+
         umIQ==
X-Gm-Message-State: APjAAAVTspok+vxQUH6s7b1c1WQrV+PFLMFmtX2xr3KVDcdKjMvIvkvl
        z66SY9Dyt4bMIOU8LhG/7Kc6HrpNrJs2oOW5Flw=
X-Google-Smtp-Source: APXvYqzapZcyoXvg/K9EJjtdZZMPh8k1zuhs32ixPde8PXyTRUBF8PG/4CP94Bb7WQNtLtRHg8lQle5wZPdwdvBvQuU=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr66076417qtd.18.1560871872815;
 Tue, 18 Jun 2019 08:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190618095347.3850490-1-arnd@arndb.de> <5ac26e68-8b75-1b06-eecd-950987550451@virtuozzo.com>
In-Reply-To: <5ac26e68-8b75-1b06-eecd-950987550451@virtuozzo.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Jun 2019 17:30:55 +0200
Message-ID: <CAK8P3a1CAKecyinhzG9Mc7UzZ9U15o6nacbcfSvb4EBSaWvCTw@mail.gmail.com>
Subject: Re: [PATCH] [v2] page flags: prioritize kasan bits over last-cpuid
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 4:30 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> On 6/18/19 12:53 PM, Arnd Bergmann wrote:
> > ARM64 randdconfig builds regularly run into a build error, especially
> > when NUMA_BALANCING and SPARSEMEM are enabled but not SPARSEMEM_VMEMMAP:
> >
> >  #error "KASAN: not enough bits in page flags for tag"
> >
> > The last-cpuid bits are already contitional on the available space,
> > so the result of the calculation is a bit random on whether they
> > were already left out or not.
> >
> > Adding the kasan tag bits before last-cpuid makes it much more likely
> > to end up with a successful build here, and should be reliable for
> > randconfig at least, as long as that does not randomize NR_CPUS
> > or NODES_SHIFT but uses the defaults.
> >
> > In order for the modified check to not trigger in the x86 vdso32 code
> > where all constants are wrong (building with -m32), enclose all the
> > definitions with an #ifdef.
> >
>
> Why not keep "#error "KASAN: not enough bits in page flags for tag"" under "#ifdef CONFIG_KASAN_SW_TAGS" ?

I think I had meant the #error to leave out the mention of KASAN, as there
might be other reasons for using up all the bits, but then I did not change
it in the end.

Should I remove the "KASAN" word or add the #ifdef when resending?

     Arnd
