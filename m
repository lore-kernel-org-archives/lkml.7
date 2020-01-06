Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F6CC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07870214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578332453;
	bh=bIKoVq4hl/ECNJKsDFS86OjWRdm/wDV25FzE9e9dkIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rsfn2mOGFbCYsckr0IXlhnUErE1YxnNOyZM/+2+aSSWO6u9kI30qSD2WwhXZVrpsv
	 6kvsBCTZ7/TpuaRG+kwAybwnB/nrZ/669HVLWAQKgv3KeLzF9FgI6dbYOrdQQ5UwEY
	 Hp00yGbj/FIgCHjg35PsCmEmBXJ6DuIqReYwoPOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgAFRkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:40:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFRkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 12:40:51 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FC0207FF;
        Mon,  6 Jan 2020 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578332450;
        bh=bIKoVq4hl/ECNJKsDFS86OjWRdm/wDV25FzE9e9dkIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzOCByQJUep+YkGdjIFATSvSmNO39GTmt/W4SruqlilzlYqIS9Aox9DpAAXsbXzKK
         ikAhcBRxSRwBzdq+GuVRk0xvRO5WJ2WuDhSAOARW82MI4ERsA6BNBq19HWvE0bJeeM
         u0WNumDWCk/3WMSHz79ronZ0Jwb0kcQtSfTnvCzU=
Date:   Mon, 6 Jan 2020 17:40:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pavel Labath <labath@google.com>,
        Pratyush Anand <panand@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kazuhiro Inaba <kinaba@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: hw_breakpoint: Handle inexact watchpoint addresses
Message-ID: <20200106174045.GD9676@willie-the-truck>
References: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
 <20191120191813.GD4799@willie-the-truck>
 <CAD=FV=Wntf0TCwdtNNvPY-CXX1VL_SZK8Y8yw1r=UfeayHfwgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wntf0TCwdtNNvPY-CXX1VL_SZK8Y8yw1r=UfeayHfwgw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 08:36:19AM -0800, Doug Anderson wrote:
> On Wed, Nov 20, 2019 at 11:18 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Sat, Oct 19, 2019 at 11:12:26AM -0700, Douglas Anderson wrote:
> > > This is commit fdfeff0f9e3d ("arm64: hw_breakpoint: Handle inexact
> > > watchpoint addresses") but ported to arm32, which has the same
> > > problem.
> > >
> > > This problem was found by Android CTS tests, notably the
> > > "watchpoint_imprecise" test [1].  I tested locally against a copycat
> > > (simplified) version of the test though.
> > >
> > > [1] https://android.googlesource.com/platform/bionic/+/master/tests/sys_ptrace_test.cpp
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  arch/arm/kernel/hw_breakpoint.c | 96 ++++++++++++++++++++++++---------
> > >  1 file changed, 70 insertions(+), 26 deletions(-)
> >
> > Sorry for taking so long to look at this. After wrapping my head around the
> > logic again
> 
> Yeah.  It was a little weird and (unfortunately) arbitrarily different
> in some places compared to the arm64 code.
> 
> 
> > I think it looks fine, so please put it into the patch system
> > with my Ack:
> >
> > Acked-by: Will Deacon <will@kernel.org>
> 
> Thanks!  Submitted as:
> 
> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8944/1
> 
> 
> > One interesting difference between the implementation here and the arm64
> > code is that I think if you have multiple watchpoints, all of which fire
> > with a distance != 0, then arm32 will actually report them all whereas
> > you'd only get one on arm64.
> 
> Are you sure about that?  The "/* No exact match found. */" code is
> outside the for loop so it should only be able to trigger for exactly
> one breakpoint, no?

I didn't test it, but I think that we'll convert the first watchpoint into a
mismatch breakpoint on arm32 and then when we resume execution, we'll hit
the subsequent watchpoint and so on until we actually manage to "step" the
instruction. On arm64, we'll use hardware step directly and therefore
disable all watchpoints prior to performing the step.

Will
