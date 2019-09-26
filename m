Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C29C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DB6222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfIZPRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:17:08 -0400
Received: from foss.arm.com ([217.140.110.172]:52592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfIZPRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:17:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C50B315A2;
        Thu, 26 Sep 2019 08:17:07 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1FC53F534;
        Thu, 26 Sep 2019 08:17:06 -0700 (PDT)
Date:   Thu, 26 Sep 2019 16:17:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
Message-ID: <20190926151704.GH9689@arrakis.emea.arm.com>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926060353.54894-1-vincenzo.frascino@arm.com>
 <20190926060353.54894-2-vincenzo.frascino@arm.com>
 <20190926080616.GB26802@iMac.local>
 <0ff3d5f4-11c9-4207-c6ab-2f8e9ee7de5e@arm.com>
 <ad90f9bb-aa39-615c-3ae5-bea394bd787c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad90f9bb-aa39-615c-3ae5-bea394bd787c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 01:22:01PM +0100, Vincenzo Frascino wrote:
> On 9/26/19 11:56 AM, Vincenzo Frascino wrote:
> > On 9/26/19 9:06 AM, Catalin Marinas wrote:
> >> Now, could we not generate a COMPATCC in the Makefile and use
> >> $(COMPATCC) here instead of $(CROSS_COMPILE_COMPAT)gcc? It really
> >> doesn't make sense to check that gcc is gcc.
> >>
> > 
> > All right, COMPATCC is already in the makefile, I will use it in here.
> 
> What you are proposing seems not possible because Kconfig runs first and then
> the arch Makefile, hence compatcc does not take effect on the Kconfig. I will
> post v2 with what I proposed, please feel free to comment if you have a better idea.

I think it works as long as you export COMPATCC from the
arch/arm64/Makefile. The arch Makefile is used in the config step
AFAICT. See the diff I posted in my reply to your v2.

-- 
Catalin
