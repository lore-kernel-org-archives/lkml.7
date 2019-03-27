Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D022075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfC0NvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:51:03 -0400
Received: from foss.arm.com ([217.140.101.70]:55200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfC0NvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:51:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2649680D;
        Wed, 27 Mar 2019 06:51:03 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BEB93F59C;
        Wed, 27 Mar 2019 06:51:01 -0700 (PDT)
Date:   Wed, 27 Mar 2019 13:50:59 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 9/10] KVM: arm64: docs: document KVM support of
 pointer authentication
Message-ID: <20190327135058.GW3567@e103592.cambridge.arm.com>
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-10-git-send-email-amit.kachhap@arm.com>
 <23e4a9d4-e9e1-2c1f-32ce-e7fd96080437@arm.com>
 <20190327104428.GV3567@e103592.cambridge.arm.com>
 <bdd480a4-44b3-7ddf-44f5-5b55e6251ced@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdd480a4-44b3-7ddf-44f5-5b55e6251ced@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 05:19:28PM +0530, Amit Daniel Kachhap wrote:
> Hi,
> 
> On 3/27/19 4:14 PM, Dave Martin wrote:
> >On Mon, Mar 25, 2019 at 08:05:49PM +0000, Kristina Martsenko wrote:
> >>On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
> >>>This adds sections for KVM API extension for pointer authentication.
> >>>A brief description about usage of pointer authentication for KVM guests
> >>>is added in the arm64 documentations.
> >>>
> >>>Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> >>>Cc: Mark Rutland <mark.rutland@arm.com>
> >>>Cc: Christoffer Dall <christoffer.dall@arm.com>
> >>>Cc: Marc Zyngier <marc.zyngier@arm.com>
> >>>Cc: kvmarm@lists.cs.columbia.edu
> >>
> >>I think it makes sense to also update the Kconfig symbol description for
> >>CONFIG_ARM64_PTR_AUTH, since it currently only mentions userspace
> >>support, but now the option also enables KVM guest support.
> >>
> >>It's also worth mentioning that CONFIG_ARM64_VHE=y is required for guest
> >>support.
> >
> >Is it worth making this dependency explicit in Kconfig?
> Currently there is discrepancy that userspace supports ptrauth in both
> nVHE/VHE mode and KVM guest only in VHE mode. I suppose adding explicit
> dependency flag here makes both of them similar.

Looking at the history, for SVE this Kconfig restriction has always been
present.  Since ptrauth initially upstreamed without an equivalent
restriction in Kconfig, adding it now could be seen as a regression.

So, maybe it's not worth it here.

You could add a separate option, say

config ARM64_PTR_AUTH_KVM
	bool "Pointer authentication support for KVM guests"
	default y
	depends on ARM64_PTR_AUTH && ARM64_VHE && KVM

...but that may be overkill.

Cheers,
---Dave
