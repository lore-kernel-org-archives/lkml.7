Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F83C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 12:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7C1206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 12:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfLaMWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 07:22:52 -0500
Received: from foss.arm.com ([217.140.110.172]:34100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfLaMWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 07:22:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81DB0328;
        Tue, 31 Dec 2019 04:22:51 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ED693F703;
        Tue, 31 Dec 2019 04:22:50 -0800 (PST)
Date:   Tue, 31 Dec 2019 12:22:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20191231122245.GA35523@bogus>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <AM0PR04MB44817F7C0FB0E6D417823B4A88260@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB44817F7C0FB0E6D417823B4A88260@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 02:50:40AM +0000, Peng Fan wrote:
>
> > Subject: [PATCH] firmware: arm_scmi: Make scmi core independent of
> > transport type
> >
> > The SCMI specification is fairly independent of the transport protocol, which
> > can be a simple mailbox (already implemented) or anything else.
> > The current Linux implementation however is very much dependent of the
> > mailbox transport layer.
> >
> > This patch makes the SCMI core code (driver.c) independent of the mailbox
> > transport layer and moves all mailbox related code to a new
> > file: mailbox.c.
> >
> > We can now implement more transport protocols to transport SCMI
> > messages.
> >
> > The transport protocols just need to provide struct scmi_transport_ops, with
> > its version of the callbacks to enable exchange of SCMI messages.
>
> Will there be v2? will this be used to replace smc mailbox?
>

There's a requirement for virtio based transport too. I need to do
a thorough review once I am able to gather the details. Feel free to
add SMC based transport based on this patch if you can, you need not
wait for me. I am fine with the approach as such.

Also I was waiting to get some feedback from Arnd or Jassi.

--
Regards,
Sudeep
