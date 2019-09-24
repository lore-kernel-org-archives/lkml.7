Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F1BC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226A320665
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tV4SoPth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389500AbfIXP3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:29:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33347 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfIXP3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:29:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so1601574pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wX1ufemuVcZ1/+F45a1SkQ+EbtNri2rD1aWT8xtEdFA=;
        b=tV4SoPthoWRTYODIqZrV/aC6Sy0AUAsJmY8+miZnW8eGoJuGgrCmC2Gwxs9g7wu6n4
         HZ1nGz2DO267ukmKLDkhgAtHlfP1NoS/zJ8Ad3Ab33inKm+oOlmqbwG/QLyiIyhwEguT
         Tva3X+3cOLK30dewFhu0Z44DTxNbYT7IKxH/q6l1UEPga27KweT6Y3IP9sDB8qFP6Kdz
         oGjfVPGuNPC8+0JJp3YnfHfHw/OEWuBrBW7/CEUEkX2lwARfoDqV5bTjehqV8n4KvXnp
         AQIxSAozmjR/alnw9QBwiHhJL7FKChxKg953mKgDnzqbwQNJljZr48U4PA6ehsAlk3Es
         k3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wX1ufemuVcZ1/+F45a1SkQ+EbtNri2rD1aWT8xtEdFA=;
        b=RSi0HItdx6MJSeuVK+OyKjyVrKZyZ6g8OaS+nHOaFPEAAPeFuqDESbrNiHxQttZG9F
         AVlnikapa8qo1R1eNWWUntkJc0a2zQJ7O6yiCIuNR/Ewf0ejf48UysOqTmI5kr4POFrT
         acBKHjWNvUDi/+5CHt5DZxYXOz9PTtLNkW3Gs7tQELU3K8M6hxbfinWg/hLDukpsDXqK
         UcFtq7kfHNdBGXoNJYRoOrF9mxHMxu+Di1m2Y1fZtv/FhqLuGe0I+rhsjrTp+0zRECtF
         mvd19vpETJe8f1ZXAxjDfqQrP7d01PKKpev7kLwMn75nhARsHcnkHRZXhwp8yMCALKCQ
         qHuA==
X-Gm-Message-State: APjAAAUJSFPIxEODcVZHifcVOMH8iQBRluCjLpUCqUEARFUo8PzEELEI
        Kgu1aaLRGYeoy62ar/c9eng=
X-Google-Smtp-Source: APXvYqw6B/kU84DrWlicmm5F5ycfnicD7nHzLATMgZQ9XTa2Px4+hI7yUIysB8iSsBop1/FAD9fgHQ==
X-Received: by 2002:a62:1658:: with SMTP id 85mr4065421pfw.195.1569338970064;
        Tue, 24 Sep 2019 08:29:30 -0700 (PDT)
Received: from [0.0.0.0] (104.129.187.94.16clouds.com. [104.129.187.94])
        by smtp.gmail.com with ESMTPSA id q2sm3656607pfg.144.2019.09.24.08.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:29:29 -0700 (PDT)
