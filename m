Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E575AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96B623D16
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfFDOo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:44:56 -0400
Received: from foss.arm.com ([217.140.101.70]:45532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbfFDOoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:44:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12917341;
        Tue,  4 Jun 2019 07:44:55 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF76F3F690;
        Tue,  4 Jun 2019 07:44:53 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:44:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH V2 1/4] arm64/mm: Drop mmap_sem before calling
 __do_kernel_fault()
Message-ID: <20190604144450.GK6610@arrakis.emea.arm.com>
References: <1559544085-7502-1-git-send-email-anshuman.khandual@arm.com>
 <1559544085-7502-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559544085-7502-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 12:11:22PM +0530, Anshuman Khandual wrote:
> There is an inconsistency between down_read_trylock() success and failure
> paths while dealing with kernel access for non exception table areas where
> it calls __do_kernel_fault(). In case of failure it just bails out without
> holding mmap_sem but when it succeeds it does so while holding mmap_sem.
> Fix this inconsistency by just dropping mmap_sem in success path as well.
> 
> __do_kernel_fault() calls die_kernel_fault() which then calls show_pte().
> show_pte() in this path might become bit more unreliable without holding
> mmap_sem. But there are already instances [1] in do_page_fault() where
> die_kernel_fault() gets called without holding mmap_sem. show_pte() can
> be made more robust independently but in a later patch.
> 
> [1] Conditional block for (is_ttbr0_addr && is_el1_permission_fault)
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>

Queued for 5.3. Thanks.

-- 
Catalin
