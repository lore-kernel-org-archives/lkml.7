Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA417C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1252173E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWqT9GUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfGAOC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:02:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40646 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfGAOC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:02:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id e8so13553127otl.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 07:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mTLzSHEBC/4Fb0YvX/BaQpjenyALQQfdmQqtbEqVeC4=;
        b=KWqT9GUxmh3VafmrfPf/gJWxTiUneXDAFEgnh1s3WOsu746TUNi3d8WApsEUD9fTm0
         EXZtypfzYVC9xUjP8bs+L+L4uhe5cmPzQTdzZ+2WTwq5e/2QkLbjt4w5ao+siQd2aKaU
         aJKGlD4nrBrhcvZKTpEOMs8iHa7RXIG8MVn+9xNrisvrlDDkxjL1ZyxDyevXfkzDKblr
         YO7cTlY5/Hw+eVSdBynQH+zNWJJvfV49oOS6Ryl3FiRqzuKUn27667vvygggmZpLNtzH
         U2mFiEdBW20XUC6d1BLh8csqT1oBMF+35J4pCkwaYoecQfAyPOoNBy5p9lHCjS/XVI7e
         E3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mTLzSHEBC/4Fb0YvX/BaQpjenyALQQfdmQqtbEqVeC4=;
        b=b0ApsnuztZfufP5F0QOjOCW/FmCoz2j9hucZ3j6ghz+dAJS8cfwt/hGawzRoc8sbTQ
         ei6mowHvzDq00vbV6NMc5AmrJRT45/MpkR1xgIs5oqPbiBYEUj+Bm/5dt7ObQYKZIREn
         mqEMB12Kq3oInPA7uYeN3vngETuPnliXNMHz5lQBBiKfYhTwpgOl3cIyeTdlb2wvbN8d
         xUmzGm+bHCaSqtBDC4X5c7fHff8+4wbySzKFpJ5g6U1HWmufvNxizAMf9K7urwkoIsqh
         bFxYFgDV50ITyRJx6uugk1zibIFBMGtJbnAJbYNzf26CdSXyGHaH20F3X3Q7KkAK/JXT
         hD8g==
X-Gm-Message-State: APjAAAXUhWsiOTLNiw+SGVMIeSUoWeRxyLdpdMSAh0akqp3jDHhr0pCN
        Txfwj1cbOTs+wN1E2Ds/TKa5nLGLZ4inPtRrTOd5sf22wU3ChA==
X-Google-Smtp-Source: APXvYqyAsx1S9OtS8w24N2zJ3agu3XvSVg/vZkOrvDCKMK4FwUhsxDlqboOAiuSQD+ZUKWlYTSmlxFCIbE4Hpcu8Ahc=
X-Received: by 2002:a9d:735a:: with SMTP id l26mr21168394otk.105.1561989747492;
 Mon, 01 Jul 2019 07:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a861f6058b2699e0@google.com> <03763360-a7de-de87-eb90-ba7838143930@I-love.SAKURA.ne.jp>
 <d088f188-5f32-d8fc-b9a0-0b404f7501cc@I-love.SAKURA.ne.jp> <ceef00e8-819a-c0f0-cbb5-60e60e6631fe@redhat.com>
In-Reply-To: <ceef00e8-819a-c0f0-cbb5-60e60e6631fe@redhat.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Mon, 1 Jul 2019 19:32:16 +0530
Message-ID: <CAO_48GHu+c3_AxeMSpWbgwPZx4j7JOd6x5t9Jto7=jjV1xw9HA@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ion: Bail out upon SIGKILL when
 allocating memory.
To:     Laura Abbott <labbott@redhat.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tetsuo,

On Mon, 1 Jul 2019 at 17:07, Laura Abbott <labbott@redhat.com> wrote:
>
> On 7/1/19 6:55 AM, Tetsuo Handa wrote:
> > Andrew, can you pick up this patch? No response from Laura Abbott nor S=
umit Semwal.
Apologies; it didn't seem to get flitered out for me. I'll re-check my
email filters.
> >
> > On 2019/06/21 18:58, Tetsuo Handa wrote:
> >>  From e0758655727044753399fb4f7c5f3eb25ac5cccd Mon Sep 17 00:00:00 200=
1
> >> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Date: Fri, 21 Jun 2019 11:22:51 +0900
> >> Subject: [PATCH] staging: android: ion: Bail out upon SIGKILL when all=
ocating memory.
> >>
> >> syzbot found that a thread can stall for minutes inside
> >> ion_system_heap_allocate() after that thread was killed by SIGKILL [1]=
.
> >> Let's check for SIGKILL before doing memory allocation.
> >>
> >> [1] https://syzkaller.appspot.com/bug?id=3Da0e3436829698d5824231251fad=
9d8e998f94f5e
> >>
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail=
.com>
> >> ---
> >>   drivers/staging/android/ion/ion_page_pool.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/sta=
ging/android/ion/ion_page_pool.c
> >> index fd4995fb676e..f85ec5b16b65 100644
> >> --- a/drivers/staging/android/ion/ion_page_pool.c
> >> +++ b/drivers/staging/android/ion/ion_page_pool.c
> >> @@ -8,11 +8,14 @@
> >>   #include <linux/list.h>
> >>   #include <linux/slab.h>
> >>   #include <linux/swap.h>
> >> +#include <linux/sched/signal.h>
> >>
> >>   #include "ion.h"
> >>
> >>   static inline struct page *ion_page_pool_alloc_pages(struct ion_page=
_pool *pool)
> >>   {
> >> +    if (fatal_signal_pending(current))
> >> +            return NULL;
> >>      return alloc_pages(pool->gfp_mask, pool->order);
> >>   }
> >>
> >>
> >
>
> Acked-by: Laura Abbott <labbott@redhat.com>
fwiw, Acked-by: Sumit Semwal <sumit.semwal@linaro.org>


--=20
Thanks and regards,

Sumit Semwal
Linaro Consumer Group - Kernel Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
