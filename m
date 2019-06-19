Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D5AC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A542147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560965886;
	bh=jknSe5jW3bcaltB/kyMG6IREECByf4zxqPgnYI39H6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hEc4leTppRFCuTlYvR3eThH12RgcJ8qn0pQ6kYAPO2XI2KGCrzn/VAaDDwG7Jrb5X
	 Yt5b/B/SVsnOi9puSt+AvXg+8oMKAdF7h7vE1zeFjLwlvKzuGHca6YnFAb6zz5nm98
	 xUEDoiKg3JeJtrJIOYs8UNG2OZtVs6m3GUycqBWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfFSRiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:38:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfFSRiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:38:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B30921744;
        Wed, 19 Jun 2019 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560965883;
        bh=jknSe5jW3bcaltB/kyMG6IREECByf4zxqPgnYI39H6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7y4JpuNEob+dMW/flJ37Q1UplBw77V0kcriLi9MVJ7KwtU2DRpoEES5eLippmSzJ
         xIwPzqeMFfemyirPsvGBRCIC+EzxOgm+gfFoNqmORlz9zxg5IVH/zrcbkKCk45p9EP
         Y04Z2hWVJSTFRpabjgboL7uF+iAFiP4hRE04veEA=
Date:   Wed, 19 Jun 2019 19:38:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v7 3/7] cpu-topology: Move cpu topology code to common
 code.
Message-ID: <20190619173801.GB20916@kroah.com>
References: <20190617185920.29581-1-atish.patra@wdc.com>
 <20190617185920.29581-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617185920.29581-4-atish.patra@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:59:16AM -0700, Atish Patra wrote:
> Both RISC-V & ARM64 are using cpu-map device tree to describe
> their cpu topology. It's better to move the relevant code to
> a common place instead of duplicate code.
> 
> To: Will Deacon <will.deacon@arm.com>
> To: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> [Tested on QDF2400]
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> [Tested on Juno and other embedded platforms.]
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
