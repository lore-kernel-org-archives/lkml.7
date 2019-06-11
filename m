Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BD3C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5CA2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dyk1sksl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406303AbfFKTrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:47:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48032 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405627AbfFKTrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:47:08 -0400
Received: from zn.tnic (p200300EC2F0A6800C99A25AB4FDD1714.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:c99a:25ab:4fdd:1714])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34A461EC0982;
        Tue, 11 Jun 2019 21:47:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560282426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CC/oI2Wwu4Or8ykBFfBroDWIw6tH8IEDxVd4jkVAMhM=;
        b=dyk1sksl/FHOoXtdYp1NIGjeFoA+3olMP55Q9/k8Ph4UqCNY8LfTtJR13NcDyrG10WLcfT
        r+s/y/hTVnQ7kHnnvcCFR2/rKLzq18c72rYZaDGnBoYCRwvrOmkXCZaV4RXzOQTU4BhBO8
        bdSptWWX/hXHcY+9LKGxK2snImz9uTQ=
Date:   Tue, 11 Jun 2019 21:47:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/cpufeatures: Enumerate new AVX512 bfloat16
 instructions
Message-ID: <20190611194701.GJ31772@zn.tnic>
References: <1560186158-174788-1-git-send-email-fenghua.yu@intel.com>
 <20190610192026.GI5488@zn.tnic>
 <20190611181920.GC180343@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611181920.GC180343@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:19:20AM -0700, Fenghua Yu wrote:
> So can I re-organize word 11 and 12 as follows?
> 
> 1. Change word 11 to host scattered features.
> 2. Move the previos features in word 11 and word 12 to word 11:
> /*
>  * Extended auxiliary flags: Linux defined - For features scattered in various
>  * CPUID levels and sub-leaves like CPUID level 7 and sub-leaf 1, etc, word 19.
>  */
> #define X86_FEATURE_CQM_LLC             (11*32+ 0) /* LLC QoS if 1 */
> #define X86_FEATURE_CQM_OCCUP_LLC       (11*32+ 1) /* LLC occupancy monitoring */
> #define X86_FEATURE_CQM_MBM_TOTAL       (11*32+ 2) /* LLC Total MBM monitoring */
> #define X86_FEATURE_CQM_MBM_LOCAL       (11*32+ 3) /* LLC Local MBM monitoring */

Yap.

> 3. Change word 12 to host CPUID.(EAX=7,ECX=1):EAX:
> /* Intel-defined CPU features, CPUID level 0x7:1 (EAX), word 12 */
> #define X86_FEATURE_AVX512_BF16         (12*32+ 0) /* BFLOAT16 instructions */

This needs to be (12*32+ 5) if word 12 is going to map leaf
CPUID.(EAX=7,ECX=1):EAX.

At least judging from the arch extensions doc which lists EAX as:

Bits 04-00: Reserved.
Bit 05: AVX512_BF16. Vector Neural Network Instructions supporting BFLOAT16 inputs and conversion instructions from IEEE single precision.
Bits 31-06: Reserved.

> 4. Do other necessary changes to match the new word 11 and word 12.

But split in two patches: first does steps 1+2, second patch adds the
new leaf to word 12.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
