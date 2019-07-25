Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9112CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6575E2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbfGYRH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:07:26 -0400
Received: from foss.arm.com ([217.140.110.172]:33132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387923AbfGYRHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:07:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C96A174E;
        Thu, 25 Jul 2019 10:07:25 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EFD23F71A;
        Thu, 25 Jul 2019 10:07:23 -0700 (PDT)
Date:   Thu, 25 Jul 2019 18:07:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Mark Rutland <mark.rutland@arm.com>,
        x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Brown <Mark.Brown@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <Steven.Price@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC] mm/pgtable/debug: Add test validating architecture page
 table helpers
Message-ID: <20190725170720.GB11545@arrakis.emea.arm.com>
References: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
 <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:25:23PM +0530, Anshuman Khandual wrote:
> +#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(__ARCH_HAS_4LEVEL_HACK)
> +static void pud_clear_tests(void)
> +{
> +	pud_t pud;
> +
> +	pud_clear(&pud);
> +	WARN_ON(!pud_none(pud));
> +}

For the clear tests, I think you should initialise the local variable to
something non-zero rather than rely on whatever was on the stack. In
case it fails, you have a more deterministic behaviour.

-- 
Catalin
