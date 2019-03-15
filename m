Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FA6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE84B21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfCOPMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:12:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60830 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfCOPMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:12:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2001A78;
        Fri, 15 Mar 2019 08:12:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 274733F614;
        Fri, 15 Mar 2019 08:12:44 -0700 (PDT)
Date:   Fri, 15 Mar 2019 15:12:41 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Okamoto, Takayuki" <tokamoto@jp.fujitsu.com>
Cc:     'Will Deacon' <will.deacon@arm.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        'James Morse' <james.morse@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "Zhang, Lei" <zhang.lei@jp.fujitsu.com>,
        "hange-folder>?" <toggle-mailboxes@lakrids.cambridge.arm.com>
Subject: Re: [RESEND PATCH] Make Fujitsu Erratum 010001 patch can be applied
 on A64FX v1r0
Message-ID: <20190315151241.GC48314@lakrids.cambridge.arm.com>
References: <5FA513F682BE7F4EAAB8EE035D5B08E44E9363CC@G01JPEXMBKW02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FA513F682BE7F4EAAB8EE035D5B08E44E9363CC@G01JPEXMBKW02>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 12:22:36PM +0000, Okamoto, Takayuki wrote:
> I resend the patch due to whitespace munging.
> 
> > -----Original Message-----
> > From: James Morse <james.morse@arm.com>
> > Sent: Wednesday, February 27, 2019 3:44 AM
> > To: james.morse@arm.com; linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org; Catalin Marinas
> > <catalin.marinas@arm.com>; Mark Rutland <mark.rutland@arm.com>; Will
> > Deacon <will.deacon@arm.com>; Zhang, Lei <zhang.lei@jp.fujitsu.com>
> > Subject: [PATCH v5] arm64: Add workaround for Fujitsu A64FX erratum
> > 010001
> > 
> > +/* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
> > +#define MIDR_FUJITSU_ERRATUM_010001
> > 	MIDR_FUJITSU_A64FX
> > +#define MIDR_FUJITSU_ERRATUM_010001_MASK
> > 	(~MIDR_VARIANT(1))
> 
> This workaround for the erratum should be applied for both A64FX v1r0 and
> v0r0, however, the patch v5 is only enabled on A64FX v0r0(MIDR.Variant == 0
> && MIDR.Revision == 0).
> This issue is caused by the macro MIDR_FUJITSU_ERRATUM_010001_MASK.
> 
> I have tested on both A64FX v1r0 and v0r0. This new patch will effect
> only for A64FX.
> 
> --
> Changed to be applied for not only A64FX v0r0 but also v1r0.
> 
> Signed-off-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
> ---
>  arch/arm64/include/asm/cputype.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 2afb133..1fb47b5 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -129,7 +129,7 @@
>  
>  /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
>  #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
> -#define MIDR_FUJITSU_ERRATUM_010001_MASK	(~MIDR_VARIANT(1))

The bug is is that MIDR_VARIANT() is meant to extract the variant from a
full MIDR value, not generate an in-place field value.

> +#define MIDR_FUJITSU_ERRATUM_010001_MASK	(~(0x1 << MIDR_VARIANT_SHIFT))

I beleive this can be:

#define MIDR_FUJITSU_ERRATUM_010001_MASK	(~MIDR_VAR_REV(1, 0))

But otherwise this looks fine to me.

Thanks,
Mark.

>  #define TCR_CLEAR_FUJITSU_ERRATUM_010001	(TCR_NFD1 | TCR_NFD0)
>  
>  #ifndef __ASSEMBLY__
> -- 
> 1.8.3.1
> 
