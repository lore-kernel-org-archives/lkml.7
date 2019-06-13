Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E64C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C798B20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbfFMPIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:08:14 -0400
Received: from foss.arm.com ([217.140.110.172]:41740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732381AbfFMPIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:08:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28E59367;
        Thu, 13 Jun 2019 08:08:12 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E383A3F718;
        Thu, 13 Jun 2019 08:08:10 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:08:04 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 0/6] mailbox: arm_mhu: add support to use in doorbell mode
Message-ID: <20190613150804.GA11854@e107155-lin>
References: <20190531143320.8895-1-sudeep.holla@arm.com>
 <CABb+yY1u5zdocgV=HhQcHWQa_R7ArtFqndU5_T=NsPHJ=jwseA@mail.gmail.com>
 <20190531165326.GA18115@e107155-lin>
 <20190603193946.GC2456@sirena.org.uk>
 <20190604093827.GA31069@e107533-lin.cambridge.arm.com>
 <20190605194636.GW2456@sirena.org.uk>
 <CABb+yY27Xe7d5=drKUGg82rJXcRU3EfZkG9FygZoOiioY-BMyw@mail.gmail.com>
 <20190606125140.GB26273@e107155-lin>
 <CABb+yY06heJ5s5-2tvrDt9CdL+--YLG+P52e52YFPqTA=Nb3vw@mail.gmail.com>
 <20190606154045.GA2429@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606154045.GA2429@e107155-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 04:40:45PM +0100, Sudeep Holla wrote:
> On Thu, Jun 06, 2019 at 10:20:40AM -0500, Jassi Brar wrote:
> > On Thu, Jun 6, 2019 at 7:51 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > >
> > > > BTW, this is not going to be the end of SCMI troubles (I believe
> > > > that's what his client is). SCMI will eventually have to be broken up
> > > > in layers (protocol and transport) for many legit platforms to use it.
> > > > That is mbox_send_message() will have to be replaced by, say,
> > > > platform_mbox_send()  in drivers/firmware/arm_scmi/driver.c  OR  the
> > > > platforms have to have shmem and each mailbox controller driver (that
> > > > could ever be used under scmi) will have to implement "doorbell
> > > > emulation" mode. That is the reason I am not letting the way paved for
> > > > such emulations.
> > > >
> > >
> > > While I don't dislike or disagree with separate transport in SCMI which
> > > I have invested time and realised that I will duplicate mailbox framework
> > > at the end.
> > >
> > Can you please share the code? Or is it no more available?
> >
> > > So I am against it only because of duplication and extra
> > > layer of indirection which has performance impact(we have this seen in
> > > sched governor for DVFS).
> > >
> > I don't see why the overhead should increase noticeably.
> >
>
> Simple, if 2 protocols share the same channel, then the requests are
> serialised. E.g. if bits 0 and 1 are allocated for protocol#1
> and bits 2 and 3 for protocol#2 and protocol#1 has higher latency
> requirements like sched-governor DVFS and there are 3-4 pending requests
> on protocol#2, then the incoming request for protocol#1 is blocked.
>

Any idea on addressing the above with abstraction layer above the driver ?
And the bit allotment without the virtual channel representation in DT.
These 2 are main issues that needs to be resolved.

--
Regards,
Sudeep
