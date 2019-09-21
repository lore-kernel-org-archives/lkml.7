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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56844C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2204021835
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKx+ohh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394026AbfIUAeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 20:34:03 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34313 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393246AbfIUAeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 20:34:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so9169066qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 17:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ls2WeM2S48aCpm2BV0Nn7xBRADmjB/cdArv6Rh7SXBQ=;
        b=LKx+ohh5JdCeuL4mjiOq1hdDZLZy1Q/36ZGCyGcMhTZ+sblIXIChyb0Hpo3cxX8jOi
         5AwQNcPAeNakwR9FO2KoX1T3gt+wNIN6PIlHeKyI3iTLbQnAuZqXfhZD1HMQDHtOhqGW
         EJIybCx2OkWbTmVv9HFViXjADaZ3zhz8bfHttAyevL2r2dUMEJnebqAzI1SfrnUat2Vo
         G6GV/F8WOsBwka1BmhcgnTwqF+KmBJzU4AcoXBeVTzDWNxOZa/1eOJfwvbcUV2bkg8yr
         wTV5ANAVIzolMdWkn7SsanxH2VkPSC0Wjg1PjlU6IXfxMJvSf2v3TYCPimT+lnfdOTPr
         Yiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ls2WeM2S48aCpm2BV0Nn7xBRADmjB/cdArv6Rh7SXBQ=;
        b=MbHpAac9DifuRMMCys41OucCeF8OUWWF/m5WHWRc8+4OmeCsHpsbDqwqk0k4uFU6YB
         +dYvw3uAWqf+AoI9jzArONm+sCWrog3qu3vhk+kj4tS2/h3fD3fI44/ZyQ5jSimRUGn6
         mi/AuqWGvuWWi1UxUSl2IYVGJZcPG9ucNPwYoltbBrpjjkX45GgabAnNB+XHmonx88RQ
         eHn9qNwGl2/H+Wj4hTN8ptyP3FmndCm/dGETPPzV5tb+vcB7QiymCU6AzTBs0KD2KxTS
         JKm1jwUqyS63c/Yeja9/lUFOc+hOE+jRHueFkzJ6mxxkQ915MqwwRkIGh0yV+36O1dWO
         shbQ==
X-Gm-Message-State: APjAAAXJaB4w8hsFTM0CkbkRvISqntxd0nFegjL9k+ZuPayR/Bj+cJCB
        WPewlSRHhSEfG4ClY6XH71XuxfvyfcWYyMhxYRk=
X-Google-Smtp-Source: APXvYqzpaDfiMuROERxboLRUs7u8rIb9E09Kb+MnuUYYTCyFWb5ZVbJ2v9mZgg5YyS5oW/8Jc9kZnA3V8jRPreKEAeg=
X-Received: by 2002:a37:a7c5:: with SMTP id q188mr6355145qke.445.1569026041666;
 Fri, 20 Sep 2019 17:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <1568994684-1425-1-git-send-email-hqjagain@gmail.com> <1a162778-41b9-4428-1058-82aaf82314b1@nvidia.com>
In-Reply-To: <1a162778-41b9-4428-1058-82aaf82314b1@nvidia.com>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Sat, 21 Sep 2019 08:33:48 +0800
Message-ID: <CAJRQjodUajhYgQV7Z821qFwYzR0jSxJt54y=4XjqYW68mNMzTQ@mail.gmail.com>
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

