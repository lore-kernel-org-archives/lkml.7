Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEDDC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA7E2086D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfHGKfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:35:54 -0400
Received: from foss.arm.com ([217.140.110.172]:46188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfHGKfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:35:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5050B1570;
        Wed,  7 Aug 2019 03:35:53 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AC853F575;
        Wed,  7 Aug 2019 03:35:51 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:35:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        aidapala@qti.qualcomm.com, pajay@qti.qualcomm.com,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        wesleys@xilinx.com, Felix Burton <fburton@xilinx.com>,
        Saeed Nowshadi <saeed.nowshadi@xilinx.com>
Subject: Re: [PATCH v2 4/5] firmware: arm_scmi: Add RESET protocol in SCMI
 v2.0
Message-ID: <20190807103549.GI16546@e107155-lin>
References: <20190806170208.6787-1-sudeep.holla@arm.com>
 <20190806170208.6787-5-sudeep.holla@arm.com>
 <1565165870.5048.4.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565165870.5048.4.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 10:17:50AM +0200, Philipp Zabel wrote:
> On Tue, 2019-08-06 at 18:02 +0100, Sudeep Holla wrote:
> > SCMIv2.0 adds a new Reset Management Protocol to manage various reset
> > states a given device or domain can enter. Device(s) that can be
> > collectively reset through a common reset signal constitute a reset
> > domain for the firmware.
> > 
> > A reset domain can be reset autonomously or explicitly through assertion
> > and de-assertion of the signal. When autonomous reset is chosen, the
> > firmware is responsible for taking the necessary steps to reset the
> > domain and to subsequently bring it out of reset. When explicit reset is
> > chosen, the caller has to specifically assert and then de-assert the
> > reset signal by issuing two separate RESET commands.
> > 
> > Add the basic SCMI reset infrastructure that can be used by Linux
> > reset controller driver.
> > 
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/Makefile |   2 +-
> >  drivers/firmware/arm_scmi/reset.c  | 231 +++++++++++++++++++++++++++++
> >  include/linux/scmi_protocol.h      |  26 ++++
> >  3 files changed, 258 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/firmware/arm_scmi/reset.c
> > 
> > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> > index c47d28d556b6..5f298f00a82e 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile
> > @@ -2,5 +2,5 @@
> >  obj-y	= scmi-bus.o scmi-driver.o scmi-protocols.o
> >  scmi-bus-y = bus.o
> >  scmi-driver-y = driver.o
> > -scmi-protocols-y = base.o clock.o perf.o power.o sensors.o
> > +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o
> >  obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
> > diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
> > new file mode 100644
> > index 000000000000..11cb8b5ccf34
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/reset.c
> > @@ -0,0 +1,231 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * System Control and Management Interface (SCMI) Reset Protocol
> > + *
> > + * Copyright (C) 2019 ARM Ltd.
> > + */
> > +
> > +#include "common.h"
> > +
> > +enum scmi_reset_protocol_cmd {
> > +	RESET_DOMAIN_ATTRIBUTES = 0x3,
> > +	RESET = 0x4,
> > +	RESET_NOTIFY = 0x5,
> > +};
> > +
> > +enum scmi_reset_protocol_notify {
> > +	RESET_ISSUED = 0x0,
> > +};
> > +
> > +#define NUM_RESET_DOMAIN_MASK	0xffff
> > +#define RESET_NOTIFY_ENABLE	BIT(0)
> > +
> > +struct scmi_msg_resp_reset_domain_attributes {
> > +	__le32 attributes;
> > +#define SUPPORTS_ASYNC_RESET(x)		((x) & BIT(31))
> > +#define SUPPORTS_NOTIFY_RESET(x)	((x) & BIT(30))
> > +	__le32 latency;
> > +	    u8 name[SCMI_MAX_STR_SIZE];
> > +};
> > +
> > +struct scmi_msg_reset_domain_reset {
> > +	__le32 domain_id;
> > +	__le32 flags;
> > +#define AUTONOMOUS_RESET	BIT(0)
> > +#define EXPLICIT_RESET_ASSERT	BIT(1)
> > +#define ASYNCHRONOUS_RESET	BIT(2)
> > +	__le32 reset_state;
> > +#define ARCH_RESET_TYPE		BIT(31)
> > +#define COLD_RESET_STATE	BIT(0)
> > +#define ARCH_COLD_RESET		(ARCH_RESET_TYPE | COLD_RESET_STATE)
> > +};
> > +
> > +struct reset_dom_info {
> > +	bool async_reset;
> > +	bool reset_notify;
> > +	u32 latency_us;
> > +	char name[SCMI_MAX_STR_SIZE];
> > +};
> > +
> > +struct scmi_reset_info {
> > +	int num_domains;
> > +	struct reset_dom_info *dom_info;
> > +};
> > +
> > +static int scmi_reset_attributes_get(const struct scmi_handle *handle,
> > +				     struct scmi_reset_info *pi)
> > +{
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	u32 *attr;
> > +
> > +	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
> > +				 SCMI_PROTOCOL_RESET, 0, sizeof(*attr), &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	attr = t->rx.buf;
> > +
> > +	ret = scmi_do_xfer(handle, t);
> > +	if (!ret)
> > +		pi->num_domains = le32_to_cpu(*attr) & NUM_RESET_DOMAIN_MASK;
> > +
> > +	scmi_xfer_put(handle, t);
> > +	return ret;
> > +}
> > +
> > +static int
> > +scmi_reset_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
> > +				 struct reset_dom_info *dom_info)
> > +{
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_resp_reset_domain_attributes *attr;
> > +
> > +	ret = scmi_xfer_get_init(handle, RESET_DOMAIN_ATTRIBUTES,
> > +				 SCMI_PROTOCOL_RESET, sizeof(domain),
> > +				 sizeof(*attr), &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
> 
> Should this use
> 	put_unaligned_le32(domain, t->tx.buf);
> ? Either way,
> 

Ah, new function to me. I will take a look, may need more place to fix.

> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>

Thanks,
Sudeep
