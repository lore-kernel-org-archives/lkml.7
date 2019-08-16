Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8DDC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A4E21655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfHPHBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:01:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41479 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPHBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:01:14 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyWEW-0003nX-Is; Fri, 16 Aug 2019 09:01:08 +0200
Date:   Fri, 16 Aug 2019 09:01:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Luck, Tony" <tony.luck@intel.com>
cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
In-Reply-To: <20190815224704.GA10025@agluck-desk2.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1908160900290.1908@nanos.tec.linutronix.de>
References: <20190814234030.30817-1-tony.luck@intel.com> <20190815075822.GC15313@zn.tnic> <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com> <20190815175455.GJ15313@zn.tnic> <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
 <alpine.DEB.2.21.1908152217070.1908@nanos.tec.linutronix.de> <20190815224704.GA10025@agluck-desk2.amr.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019, Luck, Tony wrote:
> >From 093bf8cd02f4c7a3fa256c2cf7302014190e2840 Mon Sep 17 00:00:00 2001
> From: Tony Luck <tony.luck@intel.com>
> Date: Thu, 15 Aug 2019 11:16:24 -0700
> Subject: [PATCH] x86/cpu: Explain Intel model naming convention
> 
> Dave Hansen spelled out the rules in an e-mail:
> 
>  https://lkml.kernel.org/r/91eefbe4-e32b-d762-be4d-672ff915db47@intel.com
> 
> Copy those right into the <asm/intel-family.h> file to
> make it easy for people to find them.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 0278aa66ef62..fe7c205233f1 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -11,6 +11,21 @@
>   * While adding a new CPUID for a new microarchitecture, add a new
>   * group to keep logically sorted out in chronological order. Within
>   * that group keep the CPUID for the variants sorted by model number.
> + *
> + * The defined symbol names have the following form:
> + *	INTEL_FAM6{OPTFAMILY}_{MICROARCH}{OPTDIFF}
> + * where:
> + * OPTFAMILY	Describes the family of CPUs that this belongs to. Default
> + *		is assumed to be "_CORE" (and should be omitted). Other values
> + *		currently in use are _ATOM and _XEON_PHI
> + * MICROARCH	Is the code name for the micro-architecture for this core.
> + *		N.B. Not the platform name.
> + * OPTDIFF	If needed, a short string to differentiate by market segment.
> + *		Exact strings here will vary over time. _DESKTOP, _MOBILE, and
> + *		_X (short for Xeon server) should be used when they are
> + *		appropriate.
> + *
> + * The #define line may optionally include a comment including platform names.
>   */

Acked-by: Thomas Gleixner <tglx@linutronix.de>
