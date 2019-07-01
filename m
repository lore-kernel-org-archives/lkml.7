Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB00C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC2220B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfGAMRR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:17:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40299 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfGAMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:17:17 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hhvF8-0004tA-D8; Mon, 01 Jul 2019 14:17:10 +0200
Date:   Mon, 1 Jul 2019 14:17:10 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v8 4/5] x86/xsave: Make XSAVE check the base CPUID
 features before enabling
Message-ID: <20190701121710.vardxktdc63gtcj5@linutronix.de>
References: <20171005215256.25659-1-andi@firstfloor.org>
 <20171005215256.25659-5-andi@firstfloor.org>
 <a36a8cc2-3d9e-dc70-bbe4-bfc5edef395a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <a36a8cc2-3d9e-dc70-bbe4-bfc5edef395a@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-29 17:22:59 [+0200], Vegard Nossum wrote:
> The commit for this patch in mainline
> (ccb18db2ab9d923df07e7495123fe5fb02329713) causes the kernel to hang on
> boot when passing the "nofxsr" option:

as a result of nofxsr we do:
[0]	setup_clear_cpu_cap(X86_FEATURE_FXSR);
[1]	setup_clear_cpu_cap(X86_FEATURE_FXSR_OPT);
[2]	setup_clear_cpu_cap(X86_FEATURE_XMM);


the commit in question removes then XFEATURE_MASK_SSE from
`xfeatures_mask'.
Boot stops in fpu__init_cpu_xstate() / xsetbv() due to #GP:
|If an attempt is made to set XCR0[2:1] to 10b.
(from Vol. 2C).

[1] is "harmless". Dropping [2] does not fix the issue because [0]
still clears all three flags due to 
| static const struct cpuid_dep cpuid_deps[] = {
…
|      { X86_FEATURE_XMM,              X86_FEATURE_FXSR      },

Clearing additionally XMM2 (and adding the missing bits to
xsave_cpuid_features/xfeature_names) would boot further.
Later it crashes in raid6 while probing for AVX/2 code…

Disabling XMM+XMM2 in order get (and fixing it up for AVX+AVX2) would
give use XSAVE instead of FSAVE.
This won't work on 64bit userland because it expects SSE to be around
(and FXSR to save the SSE bits).
Even my 32bit Debian Wheezy doesn't work because it wants FXSR :)

So if it is unlikely to have XSAVE but no FXSR I would suggest to add
"fpu__xstate_clear_all_cpu_caps()" to nofxsr and behave like "nofxsr
noxsave".

Sebastian
