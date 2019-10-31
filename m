Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC55CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A36220873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfJaOh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:37:29 -0400
Received: from foss.arm.com ([217.140.110.172]:49786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbfJaOh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:37:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9A741F1;
        Thu, 31 Oct 2019 07:37:28 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D2843F71E;
        Thu, 31 Oct 2019 07:37:26 -0700 (PDT)
Date:   Thu, 31 Oct 2019 14:37:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v14 21/22] arm64: mm: Convert mm/dump.c to use
 walk_page_range()
Message-ID: <20191031143724.GE39590@arrakis.emea.arm.com>
References: <20191028135910.33253-1-steven.price@arm.com>
 <20191028135910.33253-22-steven.price@arm.com>
 <20191030164535.GC13309@arrakis.emea.arm.com>
 <40956d62-241c-6685-72f1-bfc01183141e@arm.com>
 <20191031140038.GC39590@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031140038.GC39590@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:00:38PM +0000, Catalin Marinas wrote:
> On Thu, Oct 31, 2019 at 01:32:34PM +0000, Steven Price wrote:
> > On 30/10/2019 16:45, Catalin Marinas wrote:
> > > On Mon, Oct 28, 2019 at 01:59:09PM +0000, Steven Price wrote:
> > >> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> > >> index 93f9f77582ae..9d9b740a86d2 100644
> > >> --- a/arch/arm64/mm/dump.c
> > >> +++ b/arch/arm64/mm/dump.c
> > >> @@ -15,6 +15,7 @@
> > >>  #include <linux/io.h>
> > >>  #include <linux/init.h>
> > >>  #include <linux/mm.h>
> > >> +#include <linux/ptdump.h>
> > >>  #include <linux/sched.h>
> > >>  #include <linux/seq_file.h>
> > >>  
> > >> @@ -75,10 +76,11 @@ static struct addr_marker address_markers[] = {
> > >>   * dumps out a description of the range.
> > >>   */
> > >>  struct pg_state {
> > >> +	struct ptdump_state ptdump;
> > >>  	struct seq_file *seq;
> > >>  	const struct addr_marker *marker;
> > >>  	unsigned long start_address;
> > >> -	unsigned level;
> > >> +	int level;
> > >>  	u64 current_prot;
> > >>  	bool check_wx;
> > >>  	unsigned long wx_pages;
> > >> @@ -178,6 +180,10 @@ static struct pg_level pg_level[] = {
> > >>  		.name	= "PGD",
> > >>  		.bits	= pte_bits,
> > >>  		.num	= ARRAY_SIZE(pte_bits),
> > >> +	}, { /* p4d */
> > >> +		.name	= "P4D",
> > >> +		.bits	= pte_bits,
> > >> +		.num	= ARRAY_SIZE(pte_bits),
> > >>  	}, { /* pud */
> > >>  		.name	= (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
> > >>  		.bits	= pte_bits,
> > > 
> > > We could use "PGD" for the p4d entry since we don't have five levels.
> > > This patches the "PGD" name used for pud/pmd when these levels are
> > > folded.
> > 
> > Good point, although I'd actually be more tempted to do the opposite -
> > remove the special casing for PUD/PMD as the generic code should now
> > never provide those levels if they are folded. What do you think?
> 
> I agree, it makes sense.

Forgot to mention. With the additional patch you sent, feel free to also
add my r-o-b on this one.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
