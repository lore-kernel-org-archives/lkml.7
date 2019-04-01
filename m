Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B62C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBF12084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfDAISP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:18:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57484 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfDAISO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:18:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39AF7374;
        Mon,  1 Apr 2019 01:18:14 -0700 (PDT)
Received: from blommer (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E9C43F690;
        Mon,  1 Apr 2019 01:18:10 -0700 (PDT)
Date:   Mon, 1 Apr 2019 09:17:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     Julien Thierry <julien.thierry@arm.com>, will.deacon@arm.com,
        mingo@redhat.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Change PMCR write to read-modify-write
Message-ID: <20190401081757.lbfsuoocltq4lysj@blommer>
References: <1553134066-20272-1-git-send-email-psodagud@codeaurora.org>
 <bb4ece56-ac42-05f2-8475-38c49539999d@arm.com>
 <b2e82eca3dec9d1ea9053e9e69223db3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e82eca3dec9d1ea9053e9e69223db3@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:02:27PM -0700, Sodagudi Prasad wrote:
> On 2019-03-21 06:34, Julien Thierry wrote:
> > Hi Prasad,
> > 
> > On 21/03/2019 02:07, Prasad Sodagudi wrote:
> > > Preserves the bitfields of PMCR_EL0(AArch64) during PMU reset.
> > > Reset routine should write a 1 to PMCR.C and PMCR.P fields only
> > > to reset the counters. Other fields should not be changed
> > > as they could be set before PMU initialization and their
> > > value must be preserved even after reset.
> > 
> > Are there any particular bit you are concerned about? Apart from the RO
> > ones and the Res0 ones (to which we are already writing 0), I see:
> > 
> > DP -> irrelevant for non-secure
> > X -> This one is the only potentially interesting, however it resets to
> > an architecturally unknown value, so unless we know for a fact it was
> > set before hand, we probably want to clear it
> > D -> ignored when we have LC set (and we do)
> > E -> Since this is the function we use to reset the PMU on the current
> > CPU, we probably want to set this bit to 0 regardless of its previous
> > value
> > 
> > So, is there any issue this patch is solving?
> 
> Hi Julien,
> 
> Thanks for taking a look into this patch. Yes. On our Qualcomm platforms,
> observed that X bit is getting cleared by kernel.
> This bit is getting set by firmware for Qualcomm use cases and non-secure
> world is resetting without this patch.

Given the kernel reconfigures the PMU dynamically at runtime (e.g. to multiplex
events over counters), I don't follow how this is useful. Could you elaborate
on how specifically you intend to use this?

> I think, changing that register this register modifications to
> read-modify-write style make sense.

I disagree. 

In general, RESx bits may be allocated new meanings in future (and will reset
to UNKNOWN values), so it is not safe to simply preserve the reset value. Given
that, any kernel _must_ explicitly reset registers in order to ensure the
expected behaviour.

Thanks
Mark.
