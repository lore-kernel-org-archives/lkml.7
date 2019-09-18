Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385D3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1352B21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfIRV1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 17:27:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48690 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfIRV1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 17:27:05 -0400
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id e472a91455a20de2; Wed, 18 Sep 2019 23:27:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mario.Limonciello@dell.com
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryan.Hong@dell.com, Crag.Wang@dell.com, sjg@google.com,
        Jared.Dominguez@dell.com
Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into deepest state
Date:   Wed, 18 Sep 2019 23:27:01 +0200
Message-ID: <5633857.hqcsiBO4aL@kreacher>
In-Reply-To: <706f61c67b354f3d8f841a82e3d48541@AUSX13MPC105.AMER.DELL.COM>
References: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com> <10773060.Xg13aEV830@kreacher> <706f61c67b354f3d8f841a82e3d48541@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 18, 2019 6:52:31 PM CEST Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Sent: Tuesday, September 17, 2019 4:36 PM
> > To: Keith Busch
> > Cc: Limonciello, Mario; Jens Axboe; Christoph Hellwig; Sagi Grimberg; linux-
> > nvme@lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg@google.com;
> > Dominguez, Jared
> > Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into deepest
> > state
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Tuesday, September 17, 2019 11:24:14 PM CEST Keith Busch wrote:
> > > On Wed, Sep 11, 2019 at 06:42:33PM -0500, Mario Limonciello wrote:
> > > > The action of saving the PCI state will cause numerous PCI configuration
> > > > space reads which depending upon the vendor implementation may cause
> > > > the drive to exit the deepest NVMe state.
> > > >
> > > > In these cases ASPM will typically resolve the PCIe link state and APST
> > > > may resolve the NVMe power state.  However it has also been observed
> > > > that this register access after quiesced will cause PC10 failure
> > > > on some device combinations.
> > > >
> > > > To resolve this, move the PCI state saving to before SetFeatures has been
> > > > called.  This has been proven to resolve the issue across a 5000 sample
> > > > test on previously failing disk/system combinations.
> > > >
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > > ---
> > > >  drivers/nvme/host/pci.c | 13 +++++++------
> > > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > index 732d5b6..9b3fed4 100644
> > > > --- a/drivers/nvme/host/pci.c
> > > > +++ b/drivers/nvme/host/pci.c
> > > > @@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
> > > >  	if (ret < 0)
> > > >  		goto unfreeze;
> > > >
> > > > +	/*
> > > > +	 * A saved state prevents pci pm from generically controlling the
> > > > +	 * device's power. If we're using protocol specific settings, we don't
> > > > +	 * want pci interfering.
> > > > +	 */
> > > > +	pci_save_state(pdev);
> > > > +
> > > >  	ret = nvme_set_power_state(ctrl, ctrl->npss);
> > > >  	if (ret < 0)
> > > >  		goto unfreeze;
> > > > @@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
> > > >  		ret = 0;
> > > >  		goto unfreeze;
> > > >  	}
> > > > -	/*
> > > > -	 * A saved state prevents pci pm from generically controlling the
> > > > -	 * device's power. If we're using protocol specific settings, we don't
> > > > -	 * want pci interfering.
> > > > -	 */
> > > > -	pci_save_state(pdev);
> > > >  unfreeze:
> > > >  	nvme_unfreeze(ctrl);
> > > >  	return ret;
> > >
> > > In the event that something else fails after the point you've saved
> > > the state, we need to fallback to the behavior for when the driver
> > > doesn't save the state, right?
> > 
> > Depending on whether or not an error is going to be returned.
> > 
> > When returning an error, it is not necessary to worry about the saved state,
> > because that will cause the entire system-wide suspend to be aborted.
> 
> It looks like in this case an error would be returned.

Not necessarily.

If nvme_set_power_state() returns a positive number, you need to clear
pdev->state_saved before jumping to unfreeze.

Actually, you can drop the "goto unfreeze" after the "ret = 0" (in the
"if (ret)" block) and add the clearing of pdev->state_saved before it.

Let me reply to the original patch, though.

> 
> > 
> > Otherwise it is sufficient to clear the state_saved flag of the PCI device
> > before returning 0 to make the PCI layer take over.
> 




