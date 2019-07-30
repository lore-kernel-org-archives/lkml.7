Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71507C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436DF208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564490640;
	bh=mGJfgDis7lFxQTibrlwo/CHqOx+DsqVJYO1TNNcS7h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DfljNBPSj0NS2j7cTBSU2Xl0MzVDqHjqjum9WTQvnC9ostBHzh6m4vZeqa2gIsCmv
	 37eqJB83rGMrw1LR8wzy3zJvGfqs9Gn6rqQ6nSEYMVeOUHzWB4s1wReTGnLu+rg2uH
	 TWJKhHSrk5q6ymdKtXSBmOebY5ybJLCoft34TxQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfG3Mn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbfG3Mn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:43:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68FD52089E;
        Tue, 30 Jul 2019 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564490637;
        bh=mGJfgDis7lFxQTibrlwo/CHqOx+DsqVJYO1TNNcS7h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUGaksynRCgKQ1s5ZcA8SMI7/VZWYXnjDuAtpM6+rm16sUM2BkCoBMWPbfeGeyYtX
         s8MRiUsTw9AxP68uLNUH8O0WtIzeXmiXw5vDr9RXFzHoA8YOtVvmeFuvXdvU3Lp3cs
         ZoreLJUCXvi6555PA2gikhhk9NKnME9zHHvewmWc=
Date:   Tue, 30 Jul 2019 13:43:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm_pmu: Mark expected switch fall-through
Message-ID: <20190730124352.iwh5kbnc2d76mqyf@willie-the-truck>
References: <20190726112737.19309-1-anders.roxell@linaro.org>
 <20190726122956.GC26088@lakrids.cambridge.arm.com>
 <20190726151825.GA12552@e121166-lin.cambridge.arm.com>
 <20190730112415.GB51922@lakrids.cambridge.arm.com>
 <20190730112758.ctgg6l5gldsefdgs@willie-the-truck>
 <CADYN=9+9wnpX1jSaDmowDov9GerQsdobxnVqwAf=WGk=7-VcRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADYN=9+9wnpX1jSaDmowDov9GerQsdobxnVqwAf=WGk=7-VcRw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 02:30:27PM +0200, Anders Roxell wrote:
> On Tue, 30 Jul 2019 at 13:28, Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Jul 30, 2019 at 12:24:15PM +0100, Mark Rutland wrote:
> > > On Fri, Jul 26, 2019 at 04:18:25PM +0100, Lorenzo Pieralisi wrote:
> > > > On Fri, Jul 26, 2019 at 01:29:56PM +0100, Mark Rutland wrote:
> > > > > On Fri, Jul 26, 2019 at 01:27:37PM +0200, Anders Roxell wrote:
> > > > > > When fall-through warnings was enabled by default the following warning
> > > > > > was starting to show up:
> > > > > >
> > > > > > ../drivers/perf/arm_pmu.c: In function ‘cpu_pm_pmu_notify’:
> > > > > > ../drivers/perf/arm_pmu.c:726:3: warning: this statement may fall
> > > > > >  through [-Wimplicit-fallthrough=]
> > > > > >    cpu_pm_pmu_setup(armpmu, cmd);
> > > > > >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > ../drivers/perf/arm_pmu.c:727:2: note: here
> > > > > >   case CPU_PM_ENTER_FAILED:
> > > > > >   ^~~~
> > > > > >
> > > > > > Rework so that the compiler doesn't warn about fall-through.
> > > > > >
> > > > > > Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
> > > > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > I'm not convinced that this is the correct patch to fix this issue.
> > > > > > However, I can't see why we do 'armpmu->start(armpmu);' only in 'case
> > > > > > CPU_PM_ENTER_FAILED' and why we not call function cpu_pm_pmu_setup()
> > > > > > there also, since in cpu_pm_pmu_setup() has a case prepared for
> > > > > > CPU_PM_ENTER_FAILED.
> > > > >
> > > > > I agree, think that should be:
> > > > >
> > > > >   case CPU_PM_EXIT:
> > > > >   case CPU_PM_ENTER_FAILED:
> > > > >           cpu_pm_pmu_setup(armpmu, cmd);
> > > > >           armpmu->start(armpmu);
> > > > >           break;
> > > > >
> > > > > ... so that we re-start the events before we start the PMU.
> > > > >
> > > > > That would be a fix for commit:
> > > > >
> > > > >   da4e4f18afe0f372 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
> > > >
> > > > Yes that's correct, apologies. Probably we did not hit it because CPU PM
> > > > notifier entry failures are a pretty rare event; regardless:
> > > >
> > > > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > >
> > > > I can send the updated fix, just let me know.
> > >
> > > I'm not sure what Will wants, but assuming you do so:
> > >
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> >
> > I gave up waiting
> 
> I'm sorry for letting you wait.

No, not at all. It's just that everybody was piling in with patches for
these issues and I suspected you were busy dealing with responses. Rather
than wait, I figured the best bet was just to get this fixed.

Are you going to respin the SMMUv3 change per Robin's feedback?

Will
