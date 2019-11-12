Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB92C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3C42067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573579681;
	bh=l3SuH1oTbu7Dtm62dAEfptJKeIljcJanzu2UAes3Jgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o3mm4z1RS8ZN/jP15STvURTaPMqJqXJEEC6ZTts9ZpZCFkZ4LbTw0CGkBWeVyS2ez
	 wJjC4+o1T0nH9p/KLid0B7FFYzmIqjHTUjhQShMpkGXDmYJOgNmbz3wqIY5eUNUx5N
	 DHIpuNvrd6XJupdiarigrqFvziNpl/uev0kfF520=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKLR2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:28:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLR2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:28:00 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC1E2084E;
        Tue, 12 Nov 2019 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573579679;
        bh=l3SuH1oTbu7Dtm62dAEfptJKeIljcJanzu2UAes3Jgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=05ZxocR8A5mWUXm+BIyO9KKWckdD0JaMcD/BUjA+HQDW0dlPAvkf+oY2/MCoMkxTK
         HVPUStjK0Pun33usyrN9gKhEv6RRnoGWL8botbhBOvwGsmC7JnD0eQHuuFL6Tmg6II
         oExKVXPYUr5vchSwVX1xxiCTisbkgHk+Do3R+VDQ=
Date:   Tue, 12 Nov 2019 17:27:54 +0000
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Kconfig: add a choice for endianess
Message-ID: <20191112172754.GA19889@willie-the-truck>
References: <20191112160144.8357-1-anders.roxell@linaro.org>
 <e44db1ec-e562-18c4-ca6f-96e4279564ed@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e44db1ec-e562-18c4-ca6f-96e4279564ed@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 04:24:31PM +0000, John Garry wrote:
> On 12/11/2019 16:01, Anders Roxell wrote:
> > When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
> > CONFIG_CPU_BIG_ENDIAN gets enabled. Which tends not to be what most
> > people wants. Another concern that thas come up is that ACPI in't built
> 
> /s/wants/want/, s/thas/has/, s/in't/isn't/
> 
> > for an allmodconfig kernel today since that also depends on !CPU_BIG_ENDIAN.
> > 
> > Rework so that we introduce a 'choice' and default the choice to
> > CPU_LITTLE_ENDIAN. That means that when we build an allmodconfig kernel
> > it will default to CPU_LITTLE_ENDIAN that most people tends to want.
> > 
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> FWIW, apart from spelling mistakes:
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
> > ---
> >   arch/arm64/Kconfig | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 64764ca92fca..62f83c234a61 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -877,11 +877,24 @@ config ARM64_PA_BITS
> >   	default 48 if ARM64_PA_BITS_48
> >   	default 52 if ARM64_PA_BITS_52
> > +choice
> > +	prompt "Endianess"
> 
> Should this be "Endianness"?
> 
> > +	default CPU_LITTLE_ENDIAN
> > +	help
> > +	  Choose what mode you plan on running your kernel in.

While we're at it, I'd avoid the use of "mode" here since that has a
different meaning in the architecture, although I see we already use that
terminology for CPU_BIG_ENDIAN. How about:

  "Select the endianness of data accesses performed by the CPU. Userspace
   applications will need to be compiled and linked for the endianness
   that is selected here.

   Little-endian is compatible with x86, but big-endian is faster."

(ok, maybe drop that last sentence ;)

> >   config CPU_BIG_ENDIAN
> >          bool "Build big-endian kernel"
> >          help
> >            Say Y if you plan on running a kernel in big-endian mode.

Then this can be:

  "Say Y if you plan on running a kernel with a big-endian userspace."

> > +config CPU_LITTLE_ENDIAN
> > +	bool "Build little-endian kernel"
> > +	help
> > +	  Say Y if you plan on running a kernel in little-endian mode.


  "Say Y if you plan on running a kernel with a little-endian userspace.
   This is usually the case for distributions targetting arm64."

I think it's userspace that people really care about, so wording it in
terms of that makes most sense to me.

Will
