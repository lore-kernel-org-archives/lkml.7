Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF136C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7510120C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565366675;
	bh=RST8kUqGa3EkEYcZ6G11NR+ZZghL7kEVO1zMz4NPp7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1gb+4UK4KEOGwSjMGjCFZeuOLFsvDOdPkggHdjHK4ZeodpsVImeQ6YsSSz20BOXeJ
	 +ynD6Dwj0SrqTKhpfexwGJD89ewsqsj0jIRZUvF1kQLVBvage5Q0fx1LZ7EDib4VlL
	 uogkLy/6SaLpq36RtY7RDcLnEIRQWpVJWbSB3aAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437018AbfHIQEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfHIQEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:04:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB472089E;
        Fri,  9 Aug 2019 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565366673;
        bh=RST8kUqGa3EkEYcZ6G11NR+ZZghL7kEVO1zMz4NPp7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDzfyi+pk3e+iDlG3QxTh0Z9hlWThfO0tMKxYmAhtqvCx83ws0kdnDfTsdO6w1obR
         dOV8hI+cVQRqe07nyMxZA+u+GD3K0diq+rKgO5tSHTzl2C68gkTdy4zmHYXU/HwPtO
         a2cK96jjECdjtqRspsytIDBIG8u7p9Iph671s4Jk=
Date:   Fri, 9 Aug 2019 17:04:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH 4/6] lib/refcount: Move bulk of REFCOUNT_FULL
 implementation into header
Message-ID: <20190809160428.smumdvimrtn7rv6u@willie-the-truck>
References: <20190802101000.12958-1-will@kernel.org>
 <20190802101000.12958-5-will@kernel.org>
 <20190802185222.GD2349@hirez.programming.kicks-ass.net>
 <201908021915.95BD6B26FC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908021915.95BD6B26FC@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 07:23:07PM -0700, Kees Cook wrote:
> On Fri, Aug 02, 2019 at 08:52:22PM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 02, 2019 at 11:09:58AM +0100, Will Deacon wrote:
> > > In an effort to improve performance of the REFCOUNT_FULL implementation,
> > > move the bulk of its functions into linux/refcount.h. This allows them
> > > to be inlined in the same way as if they had been provided via
> > > CONFIG_ARCH_HAS_REFCOUNT.
> > 
> > Hehe, they started out this way, then Linus said to stuff them in a C
> > file :-)
> 
> I asked this at the time and didn't quite get a straight answer; Linus's
> request was private:
> 
> https://lore.kernel.org/lkml/20170213180020.GK6500@twins.programming.kicks-ass.net/
> 
> It seemed sensible to me (then and now) to have them be inline if there
> were so many performance concerns about it, etc. Was it just the image
> size bloat due to the WARNs? So... since we're back to this topic. Why
> should they not be inline?

I mean, I can always just move this into an arm64-specific implementation
if I have to, but it seems a shame given that it's completely generic and
seems to perform just as well as the x86-specific implementation on my
laptop.

Will
