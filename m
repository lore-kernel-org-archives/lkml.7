Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75274C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F7A2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt/DTI5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfEIEnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 00:43:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34900 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIEnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 00:43:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id m20so823520lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 21:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3NuoyA6DsdN8vS1rlRQd+bW+avLSVguOFGnQl9Uq1o=;
        b=Lt/DTI5wNAIhQ/6m6siviyT/JhbAp3rvLyUD63xEOH2IAg2pMCbMTS5GVTmn+YjFEr
         pnlVWawZ4nlMIvBOt171hzqJoikbtkxHGB0/mAiy4+T0Rw2CoC2QP83rkkwOknkyTrVW
         IRuOvLBwGlgkRwVCBqoWuPwWjarfOB15lA5TfomCotP/1mkZgzE2vDNTJwjtVgAPyFrS
         MJpWxa//z66mbSVrM03P8D5yOr826PzQmL+znaT8rF9P0GSt8GxB25i3hV1aFx4c6bFG
         01Sw6nLVbznCBMk4a/bLRUHhV8ZEFJoUM3gjiFpUeSDeboJ9cpOKY0J2miFZ1Gf+wdk2
         AoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3NuoyA6DsdN8vS1rlRQd+bW+avLSVguOFGnQl9Uq1o=;
        b=VXzrC60QzQETd/xZa9afqlwZ/Q2Z13OduUxfHHA9frnxzzbahA9GY9M3QvZSlbvPsz
         Aewt9IyPBGzen1BJ6+urj+/bkUg0ubDDByiND+aY3+IYkR83U4g+y9nUjicHnM8O2gCN
         E6b28jE25O+ZR30oRjwEARbqDZQHJTcUcTDqesKLyEqsP9Co6kdyuDYheMZY/wt1KbLD
         kDGFixGiFAEIvjlOkCIDXRi0xUP5+Mmguc5fIKrFCDZHXtktnmEL4//JjNEsaJVfAWAJ
         TPNFXEqCxa+a5zHtJDVuUACu+zmRE/XmyrgUzpXGx3rDBF12I0ZZZSqaXaEhQOL0+CEa
         E5Kw==
X-Gm-Message-State: APjAAAUyS4D0ll6z9qRM26mRPKBd92sEtFdu92rj7nhoJ/MR8gegwYXC
        FwY2m4R3kDIJjXuSZv6vNNcslEBjo90nPV+ftSo=
X-Google-Smtp-Source: APXvYqyahlAiHd3my+REndsaCdCPgpOP53l6bfy+BbUj2xIO/9159X2NF1ynIXXakgT60wBBaFKFYZTmcckc0FIv784=
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr855035ljc.9.1557376985164;
 Wed, 08 May 2019 21:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190506232942.12623-1-rcampbell@nvidia.com> <20190506232942.12623-5-rcampbell@nvidia.com>
 <CAFqt6zbhLQuw2N5-=Nma-vHz1BkWjviOttRsPXmde8U1Oocz0Q@mail.gmail.com> <fa2078fd-3ec7-5503-94d7-c4d1a766029a@nvidia.com>
In-Reply-To: <fa2078fd-3ec7-5503-94d7-c4d1a766029a@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 9 May 2019 10:12:52 +0530
Message-ID: <CAFqt6zbL1r6+G6f-4-cpktyNZ929d4tNfQDt4oHXqeHoC9chHw@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm/hmm: hmm_vma_fault() doesn't always call hmm_range_unregister()
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 11:42 PM Ralph Campbell <rcampbell@nvidia.com> wrote:
>
>
> On 5/7/19 6:15 AM, Souptick Joarder wrote:
> > On Tue, May 7, 2019 at 5:00 AM <rcampbell@nvidia.com> wrote:
> >>
> >> From: Ralph Campbell <rcampbell@nvidia.com>
> >>
> >> The helper function hmm_vma_fault() calls hmm_range_register() but is
> >> missing a call to hmm_range_unregister() in one of the error paths.
> >> This leads to a reference count leak and ultimately a memory leak on
> >> struct hmm.
> >>
> >> Always call hmm_range_unregister() if hmm_range_register() succeeded.
> >
> > How about * Call hmm_range_unregister() in error path if
> > hmm_range_register() succeeded* ?
>
> Sure, sounds good.
> I'll include that in v2.

Thanks.
>
> >>
> >> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> >> Cc: John Hubbard <jhubbard@nvidia.com>
> >> Cc: Ira Weiny <ira.weiny@intel.com>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Balbir Singh <bsingharora@gmail.com>
> >> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> >> Cc: Matthew Wilcox <willy@infradead.org>
> >> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> ---
> >>   include/linux/hmm.h | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> >> index 35a429621e1e..fa0671d67269 100644
> >> --- a/include/linux/hmm.h
> >> +++ b/include/linux/hmm.h
> >> @@ -559,6 +559,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
> >>                  return (int)ret;
> >>
> >>          if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
> >> +               hmm_range_unregister(range);
> >>                  /*
> >>                   * The mmap_sem was taken by driver we release it here and
> >>                   * returns -EAGAIN which correspond to mmap_sem have been
> >> @@ -570,13 +571,13 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
> >>
> >>          ret = hmm_range_fault(range, block);
> >>          if (ret <= 0) {
> >> +               hmm_range_unregister(range);
> >
> > what is the reason to moved it up ?
>
> I moved it up because the normal calling pattern is:
>      down_read(&mm->mmap_sem)
>      hmm_vma_fault()
>          hmm_range_register()
>          hmm_range_fault()
>          hmm_range_unregister()
>      up_read(&mm->mmap_sem)
>
> I don't think it is a bug to unlock mmap_sem and then unregister,
> it is just more consistent nesting.

Ok. I think, adding it in change log will be helpful :)
>
> >>                  if (ret == -EBUSY || !ret) {
> >>                          /* Same as above, drop mmap_sem to match old API. */
> >>                          up_read(&range->vma->vm_mm->mmap_sem);
> >>                          ret = -EBUSY;
> >>                  } else if (ret == -EAGAIN)
> >>                          ret = -EBUSY;
> >> -               hmm_range_unregister(range);
> >>                  return ret;
> >>          }
> >>          return 0;
> >> --
> >> 2.20.1
> >>
