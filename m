Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CDBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9F520675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfCFKTb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:19:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40829 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfCFKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:19:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so12185836qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KDuqq3OQugnVi/sHGn4FIjHcj0fzu4Mo+4imtCZdOzM=;
        b=JBa2TuMv64zTSBPGXHoOsSv0Mfw3wTnzxP0XN14H7IWqIsjKUAYa453WqvTKMREKzO
         bJV9O7Z/bodCdR2zjhE9QM/tedvnByt6XXK5lHnZb1FW5jYhFXsh3CZ0ckOS7BvGhaAG
         CyoT6bx6VbIbxDNSLkHnLhj1dTnbqjNVQKj8v2t5jt9mRhmitKiWmZ9LxDOPammyl4gs
         HvJo4Z01fAIwgdXAo5y/NGYUtCQ0hSbQlZTo2S+y8zVYIazrwYYyp58zFP4A0m0fXlnm
         +U1Lv3cPzzfv/MhzCMlyuD4BtdJrVi9SxMHw+BLjHEBByuWfuwQfDfdcQvlPWUucZq3P
         hLIw==
X-Gm-Message-State: APjAAAU2Ffyi54+QitW02ONFlxE4VpNvbMPY56z+PXWY9ihomNq+1fxA
        sB0XxvmH+J4xKVBGDoULbD+8xHtGPWb6EQf1wE0=
X-Google-Smtp-Source: APXvYqwlRefBtN7F0BSjmxiEhBo6nicOMU4ZZ22wsdOnFGndKuvhBT7TV6ri6KNFkjGqXGJxdr4OPG0fXMcEPCvYwSA=
X-Received: by 2002:a0c:b501:: with SMTP id d1mr5707775qve.115.1551867570098;
 Wed, 06 Mar 2019 02:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20190304200026.1140281-1-arnd@arndb.de> <bf509a99-604b-10a4-e71b-f4f8e61f00b3@nvidia.com>
In-Reply-To: <bf509a99-604b-10a4-e71b-f4f8e61f00b3@nvidia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 11:19:13 +0100
Message-ID: <CAK8P3a2no2gjWXTcgg_g1DJ9B-j8LfyaeOn+Ji18bWS5mQNZUA@mail.gmail.com>
Subject: Re: [PATCH] mm/hmm: fix unused variable warnings
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 12:51 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> With some Kconfig local hacks that removed all HUGE* support, while leaving
> HMM enabled, I was able to reproduce your results, and also to verify the
> fix. It also makes sense from reading it.

Thanks for the confirmation.

> Also, I ran into one more warning as well:
>
> mm/hmm.c: In function ‘hmm_vma_walk_pud’:
> mm/hmm.c:764:25: warning: unused variable ‘vma’ [-Wunused-variable]
>   struct vm_area_struct *vma = walk->vma;
>                          ^~~
>
> ...which can be fixed like this:
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index c4beb1628cad..c1cbe82d12b5 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -761,7 +761,6 @@ static int hmm_vma_walk_pud(pud_t *pudp,
>  {
>         struct hmm_vma_walk *hmm_vma_walk = walk->private;
>         struct hmm_range *range = hmm_vma_walk->range;
> -       struct vm_area_struct *vma = walk->vma;
>         unsigned long addr = start, next;
>         pmd_t *pmdp;
>         pud_t pud;
> @@ -807,7 +806,7 @@ static int hmm_vma_walk_pud(pud_t *pudp,
>                 return 0;
>         }
>
> -       split_huge_pud(vma, pudp, addr);
> +       split_huge_pud(walk->vma, pudp, addr);
>         if (pud_none(*pudp))
>                 goto again;
>
> ...so maybe you'd like to fold that into your patch?

I also ran into this one last night during further randconfig testing,
and came up with the same patch that you showed here. I'll
send this one to Andrew and add a Reported-by line for you,
since he already merged the first patch.

I'll leave it up to Andrew to fold the fixes into one, or into the original
patches if he thinks that makes sense.

     Arnd
