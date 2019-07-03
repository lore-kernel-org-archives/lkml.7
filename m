Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8306C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2842089C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTQ/vUCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGCB2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:28:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34017 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfGCB2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:28:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id u18so788105wru.1;
        Tue, 02 Jul 2019 18:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yy/jJe6Qlwwp1Uwe0Cit54zA7Vf11kpokyvinUCks7c=;
        b=aTQ/vUCfodZFR5bl0E3g9XXd7THPV9nPu2mYp1+I8zMhs9sW7E6Ryo+nF5yEJRUyNX
         fI8WUsDhjEVt5q7xnTAgk5AA+5WeigU53ZxjE4QoGIwbCvPIcq4EZoVsRxM6FKfrPuov
         Qv+OEuln/KI5BLM4Pcsc6t/+OoqYbY+FJfgqqCNBwH5J9qIXgp7HRmXM/Hp/6QQGgZD3
         RYP/lR0JWxJM/E4pW5wsV+9KSD10OM3lmMEU8ATdAqNCmgb6fDdjtBE+6ORfdyU9DXjd
         JVUjqtL75spzdpAY6myj7OjBc40Gef9T6W9tBjtXlgTblrPH+kg8uUbhXkFlI1Wc3GOk
         D0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yy/jJe6Qlwwp1Uwe0Cit54zA7Vf11kpokyvinUCks7c=;
        b=VbS7125Xu3y5i7b1GwiKV/aytg+I8tAWJI2xvqGtxl0ED+cm2aucFHw3lFV3KJapiY
         +Vy31Z2g9gZBZt4jT7MKTl/ZllRd0SvT+nMrZY7/nKayAIFhxyiUtMEktmEshbA4duOa
         AkakRNiI53CsVW4TU13pNqCjt3k4wciDg5TNmfSQYhk2F8Zw9fkwV78TF9oE10e4E/i7
         k5vDcMtASQFf4S4hBhsTT2+wdZbOnlRUDyTMnMRAFSB2e+yRsdBVKZ6awTN5DiA/Od+B
         sTXmcwFJbouc44PwvZD6dnkzToyyCy9KGxuXJg9WsqtHLt5wJTipAigwtUWmsbP1mrBQ
         ojLg==
X-Gm-Message-State: APjAAAV1xcLOF4U5PjewohHXwh1FasFaNAcfgz2Q+DQ3sUJdxRHBVhZw
        oUJTjZsY8ni3/qRLr5iSQbTxjutHdGTFrma2rPArj2PdkVA=
X-Google-Smtp-Source: APXvYqzIEb02aajpAGNava/id0J1XqTeNG0vVxYK5uLbQYjjwdzYTBzNUK+/I5XN+jnCDfKY6KrEoXRwtDvbB0DH4xE=
X-Received: by 2002:adf:dec3:: with SMTP id i3mr14133575wrn.74.1562117322653;
 Tue, 02 Jul 2019 18:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190701213304.34eeaef8@canb.auug.org.au> <20190701231036.GC23718@mellanox.com>
In-Reply-To: <20190701231036.GC23718@mellanox.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 2 Jul 2019 21:28:30 -0400
Message-ID: <CADnq5_OGiOZaz8V1aLLNL9F88pkthKh4ytYMaaFZ8j3XbgOnkg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the hmm tree
To:     Jason Gunthorpe <jgg@mellanox.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Yang, Philip" <Philip.Yang@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 3:24 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Jul 01, 2019 at 09:33:04PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the hmm tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> >
> > mm/hmm.c: In function 'hmm_get_or_create':
> > mm/hmm.c:50:2: error: implicit declaration of function 'lockdep_assert_held_exclusive'; did you mean 'lockdep_assert_held_once'? [-Werror=implicit-function-declaration]
> >   lockdep_assert_held_exclusive(&mm->mmap_sem);
> >   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   lockdep_assert_held_once
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: In function 'amdgpu_ttm_tt_get_user_pages':
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:778:28: error: passing argument 2 of 'hmm_range_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
> >   hmm_range_register(range, mm, start,
> >                             ^~
> > In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:35:
> > include/linux/hmm.h:464:29: note: expected 'struct hmm_mirror *' but argument is of type 'struct mm_struct *'
> >           struct hmm_mirror *mirror,
> >           ~~~~~~~~~~~~~~~~~~~^~~~~~
> >
> > Caused by commit
> >
> >   e36acfe6c86d ("mm/hmm: Use hmm_mirror not mm as an argument for hmm_range_register")
> >
> > interacting with commit
> >
> >   66c45500bfdc ("drm/amdgpu: use new HMM APIs and helpers")
> >
> > from the drm tree.
> >
> > All I could do for now was to mark the AMDGPU driver broken.  Please
> > submit a merge for for me (and later Linus) to use.
>
> This is expected, the AMD guys have the resolution for this from when
> they tested hmm.git..
>
> I think we are going to have to merge hmm.git into the amdgpu tree and
> push the resolution forward, as it looks kind of complicated to shift
> onto Linus or DRM.
>
> Probably amdgpu needs to gain a few patches making the hmm_mirror
> visible to amdgpu_ttm.c and then the merge resolution will be simple?
>
> AMD/DRM we have a few days left to decide on how best to handle the
> conflict, thanks.

Philip and Felix have been working on a branch with hmm merged into
drm-next with all the conflicts fixes up.  I'll post it out tomorrow
once I get Felix's latest revisions.

Alex

>
> Regards,
> Jason
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
