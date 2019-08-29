Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F23C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB492339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfH2PhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:37:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2PhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:37:17 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CC30F283C49;
        Thu, 29 Aug 2019 16:37:13 +0100 (BST)
Date:   Thu, 29 Aug 2019 17:37:09 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH 1/4] i3c: master: detach and free device if
 pre_assign_dyn_addr() fails
Message-ID: <20190829173709.79c093dd@collabora.com>
In-Reply-To: <SN6PR12MB2655E9E544D7E96323BAC796AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
        <e26948eaaf765f683d8fe0618a31a98e2ecc0e65.1567071213.git.vitor.soares@synopsys.com>
        <20190829124115.482cd8ec@collabora.com>
        <SN6PR12MB26551F172804D039F3EAA991AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
        <20190829163520.126d42d6@collabora.com>
        <SN6PR12MB2655E9E544D7E96323BAC796AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 15:23:30 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> From: Boris Brezillon <boris.brezillon@collabora.com>
> Date: Thu, Aug 29, 2019 at 15:35:20
> 
> > On Thu, 29 Aug 2019 13:53:24 +0000
> > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> >   
> > > Hi Boris,
> > > 
> > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > Date: Thu, Aug 29, 2019 at 11:41:15
> > >   
> > > > +Przemek
> > > > 
> > > > Please try to Cc active I3C contributors so they get a chance to
> > > > comment on your patches.    
> > > 
> > > I can do that next time.
> > >   
> > > > 
> > > > On Thu, 29 Aug 2019 12:19:32 +0200
> > > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > > >     
> > > > > On pre_assing_dyn_addr() the devices that fail:
> > > > >   i3c_master_setdasa_locked()
> > > > >   i3c_master_reattach_i3c_dev()
> > > > >   i3c_master_retrieve_dev_info()
> > > > > 
> > > > > are kept in memory and master->bus.devs list. This makes the i3c devices
> > > > > without a dynamic address are sent on DEFSLVS CCC command. Fix this by
> > > > > detaching and freeing the devices that fail on pre_assign_dyn_addr().    
> > > > 
> > > > I don't think removing those entries is a good strategy, as one might
> > > > want to try to use a different dynamic address if the requested one
> > > > is not available.    
> > > 
> > > Do you mean same 'assigned-address' attribute in DT?  
> > 
> > Yes, or say it's another device that got the address we want and this
> > device doesn't want to release the address (I'm assuming the !SA case).
> >   
> > > 
> > > If so, it is checked here:
> > > 
> > > static int i3c_master_bus_init(struct i3c_master_controller *master)
> > > ...
> > > 	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
> > > 		struct i3c_device_info info = {
> > > 			.static_addr = i3cboardinfo->static_addr,
> > > 		};
> > > 
> > > 		if (i3cboardinfo->init_dyn_addr) {
> > > 			status = i3c_bus_get_addr_slot_status(&master->bus,
> > > 			^
> > > 						i3cboardinfo->init_dyn_addr);
> > > 			if (status != I3C_ADDR_SLOT_FREE) {
> > > 				ret = -EBUSY;
> > > 				goto err_detach_devs;
> > > 			}
> > > 		}
> > > 
> > > 		i3cdev = i3c_master_alloc_i3c_dev(master, &info);
> > > 		if (IS_ERR(i3cdev)) {
> > > 			ret = PTR_ERR(i3cdev);
> > > 			goto err_detach_devs;
> > > 		}
> > > 
> > > 		i3cdev->boardinfo = i3cboardinfo;
> > > 
> > > 		ret = i3c_master_attach_i3c_dev(master, i3cdev);
> > > 		if (ret) {
> > > 			i3c_master_free_i3c_dev(i3cdev);
> > > 			goto err_detach_devs;
> > > 		}
> > > 	}
> > > ...
> > > 
> > > and later if it fails i3c_master_pre_assign_dyn_addr(), the device can 
> > > participate in Enter Dynamic Address Assignment process.
> > > I may need to check the boardinfo->init_dyn_addr status on 
> > > i3c_master_add_i3c_dev_locked before i3c_master_setnewda_locked().  
> > 
> > I need to double check but I thought we were already handling that case
> > properly.  
> 
> Yes, it is handled in the code above.

No, I meant the 'assign init_dyn_addr even if !SA', and the code I
pointed in my other reply tends to confirm that this is something we
already take into account (maybe not correctly, but the code is here).

> 
> >   
> > >   
> > > > Why not simply skipping entries that have ->dyn_addr
> > > > set to 0 when preparing a DEFSLVS frame    
> > > 
> > > I considered that solution too but if the device isn't enumerated why 
> > > should it be attached and kept in memory?  
> > 
> > Might be a device that supports HJ, and in that case we might want the
> > controller to reserve a slot in its device table for that device.
> > Anyway, it doesn't hurt to have it around as long as we don't pass the
> > device through DEFSLVS if it doesn't have a dynamic address. I really
> > prefer to keep the logic unchanged and fix it if it needs to be fixed.  
> 
> Well, we aren't reserving a slot because we need another one to attach 
> the device when it is enumerated and hence a device may be using 2 slots 
> in the controller.

Right, you shouldn't reserve a slot when ->static_address == 0 &&
->dynamic_address == 0, but I still don't see where the problem is with
the solution we have right now, sorry. Note that even if you reserve a
slot in that case, the device only occupies 2 slots for a short amount
of time, because the add_i3c_dev() logic will detect that the descriptor
already exists and reattach the device with its new address.

> It may cause problems in HC with reduced slots and it is another reason 
> why I think we should detach device without dynamic address after the 
> enumeration phase.

Can you please try the approach I suggest? => fix the existing logic to
make it work without this "free undiscovered dev desc, reallocate later"
dance.
