Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E0AC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D53A20656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="NhFDt2GD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgAGJfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:35:37 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:34624 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgAGJfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:35:37 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 94D492E147D;
        Tue,  7 Jan 2020 12:35:33 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id h27FGk7aFr-ZWvOxK5e;
        Tue, 07 Jan 2020 12:35:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1578389733; bh=v2AjJsKmlVuvG4ZJs7dIGBHGueTYXG52IcpCaI7Exro=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=NhFDt2GDsyQSBPqF5kyyt/HTUf2jLUgpop4IcDtsepkJCHReoU12Y2wpKOCzbM7bE
         0mA80NU9mZEgj/cjqPtzv+bLsr/jRXlEU78gvne7JiDeEYCiXk0clEz4f8xazd7D3Y
         93o4S+CfrnI4oPXyHisT1Ueq0+hcBqsPnkwO8Cww=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6407::1:5])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Hjw2ShryIg-ZWVCuV1m;
        Tue, 07 Jan 2020 12:35:32 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/rmap: fix reusing mergeable anon_vma as parent when
 fork
To:     "lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richardw.yang" <richardw.yang@linux.intel.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>
References: <157830736034.8148.7070851958306750616.stgit@buzz>
 <CALYGNiMUQ2=OjF4G3jQYZMXja5mGinXB8M1YRCe8kctCzQoWHw@mail.gmail.com>
 <2020010710441027026650@gmail.com>
 <f008876f-c163-e77d-d8e6-4722ba69e9f0@yandex-team.ru>
 <2020010717045916228557@gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <a9af1185-7ad4-c3a1-b61c-063ddc013c85@yandex-team.ru>
