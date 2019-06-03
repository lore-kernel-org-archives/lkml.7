Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A043FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E00326D15
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFCV6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:58:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60508 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfFCV6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 17:58:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5200CA78;
        Mon,  3 Jun 2019 14:21:10 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1326C3F5AF;
        Mon,  3 Jun 2019 14:21:07 -0700 (PDT)
Date:   Mon, 3 Jun 2019 22:21:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        marc.zyngier@arm.com, Dave.Martin@arm.com, suzuki.poulose@arm.com,
        will.deacon@arm.com, christoffer.dall@arm.com,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190603212104.mhz7vvj7afb2p3yr@mbp>
References: <20190521172139.21277-1-julien.grall@arm.com>
 <20190521172139.21277-4-julien.grall@arm.com>
 <20190603162534.GF63283@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603162534.GF63283@arrakis.emea.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 05:25:34PM +0100, Catalin Marinas wrote:
> On Tue, May 21, 2019 at 06:21:39PM +0100, Julien Grall wrote:
> > Since a softirq is supposed to check may_use_simd() anyway before
> > attempting to use FPSIMD/SVE, there is limited reason to keep softirq
> > disabled when touching the FPSIMD/SVE context. Instead, we can simply
> > disable preemption and mark the FPSIMD/SVE context as in use by setting
> > CPU's fpsimd_context_busy flag.
> [...]
> > +static void get_cpu_fpsimd_context(void)
> > +{
> > +	preempt_disable();
> > +	__get_cpu_fpsimd_context();
> > +}
> 
> Is there anything that prevents a softirq being invoked between
> preempt_disable() and __get_cpu_fpsimd_context()?

Actually, it shouldn't matter as the softirq finishes using the fpsimd
before the thread is resumed.

-- 
Catalin