>On 9/20/19 8:51 AM, Qiujun Huang wrote:
>> __get_user_pages_fast try to walk the page table but the
>> hugepage pte is replace by hwpoison swap entry by mca path.
>
>I expect you mean MCE (machine check exception), rather than mca?
Yeah
>
>> ...
>> [15798.177437] mce: Uncorrected hardware memory error in
>>                               user-access at 224f1761c0
>> [15798.180171] MCE 0x224f176: Killing pal_main:6784 due to
>>                               hardware memory corruption
>> [15798.180176] MCE 0x224f176: Killing qemu-system-x86:167336
>>                               due to hardware memory corruption
>> ...
>> [15798.180206] BUG: unable to handle kernel
>> [15798.180226] paging request at ffff891200003000
>> [15798.180236] IP: [<ffffffff8106edae>] gup_pud_range+
>>                               0x13e/0x1e0
>> ...
>>
>> We need to skip the hwpoison entry in gup_pud_range.
>
>It would be nice if this spelled out a little more clearly what's
>wrong. I think you and Aneesh are saying that the entry is really
>a swap entry, created by the MCE response to a bad page?
do_machine_check->
do_memory_failure->
memory_failure->
hwpoison_user_mappings
will updated PUD level PTE entry as a swap entry.

static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
unsigned long address, void *arg)
{
...
if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
if (PageHuge(page)) {
int nr = 1 << compound_order(page);
hugetlb_count_sub(nr, mm);
set_huge_swap_pte_at(mm, address,
pvmw.pte, pteval,
vma_mmu_pagesize(vma));
} else {
dec_mm_counter(mm, mm_counter(page));
set_pte_at(mm, address, pvmw.pte, pteval);
}
...

and, gup_pud_range will reference the pud entry.

gup_pud_range->gup_pmd_range:
static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
int write, struct page **pages, int *nr)
{
unsigned long next;
pmd_t *pmdp;

pmdp = pmd_offset(&pud, addr);
do {
pmd_t pmd = *pmdp;  <--the pmdp is hwpoison swap entry. ffff891200003000
and results in corruption

...
>
>>
>> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
>> ---
>>  mm/gup.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 98f13ab..6157ed9 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2230,6 +2230,8 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
>>               next = pud_addr_end(addr, end);
>>               if (pud_none(pud))
>>                       return 0;
>> +             if (unlikely(!pud_present(pud)))
>> +                     return 0;
>
>If the MCE hwpoison behavior puts in swap entries, then it seems like all
>page table walkers would need to check for p*d_present(), and maybe at all
>levels too, right?
I think so
>
>thanks,



On Sat, Sep 21, 2019 at 3:37 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/20/19 8:51 AM, Qiujun Huang wrote:
> > __get_user_pages_fast try to walk the page table but the
> > hugepage pte is replace by hwpoison swap entry by mca path.
>
> I expect you mean MCE (machine check exception), rather than mca?
>
> > ...
> > [15798.177437] mce: Uncorrected hardware memory error in
> >                               user-access at 224f1761c0
> > [15798.180171] MCE 0x224f176: Killing pal_main:6784 due to
> >                               hardware memory corruption
> > [15798.180176] MCE 0x224f176: Killing qemu-system-x86:167336
> >                               due to hardware memory corruption
> > ...
> > [15798.180206] BUG: unable to handle kernel
> > [15798.180226] paging request at ffff891200003000
> > [15798.180236] IP: [<ffffffff8106edae>] gup_pud_range+
> >                               0x13e/0x1e0
> > ...
> >
> > We need to skip the hwpoison entry in gup_pud_range.
>
> It would be nice if this spelled out a little more clearly what's
> wrong. I think you and Aneesh are saying that the entry is really
> a swap entry, created by the MCE response to a bad page?
>
> >
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > ---
> >  mm/gup.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 98f13ab..6157ed9 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2230,6 +2230,8 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
> >               next = pud_addr_end(addr, end);
> >               if (pud_none(pud))
> >                       return 0;
> > +             if (unlikely(!pud_present(pud)))
> > +                     return 0;
>
> If the MCE hwpoison behavior puts in swap entries, then it seems like all
> page table walkers would need to check for p*d_present(), and maybe at all
> levels too, right?
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
>
> >               if (unlikely(pud_huge(pud))) {
> >                       if (!gup_huge_pud(pud, pudp, addr, next, flags,
> >                                         pages, nr))
> >
