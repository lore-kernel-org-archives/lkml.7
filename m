Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD174C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82603208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560795052;
	bh=FUMyawJcKwbgBq1KBzfgBo/OSPZ3Ne48mCmHGmTnYa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zd0mku3Zka1V2BDQcLWVrtNucOx9pEnt4LXZBT4XqXPUTMggeGkXium1wZkvDnoLg
	 qBMjQv0qKUjwNuSiXRMQ7pKNZyImhYuCxCrjFT2unOUlgOZTEQvJb9oVys9Zud908K
	 caVr5upqMkESek3QQE71jgy8/JAFlFuD5BiKHnzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfFQSKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfFQSKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:10:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D42B208C0;
        Mon, 17 Jun 2019 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560795049;
        bh=FUMyawJcKwbgBq1KBzfgBo/OSPZ3Ne48mCmHGmTnYa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcI1FxBBGA3pU+DeRfee97d7nwghNbUJ6glZCY9nO2A6deGImGozosVBQuYy2Zyib
         /Y+MS2INO9y8v/NC+3rITV+N5RU/Sk/Wwq4E0EcQOtX8bBHgj2aWC3Qf7ZiPH+rQQD
         y0J4qJyt6ukMIvBjxb0fTHJe3Wa81NjhSgw9XkyY=
Date:   Mon, 17 Jun 2019 19:10:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@Broadcom.com, ard.biesheuvel@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: Allow user selection of ARM64_MODULE_PLTS
Message-ID: <20190617181045.fekodnky6un4i723@willie-the-truck>
References: <20190614025932.533-1-f.fainelli@gmail.com>
 <20190617173241.GM30800@fuggles.cambridge.arm.com>
 <2624ce8b-0206-a217-8793-c1223178246c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2624ce8b-0206-a217-8793-c1223178246c@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:03:28AM -0700, Florian Fainelli wrote:
> On 6/17/19 10:32 AM, Will Deacon wrote:
> > On Thu, Jun 13, 2019 at 07:59:32PM -0700, Florian Fainelli wrote:
> >> Make ARM64_MODULE_PLTS a selectable Kconfig symbol, since some people
> >> might have very big modules spilling out of the dedicated module area
> >> into vmalloc. Help text is copied from the ARM 32-bit counterpart.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  arch/arm64/Kconfig | 14 +++++++++++++-
> >>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 697ea0510729..36befe987b73 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -1418,8 +1418,20 @@ config ARM64_SVE
> >>  	  KVM in the same kernel image.
> >>  
> >>  config ARM64_MODULE_PLTS
> >> -	bool
> >> +	bool "Use PLTs to allow module memory to spill over into vmalloc area"
> >>  	select HAVE_MOD_ARCH_SPECIFIC
> >> +	help
> >> +	  Allocate PLTs when loading modules so that jumps and calls whose
> >> +	  targets are too far away for their relative offsets to be encoded
> >> +	  in the instructions themselves can be bounced via veneers in the
> >> +	  module's PLT. This allows modules to be allocated in the generic
> >> +	  vmalloc area after the dedicated module memory area has been
> >> +	  exhausted. The modules will use slightly more memory, but after
> >> +	  rounding up to page size, the actual memory footprint is usually
> >> +	  the same.
> > 
> > Isn't the worry really about the runtime performance overhead introduced
> > by the veneers, as opposed to the memory usage of the module?
> 
> The main concern is indeed runtime performance (both added veneers and
> possibly increased cache trashing) and second could be the increased
> vmalloc usage. Do you want me to rephrase that part, or drop it?

Whichever you prefer.

> > 
> >> +	  Disabling this is usually safe for small single-platform
> >> +	  configurations. If unsure, say y.
> > 
> > So should this be on by default?
> 
> It is turned on under certain conditions that require it (v2 makes that
> clearer, based on Ard's feedback), having it turned off by default at
> least makes people realize (or rather can be used as argument) that the
> modules are possibly too big.
> 
> Under certain build configurations like test/manufacturing, you might
> have a set of large modules that should still load, hence this patch.

I'm fine with leaving it default off, but then let's not say "If unsure, say
y". In fact, you can remove that whole "disabling this is usually safe" part
I reckon.

Will
