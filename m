Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEAEC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F385A24B36
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfFDJ5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:57:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39178 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbfFDJ5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:57:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAB0B80D;
        Tue,  4 Jun 2019 02:57:17 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EFFB3F246;
        Tue,  4 Jun 2019 02:57:16 -0700 (PDT)
Date:   Tue, 4 Jun 2019 10:57:14 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] KVM: arm64: Drop 'const' from argument of vq_present()
Message-ID: <20190604095713.GV28398@e103592.cambridge.arm.com>
References: <699121e5c938c6f4b7b14a7e2648fa15af590a4a.1559623368.git.viresh.kumar@linaro.org>
 <20190604084349.prnnvjvjaeuhsmgs@mbp>
 <20190604085545.hsmxfqkpt2cbrhtw@vireshk-i7>
 <20190604092639.GS28398@e103592.cambridge.arm.com>
 <20190604093153.2pzv55knl6axugrv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604093153.2pzv55knl6axugrv@vireshk-i7>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 03:01:53PM +0530, Viresh Kumar wrote:
> On 04-06-19, 10:26, Dave Martin wrote:
> > I'm in two minds about whether this is worth fixing, but if you want to
> > post a patch to remove the extra const (or convert vq_present() to a
> > macro), I'll take a look at it.
> 
> This patch already does what you are asking for (remove the extra
> const), isn't it ?

Yes, sorry -- I didn't scroll back far enough.

> I looked at my textbook (The C programming Language, By Brian W.
> Kernighan and Dennis M. Ritchie.) and it says:
> 
> "
> The const declaration can also be used with array arguments, to
> indicate that the function does not change that array:
> 
> int strlen(const char[]);
> "
> 
> and so this patch isn't necessary for sure.

This is an array to which a pointer argument points, not an array
argument.  I think that's how we hit the constified double-indirection
problem.

Cheers
---Dave
