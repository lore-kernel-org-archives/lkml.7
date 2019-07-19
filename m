Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB43C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D88A21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfGSK0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:26:52 -0400
Received: from foss.arm.com ([217.140.110.172]:41552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSK0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:26:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95B1337;
        Fri, 19 Jul 2019 03:26:50 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F14BC3F59C;
        Fri, 19 Jul 2019 03:26:49 -0700 (PDT)
Date:   Fri, 19 Jul 2019 11:26:36 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: Re: [PATCH 02/11] firmware: arm_scmi: Segregate tx channel handling
 and prepare to add rx
Message-ID: <20190719102636.GA18022@e107155-lin>
References: <20190708154730.16643-1-sudeep.holla@arm.com>
 <20190708154730.16643-3-sudeep.holla@arm.com>
 <CA+-6iNzmkT26cEdpD_C=L0bJ4TOEZwGuakin+GR4brSjSETfRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNzmkT26cEdpD_C=L0bJ4TOEZwGuakin+GR4brSjSETfRA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 05:23:10PM -0400, Jim Quinlan wrote:
> On Mon, Jul 8, 2019 at 11:47 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The transmit(Tx) channels are specified as the first entry and the
> > receive(Rx) channels are the second entry as per the device tree
> > bindings. Since we currently just support Tx, index 0 is hardcoded at
> > all required callsites.
> >
> > In order to prepare for adding Rx support, let's remove those hardcoded
> > index and add boolean parameter to identify Tx/Rx channels when setting
> > them up.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/driver.c | 33 ++++++++++++++++--------------
> >  1 file changed, 18 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 0bd2af0a008f..f7fb6d5bfc64 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -112,7 +112,7 @@ struct scmi_chan_info {
> >   * @version: SCMI revision information containing protocol version,
> >   *     implementation version and (sub-)vendor identification.
> >   * @minfo: Message info
> > - * @tx_idr: IDR object to map protocol id to channel info pointer
> > + * @tx_idr: IDR object to map protocol id to Tx channel info pointer
> >   * @protocols_imp: List of protocols implemented, currently maximum of
> >   *     MAX_PROTOCOLS_IMP elements allocated by the base protocol
> >   * @node: List head
> > @@ -640,22 +640,26 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
> >         return 0;
> >  }
> >
> > -static int scmi_mailbox_check(struct device_node *np)
> > +static int scmi_mailbox_check(struct device_node *np, int idx)
> >  {
> > -       return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, NULL);
> > +       return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells",
> > +                                         idx, NULL);
> >  }
> >
> > -static inline int
> > -scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
> > +static int scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev,
> > +                               int prot_id, bool tx)
> >  {
> > -       int ret;
> > +       int ret, idx;
> >         struct resource res;
> >         resource_size_t size;
> >         struct device_node *shmem, *np = dev->of_node;
> >         struct scmi_chan_info *cinfo;
> >         struct mbox_client *cl;
> >
> > -       if (scmi_mailbox_check(np)) {
> > +       /* Transmit channel is first entry i.e. index 0 */
> > +       idx = tx ? 0 : 1;
> > +
> > +       if (scmi_mailbox_check(np, idx)) {
> >                 cinfo = idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
> >                 goto idr_alloc;
> >         }
> > @@ -669,11 +673,11 @@ scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
> >         cl = &cinfo->cl;
> >         cl->dev = dev;
> >         cl->rx_callback = scmi_rx_callback;
> > -       cl->tx_prepare = scmi_tx_prepare;
> > +       cl->tx_prepare = tx ? scmi_tx_prepare : NULL;
> >         cl->tx_block = false;
> > -       cl->knows_txdone = true;
> > +       cl->knows_txdone = tx;
> >
> > -       shmem = of_parse_phandle(np, "shmem", 0);
> > +       shmem = of_parse_phandle(np, "shmem", idx);
> Hi Sudeep,
> 
> You can't see it in the diff but you have two error messages that use
> "Tx"; should this be changed to "Tx/Rx"?
> 

Thanks for spotting, will fix it.

--
Regards,
Sudeep
