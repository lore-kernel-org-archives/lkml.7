Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F50C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B5521872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552594032;
	bh=QE2MFC2S7ITMsfk2pgjvm/86pVHHvXfZGQMDeg6oAf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MNZZiZAlk6dCmDhm5nxGM+jhk3tUEEfyGQXSPdMkFJ66rtyCDzpT/JXM0LF76FuVs
	 TvFQJoFLlr12rnIf3N3G3eqjDfKB70jeLpIFvnjGL97oxNz0oABoBOiGjsnKJ7I4IW
	 F2lZoUlj1iAydDWLthi5Xu3ayV/MeUl1WLuCw/c0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfCNUHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfCNUHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:07:11 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3423E2082F;
        Thu, 14 Mar 2019 20:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552594030;
        bh=QE2MFC2S7ITMsfk2pgjvm/86pVHHvXfZGQMDeg6oAf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enuAJKjXF9qtcsilanCribrJnZ6V4ZSdKuTOE9nu6Ut9pKKf/X+EvhPdijLzVyoc6
         Q8X7cSsVxriG+X9v1Aq4HSVb9/duC7ET+TnnQq2xicplgaKQoH0ueotIKmcJ1R9IDn
         5YI7x4zU6S3yt4FvEY3me5GPA9ur53UunLO+wTAA=
Date:   Thu, 14 Mar 2019 13:07:09 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Alan J. Wylie" <alan@wylie.me.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Regression] Re: Linux 5.0.2
Message-ID: <20190314200709.GA16125@kroah.com>
References: <20190314162756.GA20704@kroah.com>
 <87pnqtkz23.fsf@wylie.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnqtkz23.fsf@wylie.me.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 07:59:00PM +0000, Alan J. Wylie wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > I'm announcing the release of the 5.0.2 kernel.
> 
> There is a regression for AMD-only builds.

Adding the stable list, which people should do...

> 
> See also Alec Ari's report:
> https://lkml.org/lkml/2019/3/13/1113
> 
> > If CONFIG_CPU_SUP_INTEL is disabled with either the 5.0.2 or 4.20.16
> > kernel, it errors out right away:
> 
> $ grep "CONFIG_CPU_SUP_" .config
> # CONFIG_CPU_SUP_INTEL is not set
> CONFIG_CPU_SUP_AMD=y
> # CONFIG_CPU_SUP_HYGON is not set
> # CONFIG_CPU_SUP_CENTAUR is not set
> 
> CC      arch/x86/events/core.o
> In file included from arch/x86/events/core.c:44:
> arch/x86/events/perf_event.h:1035:45: warning: ‘struct cpu_hw_event’ declared inside parameter list will not be visible outside of this definition or declaration
>  static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
>                                              ^~~~~~~~~~~~
> arch/x86/events/perf_event.h:1040:45: warning: ‘struct cpu_hw_event’ declared inside parameter list will not be visible outside of this definition or declaration
>  static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
>                                              ^~~~~~~~~~~~
> arch/x86/events/core.c: In function ‘free_fake_cpuc’:
> arch/x86/events/core.c:1998:20: error: passing argument 1 of ‘intel_cpuc_finish’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   intel_cpuc_finish(cpuc);
>                     ^~~~
> In file included from arch/x86/events/core.c:44:
> arch/x86/events/perf_event.h:1040:59: note: expected ‘struct cpu_hw_event *’ but argument is of type ‘struct cpu_hw_events *’
>  static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
>                                       ~~~~~~~~~~~~~~~~~~~~~^~~~
> arch/x86/events/core.c: In function ‘allocate_fake_cpuc’:
> arch/x86/events/core.c:2012:25: error: passing argument 1 of ‘intel_cpuc_prepare’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   if (intel_cpuc_prepare(cpuc, cpu))
>                          ^~~~
> In file included from arch/x86/events/core.c:44:
> arch/x86/events/perf_event.h:1035:59: note: expected ‘struct cpu_hw_event *’ but argument is of type ‘struct cpu_hw_events *’
>  static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
>                                       ~~~~~~~~~~~~~~~~~~~~~^~~~
> cc1: some warnings being treated as errors

Is this a regression?  If so, what commit caused this?  Is this also an
issue in Linus's tree right now?

thanks,

greg k-h
