Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FC4C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3220657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfFSRMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:12:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:37340 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfFSRMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:12:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 10:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,393,1557212400"; 
   d="scan'208";a="153866740"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by orsmga008.jf.intel.com with ESMTP; 19 Jun 2019 10:12:49 -0700
Date:   Wed, 19 Jun 2019 10:12:49 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qian Cai <cai@lca.pw>, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cacheinfo: fix a -Wtype-limits warning
Message-ID: <20190619171249.GG1203@linux.intel.com>
References: <1559763654-5155-1-git-send-email-cai@lca.pw>
 <20190605200703.GD26328@linux.intel.com>
 <20190619170127.GF9574@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619170127.GF9574@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 07:01:27PM +0200, Borislav Petkov wrote:
> On Wed, Jun 05, 2019 at 01:07:04PM -0700, Sean Christopherson wrote:
> > Might be worth calling out in the changelog that 'c->x86 == 0x17' is true
> > if and only if c->x86_model was explicitly set by cpu_detect(), i.e. the
> > patch is correct even if the original intent was a misguided attempt to
> > check that x86_model has been set.
> 
> Are you thinking about some sick virt scenario where base CPUID level is < 1?

Ha, no.  My comment was that it'd be worth explaining that the original
'c->x86_model >= 0' check was completely bogus, even if the intent was
something like 'c->x86_model != 0'.

> In this particular case, there's a guard at the beginning of
> cacheinfo_amd_init_llc_id():
> 
>         if (!cpuid_edx(0x80000006))
>                 return;
> 
> but if there's CPUs which have CPUID 0x80000006 but base CPUID level is
> < 1, then that's their problem.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
