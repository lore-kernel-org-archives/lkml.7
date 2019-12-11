Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BC1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069B122B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbfLKPfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:35:07 -0500
Received: from foss.arm.com ([217.140.110.172]:34436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387538AbfLKP2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:28:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 133C630E;
        Wed, 11 Dec 2019 07:28:04 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 487413F52E;
        Wed, 11 Dec 2019 07:28:03 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:28:01 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 15/15] reset: reset-scmi: Match scmi device by both name
 and protocol id
Message-ID: <20191211152801.GB28474@bogus>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-16-sudeep.holla@arm.com>
 <9d8fd7d89e035c41a3be7d5a5fa2e370b32910f1.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d8fd7d89e035c41a3be7d5a5fa2e370b32910f1.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:51:41AM +0100, Philipp Zabel wrote:
> Hi Sudeep,
>
> On Tue, 2019-12-10 at 14:53 +0000, Sudeep Holla wrote:
> > The scmi bus now has support to match the driver with devices not only
> > based on their protocol id but also based on their device name if one is
> > available. This was added to cater the need to support multiple devices
> > and drivers for the same protocol.
> >
> > Let us add the name "reset" to scmi_device_id table in the driver so
> > that in matches only with device with the same name and protocol id
> > SCMI_PROTOCOL_RESET.
> >
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/reset/reset-scmi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
> > index b46df80ec6c3..8d3a858e3b19 100644
> > --- a/drivers/reset/reset-scmi.c
> > +++ b/drivers/reset/reset-scmi.c
> > @@ -108,7 +108,7 @@ static int scmi_reset_probe(struct scmi_device *sdev)
> >  }
> >
> >  static const struct scmi_device_id scmi_id_table[] = {
> > -	{ SCMI_PROTOCOL_RESET },
> > +	{ SCMI_PROTOCOL_RESET, "reset" },
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> > --
> > 2.17.1
>
> I can't speak to the correctness of this approach, but in case the rest
> of the series passes review, this patch is
>

I understand that and completely depends on the review of the patches
implementing it.

> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> to be merged together with the other patches.
>

Thanks.

--
Regards,
Sudeep
