Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36BCECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BA621906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569935948;
	bh=HKniFrzlEIzDLbVQIXPlj+qxkY260aNAZwM8YakNKBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UnXs2IaK68+8gySFlAN+yhEFf8/N75f28UDJMpsAk/7Iv/aGNSazys/umym6vV/ht
	 cULJaoFPicwq/6B58ZAnzGSzXlhPfwoEg+RtYv+ABCeDpJDKG4vlpEuiIn0lpYG0yQ
	 r77Agf4VDpsz7+e+w5sCKlnDozj6UFETxc2xxqDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbfJANTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:19:08 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:38169 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388005AbfJANTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:19:07 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iFI3N-0005kv-Pu; Tue, 01 Oct 2019 15:18:57 +0200
Date:   Tue, 1 Oct 2019 14:18:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jia He <justin.he@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v10 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Message-ID: <20191001141848.762296bd@why>
In-Reply-To: <20191001125446.gknoofnm7az4wqf5@willie-the-truck>
References: <20190930015740.84362-1-justin.he@arm.com>
        <20190930015740.84362-2-justin.he@arm.com>
        <20191001125446.gknoofnm7az4wqf5@willie-the-truck>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, justin.he@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com, willy@infradead.org, kirill.shutemov@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, punitagrawal@gmail.com, tglx@linutronix.de, akpm@linux-foundation.org, hejianet@gmail.com, Kaly.Xin@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 13:54:47 +0100
Will Deacon <will@kernel.org> wrote:

> On Mon, Sep 30, 2019 at 09:57:38AM +0800, Jia He wrote:
> > We unconditionally set the HW_AFDBM capability and only enable it on
> > CPUs which really have the feature. But sometimes we need to know
> > whether this cpu has the capability of HW AF. So decouple AF from
> > DBM by new helper cpu_has_hw_af().
> > 
> > Signed-off-by: Jia He <justin.he@arm.com>
> > Suggested-by: Suzuki Poulose <Suzuki.Poulose@arm.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/include/asm/cpufeature.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index 9cde5d2e768f..949bc7c85030 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -659,6 +659,16 @@ static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
> >  	default: return CONFIG_ARM64_PA_BITS;
> >  	}
> >  }
> > +
> > +/* Check whether hardware update of the Access flag is supported */
> > +static inline bool cpu_has_hw_af(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM))
> > +		return read_cpuid(ID_AA64MMFR1_EL1) & 0xf;  
> 
> 0xf? I think we should have a mask in sysreg.h for this constant.

We don't have the mask, but we certainly have the shift.

GENMASK(ID_AA64MMFR1_HADBS_SHIFT + 3, ID_AA64MMFR1_HADBS_SHIFT) is a bit
of a mouthful though. Ideally, we'd have a helper for that.

	M.
-- 
Without deviation from the norm, progress is not possible.
