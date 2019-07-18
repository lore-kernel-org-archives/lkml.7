Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E4DC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DBA2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfGRFSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 01:18:51 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:44853 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725959AbfGRFSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:18:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C4B22180A68BF;
        Thu, 18 Jul 2019 05:18:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: power11_12a7847651600
X-Filterd-Recvd-Size: 2231
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Jul 2019 05:18:48 +0000 (UTC)
Message-ID: <9eda0e29f524275a217411ea81352271b782baa4.camel@perches.com>
Subject: Re: [PATCH] KVM: x86/vPMU: refine kvm_pmu err msg when event
 creation failed
From:   Joe Perches <joe@perches.com>
To:     Like Xu <like.xu@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Avi Kivity <avi@scylladb.com>
Cc:     kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
        like.xu@linux.inetl.com, linux-kernel@vger.kernel.org
Date:   Wed, 17 Jul 2019 22:18:46 -0700
In-Reply-To: <20190718044914.35631-1-like.xu@linux.intel.com>
References: <20190718044914.35631-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-18 at 12:49 +0800, Like Xu wrote:
> If a perf_event creation fails due to any reason of the host perf
> subsystem, it has no chance to log the corresponding event for guest
> which may cause abnormal sampling data in guest result. In debug mode,
> this message helps to understand the state of vPMC and we should not
> limit the number of occurrences.
[]
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
[]
> @@ -131,8 +131,8 @@ static void pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type,
>  						 intr ? kvm_perf_overflow_intr :
>  						 kvm_perf_overflow, pmc);
>  	if (IS_ERR(event)) {
> -		printk_once("kvm_pmu: event creation failed %ld\n",
> -			    PTR_ERR(event));
> +		pr_debug("kvm_pmu: event creation failed %ld\n for pmc->idx = %d",
> +			    PTR_ERR(event), pmc->idx);

Perhaps this was written as printk_once to avoid
spamming the log with repeated messages.

Maybe this should use pr_debug_ratelimited.
(and it should also have a \n termination like:)

		pr_debug_ratelimited("kvm_pmu: event creation failed %ld for pmc->idx = %d\n",
				     PTR_ERR(event), pmc->idx);

Perhaps Avi Kivity remembers why he wrote it this way.
https://lore.kernel.org/kvm/1305129333-7456-6-git-send-email-avi@redhat.com/


