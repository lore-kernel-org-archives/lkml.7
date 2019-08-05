Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C5BC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C6620657
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfHEN2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:28:40 -0400
Received: from foss.arm.com ([217.140.110.172]:49066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730723AbfHEN2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:28:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 602A1337;
        Mon,  5 Aug 2019 06:28:37 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 279043F706;
        Mon,  5 Aug 2019 06:28:35 -0700 (PDT)
Date:   Mon, 5 Aug 2019 14:28:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        aidapala@qti.qualcomm.com, pajay@qti.qualcomm.com,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        wesleys@xilinx.com, Felix Burton <fburton@xilinx.com>,
        Saeed Nowshadi <saeed.nowshadi@xilinx.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Quentin Perret <Quentin.Perret@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/5] firmware: arm_scmi: Make use SCMI v2.0 fastchannel
 for performance protocol
Message-ID: <20190805132833.GC627@e107155-lin>
References: <20190726135954.11078-1-sudeep.holla@arm.com>
 <20190726135954.11078-3-sudeep.holla@arm.com>
 <CAN5uoS-dgtz55O+AAxEFkgtijpHj_-NSy7SkNRAkhEJN5v4PWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS-dgtz55O+AAxEFkgtijpHj_-NSy7SkNRAkhEJN5v4PWA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 03:16:41PM +0200, Etienne Carriere wrote:
> On Fri, 26 Jul 2019 at 16:00, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > SCMI v2.0 adds support for "FastChannel" which do not use a message
> > header as they are specialized for a single message.
> >
> > Only PERFORMANCE_LIMITS_{SET,GET} and PERFORMANCE_LEVEL_{SET,GET}
> > commands are supported over fastchannels. As they are optional, they
> > need to be discovered by PERFORMANCE_DESCRIBE_FASTCHANNEL command.
> > Further {LIMIT,LEVEL}_SET commands can have optional doorbell support.
> >
> > Add support for making use of these fastchannels.
> >
> > Cc: Ionela Voinescu <Ionela.Voinescu@arm.com>
> > Cc: Chris Redpath <Chris.Redpath@arm.com>
> > Cc: Quentin Perret <Quentin.Perret@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/perf.c | 104 +++++++++++++++++++++++++++++--
> >  1 file changed, 100 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> > index 6cce3e82e81e..b9144efbd6fb 100644
> > --- a/drivers/firmware/arm_scmi/perf.c
> > +++ b/drivers/firmware/arm_scmi/perf.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/bits.h>
> >  #include <linux/of.h>
> >  #include <linux/io.h>
> > +#include <linux/io-64-nonatomic-hi-lo.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_opp.h>
> >  #include <linux/sort.h>
> > @@ -293,7 +294,42 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
> >         return ret;
> >  }
> >
> > -static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
> > +#define SCMI_PERF_FC_RING_DB(doorbell, w)              \
>
> Suggest to reformat into a macro style:
>     #define SCMI_PERF_FC_RING_DB(doorbell, w)              \
>         do { \
>                 (...) \
>         } while (0)
>

Sure I can try that.

> > +{                                                      \
> > +       u##w val = 0;                                   \
> > +       struct scmi_fc_db_info *db = doorbell;          \
> > +                                                       \
> > +       if ((db)->mask)                                 \
>
> remove parentheses. I would say, could simply remove `if (db->mask)` here.

Ah, missed to drop this one. We can avoid reading the value if mask = 0,
so I prefer to keep it.
>
> > +               val = ioread##w(db->addr) & db->mask;   \
> > +       iowrite##w((u##w)db->set | val, db->addr);      \
> > +}
> > +
> > +static void scmi_perf_fc_ring_db(struct scmi_fc_db_info *db)
> > +{
> > +       if (!db || !db->addr)
> > +               return;
> > +
> > +       if (db->width == 1)
> > +               SCMI_PERF_FC_RING_DB(db, 8)
> > +       else if (db->width == 2)
> > +               SCMI_PERF_FC_RING_DB(db, 16)
> > +       else if (db->width == 4)
> > +               SCMI_PERF_FC_RING_DB(db, 32)
> > +       else /* db->width == 8 */
> > +#ifdef CONFIG_64BIT
> > +               SCMI_PERF_FC_RING_DB(db, 64)
> > +#else
> > +       {
> > +               u64 val = 0;
> > +
> > +               if (db->mask)
> > +                       val = ioread64_hi_lo(db->addr) & db->mask;
> > +               iowrite64_hi_lo(db->set, db->addr);
>
> Is `value` missing here?
> Why not using SCMI_PERF_FC_RING_DB(db, 64) here?
>

I am still using it. Just if CONFIG_64BIT is enabled and  io{read,write}64
are defined. ARM32/MIPS and other 32-bit platform build might fail
otherwise. I don't want to restrict SCMI to 64-bit platforms only.

--
Regards,
Sudeep
