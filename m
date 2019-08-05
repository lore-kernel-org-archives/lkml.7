Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC96DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3E7206C1
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfHEMwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:52:53 -0400
Received: from foss.arm.com ([217.140.110.172]:47884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfHEMwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:52:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B39D337;
        Mon,  5 Aug 2019 05:52:52 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3BA3F706;
        Mon,  5 Aug 2019 05:52:51 -0700 (PDT)
Date:   Mon, 5 Aug 2019 13:52:45 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>
Subject: Re: [PATCH v2 6/6] firmware: arm_scmi: Check if platform has
 released shmem before using
Message-ID: <20190805125245.GA627@e107155-lin>
References: <20190726134531.8928-1-sudeep.holla@arm.com>
 <20190726134531.8928-7-sudeep.holla@arm.com>
 <CAN5uoS_TA5ELTLtHnUbWhaOHyUDjoKZz0S8SfmXBfR+n-=_M3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS_TA5ELTLtHnUbWhaOHyUDjoKZz0S8SfmXBfR+n-=_M3w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 02:33:53PM +0200, Etienne Carriere wrote:
> Hello Sudeep,
>
> On Fri, 26 Jul 2019 at 15:46, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Sometimes platfom may take too long to respond to the command and OS
> > might timeout before platform transfer the ownership of the shared
> > memory region to the OS with the response.
> >
> > Since the mailbox channel associated with the channel is freed and new
> > commands are dispatch on the same channel, OS needs to wait until it
> > gets back the ownership. If not, either OS may end up overwriting the
> > platform response for the last command(which is fine as OS timed out
> > that command) or platform might overwrite the payload for the next
> > command with the response for the old.
> >
> > The latter is problematic as platform may end up interpretting the
> > response as the payload. In order to avoid such race, let's wait until
> > the OS gets back the ownership before we prepare the shared memory with
> > the payload for the next command.
> >
> > Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/driver.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 69bf85fea967..765573756987 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -265,6 +265,14 @@ static void scmi_tx_prepare(struct mbox_client *cl, void *m)
> >         struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
> >         struct scmi_shared_mem __iomem *mem = cinfo->payload;
> >
> > +       /*
> > +        * Ideally channel must be free by now unless OS timeout last
> > +        * request and platform continued to process the same, wait
> > +        * until it releases the shared memory, otherwise we may endup
> > +        * overwriting it's response with new command payload or vice-versa
>
> minor typo: s/it's/its/
> maybe also s/command/message/
>

Thanks for taking a look at this, both are fixed locally now.

--
Regards,
Sudeep
