Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE1EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8489D24082
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfFDJBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:01:30 -0400
Received: from foss.arm.com ([217.140.101.70]:38348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfFDJB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:01:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BB2315A2;
        Tue,  4 Jun 2019 02:01:29 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [10.37.9.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B45243F246;
        Tue,  4 Jun 2019 02:01:26 -0700 (PDT)
Date:   Tue, 4 Jun 2019 10:01:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/6] mailbox: add support for doorbell/signal mode
 controllers
Message-ID: <20190604090123.GC23250@e107533-lin.cambridge.arm.com>
References: <20190531143320.8895-1-sudeep.holla@arm.com>
 <20190531143320.8895-2-sudeep.holla@arm.com>
 <CABb+yY2ON+etV_g+zBQUrV9x2_0QubUeEPuxs=EKw_JCt570BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY2ON+etV_g+zBQUrV9x2_0QubUeEPuxs=EKw_JCt570BQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:51:05PM -0500, Jassi Brar wrote:
> On Fri, May 31, 2019 at 9:33 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index 38d9df3fb199..e26a079f8223 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -77,7 +77,10 @@ static void msg_submit(struct mbox_chan *chan)
> >         if (chan->cl->tx_prepare)
> >                 chan->cl->tx_prepare(chan->cl, data);
> >         /* Try to submit a message to the MBOX controller */
> > -       err = chan->mbox->ops->send_data(chan, data);
> > +       if (chan->mbox->ops->send_data)
> > +               err = chan->mbox->ops->send_data(chan, data);
> > +       else
> > +               err = chan->mbox->ops->send_signal(chan);
> >         if (!err) {
> >                 chan->active_req = data;
> >                 chan->msg_count--;
> >
> The  'void *data'  parameter in send_data() is controller specific.
> The doorbell controllers should simply ignore that.
> 
> So signal/doorbell controllers are already supported fine. See
> drivers/mailbox/tegra-hsp.c for example.
>

Agreed, I did have that. But then I thought this API makes it even
clearer to the users that no data is expected. I am fine either way.

--
Regards,
Sudeep
