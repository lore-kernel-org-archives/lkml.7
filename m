Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F98C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00B721655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfLLMPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:15:37 -0500
Received: from foss.arm.com ([217.140.110.172]:44682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfLLMPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:15:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B26B11FB;
        Thu, 12 Dec 2019 04:15:36 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B74C3F718;
        Thu, 12 Dec 2019 04:15:35 -0800 (PST)
Date:   Thu, 12 Dec 2019 12:15:31 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 08/15] firmware: arm_scmi: Add and initialise protocol
 version to scmi_device structure
Message-ID: <20191212121531.GA27215@bogus>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-9-sudeep.holla@arm.com>
 <b79fe89b-5779-f70b-cfb8-4b20f622e9ef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b79fe89b-5779-f70b-cfb8-4b20f622e9ef@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:06:50PM +0000, Cristian Marussi wrote:
> On 10/12/2019 14:53, Sudeep Holla wrote:
> > It's useful to keep track of scmi protocol version in the scmi device
> > structure along with the protocol id. These can be used to expose the
> > information to the userspace via bus dev_groups attributes as well.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/clock.c   | 6 +++++-
> >  drivers/firmware/arm_scmi/perf.c    | 6 +++++-
> >  drivers/firmware/arm_scmi/power.c   | 6 +++++-
> >  drivers/firmware/arm_scmi/reset.c   | 6 +++++-
> >  drivers/firmware/arm_scmi/sensors.c | 6 +++++-
> >  include/linux/scmi_protocol.h       | 1 +
> >  6 files changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> > index b567ec03f711..b68736ae7f88 100644
> > --- a/drivers/firmware/arm_scmi/clock.c
> > +++ b/drivers/firmware/arm_scmi/clock.c
> > @@ -318,8 +318,11 @@ static int scmi_clock_protocol_init(struct scmi_device *dev)
> >  	struct clock_info *cinfo;
> >  	struct scmi_handle *handle = dev->handle;
> >
> > -	if (handle->clk_ops && handle->clk_priv)
> > +	if (handle->clk_ops && handle->clk_priv) {
> > +		cinfo = handle->clk_priv;
> > +		dev->version = cinfo->version;
> >  		return 0; /* initialised already for the first device */
> > +	}
> >
>
> This is the device specific init stuff which I would remove from this proto
> initialization, which is the reason for this proto_init to be invoked for
> all devices defined for such proto.
>

Agreed, this is something I could come up with quickly, I have to think about
this more for sure.

> I'd say to move dev->version initialization into the specific
> scmi_drv->probe which is called after scmi_protocol_init inside
> bus:scmi_dev_probe, after having disabled the proto_init after the first
> invocation, once the protocol is initialized, BUT this would result anyway
> in duplication since you'll have to fill dev->version from the custom
> protocol info in each of the related scmi drivers, and that would also mean
> delegating to a possible user scmi driver .probe an initialization which is
> then needed by the sysfs attribute exposed by the SCMI framework code.
>
I am trying to avoid that as it's just version and we should be able to
manage this in the scmi_bus layer. I agree what we have in these patches
are not so pretty.

Anyways, thanks a lot for all the review.

--
Regards,
Sudeep
