Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B32EC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A71B20866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfFFMvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:51:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46832 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfFFMvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:51:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C15C374;
        Thu,  6 Jun 2019 05:51:45 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 834683F5AF;
        Thu,  6 Jun 2019 05:51:43 -0700 (PDT)
Date:   Thu, 6 Jun 2019 13:51:41 +0100
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
Message-ID: <20190606125140.GB26273@e107155-lin>
References: <20190531143320.8895-1-sudeep.holla@arm.com>
 <CABb+yY1u5zdocgV=HhQcHWQa_R7ArtFqndU5_T=NsPHJ=jwseA@mail.gmail.com>
 <20190531165326.GA18115@e107155-lin>
 <20190603193946.GC2456@sirena.org.uk>
 <20190604093827.GA31069@e107533-lin.cambridge.arm.com>
 <20190605194636.GW2456@sirena.org.uk>
 <CABb+yY27Xe7d5=drKUGg82rJXcRU3EfZkG9FygZoOiioY-BMyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY27Xe7d5=drKUGg82rJXcRU3EfZkG9FygZoOiioY-BMyw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 07:51:12PM -0500, Jassi Brar wrote:
> On Wed, Jun 5, 2019 at 2:46 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Tue, Jun 04, 2019 at 10:44:24AM +0100, Sudeep Holla wrote:
> > > On Mon, Jun 03, 2019 at 08:39:46PM +0100, Mark Brown wrote:
> >
> > >
> > > > It feels like the issues with sharing access to the hardware and with the
> > > > API for talking to doorbell hardware are getting tied together and
> > > > confusing things.  But like I say I might be missing something here.
> >
> > ...
> >
> > > So what I am trying to convey here is MHU controller hardware can be
> > > used choosing one of the  different transport protocols available and
> > > that's platform choice based on the use-case.
> >
> > > The driver in the kernel should identify the same from the firmware/DT
> > > and configure it appropriately.
> >
> > > It may get inefficient and sometime impossible to address all use-case
> > > if we stick to one transport protocol in the driver and try to build
> > > an abstraction on top to use in different transport mode.
> >
> > Right, what I was trying to get at was that it feels like the discussion
> > is getting wrapped up in the specifics of the MHU rather than
> > representing this sort of controller with multiple modes in the
> > framework.
> >
> Usually when a controller could be used in more than one way, we
> implement the more generic usecase. And that's what was done for MHU.

That's debatable and we have done that so extensively so far.
So what I am saying is to implement different modes not just one so that
as many use-case are addressed.

> Implementing doorbell scheme would have disallowed mhu platforms that
> don't have any shmem between the endpoints. Now such platforms could
> use 32bits registers to pass/get data. Meanwhile doorbells could be
> emulated in client code.
>  Also, next version of MHU has many (100?) such 32bit registers per
> interrupt. Clearly those are not meant to be seen as 3200 doorbells,
> but as message passing windows. (or maybe that is an almost different
> controller because of the differences)
>

I disagree. It's configurable and vendors can just choose 2 instead of
100s as you mentioned based on the use-case and needs. So we will still
need the same there.

> BTW, this is not going to be the end of SCMI troubles (I believe
> that's what his client is). SCMI will eventually have to be broken up
> in layers (protocol and transport) for many legit platforms to use it.
> That is mbox_send_message() will have to be replaced by, say,
> platform_mbox_send()  in drivers/firmware/arm_scmi/driver.c  OR  the
> platforms have to have shmem and each mailbox controller driver (that
> could ever be used under scmi) will have to implement "doorbell
> emulation" mode. That is the reason I am not letting the way paved for
> such emulations.
>

While I don't dislike or disagree with separate transport in SCMI which
I have invested time and realised that I will duplicate mailbox framework
at the end. So I am against it only because of duplication and extra
layer of indirection which has performance impact(we have this seen in
sched governor for DVFS). So idea wise, it's good and I don't disagree
with practically seen performance impact. Hence I thought it's sane to
do something I am proposing. It also avoids coming up with virtual DT
nodes for this layer of abstract which I am completely against.

--
Regards,
Sudeep
