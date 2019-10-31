Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FADACA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E483D20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfJaOgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:36:06 -0400
Received: from foss.arm.com ([217.140.110.172]:49744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbfJaOgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:36:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0C111F1;
        Thu, 31 Oct 2019 07:36:05 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ADB53F71E;
        Thu, 31 Oct 2019 07:36:03 -0700 (PDT)
Date:   Thu, 31 Oct 2019 14:36:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: ptdump: Reduce level numbers by 1 in note_page()
Message-ID: <20191031143600.GD39590@arrakis.emea.arm.com>
References: <40956d62-241c-6685-72f1-bfc01183141e@arm.com>
 <20191031133322.3239-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031133322.3239-1-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 01:33:22PM +0000, Steven Price wrote:
> Rather than having to increment the 'depth' number by 1 in
> ptdump_hole(), let's change the meaning of 'level' in note_page() since
> that makes the code simplier.
> 
> Note that for x86, the level numbers were previously increased by 1 in
> commit 45dcd2091363 ("x86/mm/dump_pagetables: Fix printout of p4d level")
> and the comment "Bit 7 has a different meaning" was not updated, so this
> change also makes the code match the comment again.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/mm/dump.c          |  6 +++---
>  arch/x86/mm/dump_pagetables.c | 19 ++++++++++---------
>  include/linux/ptdump.h        |  1 +
>  mm/ptdump.c                   | 16 ++++++++--------

For the arm64 part:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
