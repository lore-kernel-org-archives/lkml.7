Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE50C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7302083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aZrBSxo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbfHORyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:54:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35720 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729909AbfHORyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:54:12 -0400
Received: from zn.tnic (p200300EC2F0B5200B5E4FA5ECC10BE25.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5200:b5e4:fa5e:cc10:be25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29DA21EC097D;
        Thu, 15 Aug 2019 19:54:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565891651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vF2oh2cDgq7Qt+uvuum84fXp+ZMjQvhfOcSDfMKlKo0=;
        b=aZrBSxo9m8AmaF86l66Mn565+4csBCvu8eJtisYvxojZdmg4jiUfHjJtcJjVfQR4+lZKJl
        XkpDmxQI9W7JqfWxeUbJJ0NnJ/QZxWF1PQGH3FRAYB3LURjeKJB6aZM33HRPDDjJV27Ig9
        6WqSQodsphBtUPOle4qd/DPkMZ0qUTk=
Date:   Thu, 15 Aug 2019 19:54:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Message-ID: <20190815175455.GJ15313@zn.tnic>
References: <20190814234030.30817-1-tony.luck@intel.com>
 <20190815075822.GC15313@zn.tnic>
 <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:21:59AM -0700, Luck, Tony wrote:
> Like this?

Actually, I was thinking you'd put it above the defines in the file
intel-family.h itself so that *everyone* who wants to add a model, sees
it first and while that explanation below is very nice...

> +The CPU model number on a running system can be found by executing
> +the CPUID(EAX=0) instruction to find the vendor, family, model
> +and stepping.  The model number is found by concatenating two bit
> +fields from the EAX return value. Bits 19:16 (extended model number)
> +and 7:4 (model number).
> +
> +Inside the Linux kernel the vendor, family, model and stepping are
> +stored in the cpuinfo_x86 structure. Model specific code typically
> +uses x86_match_cpu() to determine if it is running on any of some
> +list of CPU models.
> +
> +There are several subsystems that need model specific handling on
> +Intel CPUs. For code legibility it is better to assign names for
> +the various model numbers in the include file <asm/intel-family.h>
> +
> +Currently all interesting Intel CPU models are in family 6.

.. we're probably going to need the text only from here on down:

> +
> +HOWTO Build an INTEL_FAM6_ definition:
> +
> +1. Start with INTEL_FAM6_
> +2. If not Core-family, add a note about it, like "ATOM".  There are only
> +   two options for this (Xeon Phi and Atom).  It is exceedingly unlikely
> +   that you are adding a cpu which needs a new option here.
> +3. Add the processor microarchitecture, not the platform name
> +4. Add a short differentiator if necessary.  Add an _X to differentiate
> +   Server from Client.
> +5. Add an optional comment with the platform name(s)
> +
> +It should end up looking like this:
> +
> +INTEL_FAM6_<ATOM?>_<MICROARCH>_<SHORT...> /* Platform Name */
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
