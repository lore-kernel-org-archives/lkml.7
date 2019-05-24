Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD43BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682602184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558685618;
	bh=YsDeliNo7Ubh4SkmiIuonqt/fecM2XRoPtu9XHwJW1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eZ5d/6QYR4Wx2q9D8wM575Xhuq4WLmX/RRVy1hss4vbVMKfDeT4IWrll7lVVSDZP0
	 Xpndo7WoeIYwOvXlMNbSm95N/ebwu8++prGmFD/Khn5qrzgMRCYdxobX8DYaNCuwC9
	 BP4EpZStWcf5q6m2RzOmmvqUFNKt8lvxLkn92XMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389656AbfEXINh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389327AbfEXINg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:13:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA4A420665;
        Fri, 24 May 2019 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558685615;
        bh=YsDeliNo7Ubh4SkmiIuonqt/fecM2XRoPtu9XHwJW1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xlJxGxBq//CNpb3pQoACWgIZn0+lfdCRzeG2tFHdG5TYsZEUxhCPhMMlh9ZOYQaPU
         rxCD1Q+zZ5XZsAjdyLUV/JX3ZEPgblvIXsLuUHbJcpqogKUA/2i/oY4Z0iWgRRQzkO
         fH4FD9e/fO+lCMOSA3vck3M6ZkZf85KmAuqvMA4c=
Date:   Fri, 24 May 2019 10:13:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFT PATCH v5 3/5] cpu-topology: Move cpu topology code to
 common code.
Message-ID: <20190524081333.GA15566@kroah.com>
References: <20190524000653.13005-1-atish.patra@wdc.com>
 <20190524000653.13005-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524000653.13005-4-atish.patra@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 05:06:50PM -0700, Atish Patra wrote:
> Both RISC-V & ARM64 are using cpu-map device tree to describe
> their cpu topology. It's better to move the relevant code to
> a common place instead of duplicate code.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  arch/arm64/include/asm/topology.h |  23 ---
>  arch/arm64/kernel/topology.c      | 303 +-----------------------------
>  drivers/base/arch_topology.c      | 296 +++++++++++++++++++++++++++++
>  include/linux/arch_topology.h     |  28 +++
>  include/linux/topology.h          |   1 +
>  5 files changed, 329 insertions(+), 322 deletions(-)

What, now _I_ have to maintain drivers/base/arch_topology.c?  That's
nice for everyone else, but not me :(

Ugh.

Anyway, what are you wanting to happen to this series?  I think we need
some ARM people to sign off on it before I can take the whole thing,
right?

thanks,

greg k-h
