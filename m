Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917B2C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668542080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570389675;
	bh=KGQpWyuNGlR6/YpNIjIUQyU5X4xp21pku07dVF1CvyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wMRkDMZ+et8JyVpSvRYKaEkspKnCpHXGL7IIMwiGRxNVAsouUNoiJrYT4vCdrl1qY
	 tC9qru8YmMw0pYgmsreqeklfBZePaoWO5oaRqFMtdRRGHfZrSEXNZmXEDtQX8Nedbh
	 fvRAzz9PrhOoYpAt1KBYo5t6L0PNz9GDFHxRbOW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfJFTVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfJFTVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:21:14 -0400
Received: from keith-busch (unknown [8.36.226.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA932077B;
        Sun,  6 Oct 2019 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570389673;
        bh=KGQpWyuNGlR6/YpNIjIUQyU5X4xp21pku07dVF1CvyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbUwgqDTxshiTN1hHNE6IJ45J+AU1NjVJtVG/2gImJwC0qss9n51PPXbI1TvguH6C
         rdzxQJ6w5F1LsH2cwsjBtrF76K6AE//N7Lj8qSM8IXbctVFvy+b/DyQU4VVzsjk8Ft
         Q3ix9/OjqkJZb1Nj7stlJ2uzHLKAgEckfQFoQly4=
Date:   Sun, 6 Oct 2019 13:21:11 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Tyler Ramer <tyaramer@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown when removing dead controller
Message-ID: <20191006192109.GA9983@keith-busch>
References: <20191003191354.GA4481@Serenity>
 <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 11:36:42AM -0400, Tyler Ramer wrote:
> Here's a failure we had which represents the issue the patch is
> intended to solve:
> 
> Aug 26 15:00:56 testhost kernel: nvme nvme4: async event result 00010300
> Aug 26 15:01:27 testhost kernel: nvme nvme4: controller is down; will
> reset: CSTS=0x3, PCI_STATUS=0x10
> Aug 26 15:02:10 testhost kernel: nvme nvme4: Device not ready; aborting reset
> Aug 26 15:02:10 testhost kernel: nvme nvme4: Removing after probe
> failure status: -19
> 
> The CSTS warnings comes from nvme_timeout, and is printed by
> nvme_warn_reset. A reset then occurs
> Controller state should be NVME_CTRL_RESETTING
> 
> Now, in nvme_reset_work, controller is never marked "CONNECTING"  at:
> 
>      if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING))
> 
> because several lines above, we can determine that
> nvme_pci_configure_admin_queues returns
> a bad result, which triggers a goto out_unlock and prints "removing
> after probe failure status: -19"
> 
> Because state is never changed to NVME_CTRL_CONNECTING or
> NVME_CTRL_DELETING, the
> logic added in https://github.com/torvalds/linux/commit/2036f7263d70e67d70a67899a468588cb7356bc9
> should not apply. 

Nor should it, because there are no IO in flight at this point, there
can't be any timeout work to check the state.

> We can further validate that dev->ctrl.state ==
> NVME_CTRL_RESETTING thanks to
> the WARN_ON in nvme_reset_work.

I'm not sure I see what this is fixing. Setting the shutdown to true is
usually just to get the queues flushed, but the nvme_kill_queues() that
we call accomplishes the same thing.
 
> On Thu, Oct 3, 2019 at 3:13 PM Tyler Ramer <tyaramer@gmail.com> wrote:
> >
> > Always shutdown the controller when nvme_remove_dead_controller is
> > reached.
> >
> > It's possible for nvme_remove_dead_controller to be called as part of a
> > failed reset, when there is a bad NVME_CSTS. The controller won't
> > be comming back online, so we should shut it down rather than just
> > disabling.
> >
> > Signed-off-by: Tyler Ramer <tyaramer@gmail.com>
> > ---
> >  drivers/nvme/host/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index c0808f9eb8ab..c3f5ba22c625 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2509,7 +2509,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
> >  static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
> >  {
> >         nvme_get_ctrl(&dev->ctrl);
> > -       nvme_dev_disable(dev, false);
> > +       nvme_dev_disable(dev, true);
> >         nvme_kill_queues(&dev->ctrl);
> >         if (!queue_work(nvme_wq, &dev->remove_work))
> >                 nvme_put_ctrl(&dev->ctrl);
> > --
> > 2.23.0
> >
