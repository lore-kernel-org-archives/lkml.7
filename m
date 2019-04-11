Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90061C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6382A2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDKQZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:25:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45860 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfDKQZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:25:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95B0280D;
        Thu, 11 Apr 2019 09:25:54 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18FA33F59C;
        Thu, 11 Apr 2019 09:25:52 -0700 (PDT)
Date:   Thu, 11 Apr 2019 17:25:45 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RESEND][PATCH v2] firmware/psci: add support for SYSTEM_RESET2
Message-ID: <20190411162545.GA5327@e107155-lin>
References: <20190411103346.22462-1-sudeep.holla@arm.com>
 <20190411110302.GA55959@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411110302.GA55959@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:03:04PM +0100, Mark Rutland wrote:
> On Thu, Apr 11, 2019 at 11:33:46AM +0100, Sudeep Holla wrote:
> > PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
> > where the semantics are described by the PSCI specification itself as
> > well as vendor-specific resets. Currently only system warm reset
> > semantics is defined as part of architectural resets by the specification.
> > 
> > This patch implements support for SYSTEM_RESET2 by making using of
> > reboot_mode passed by the reboot infrastructure in the kernel.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/psci.c   | 21 +++++++++++++++++++++
> >  include/uapi/linux/psci.h |  2 ++
> >  2 files changed, 23 insertions(+)
> > 
> > Resending [1] based on the request. I hope to get some testing this time.
> > Last time Xilinx asked multiple times but never got any review or testing
> > https://lore.kernel.org/lkml/1525257003-8608-1-git-send-email-sudeep.holla@arm.com/
> > 
> > diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> > index c80ec1d03274..91748725534e 100644
> > --- a/drivers/firmware/psci.c
> > +++ b/drivers/firmware/psci.c
> > @@ -88,6 +88,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
> >  				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
> > 
> >  static u32 psci_cpu_suspend_feature;
> > +static bool psci_system_reset2_supported;
> > 
> >  static inline bool psci_has_ext_power_state(void)
> >  {
> > @@ -253,6 +254,15 @@ static int get_set_conduit_method(struct device_node *np)
> > 
> >  static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
> >  {
> > +	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> > +	    psci_system_reset2_supported)
> > +		/*
> > +		 * reset_type[31] = 0 (architectural)
> > +		 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
> > +		 * cookie = 0 (ignored by the implementation)
> > +		 */
> > +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), 0, 0, 0);
> 
> Since the comment and invocation span multiple lines, could we please
> wrap them in braces?
>

Yes, that would be better, will update it.

> Other than that, this looks good to me, so:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 

Thanks.

--
Regards,
Sudeep
