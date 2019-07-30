Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF85EC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0012087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfG3LYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:24:19 -0400
Received: from foss.arm.com ([217.140.110.172]:59496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG3LYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:24:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 423FB28;
        Tue, 30 Jul 2019 04:24:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 746E93F575;
        Tue, 30 Jul 2019 04:24:17 -0700 (PDT)
Date:   Tue, 30 Jul 2019 12:24:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: Mark expected switch fall-through
Message-ID: <20190730112415.GB51922@lakrids.cambridge.arm.com>
References: <20190726112737.19309-1-anders.roxell@linaro.org>
 <20190726122956.GC26088@lakrids.cambridge.arm.com>
 <20190726151825.GA12552@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726151825.GA12552@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 04:18:25PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jul 26, 2019 at 01:29:56PM +0100, Mark Rutland wrote:
> > On Fri, Jul 26, 2019 at 01:27:37PM +0200, Anders Roxell wrote:
> > > When fall-through warnings was enabled by default the following warning
> > > was starting to show up:
> > > 
> > > ../drivers/perf/arm_pmu.c: In function ‘cpu_pm_pmu_notify’:
> > > ../drivers/perf/arm_pmu.c:726:3: warning: this statement may fall
> > >  through [-Wimplicit-fallthrough=]
> > >    cpu_pm_pmu_setup(armpmu, cmd);
> > >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > ../drivers/perf/arm_pmu.c:727:2: note: here
> > >   case CPU_PM_ENTER_FAILED:
> > >   ^~~~
> > > 
> > > Rework so that the compiler doesn't warn about fall-through.
> > > 
> > > Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > ---
> > > 
> > > I'm not convinced that this is the correct patch to fix this issue.
> > > However, I can't see why we do 'armpmu->start(armpmu);' only in 'case
> > > CPU_PM_ENTER_FAILED' and why we not call function cpu_pm_pmu_setup()
> > > there also, since in cpu_pm_pmu_setup() has a case prepared for
> > > CPU_PM_ENTER_FAILED.
> > 
> > I agree, think that should be:
> > 
> > 	case CPU_PM_EXIT:
> > 	case CPU_PM_ENTER_FAILED:
> > 		cpu_pm_pmu_setup(armpmu, cmd);
> > 		armpmu->start(armpmu);
> > 		break;
> > 
> > ... so that we re-start the events before we start the PMU.
> > 
> > That would be a fix for commit:
> > 
> >   da4e4f18afe0f372 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
> 
> Yes that's correct, apologies. Probably we did not hit it because CPU PM
> notifier entry failures are a pretty rare event; regardless:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> I can send the updated fix, just let me know.

I'm not sure what Will wants, but assuming you do so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
