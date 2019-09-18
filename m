Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C7CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6996214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbfIRQpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:45:52 -0400
Received: from foss.arm.com ([217.140.110.172]:45048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbfIRQpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:45:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8647337;
        Wed, 18 Sep 2019 09:45:51 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1356A3F59C;
        Wed, 18 Sep 2019 09:45:48 -0700 (PDT)
Date:   Wed, 18 Sep 2019 17:45:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v4 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Message-ID: <20190918164546.GA41588@arrakis.emea.arm.com>
References: <20190918131914.38081-1-justin.he@arm.com>
 <20190918131914.38081-2-justin.he@arm.com>
 <78881acb-5871-9534-c8cc-6f54937be3fd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78881acb-5871-9534-c8cc-6f54937be3fd@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 03:20:41PM +0100, Suzuki K Poulose wrote:
> On 18/09/2019 14:19, Jia He wrote:
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index c96ffa4722d3..206b6e3954cf 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -390,6 +390,7 @@ extern DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
> >   	for_each_set_bit(cap, cpu_hwcaps, ARM64_NCAPS)
> >   bool this_cpu_has_cap(unsigned int cap);
> > +bool cpu_has_hw_af(void);
> >   void cpu_set_feature(unsigned int num);
> >   bool cpu_have_feature(unsigned int num);
> >   unsigned long cpu_get_elf_hwcap(void);
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index b1fdc486aed8..c5097f58649d 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1141,6 +1141,12 @@ static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
> >   	return true;
> >   }
> > +/* Decouple AF from AFDBM. */
> > +bool cpu_has_hw_af(void)
> > +{
> Sorry for not having asked this earlier. Are we interested in,
> 
> "whether *this* CPU has AF support ?" or "whether *at least one*
> CPU has the AF support" ? The following code does the former.
> 
> > +	return (read_cpuid(ID_AA64MMFR1_EL1) & 0xf);

In a non-preemptible context, the former is ok (per-CPU).

-- 
Catalin
