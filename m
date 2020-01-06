Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ED7C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280692072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAFLAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:00:17 -0500
Received: from foss.arm.com ([217.140.110.172]:42862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgAFLAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:00:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF869328;
        Mon,  6 Jan 2020 03:00:15 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC7843F534;
        Mon,  6 Jan 2020 03:00:14 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:00:07 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200106110007.GA54466@bogus>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <CABb+yY0qh-qWJWxEaB9_XxmiFb=xP0hOxpm1j54seeT3dMKt2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY0qh-qWJWxEaB9_XxmiFb=xP0hOxpm1j54seeT3dMKt2w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 02:09:27PM -0600, Jassi Brar wrote:
> On Fri, Nov 29, 2019 at 3:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The SCMI specification is fairly independent of the transport protocol,
> > which can be a simple mailbox (already implemented) or anything else.
> > The current Linux implementation however is very much dependent of the
> > mailbox transport layer.
> >
> > This patch makes the SCMI core code (driver.c) independent of the
> > mailbox transport layer and moves all mailbox related code to a new
> > file: mailbox.c.
> >
> > We can now implement more transport protocols to transport SCMI
> > messages.
> >
> > The transport protocols just need to provide struct scmi_transport_ops,
> > with its version of the callbacks to enable exchange of SCMI messages.
> >
> We can either add new transport layer between SCMI and Mailbox layers,
> or we can write new transport as a mailbox driver (which I always
> thought could be a usecase). Right now I am of no strong opinion
> either way.  Depends, what other transport do you have in mind?
>

To be more clear, this patch abstracts the SCMI transport so that mailbox
can be one of the transport. The plan is to add SMC/HVC, SMC/HVC over SPCI,
vitio based transport as alternative to mailbox. These are neither added
as mailbox driver nor transport layer between SCMI and Mailbox. E.g.:
we either use Peng's SMC based mailbox driver as is or add a new transport
independent of mailbox framework here as SCMI transport.

--
Regards,
Sudeep
