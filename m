Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68272C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC5D20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="nFBb8+Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfLLLX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:23:56 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:46648 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbfLLLXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:23:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id CBE523F32B;
        Thu, 12 Dec 2019 12:23:52 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=nFBb8+Rt;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G8z2xj_3V-v3; Thu, 12 Dec 2019 12:23:51 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 262773F26D;
        Thu, 12 Dec 2019 12:23:45 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 2BCE93621B7;
        Thu, 12 Dec 2019 12:23:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1576149825; bh=0JZnC+Uy586lVJiOKHiYswU6Ao8GHC2lftbRnIZ6H/w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nFBb8+RtJqhH0zvDLKtZWuGfMJzB3Q1+HkLJ0R6kr8cN+hXH8q6TkWbtibx4QMXHA
         91bZ47Pi2vo+F9f8rvkMHY1haRN+PhHe7HGnKHeD1XOT6yoNzD1NARmPQtg0GuIiJz
         4RzLXUb/4ZGJFhmcfQLskuH84dVm1C/2dVt/h1bs=
Subject: Re: [PATCH v16 11/25] mm: pagewalk: Add p4d_entry() and pgd_entry()
To:     Steven Price <steven.price@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Zong Li <zong.li@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20191206135316.47703-1-steven.price@arm.com>
 <20191206135316.47703-12-steven.price@arm.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <13280f9e-6f03-e1fd-659a-31462ba185b0@shipmail.org>
Date:   Thu, 12 Dec 2019 12:23:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191206135316.47703-12-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/19 2:53 PM, Steven Price wrote:
> pgd_entry() and pud_entry() were removed by commit 0b1fbfe50006c410
> ("mm/pagewalk: remove pgd_entry() and pud_entry()") because there were
> no users. We're about to add users so reintroduce them, along with
> p4d_entry() as we now have 5 levels of tables.
>
> Note that commit a00cc7d9dd93d66a ("mm, x86: add support for
> PUD-sized transparent hugepages") already re-added pud_entry() but with
> different semantics to the other callbacks. Since there have never
> been upstream users of this, revert the semantics back to match the
> other callbacks. This means pud_entry() is called for all entries, not
> just transparent huge pages.

Actually, there are two users of pud_entry(), in hmm.c and since 5.5rc1 
also mapping_dirty_helpers.c. The latter one is unproblematic and 
requires no attention but the one in hmm.c is probably largely untested, 
and seems to assume it was called outside of the spinlock.

The problem with the current patch is that the hmm pud_entry will 
traverse also pmds, so that will be done twice now.

In another thread we were discussing a means of rerunning the level (in 
case of a race), or continuing after a level, based on the return value 
after the callback. The change was fairly invasive,


> Tested-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   include/linux/pagewalk.h | 19 +++++++++++++------
>   mm/pagewalk.c            | 27 ++++++++++++++++-----------
>   2 files changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index 6ec82e92c87f..06790f23957f 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -8,15 +8,15 @@ struct mm_walk;
>   
>   /**
>    * mm_walk_ops - callbacks for walk_page_range
> - * @pud_entry:		if set, called for each non-empty PUD (2nd-level) entry
> - *			this handler should only handle pud_trans_huge() puds.
> - *			the pmd_entry or pte_entry callbacks will be used for
> - *			regular PUDs.
> - * @pmd_entry:		if set, called for each non-empty PMD (3rd-level) entry
> + * @pgd_entry:		if set, called for each non-empty PGD (top-level) entry
> + * @p4d_entry:		if set, called for each non-empty P4D entry
> + * @pud_entry:		if set, called for each non-empty PUD entry
> + * @pmd_entry:		if set, called for each non-empty PMD entry
>    *			this handler is required to be able to handle
>    *			pmd_trans_huge() pmds.  They may simply choose to
>    *			split_huge_page() instead of handling it explicitly.
> - * @pte_entry:		if set, called for each non-empty PTE (4th-level) entry
> + * @pte_entry:		if set, called for each non-empty PTE (lowest-level)
> + *			entry
>    * @pte_hole:		if set, called for each hole at all levels
>    * @hugetlb_entry:	if set, called for each hugetlb entry
>    * @test_walk:		caller specific callback function to determine whether
> @@ -27,8 +27,15 @@ struct mm_walk;
>    * @pre_vma:            if set, called before starting walk on a non-null vma.
>    * @post_vma:           if set, called after a walk on a non-null vma, provided
>    *                      that @pre_vma and the vma walk succeeded.
> + *
> + * p?d_entry callbacks are called even if those levels are folded on a
> + * particular architecture/configuration.
>    */
>   struct mm_walk_ops {
> +	int (*pgd_entry)(pgd_t *pgd, unsigned long addr,
> +			 unsigned long next, struct mm_walk *walk);
> +	int (*p4d_entry)(p4d_t *p4d, unsigned long addr,
> +			 unsigned long next, struct mm_walk *walk);
>   	int (*pud_entry)(pud_t *pud, unsigned long addr,
>   			 unsigned long next, struct mm_walk *walk);
>   	int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index ea0b9e606ad1..c089786e7a7f 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -94,15 +94,9 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>   		}
>   
>   		if (ops->pud_entry) {
> -			spinlock_t *ptl = pud_trans_huge_lock(pud, walk->vma);
> -
> -			if (ptl) {
> -				err = ops->pud_entry(pud, addr, next, walk);
> -				spin_unlock(ptl);
> -				if (err)
> -					break;
> -				continue;
> -			}
> +			err = ops->pud_entry(pud, addr, next, walk);
> +			if (err)
> +				break;

Actually, there are two current users of pud_entry(), in hmm.c and since 
5.5rc1 also mapping_dirty_helpers.c. The latter one is unproblematic and 
requires no attention but the one in hmm.c is probably largely untested, 
and seems to assume it was called outside of the spinlock.

The problem with the current patch is that the hmm pud_entry will 
traverse also pmds, so that will now be done twice.

/Thomas

