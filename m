Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D241ECA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6788208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfJ3Qpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:45:41 -0400
Received: from foss.arm.com ([217.140.110.172]:37992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfJ3Qpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:45:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FBDB31F;
        Wed, 30 Oct 2019 09:45:40 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 119493F6C4;
        Wed, 30 Oct 2019 09:45:37 -0700 (PDT)
Date:   Wed, 30 Oct 2019 16:45:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v14 21/22] arm64: mm: Convert mm/dump.c to use
 walk_page_range()
Message-ID: <20191030164535.GC13309@arrakis.emea.arm.com>
References: <20191028135910.33253-1-steven.price@arm.com>
 <20191028135910.33253-22-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028135910.33253-22-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 01:59:09PM +0000, Steven Price wrote:
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index 93f9f77582ae..9d9b740a86d2 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -15,6 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/init.h>
>  #include <linux/mm.h>
> +#include <linux/ptdump.h>
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
>  
> @@ -75,10 +76,11 @@ static struct addr_marker address_markers[] = {
>   * dumps out a description of the range.
>   */
>  struct pg_state {
> +	struct ptdump_state ptdump;
>  	struct seq_file *seq;
>  	const struct addr_marker *marker;
>  	unsigned long start_address;
> -	unsigned level;
> +	int level;
>  	u64 current_prot;
>  	bool check_wx;
>  	unsigned long wx_pages;
> @@ -178,6 +180,10 @@ static struct pg_level pg_level[] = {
>  		.name	= "PGD",
>  		.bits	= pte_bits,
>  		.num	= ARRAY_SIZE(pte_bits),
> +	}, { /* p4d */
> +		.name	= "P4D",
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
>  	}, { /* pud */
>  		.name	= (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
>  		.bits	= pte_bits,

We could use "PGD" for the p4d entry since we don't have five levels.
This patches the "PGD" name used for pud/pmd when these levels are
folded.

> @@ -240,11 +246,15 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
>  	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
>  }
>  
> -static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
> -				u64 val)
> +static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
> +		      unsigned long val)
>  {
> +	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
>  	static const char units[] = "KMGTPE";
> -	u64 prot = val & pg_level[level].mask;
> +	u64 prot = 0;
> +
> +	if (level >= 0)
> +		prot = val & pg_level[level].mask;

I think this test is not needed as we never have level < 0. The only
call with a level 0 is from ptdump_hole() where the level passed is
depth+1 while depth is -1 or higher.

Anyway, we can keep this test _if_ we shift the levels down. I find it
quite confusing that ptdump_hole() takes a 'depth' argument where 0 is
PGD and 4 is PTE while for note_page() 1 is PGD and 5 PTE.

-- 
Catalin
