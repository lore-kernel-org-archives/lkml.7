Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59338ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B57F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbfJOOFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:05:46 -0400
Received: from foss.arm.com ([217.140.110.172]:39408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732292AbfJOOFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:05:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25D30337;
        Tue, 15 Oct 2019 07:05:45 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 237813F718;
        Tue, 15 Oct 2019 07:05:44 -0700 (PDT)
Date:   Tue, 15 Oct 2019 15:05:42 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] arm64: cpufeature: Fix the type of no FP/SIMD
 capability
Message-ID: <20191015140541.GW27757@arm.com>
References: <20191011113620.GG27757@arm.com>
 <4ba5c423-4e2a-d810-cd36-32a16ad42c91@arm.com>
 <20191011142137.GH27757@arm.com>
 <418b0c4b-cbcd-4263-276d-1e9edc5eee0b@arm.com>
 <20191014145204.GS27757@arm.com>
 <12e002e7-42e8-c205-e42c-3348359d2f98@arm.com>
 <20191014155009.GM24047@e103592.cambridge.arm.com>
 <CAKv+Gu83oa3+DKNFowVkE=mZfLorAvGQ3GVPiZtsXzQBcsMCWg@mail.gmail.com>
 <20191015102459.GV27757@arm.com>
 <CAKv+Gu_=jw94Hj5Vo=5w+hb5RcPR4SQvxOM02WQr9hDhyzE67g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_=jw94Hj5Vo=5w+hb5RcPR4SQvxOM02WQr9hDhyzE67g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 12:30:15PM +0200, Ard Biesheuvel wrote:
> On Tue, 15 Oct 2019 at 12:25, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Mon, Oct 14, 2019 at 06:57:30PM +0200, Ard Biesheuvel wrote:

[...]

> > > All in-kernel NEON code checks whether the NEON is usable, so I'd
> > > expect that check to return 'false' if it is too early in the boot for
> > > the NEON to be used at all.
> >
> > My concern is that the check may be done once, at probe time, for crypto
> > drivers.  If probing happens before system_supports_fpsimd() has
> > stabilised, we may be stuck with the wrong probe decision.
> >
> > So: are crypto drivers and kernel_mode_neon() users definitely only
> > probed _after_ all early CPUs are up?
> >
> 
> Isn't SMP already up when initcalls are processed?

That was my original assumption when developing SVE.  I think I
convinced myself that it was valid, but it sounds worth reinvestigating.

Assuming the assumption _is_ valid, then dropping a suitable WARN() into
system_supports_fpsimd() or cpu_has_neon() or similar may be a good idea.

Cheers
---Dave
