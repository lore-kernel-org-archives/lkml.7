Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E013C28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAD326C8F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfEaQxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:53:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54696 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfEaQxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:53:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 893B3A78;
        Fri, 31 May 2019 09:53:35 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E00553F59C;
        Fri, 31 May 2019 09:53:33 -0700 (PDT)
Date:   Fri, 31 May 2019 17:53:26 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/6] mailbox: arm_mhu: add support to use in doorbell mode
Message-ID: <20190531165326.GA18115@e107155-lin>
References: <20190531143320.8895-1-sudeep.holla@arm.com>
 <CABb+yY1u5zdocgV=HhQcHWQa_R7ArtFqndU5_T=NsPHJ=jwseA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY1u5zdocgV=HhQcHWQa_R7ArtFqndU5_T=NsPHJ=jwseA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 11:21:08AM -0500, Jassi Brar wrote:
> Hi Sudeep,
>
> On Fri, May 31, 2019 at 9:33 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > This is my another attempt to extend mailbox framework to support
> > doorbell mode mailbox hardware. It also adds doorbell support to ARM
> > MHU driver.
> >
> Nothing has really changed since the last time we discussed many months ago.
> MHU remains same, and so are my points.
>

Yes, I understand your concern.

But as mentioned in the cover letter I did try the suggestions and have
detailed reasoning why that's still an issue. In short I ended up
re-inventing mailbox framework with all the queuing and similar APIs
for this. Worse, we can't even add an extra node for that in DT to
describe that. It can't be simple shim as we need to allow multiple
users to access one physical channel at a time. We have use case
where we can this for CPU DVFS fast switching in scheduler context.

> >
> > Brief hardware description about MHU
> > ====================================
> >
> > For each of the interrupt signals, the MHU drives the signal using a 32-bit
> > register, with all 32 bits logically ORed together. The MHU provides a set of
> > registers to enable software to SET, CLEAR, and check the STATUS of each of
> > the bits of this register independently. The use of 32 bits for each interrupt
> > line enables software to provide more information about the source of the
> > interrupt.
> >
> "32 bits for each interrupt line"  =>  32 virtual channels or 32bit
> data over one physical channel. And that is how the driver is
> currently written.
>

Yes, I understand.

> > For example, each bit of the register can be associated with a type
> > of event that can contribute to raising the interrupt.
> >
> Sure there can be a usecase where each bit is associated with an event
> (virtual channel). As you said, this is just one example of how MHU
> can be used. There are other ways MHU is used already.
>

Agreed and I am not saying that's incorrect or asking to remove
support for that. Future versions of MHU are making it more complex
and the specification classify the 3 modes of transport protocol in which
the new controller can be configured and used.

The choice is left to platform based on use case to get best/optimal
results. That's the reason I am trying to convince you that we need to
support all those configurations/transport protocols in the Linux
mailbox controller driver. As you mention one use-case of MHU, the word
transfer with 2^32 - 1 options is optimal for IoT use-case where as
doorbell mode is optimal for heavy payloads. The newer versions of
MHU are designed keeping both configurations in mind and the same is
suggested by h/w teams to
various vendors.


Arnd has similar suggestions(something like patch 1) to deal with such
configurations/transport protocols. Please note I am referring to
different transport protocols and not message protocols(SCPI/SCMI fall
under this category)

> Patch-2/6 looks good though. I will pick that up.
>

Thanks.

--
Regards,
Sudeep