Subject: Re: [PATCH v8 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
To:     Catalin Marinas <catalin.marinas@arm.com>,
        "Justin He (Arm Technology China)" <Justin.He@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
References: <20190921135054.142360-1-justin.he@arm.com>
 <20190921135054.142360-4-justin.he@arm.com>
 <20190923170433.GE10192@arrakis.emea.arm.com>
 <DB7PR08MB3082BC38536AE16B056AEA05F7840@DB7PR08MB3082.eurprd08.prod.outlook.com>
 <20190924103324.GB41214@arrakis.emea.arm.com>
From:   Jia He <hejianet@gmail.com>
Message-ID: <6267b685-5162-85ac-087f-112303bb7035@gmail.com>
Date:   Tue, 24 Sep 2019 23:29:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190924103324.GB41214@arrakis.emea.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin

On 2019/9/24 18:33, Catalin Marinas wrote:
> On Tue, Sep 24, 2019 at 06:43:06AM +0000, Justin He (Arm Technology China) wrote:
>> Catalin Marinas wrote:
>>> On Sat, Sep 21, 2019 at 09:50:54PM +0800, Jia He wrote:
>>>> @@ -2151,21 +2163,53 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
>>>>   	 * fails, we just zero-fill it. Live with it.
>>>>   	 */
>>>>   	if (unlikely(!src)) {
>>>> -		void *kaddr = kmap_atomic(dst);
>>>> -		void __user *uaddr = (void __user *)(va & PAGE_MASK);
>>>> +		void *kaddr;
>>>> +		pte_t entry;
>>>> +		void __user *uaddr = (void __user *)(addr & PAGE_MASK);
>>>>
>>>> +		/* On architectures with software "accessed" bits, we would
>>>> +		 * take a double page fault, so mark it accessed here.
>>>> +		 */
> [...]
>>>> +		if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
>>>> +			vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr,
>>>> +						       &vmf->ptl);
>>>> +			if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
>>>> +				entry = pte_mkyoung(vmf->orig_pte);
>>>> +				if (ptep_set_access_flags(vma, addr,
>>>> +							  vmf->pte, entry, 0))
>>>> +					update_mmu_cache(vma, addr, vmf->pte);
>>>> +			} else {
>>>> +				/* Other thread has already handled the fault
>>>> +				 * and we don't need to do anything. If it's
>>>> +				 * not the case, the fault will be triggered
>>>> +				 * again on the same address.
>>>> +				 */
>>>> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>> +				return false;
>>>> +			}
>>>> +			pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>> +		}
> [...]
>>>> +
>>>> +		kaddr = kmap_atomic(dst);
>>> Since you moved the kmap_atomic() here, could the above
>>> arch_faults_on_old_pte() run in a preemptible context? I suggested to
>>> add a WARN_ON in patch 2 to be sure.
>> Should I move kmap_atomic back to the original line? Thus, we can make sure
>> that arch_faults_on_old_pte() is in the context of preempt_disabled?
>> Otherwise, arch_faults_on_old_pte() may cause plenty of warning if I add
>> a WARN_ON in arch_faults_on_old_pte.  I tested it when I enable the PREEMPT=y
>> on a ThunderX2 qemu guest.
> So we have two options here:
>
> 1. Change arch_faults_on_old_pte() scope to the whole system rather than
>     just the current CPU. You'd have to wire up a new arm64 capability
>     for the access flag but this way we don't care whether it's
>     preemptible or not.
>
> 2. Keep the arch_faults_on_old_pte() per-CPU but make sure we are not
>     preempted here. The kmap_atomic() move would do but you'd have to
>     kunmap_atomic() before the return.
>
> I think the answer to my question below also has some implication on
> which option to pick:
>
>>>>   		/*
>>>>   		 * This really shouldn't fail, because the page is there
>>>>   		 * in the page tables. But it might just be unreadable,
>>>>   		 * in which case we just give up and fill the result with
>>>>   		 * zeroes.
>>>>   		 */
>>>> -		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
>>>> +		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
>>>> +			/* Give a warn in case there can be some obscure
>>>> +			 * use-case
>>>> +			 */
>>>> +			WARN_ON_ONCE(1);
>>> That's more of a question for the mm guys: at this point we do the
>>> copying with the ptl released; is there anything else that could have
>>> made the pte old in the meantime? I think unuse_pte() is only called on
>>> anonymous vmas, so it shouldn't be the case here.
> If we need to hold the ptl here, you could as well have an enclosing
> kmap/kunmap_atomic (option 2) with some goto instead of "return false".

I am not 100% sure that I understand your suggestion well, so I drafted the patch

here:

Changes: optimize the indentions

      hold the ptl longer


-static inline void cow_user_page(struct page *dst, struct page *src, unsigned 
long va, struct vm_area_struct *vma)
+static inline bool cow_user_page(struct page *dst, struct page *src,
+                 struct vm_fault *vmf)
  {
+    struct vm_area_struct *vma = vmf->vma;
+    struct mm_struct *mm = vma->vm_mm;
+    unsigned long addr = vmf->address;
+    bool ret;
+    pte_t entry;
+    void *kaddr;
+    void __user *uaddr;
+
      debug_dma_assert_idle(src);

+    if (likely(src)) {
+        copy_user_highpage(dst, src, addr, vma);
+        return true;
+    }
+
      /*
       * If the source page was a PFN mapping, we don't have
       * a "struct page" for it. We do a best-effort copy by
       * just copying from the original user address. If that
       * fails, we just zero-fill it. Live with it.
       */
-    if (unlikely(!src)) {
-        void *kaddr = kmap_atomic(dst);
-        void __user *uaddr = (void __user *)(va & PAGE_MASK);
+    kaddr = kmap_atomic(dst);
+    uaddr = (void __user *)(addr & PAGE_MASK);
+
+    /*
+     * On architectures with software "accessed" bits, we would
+     * take a double page fault, so mark it accessed here.
+     */
+    vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
+    if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
+        if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
+            /*
+             * Other thread has already handled the fault
+             * and we don't need to do anything. If it's
+             * not the case, the fault will be triggered
+             * again on the same address.
+             */
+            ret = false;
+            goto pte_unlock;
+        }
+
+        entry = pte_mkyoung(vmf->orig_pte);
+        if (ptep_set_access_flags(vma, addr, vmf->pte, entry, 0))
+            update_mmu_cache(vma, addr, vmf->pte);
+    }

+    /*
+     * This really shouldn't fail, because the page is there
+     * in the page tables. But it might just be unreadable,
+     * in which case we just give up and fill the result with
+     * zeroes.
+     */
+    if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
          /*
-         * This really shouldn't fail, because the page is there
-         * in the page tables. But it might just be unreadable,
-         * in which case we just give up and fill the result with
-         * zeroes.
+         * Give a warn in case there can be some obscure
+         * use-case
           */
-        if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
-            clear_page(kaddr);
-        kunmap_atomic(kaddr);
-        flush_dcache_page(dst);
-    } else
-        copy_user_highpage(dst, src, va, vma);
+        WARN_ON_ONCE(1);
+        clear_page(kaddr);
+    }
+
+    ret = true;
+
+pte_unlock:
+    pte_unmap_unlock(vmf->pte, vmf->ptl);
+    kunmap_atomic(kaddr);
+    flush_dcache_page(dst);
+
+    return ret;
  }


---
Cheers,
Justin (Jia He)

