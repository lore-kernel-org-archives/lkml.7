Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC148C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B909A2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkkE5RjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfIUBrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 21:47:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38685 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbfIUBry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 21:47:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id u186so9255651qkc.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 18:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfnM1kEHJB20PsJ9Y6PlF1EQF63o4NAR1hJNSU7CBGI=;
        b=tkkE5RjYXLE5liJly0UZ1C2zR1unTObtqkwLG9O2vtHUo/FxtTrXn/I/XedWNWr3O+
         SYH65W5DXjgHt0rw9dbx0r5XQubscRGBGWQTrS5f0NJMv5cJiXzD7KcbmylftW4bmr0x
         CNnXmPQIUftqYie7SHHeOC8VjlJvNVI5BSUcLqYfRHCsnmuiBMh7MlbmCI7HNi908SdO
         vr8ricHxIS3N/1Vp1WnSIsNOkEHhXpic9JWWn4qG5Vq2H9QQMP3b0DJTXabldr05l4Z5
         3OzXUubbzV/pWKlg59pjmH/s04beFA+DWFsnmr62b9Y66RCjRruLBWdY8o062Z9x44LY
         BHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfnM1kEHJB20PsJ9Y6PlF1EQF63o4NAR1hJNSU7CBGI=;
        b=V5QlBgNarlG+1CAOWf+NcaaCJ6R1EJBD6jt8E0RpvFWB6o/zP3iEjzNBkpDOi0rtPY
         ki3Nz3TEBL36sWwPY6I4/BU8K6yUceFUg2mqo7SxjReKJIA1tXHCKRofyVFKc8sY9lR2
         nh/XGcZF6WSzK6uQhFfJ90CSfP/pNQi7rQJP2sf90RP4qcp7kJftw9puMtObThUf75Xx
         tR4e0fum2VM0nVWXfWG0yAEwVAX21HHfismgh+lEggvDNrRYeJuVdWMCW/nHbye4QTau
         959hN7Xq8HuByQVBGK+zoJWkl5tKQlKHp1Nz5KMgsvF6WJHk9UTm2OIqwB+dlaz0ZY5R
         Z6ew==
X-Gm-Message-State: APjAAAV0xuhTosshp9t4ULzpUOpJ/rk77+ICG9Ew3btHpd7udeFsSST5
        69X5JCpjBEIOnL7Tw9JJtgdbTJY5dAR5Ze0d7mg=
X-Google-Smtp-Source: APXvYqxfrUkE2P8KhqREWnYt0e3UxiIb1UT3YF/aWByB8II0Vdjo+Cpoifzt08pkOeqd6kWySa/+M4j1cPEXI3fDK34=
X-Received: by 2002:ae9:eb8c:: with SMTP id b134mr6500884qkg.377.1569030473789;
 Fri, 20 Sep 2019 18:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <1568994684-1425-1-git-send-email-hqjagain@gmail.com>
 <1a162778-41b9-4428-1058-82aaf82314b1@nvidia.com> <CAJRQjodUajhYgQV7Z821qFwYzR0jSxJt54y=4XjqYW68mNMzTQ@mail.gmail.com>
 <ce863f5b-2337-1ac3-4d3d-d1d62acbba24@nvidia.com>
In-Reply-To: <ce863f5b-2337-1ac3-4d3d-d1d62acbba24@nvidia.com>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Sat, 21 Sep 2019 09:47:42 +0800
Message-ID: <CAJRQjofBLyXCKXzS7jxs3FjOyh3YydiCAsT1PmyaqvvRhWxYiQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm:fix gup_pud_range
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     akpm@linux-foundation.org, ira.weiny@intel.com, jgg@ziepe.ca,
        dan.j.williams@intel.com, rppt@linux.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        keith.busch@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 9:19 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/20/19 5:33 PM, Qiujun Huang wrote:
> >> On 9/20/19 8:51 AM, Qiujun Huang wrote:
> ...
> >> It would be nice if this spelled out a little more clearly what's
> >> wrong. I think you and Aneesh are saying that the entry is really
> >> a swap entry, created by the MCE response to a bad page?
> > do_machine_check->
> > do_memory_failure->
> > memory_failure->
> > hwpoison_user_mappings
> > will updated PUD level PTE entry as a swap entry.
> >
> > static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > unsigned long address, void *arg)
> > {
> > ...
> > if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
> > pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>
> OK, that helps. Let's add something approximately like this to the
> commit description:
>
> do_machine_check()
>   do_memory_failure()
>     memory_failure()
>       hw_poison_user_mappings()
>         try_to_unmap()
>           pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>
> ...and now we have a swap entry that indicates that the page entry
> refers to a bad (and poisoned) page of memory, but gup_fast() at this
> level of the page table was ignoring swap entries, and incorrectly
> assuming that "!pxd_none() == valid and present".
>
> And this was not just a poisoned page problem, but a generaly swap entry
> problem. So, any swap entry type (device memory migration, numa migration,
> or just regular swapping) could lead to the same problem.
>
> Fix this by checking for pxd_present(), instead of pxd_none().
>
>
> > ...
> >>
> >>>
> >>> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> >>> ---
> >>>  mm/gup.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/mm/gup.c b/mm/gup.c
> >>> index 98f13ab..6157ed9 100644
> >>> --- a/mm/gup.c
> >>> +++ b/mm/gup.c
> >>> @@ -2230,6 +2230,8 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
> >>>               next = pud_addr_end(addr, end);
> >>>               if (pud_none(pud))
> >>>                       return 0;
> >>> +             if (unlikely(!pud_present(pud)))
> >>> +                     return 0;
> >>
> >> If the MCE hwpoison behavior puts in swap entries, then it seems like all
> >> page table walkers would need to check for p*d_present(), and maybe at all
> >> levels too, right?
> > I think so
> >>
>
> Should those changes be part of this fix, do you think?

Yes, please.Thanks
>
> thanks,
> --
> John Hubbard
> NVIDIA
