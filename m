Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9C0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791CE206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfG2Ke3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:34:29 -0400
Received: from foss.arm.com ([217.140.110.172]:41626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbfG2Ke3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:34:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25567344;
        Mon, 29 Jul 2019 03:34:28 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D8923F694;
        Mon, 29 Jul 2019 03:34:26 -0700 (PDT)
Date:   Mon, 29 Jul 2019 11:34:24 +0100
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
Subject: Re: [PATCH 5/5] reset: Add support for resets provided by SCMI
Message-ID: <20190729103424.GB831@e107155-lin>
References: <20190726135954.11078-1-sudeep.holla@arm.com>
 <20190726135954.11078-6-sudeep.holla@arm.com>
 <1564394355.7633.5.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564394355.7633.5.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:59:15AM +0200, Philipp Zabel wrote:
> Hi Sudeep,
>
> On Fri, 2019-07-26 at 14:59 +0100, Sudeep Holla wrote:
> > On some ARM based systems, a separate Cortex-M based System Control
> > Processor(SCP) provides the overall power, clock, reset and system
> > control. System Control and Management Interface(SCMI) Message Protocol
> > is defined for the communication between the Application Cores(AP)
> > and the SCP.
> >
> > Adds support for the resets provided using SCMI protocol for performing
> > reset management of various devices present on the SoC. Various reset
> > functionalities are achieved by the means of different ARM SCMI device
> > operations provided by the ARM SCMI framework.
> >
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> thank you for the patch. I have a few suggestions below.
>

Thanks for reviewing so quickly, all points taken and fixed locally.
Will wait for some more time before posting v2.

[...]

> > +static int
> > +scmi_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> > +{
> > +	struct scmi_reset_data *data = to_scmi_reset_data(rcdev);
> > +	const struct scmi_handle *handle = data->handle;
>
> This could be shortened to to_scmi_handle(rcdev), since none of the
> other fields in scmi_reset_data are used by the reset_control_ops
> callbacks.
>

Makes sense, missed to see that.

[...]

> > +
> > +static int scmi_reset_probe(struct scmi_device *sdev)
> > +{
> > +	struct scmi_reset_data *data;
> > +	struct device *dev = &sdev->dev;
> > +	struct device_node *np = dev->of_node;
> > +	const struct scmi_handle *handle = sdev->handle;
> > +
> > +	if (!handle || !handle->reset_ops)
> > +		return -ENODEV;
> > +
> > +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	data->rcdev.ops = &scmi_reset_ops;
> > +	data->rcdev.owner = THIS_MODULE;
> > +	data->rcdev.of_node = np;
>
> This is missing rcdev.nr_resets. When nr_resets is kept at zero, the
> check in of_reset_simple_xlate will fail for any id.
>

I clearly missed to do git add for the above :(. I did find these
after testing.

> > +	data->dev = dev;
> > +
> > +	return devm_reset_controller_register(dev, &data->rcdev);
> > +}
> > +
> > +static const struct scmi_device_id scmi_id_table[] = {
> > +	{ SCMI_PROTOCOL_RESET },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> > +
> > +static struct scmi_driver scmi_reset_driver = {
> > +	.name = "scmi-reset",
> > +	.probe = scmi_reset_probe,
> > +	.id_table = scmi_id_table,
> > +};
> > +module_scmi_driver(scmi_reset_driver);
> > +
> > +MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
> > +MODULE_DESCRIPTION("ARM SCMI clock driver");
>
> s/clock/reset controller/
>

Stupid copy-paste :(

Thanks again.

--
Regards,
Sudeep
