Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB1CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F0E20659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfJOJqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:46:02 -0400
Received: from foss.arm.com ([217.140.110.172]:33852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfJOJqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:46:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EE1A28;
        Tue, 15 Oct 2019 02:46:01 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 776CD3F68E;
        Tue, 15 Oct 2019 02:46:00 -0700 (PDT)
Date:   Tue, 15 Oct 2019 10:45:58 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, catalin.marinas@arm.com,
        Julien Grall <julien.grall@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: cpufeature: Don't expose ZFR0 to userspace when
 SVE is not enabled
Message-ID: <20191015094557.GU27757@arm.com>
References: <20191014102113.16546-1-julien.grall@arm.com>
 <20191014164313.hu2dnf5rokntzhhp@willie-the-truck>
 <223c22d0-cfe3-4aed-6a8f-b80e44cb6548@arm.com>
 <20191014172016.w6ehilts4nl5tfva@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014172016.w6ehilts4nl5tfva@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 06:20:17PM +0100, Will Deacon wrote:
> On Mon, Oct 14, 2019 at 05:57:46PM +0100, Suzuki K Poulose wrote:
> > On 14/10/2019 17:43, Will Deacon wrote:
> > > On Mon, Oct 14, 2019 at 11:21:13AM +0100, Julien Grall wrote:
> > > > The kernel may not support SVE if CONFIG_ARM64_SVE is not set and
> > > > will hide the feature from the from userspace.
> > > 
> > > I don't understand this sentence.
> > > 
> > > > Unfortunately, the fields of ID_AA64ZFR0_EL1 are still exposed and could
> > > > lead to undefined behavior in userspace.
> > > 
> > > Undefined in what way? Generally, we can't stop exposing things that
> > > we've exposed previously in case somebody has started relying on them, so
> > > this needs better justification.
> > 
> > We still expose them with this patch, but zero them out, if the SVE is not
> > supported. When SVE is enabled, we expose them as usual.
> 
> Sure, but if userspace was relying on the non-zero values, it's now broken.
> 
> What's missing from the patch description is the fact that this register is
> RAZ is SVE is not supported. Given that we get both the SVE HWCAP and
> PFR0.SVE field correct when the CONFIG option is disabled, then it's only
> very dodgy userspace which would parse the information in ZFR0 for this
> configuration and I think we can make this change as a bug fix. I'll try to
> write something sensible.

There is no SVE2 hardware yet.  On SVE(1) hardware, ZFR0 is still
reserved and all zero.

In theory userspace could look at the ZFR0 fields and deduce that SVE2 is 
valiable even when the kernel was built with SVE, but I think it highly
unlikely that any software is doing this today.

i.e., I'm pretty sure this horse is still in the stable, and I'd like to
see the door closed ;)

Cheers
---Dave
