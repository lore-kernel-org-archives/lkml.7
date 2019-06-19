Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F60C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B05208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbfFSVeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:34:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:10056 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730435AbfFSVeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:34:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 14:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="182867800"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2019 14:34:19 -0700
Date:   Wed, 19 Jun 2019 14:24:45 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 1/2] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190619212445.GA234387@romley-ivt3.sc.intel.com>
References: <1560794416-217638-1-git-send-email-fenghua.yu@intel.com>
 <1560794416-217638-2-git-send-email-fenghua.yu@intel.com>
 <20190619173628.GI9574@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619173628.GI9574@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 07:36:28PM +0200, Borislav Petkov wrote:
> On Mon, Jun 17, 2019 at 11:00:15AM -0700, Fenghua Yu wrote:
> > @@ -832,33 +857,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
> >  		c->x86_capability[CPUID_D_1_EAX] = eax;
> > -	/* Additional Intel-defined flags: level 0x0000000F */
> > -	if (c->cpuid_level >= 0x0000000F) {
> What I meant with having a separate patch doing the carve out is to have
> a single patch doing *only* code movement - no changes, no nothing. So
> that it is clear what happens. Intermixing code movement and changes is
> a bad idea and hard to review.
> 
> IOW, I did this:
> 
> ---
> From cef4f58a3da0465bbff33b2d669cc600b775f3ba Mon Sep 17 00:00:00 2001
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 19 Jun 2019 17:24:34 +0200
> Subject: [PATCH] x86/cpufeatures: Carve out CQM features retrieval
> 
> ... into a separate function for better readability. Split out from a
> patch from Fenghua Yu <fenghua.yu@intel.com> to keep the mechanical,
> sole code movement separate for easy review.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/kernel/cpu/common.c | 60 ++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2c57fffebf9b..fe6ed9696467 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -801,6 +801,38 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
>  	}
>  }
>  
> +static void init_cqm(struct cpuinfo_x86 *c)
> +{
> +	u32 eax, ebx, ecx, edx;
> 
> This way you have *pure* code movement only.
> 
> And then your second patch turns into this, which shows *exactly* what
> has been changed in init_cqm().

Yes, the added patch makes this patch set more clear and readable.

> 
> Please have a look and send me only the now third patch with corrected
> commit message.
> 
> From e33527b8cde8bef84cdc90651d1a1c7a9a5234d7 Mon Sep 17 00:00:00 2001
> From: Fenghua Yu <fenghua.yu@intel.com>
> Date: Wed, 19 Jun 2019 18:51:09 +0200
> Subject: [PATCH] x86/cpufeatures: Combine word 11 and 12 into a new
>  scattered features word
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> It's a waste for the four X86_FEATURE_CQM_* feature bits to occupy two
> whole feature bits words. To better utilize feature words, re-define
> word 11 to host scattered features and move the four X86_FEATURE_CQM_*
> features into Linux defined word 11. More scattered features can be
> added in word 11 in the future.

I checked and tested the updated patch set (now three patches). They
look much better than v2.

I will send you the now third patch with corrected commit message
in the other email thread.

Thanks.

-Fenghua