Date:   Tue, 7 Jan 2020 12:35:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2020010717045916228557@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2020 12.05, lixinhai.lxh@gmail.com wrote:
> On 2020-01-07 at 16:24 Konstantin Khlebnikov wrote:
>> On 07/01/2020 05.44, lixinhai.lxh@gmail.com wrote:
>>> On 2020-01-07 at 04:35 Konstantin Khlebnikov wrote:
>>>> On Mon, Jan 6, 2020 at 1:42 PM Konstantin Khlebnikov
>>>> <khlebnikov@yandex-team.ru> wrote:
>>>>>
>>>>> This fixes couple misconceptions in commit 4e4a9eb92133 ("mm/rmap.c: reuse
>>>>> mergeable anon_vma as parent when fork").
>>>>>
>>>>> First problem caused by initialization order in dup_mmap(): vma->vm_prev
>>>>> is set after calling anon_vma_fork(). Thus in anon_vma_fork() it points to
>>>>> previous VMA in parent mm. This is fixed by rearrangement in dup_mmap().
>>>>>
>>>>> If in parent VMAs: SRC1 SRC2 .. SRCn share anon-vma ANON0, then after fork
>>>>> before all patches in child process related VMAs: DST1 DST2 .. DSTn will
>>>>> use different anon-vmas: ANON1 ANON2 .. ANONn. Before this patch only DST1
>>>>> will fork new ANON1 and following DST2 .. DSTn will share parent's ANON0.
>>>>> With this patch DST1 will create new ANON1 and DST2 .. DSTn will share it.
>>>>>
>>>>> Also this patch moves sharing logic out of anon_vma_clone() into more
>>>>> specific anon_vma_fork() because this supposed to work only at fork().
>>>>> Function anon_vma_clone() is more generic is also used at splitting VMAs.
>>>>>
>>>>> Second problem is hidden behind first one: assumption "Parent has vm_prev,
>>>>> which implies we have vm_prev" is wrong if first VMA in parent mm has set
>>>>> flag VM_DONTCOPY. Luckily prev->anon_vma doesn't dereference NULL pointer
>>>>> because in current code 'prev' actually is same as 'pprev'. To avoid that
>>>>> this patch just checks pointer and compares vm_start to verify relation
>>>>> between previous VMAs in parent and child.
>>>>>
>>>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>>>> Fixes: 4e4a9eb92133 ("mm/rmap.c: reuse mergeable anon_vma as parent when fork")
>>>>
>>>> Oops, I've forgot to mention that Li Xinhai <lixinhai.lxh@gmail.com>
>>>> found and reported this suspicious code. Sorry.
>>>>
>>>> Reported-by: Li Xinhai <lixinhai.lxh@gmail.com>
>>>> Link: https://lore.kernel.org/linux-mm/CALYGNiNzz+dxHX0g5-gNypUQc3B=8_Scp53-NTOh=zWsdUuHAw@mail.gmail.com/T/#t
>>>>
>>>
>>> Can we change the interface
>>> int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma),
>>> to
>>> int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma, struct vm_area_struct *pcvma),
>>> and 'pcvma' means previous child vma.
>>> so highlight the use of that vma, and the current code sequence for linking 'tmp' vma
>>> in dup_mmap() is not changed(in case some code would have dependency on that
>>> linking sequence)
>>
>> There should be no dependency on linking sequence.
>> But we could generalize sharing: cloned vma could share prev anon-vma
>> (or any other actually) if anon_vma->parent == src->anon_vma.
>> This is more clear than sharing only between related vmas.
>>
> I mean in
> int dup_mmap(...)
> {
> 		tmp = vm_area_dup(mpnt);
> 
> //.... some code in this part would have dependency on 'tmp->vm_prev, tmp->vm_next'
> // ... I didn't go through all this part, but need take care about it.
> // so, better to keep the current semantic and pass in *pprev for anon vma call

Yeah, there is weird and unintentional reference in case VM_WIPEONFORK:
anon_vma_prepare -> find_mergeable_anon_vma

This is just dangerous.

> 
> 		/*
> 		 * Link in the new vma and copy the page table entries.
> 		 */
> 		*pprev = tmp;
> 		pprev = &tmp->vm_next;
> 		tmp->vm_prev = prev;
> 		prev = tmp;
> 
> }
> 
>>>
>>> Another issue is for linking the avc for the reused anon_vma. anon_vma_clone()
>>> use the iteration
>>> list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma),
>>> to link avc for child vma, and it is unable to reach the resued anon_vma because
>>> that is from the previous vma not from parent vma. So, in anon_vma_fork(),
>>> we need to setup the avc link for vma->anon.
>>
>> Oh, yes. That's another example where current code miraculously stays correct.
>>
>>>
>>>>> ---
>>>>>      kernel/fork.c |    4 ++--
>>>>>      mm/rmap.c     |   25 ++++++++++++-------------
>>>>>      2 files changed, 14 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>>>> index 2508a4f238a3..04ee5e243f65 100644
>>>>> --- a/kernel/fork.c
>>>>> +++ b/kernel/fork.c
>>>>> @@ -548,6 +548,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>                     if (retval)
>>>>>                             goto fail_nomem_policy;
>>>>>                     tmp->vm_mm = mm;
>>>>> +               tmp->vm_prev = prev;    /* anon_vma_fork use this */
>>>>> +               tmp->vm_next = NULL;
>>>>>                     retval = dup_userfaultfd(tmp, &uf);
>>>>>                     if (retval)
>>>>>                             goto fail_nomem_anon_vma_fork;
>>>>> @@ -559,7 +561,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>                     } else if (anon_vma_fork(tmp, mpnt))
>>>>>                             goto fail_nomem_anon_vma_fork;
>>>>>                     tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
>>>>> -               tmp->vm_next = tmp->vm_prev = NULL;
>>>>>                     file = tmp->vm_file;
>>>>>                     if (file) {
>>>>>                             struct inode *inode = file_inode(file);
>>>>> @@ -592,7 +593,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>                      */
>>>>>                     *pprev = tmp;
>>>>>                     pprev = &tmp->vm_next;
>>>>> -               tmp->vm_prev = prev;
>>>>>                     prev = tmp;
>>>>>
>>>>>                     __vma_link_rb(mm, tmp, rb_link, rb_parent);
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index b3e381919835..77b3aa38d5c2 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -269,19 +269,6 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>>>>>      {
>>>>>             struct anon_vma_chain *avc, *pavc;
>>>>>             struct anon_vma *root = NULL;
>>>>> -       struct vm_area_struct *prev = dst->vm_prev, *pprev = src->vm_prev;
>>>>> -
>>>>> -       /*
>>>>> -        * If parent share anon_vma with its vm_prev, keep this sharing in in
>>>>> -        * child.
>>>>> -        *
>>>>> -        * 1. Parent has vm_prev, which implies we have vm_prev.
>>>>> -        * 2. Parent and its vm_prev have the same anon_vma.
>>>>> -        */
>>>>> -       if (!dst->anon_vma && src->anon_vma &&
>>>>> -           pprev && pprev->anon_vma == src->anon_vma)
>>>>> -               dst->anon_vma = prev->anon_vma;
>>>>> -
>>>>>
>>>>>             list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
>>>>>                     struct anon_vma *anon_vma;
>>>>> @@ -334,6 +321,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>>>>>       */
>>>>>      int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
>>>>>      {
>>>>> +       struct vm_area_struct *prev = vma->vm_prev, *pprev = pvma->vm_prev;
>>>>>             struct anon_vma_chain *avc;
>>>>>             struct anon_vma *anon_vma;
>>>>>             int error;
>>>>> @@ -345,6 +333,17 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
>>>>>             /* Drop inherited anon_vma, we'll reuse existing or allocate new. */
>>>>>             vma->anon_vma = NULL;
>>>>>
>>>>> +       /*
>>>>> +        * If parent shares anon_vma with its vm_prev, keep this sharing.
>>>>> +        *
>>>>> +        * Previous VMA could be missing or not match previuos in parent
>>>>> +        * if VM_DONTCOPY is set: compare vm_start to avoid this case.
>>>>> +        */
>>>>> +       if (pvma->anon_vma && pprev && prev &&
>>>>> +           pprev->anon_vma == pvma->anon_vma &&
>>>>> +           pprev->vm_start == prev->vm_start)
>>>>> +               vma->anon_vma = prev->anon_vma;
>>>>> +
>>>>>             /*
>>>>>              * First, attach the new VMA to the parent VMA's anon_vmas,
>>>>>              * so rmap can find non-COWed pages in child processes.
>>>>>
>>>> >
