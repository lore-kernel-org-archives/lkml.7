Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC716C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BFC206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLISNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:13:21 -0500
Received: from foss.arm.com ([217.140.110.172]:40760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfLISNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:13:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A90081045;
        Mon,  9 Dec 2019 10:13:20 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC9453F6CF;
        Mon,  9 Dec 2019 10:13:19 -0800 (PST)
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <71417ba8-b844-ac96-bcad-4bf48fa8b869@arm.com>
Date:   Mon, 9 Dec 2019 18:13:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

a one minor nit, and one question about scmi_desc usage in this new transport
independent driver.

On 29/11/2019 09:31, Viresh Kumar wrote:
> The SCMI specification is fairly independent of the transport protocol,
> which can be a simple mailbox (already implemented) or anything else.
> The current Linux implementation however is very much dependent of the
> mailbox transport layer.
> 
> This patch makes the SCMI core code (driver.c) independent of the
> mailbox transport layer and moves all mailbox related code to a new
> file: mailbox.c.
> 
> We can now implement more transport protocols to transport SCMI
> messages.
> 
> The transport protocols just need to provide struct scmi_transport_ops,
> with its version of the callbacks to enable exchange of SCMI messages.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/firmware/arm_scmi/Makefile  |   3 +-
>  drivers/firmware/arm_scmi/common.h  |  39 ++++++++
>  drivers/firmware/arm_scmi/driver.c  | 143 ++++++++++-----------------
>  drivers/firmware/arm_scmi/mailbox.c | 146 ++++++++++++++++++++++++++++
>  4 files changed, 236 insertions(+), 95 deletions(-)
>  create mode 100644 drivers/firmware/arm_scmi/mailbox.c
> 

[snip]

>  /**
>   * struct scmi_info - Structure representing a SCMI instance
>   *
> @@ -128,6 +109,7 @@ struct scmi_chan_info {
>  struct scmi_info {
>  	struct device *dev;
>  	const struct scmi_desc *desc;
> +	struct scmi_transport_ops *transport_ops;
>  	struct scmi_revision_info version;
>  	struct scmi_handle handle;
>  	struct scmi_xfers_info tx_minfo;
> @@ -138,7 +120,6 @@ struct scmi_info {
>  	int users;
>  };
>  

Could we add also the related @transport_ops in the above comment block ?

> -#define client_to_scmi_chan_info(c) container_of(c, struct scmi_chan_info, cl)
>  #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
>  
>  /*

[snip]

> +
>  static int scmi_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -833,12 +800,6 @@ static int scmi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *child, *np = dev->of_node;
>  
> -	/* Only mailbox method supported, check for the presence of one */
> -	if (scmi_mailbox_check(np, 0)) {
> -		dev_err(dev, "no mailbox found in %pOF\n", np);
> -		return -EINVAL;
> -	}
> -
>  	desc = of_device_get_match_data(dev);
>  	if (!desc)
>  		return -EINVAL;

This scmi_desc struct descriptor is retrieved from  of_match_table .data and points to
the driver-provided scmi_generic_desc

static const struct scmi_desc scmi_generic_desc = {
        .max_rx_timeout_ms = 30,        /* We may increase this if required */
        .max_msg = 20,          /* Limited by MBOX_TX_QUEUE_LEN */
        .max_msg_size = 128,
};

Is not this kind of information possibly (maybe partially) related to the selected
transport, and as such it should be also provided dynamically by the chosen transport
layer at probe time, like the transport_ops, instead of being hard-coded in
this driver ?

Thanks

Cristian


