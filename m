Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C06C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F11206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLJSqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:46:37 -0500
Received: from foss.arm.com ([217.140.110.172]:53626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfLJSqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:46:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 774761FB;
        Tue, 10 Dec 2019 10:46:36 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7543F6CF;
        Tue, 10 Dec 2019 10:46:35 -0800 (PST)
Date:   Tue, 10 Dec 2019 18:46:33 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20191210184633.GC20962@bogus>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <71417ba8-b844-ac96-bcad-4bf48fa8b869@arm.com>
 <20191210053448.ugjzbp2puzvnm37f@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210053448.ugjzbp2puzvnm37f@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:04:48AM +0530, Viresh Kumar wrote:
> On 09-12-19, 18:13, Cristian Marussi wrote:
> > On 29/11/2019 09:31, Viresh Kumar wrote:

[...]

> > >  	desc = of_device_get_match_data(dev);
> > >  	if (!desc)
> > >  		return -EINVAL;
> >
> > This scmi_desc struct descriptor is retrieved from  of_match_table .data and points to
> > the driver-provided scmi_generic_desc
> >
> > static const struct scmi_desc scmi_generic_desc = {
> >         .max_rx_timeout_ms = 30,        /* We may increase this if required */
> >         .max_msg = 20,          /* Limited by MBOX_TX_QUEUE_LEN */
> >         .max_msg_size = 128,
> > };
> >
> > Is not this kind of information possibly (maybe partially) related to the selected
> > transport, and as such it should be also provided dynamically by the chosen transport
> > layer at probe time, like the transport_ops, instead of being hard-coded in
> > this driver ?
>
> I had my doubts about this thing and I missed checking it out.
>
> @Sudeep: Is this information completely mailbox specific ? Should I move it to
> mailbox.c here ?
>

May be to some/small extent.

1. max_rx_timeout_ms is firmware dependent, maximum time it expects to
   complete a synchronous request or acknowledge async request(worst case value).
2. max_msg_size is maximum size of the buffer we need to allocate, mostly
   based on the specification and we don't have any more that 0x80. But
   the custom/vendor specific protocols may wary and hence I thought of
   keeping it configurable for platforms.
3. max_msg is the maximum number of messages the transport can support.
   This is currently based on the mailbox layer. For SMC/HVC we can have
   upto nr_cpus, something different for spci/optee. We must be able to
   make it transport independent if required.

   This is mainly used to pre-allocate number of (tx/rx) buffers.

--
Regards,
Sudeep
