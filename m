Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14543C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE554218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ejYjCLWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfCVReg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:34:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39254 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbfCVReg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:34:36 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DEE31EC045C;
        Fri, 22 Mar 2019 18:34:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553276074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2wViPtD188aaypGBXVJxnVqsiNBeREMlmebHPKZuugY=;
        b=ejYjCLWQUp9Jc8PcmjYoKyInNDp21VsEZMwFiyasO6y1WB4yOKftcflWzG8kES0FeyHIix
        BplyxODrYb17k4u51VJX3/Pceys1Qp0aLDeBx94o0feB9SEXD/SKWE0+XrlpGCn42OAZDJ
        U8sVGA848StdsSMl5vWDktsrvz/LjKc=
Date:   Fri, 22 Mar 2019 18:34:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v2 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Message-ID: <20190322173436.GK12472@zn.tnic>
References: <20190321202505.5553-1-Yazen.Ghannam@amd.com>
 <20190321202505.5553-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190321202505.5553-2-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 08:25:18PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> AMD Family 17h Models 10h-2Fh may report a high number of L1 BTB MCA
> errors under certain conditions. The errors are benign and can safely be
> ignored. However, the high error rate may cause the MCA threshold
> counter to overflow causing a high rate of thresholding interrupts. In
> addition, users may see the errors reported through the AMD MCE decoder
> module, even with the interrupt disabled, due to MCA polling.
> 
> This error is reported through the Instruction Fetch bank.
> 
> Clear the "Counter Present" bit in the Instruction Fetch bank's
> MCA_MISC0 register. This will prevent enabling MCA thresholding on this
> bank which will prevent the high interrupt rate due to this error.
> 
> Define a function to filter these errors from the MCE event pool.
> Install this function during AMD vendor init. The MCA banks are enabled
> after vendor init, so the filter function will be installed before the
> spurious errors will be reported.
> 
> Cc: <stable@vger.kernel.org> # 4.14.x: c95b323dcd35: x86/MCE/AMD: Turn off MC4_MISC thresholding on all family 0x15 models
> Cc: <stable@vger.kernel.org> # 4.14.x: 30aa3d26edb0: x86/MCE/AMD: Carve out the MC4_MISC thresholding quirk
> Cc: <stable@vger.kernel.org> # 4.14.x
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20190307212552.8865-2-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * Filter out the error earlier in MCE code rather than later in EDAC.
> 
>  arch/x86/kernel/cpu/mce/amd.c | 57 ++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index e64de5149e50..2db85f65b41e 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -563,22 +563,55 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
>  	return offset;
>  }
>  
> +bool filter_mce_rv(struct mce *m)
> +{
> +	enum smca_bank_types bank_type = smca_get_bank_type(m->bank);
> +	u8 xec = (m->status >> 16) & 0x3F;
> +
> +	/*
> +	 * Spurious errors of this type may be reported.
> +	 * See Family 17h Models 10h-2Fh Erratum #1114.
> +	 */
> +	if (bank_type == SMCA_IF && xec == 10)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void filter_mce_check(struct cpuinfo_x86 *c)
> +{
> +	if (c->x86 == 0x17 && (c->x86_model >= 0x10 && c->x86_model <= 0x2F))
> +		filter_mce = filter_mce_rv;
> +}

Why all the noodling here with a check function which assigns a
filter_mce_rv (btw, that "rv" means nothing outside of AMD) and a
generic default_filter_mce?

Why not a simple filter_mce() in mce/core.c which calls amd_filter_mce()
based on x86_vendor and amd_filter_mce() is defined in mce/amd.c?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
