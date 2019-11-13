Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1F8C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F5E22459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573649073;
	bh=IEH8Ss9dnj1pNsb7Bs6QI6Vql+Jm2nsWpMPLKqcdq8Y=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=0nhgJzFtkdpInK0aBajzMkY3ijwA24ngZbgMfu7zfkbS7amytb2WSEFmLQPRYpDxF
	 sn8CofgxO0LaDdYVxscx2BN6FuMDij2Ua/YjqQ/jySuHT9PMZikciC13G6c4FaRqDY
	 j8GLKL+LDziMWhpa4dNe1t4Xnb/uQk5rnf/NGzmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKMMoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:44:32 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:53989 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbfKMMoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:44:32 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iUs0a-0001J2-0j; Wed, 13 Nov 2019 13:44:28 +0100
To:     Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 1/2] arm64: Combine workarounds for speculative AT  errata
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 13:53:48 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20191113114118.2427-2-steven.price@arm.com>
References: <20191113114118.2427-1-steven.price@arm.com>
 <20191113114118.2427-2-steven.price@arm.com>
Message-ID: <566ecd45c8bf07b3cb5d75a10c9413a8@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: steven.price@arm.com, catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-13 12:50, Steven Price wrote:
> Cortex-A57/A72 have a similar errata to Cortex-A76 regarding 
> speculation
> of the AT instruction. Since the workaround for A57/A72 doesn't 
> require
> VHE, the restriction enforcing VHE for A76 can be removed by 
> combining
> the workaround flag for both errata.

Are we sure that A76 behaves the same as A57/A72 when it comes to not
caching any of the EPD* bits in the TLB? Because the 1319367 workaround
has a lot of the A72 microarch implicit to it, and I'm not sure this
works as is on A76 or A55...

The patch itself looks OK, but I'd like some reassurance about the
above.

          M.
-- 
Jazz is not dead. It just smells funny...

