Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1134CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DCE20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCELL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:11:56 -0500
Received: from foss.arm.com ([217.140.101.70]:46574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfCELLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:11:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C4CC1596;
        Tue,  5 Mar 2019 03:11:55 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B09843F71D;
        Tue,  5 Mar 2019 03:11:53 -0800 (PST)
Date:   Tue, 5 Mar 2019 11:11:51 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     Marc Zyngier <Marc.Zyngier@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kristina Martsenko <Kristina.Martsenko@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [kvmtool PATCH v6 6/6] arm/kvm: arm64: Add a vcpu feature for
 pointer authentication
Message-ID: <20190305111149.GK3567@e103592.cambridge.arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-7-git-send-email-amit.kachhap@arm.com>
 <20190221155409.GA3567@e103592.cambridge.arm.com>
 <048f772a-1faf-5fa3-d82c-25212a5104af@arm.com>
 <20190301112452.GS16031@e103592.cambridge.arm.com>
 <b21de5ed-197d-3ea7-021c-b3bca312e70c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b21de5ed-197d-3ea7-021c-b3bca312e70c@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 04:38:18PM +0530, Amit Daniel Kachhap wrote:
> 
> Hi Dave,
> 
> On 3/1/19 4:54 PM, Dave P Martin wrote:
> >On Fri, Mar 01, 2019 at 10:37:54AM +0000, Amit Daniel Kachhap wrote:
> >>Hi,
> >>
> >>On 2/21/19 9:24 PM, Dave Martin wrote:
> >>>On Tue, Feb 19, 2019 at 02:54:31PM +0530, Amit Daniel Kachhap wrote:
> >
> >[...]
> >
> >>>>diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
> >>>>index 04be43d..2074684 100644
> >>>>--- a/arm/aarch64/include/kvm/kvm-config-arch.h
> >>>>+++ b/arm/aarch64/include/kvm/kvm-config-arch.h
> >>>>@@ -8,7 +8,9 @@
> >>>>   			"Create PMUv3 device"),				\
> >>>>   	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
> >>>>   			"Specify random seed for Kernel Address Space "	\
> >>>>-			"Layout Randomization (KASLR)"),
> >>>>+			"Layout Randomization (KASLR)"),		\
> >>>>+	OPT_BOOLEAN('\0', "ptrauth", &(cfg)->has_ptrauth,		\
> >>>>+			"Enable address authentication"),
> >>>
> >>>Nit: doesn't this enable address *and* generic authentication?  The
> >>>discussion on what capababilities and enables the ABI exposes probably
> >>>needs to conclude before we can finalise this here.
> >>ok.
> >>>
> >>>However, I would recommend that we provide a single option here that
> >>>turns both address authentication and generic authentication on, even
> >>>if the ABI treats them independently.  This is expected to be the common
> >>>case by far.
> >>ok
> >>>
> >>>We can always add more fine-grained options later if it turns out to be
> >>>necessary.
> >>Mark suggested to provide 2 flags [1] for Address and Generic
> >>authentication so I was thinking of adding 2 features like,
> >>
> >>+#define KVM_ARM_VCPU_PTRAUTH_ADDR		4 /* CPU uses pointer address
> >>authentication */
> >>+#define KVM_ARM_VCPU_PTRAUTH_GENERIC		5 /* CPU uses pointer generic
> >>authentication */
> >>
> >>And supply both of them concatenated in VCPU_INIT stage. Kernel KVM
> >>would expect both feature requested together.
> >
> >Seems reasonable.  Do you mean the kernel would treat it as an error if
> >only one of these flags is passed to KVM_ARM_VCPU_INIT, or would KVM
> >simply treat them as independent?
> If both flags are passed together then only start using ptrauth otherwise
> keep ptrauth disabled. This is just to finalize the user side abi as of now
> and KVM can be updated later.

If just flag is passed, I think KVM_ARM_VCPU_INIT should just fail.
Otherwise we risk userspace becoming accidentally reliant on behaviour
that may change in the future.

Cheers
---Dave
