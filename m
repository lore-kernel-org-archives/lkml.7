Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7E4C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122AE2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lI2ow/OD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfFLEDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:03:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54448 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfFLEDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:03:03 -0400
Received: from zn.tnic (p200300EC2F0A680098854F45E2A0A47F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:9885:4f45:e2a0:a47f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 16ED61EC0467;
        Wed, 12 Jun 2019 06:03:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560312182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s5hOtfFPgTiY8jVIYZGW21WLJ7BpwUhn+HZQo+5wkro=;
        b=lI2ow/ODPtiKcdMEX/i4VTcbA+F5/I+XzJbBbEMe3YJOkzdb6dI5aSkou4gX1PyG5Geoad
        KjmBl64czu6LR/j6cxbXtK37erJFLyEzbNX/yhFP8rJ1aJhH3lJBwZJgevD9gpuvY1RW30
        NSQNduiXK+/+j43d3ZLoI37v2yhbqqo=
Date:   Wed, 12 Jun 2019 06:02:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/cpufeatures: Enumerate new AVX512 bfloat16
 instructions
Message-ID: <20190612040259.GC32652@zn.tnic>
References: <1560186158-174788-1-git-send-email-fenghua.yu@intel.com>
 <20190610192026.GI5488@zn.tnic>
 <20190611181920.GC180343@romley-ivt3.sc.intel.com>
 <20190611194701.GJ31772@zn.tnic>
 <20190612033259.GE180343@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190612033259.GE180343@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:32:59PM -0700, Fenghua Yu wrote:
> Currently KVM doesn't simulate scattered features (the ones in CPUID_LNX_*
> in cpuid_leafs) as reverse_cpuid[] doesn't contain CPUID_LNX_*.

43500e6f294d ("x86/cpufeatures: Remove get_scattered_cpuid_leaf()")

> After the X86_FEATURES_CQM_* features are changed to scattered features,
> they will not be simulated by KVM any more as CPUID_F_0_EDX and CPUID_F_1_EDX
> are removed.

Does KVM even support resctrl? I doubt only exporting a couple of CPUID
bits into the guest is enough...

> Should patch #1 simulate X86_FEATURE_CQM_* in KVM? Or let KVM guys handle
> the scattered features?

Right, the scattered thing was removed as KVM didn't need it,
apparently, see above.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
