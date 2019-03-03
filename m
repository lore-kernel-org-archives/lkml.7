Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D51C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF5C20836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9RuIhp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCCPOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:14:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38064 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfCCPOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:14:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id a188so2313463wmf.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 07:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VrZ5zk/YsYTYEWhFr1yM4k1yqQj7V8lxdL/Jl3sZTI=;
        b=X9RuIhp1Lpa/MWGDdF2c1BjTj3uF3XOdSTluji5fLpXFbU0IKG7yxrLsV5jE/RwE4t
         ddmSNyHxpxmnaS41/5ovjYAxx5ImPiXep3Lb77uyJwSkeskXEdDfmEnsRAKsQyD0CLUC
         hJMdOW1PofMRehlAsVka8Wb2lMcnx+rI+WtMsHPDHgTbTxGjIoN0w0sddaMWeY6HT844
         pBXWE7dyUZi/j+e/oAKwk+3X5MIn9NImnuJcE/HCyZzp1LT/evULH+/OKojbo55m8y+Y
         sTVkgDrIhVS22EiEwer8GKMULE5zYV12F4J7BWz4s4PKptkDHLajJNXXMhu0WY8UwaFU
         FjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VrZ5zk/YsYTYEWhFr1yM4k1yqQj7V8lxdL/Jl3sZTI=;
        b=PTbZzTC9r/LgEPItwbH+vmnSwf1w0B7urts4dGFa22XwC3lHJQSeGH7mfneHnaV/JV
         xHelMtq+LxF29eXKJI+vYogCpZKaZQHQtnZRUcLQ1HhivfwwhJvtJ3dS5LScGxzuk4iR
         5y2Vqwr7X1IPruAiomYKfkCK9Apac46EU9Mhs8szSvCoQIGKqVmFR+jOhYIR2V2cX3Yr
         OD4YIKbkw+TFv7evI6UFWgKK1XIvSUuwNjIkMsUCqty0OOmW/oEDr0Hc8W31M2ykMdHu
         vxP82kAfCe+Woil4F8HNM2RLMVs7mV0ApyaU4RzRi+k1TD1a7WyB4DIfOLB26vAqnUUX
         ygjA==
X-Gm-Message-State: AHQUAub+L7aVJSApT2mNUZvaslWjMDGMwe5Shfi+/i4ybzSMHaMrZ/Jc
        OvsHQTjOSO85+XdfeYD7W9kXBCCSuqOs7QT/gVA=
X-Google-Smtp-Source: APXvYqw6ZWrfRjVcSAnKzX6N6sExROh917opCEwHRhj/Gbu2c42Tg1prI0LZvI8BHB1mZwDFEQaBGGw+H0bTXB/13UI=
X-Received: by 2002:a1c:2348:: with SMTP id j69mr8332833wmj.100.1551626089592;
 Sun, 03 Mar 2019 07:14:49 -0800 (PST)
MIME-Version: 1.0
References: <1551497728-12576-1-git-send-email-yuzenghui@huawei.com>
In-Reply-To: <1551497728-12576-1-git-send-email-yuzenghui@huawei.com>
From:   Zenghui Yu <zenghuiyu96@gmail.com>
Date:   Sun, 3 Mar 2019 23:14:38 +0800
Message-ID: <CAKcZhuWa4UcsoFPRkZg=M3WeUJibX8T0_R+JHS3=cyd51N9cgQ@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm64: Force a PTE mapping when logging is enabled
To:     christoffer.dall@arm.com, marc.zyngier@arm.com
Cc:     Punit Agrawal <punit.agrawal@arm.com>, suzuki.poulose@arm.com,
        julien.thierry@arm.com, LKML <linux-kernel@vger.kernel.org>,
        james.morse@arm.com, Zenghui Yu <yuzenghui@huawei.com>,
        wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think there're still some problems in this patch... Details below.

On Sat, Mar 2, 2019 at 11:39 AM Zenghui Yu <yuzenghui@huawei.com> wrote:
>
> The idea behind this is: we don't want to keep tracking of huge pages when
> logging_active is true, which will result in performance degradation.  We
> still need to set vma_pagesize to PAGE_SIZE, so that we can make use of it
> to force a PTE mapping.
>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>
> ---
> Atfer looking into https://patchwork.codeaurora.org/patch/647985/ , the
> "vma_pagesize = PAGE_SIZE" logic was not intended to be deleted. As far
> as I can tell, we used to have "hugetlb" to force the PTE mapping, but
> we have "vma_pagesize" currently instead. We should set it properly for
> performance reasons (e.g, in VM migration). Did I miss something important?
>
> ---
>  virt/kvm/arm/mmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 30251e2..7d41b16 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1705,6 +1705,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>              (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
>             !force_pte) {
>                 gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
> +       } else {
> +               /*
> +                * Fallback to PTE if it's not one of the stage2
> +                * supported hugepage sizes or the corresponding level
> +                * doesn't exist, or logging is enabled.

First, Instead of "logging is enabled", it should be "force_pte is true",
since "force_pte" will be true when:

        1) fault_supports_stage2_pmd_mappings() return false; or
        2) "logging is enabled" (e.g, in VM migration).

Second, fallback some unsupported hugepage sizes (e.g, 64K hugepage with
4K pages) to PTE is somewhat strange. And it will then _unexpectedly_
reach transparent_hugepage_adjust(), though no real adjustment will happen
since commit fd2ef358282c ("KVM: arm/arm64: Ensure only THP is candidate
for adjustment"). Keeping "vma_pagesize" there as it is will be better,
right?

So I'd just simplify the logic like:

        } else if (force_pte) {
                vma_pagesize = PAGE_SIZE;
        }


Will send a V2 later and waiting for your comments :)


thanks,

zenghui


> +                */
> +               vma_pagesize = PAGE_SIZE;
>         }
>         up_read(&current->mm->mmap_sem);
>
> --
> 1.8.3.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
