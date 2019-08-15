Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9888FC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDD42089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EekcWs4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfHOSeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:34:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42066 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730867AbfHOSeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:34:36 -0400
Received: from zn.tnic (p200300EC2F0B5200B5E4FA5ECC10BE25.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5200:b5e4:fa5e:cc10:be25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A10D21EC0959;
        Thu, 15 Aug 2019 20:34:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565894074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Oh+hQo4aEGMq33kP804dr6bgBixAm/GTzCD1fU24gME=;
        b=EekcWs4FQBu/BRFt652W7dYZSaSPFtCNOLjZtSWHwX+gH1ON888OvufulZHcnhgQgDBjt0
        vh6F23v16kIEe1EwxkHSHDbHalqTxQ5Yb53KhRubSWE7ysVcVV0XhVhsUou9fSfG64a9ly
        mWTxaekzpGFUyfW8eE91gqMYareDdPU=
Date:   Thu, 15 Aug 2019 20:35:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Message-ID: <20190815183515.GK15313@zn.tnic>
References: <20190814234030.30817-1-tony.luck@intel.com>
 <20190815075822.GC15313@zn.tnic>
 <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
 <20190815175455.GJ15313@zn.tnic>
 <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:30:55AM -0700, Luck, Tony wrote:
> On Thu, Aug 15, 2019 at 07:54:55PM +0200, Borislav Petkov wrote:
> > On Thu, Aug 15, 2019 at 10:21:59AM -0700, Luck, Tony wrote:
> > > Like this?
> > 
> > Actually, I was thinking you'd put it above the defines in the file
> > intel-family.h itself so that *everyone* who wants to add a model, sees
> > it first and while that explanation below is very nice...
> 
> V2 ... ugh ... C doesn't do well with nested comments, so the example
> has issues.  I chose to use a C++ style comment (as they are not as
> verboten in Linux as they used to be).
> 
> Another option would be to put the instructions inside #if 0 ... #endif
> but that seems less than ideal.
> 
> Any other ideas?
> 
> -Tony
> 
> From 84624a3410a3ba03c3acb13e54b1292c3ca64b8c Mon Sep 17 00:00:00 2001
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
> index 0278aa66ef62..87443df77eee 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -11,6 +11,21 @@
>   * While adding a new CPUID for a new microarchitecture, add a new
>   * group to keep logically sorted out in chronological order. Within
>   * that group keep the CPUID for the variants sorted by model number.
> + *
> + * HOWTO Build an INTEL_FAM6_ definition:
> + * 
> + * 1. Start with INTEL_FAM6_
> + * 2. If not Core-family, add a note about it, like "ATOM".  There are only
> + *    two options for this (Xeon Phi and Atom).  It is exceedingly unlikely
> + *    that you are adding a cpu which needs a new option here.
> + * 3. Add the processor microarchitecture, not the platform name
> + * 4. Add a short differentiator if necessary.  Add an _X to differentiate
> + *    Server from Client.
> + * 5. Add an optional comment with the platform name(s)
> + * 
> + * It should end up looking like this:
> + * 
> + * INTEL_FAM6_<ATOM?>_<MICROARCH>_<SHORT...> // Platform Name(s)
>   */
>  
>  #define INTEL_FAM6_CORE_YONAH		0x0E
> -- 

Thanks, LGTM. Let's wait for the others to bikeshed a little before I
take it.

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
