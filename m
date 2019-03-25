Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E5FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6E120879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfCYTtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfCYTtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:49:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C81CE3082E0E;
        Mon, 25 Mar 2019 19:49:50 +0000 (UTC)
Received: from x1.home (ovpn-116-33.phx2.redhat.com [10.3.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C1CD60CC0;
        Mon, 25 Mar 2019 19:49:50 +0000 (UTC)
Date:   Mon, 25 Mar 2019 13:49:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] vfio/mdev: Drop redundant extern for exported
 symbols
Message-ID: <20190325134950.16876957@x1.home>
In-Reply-To: <658437a2-6ed1-c834-bc40-f1bf6dce920c@nvidia.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-5-git-send-email-parav@mellanox.com>
        <658437a2-6ed1-c834-bc40-f1bf6dce920c@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 25 Mar 2019 19:49:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 00:37:04 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 3/23/2019 4:50 AM, Parav Pandit wrote:
> > There is no need use 'extern' for exported functions.
> > 
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > ---
> >  include/linux/mdev.h | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/mdev.h b/include/linux/mdev.h
> > index b6e048e..0924c48 100644
> > --- a/include/linux/mdev.h
> > +++ b/include/linux/mdev.h
> > @@ -118,21 +118,20 @@ struct mdev_driver {
> >  
> >  #define to_mdev_driver(drv)	container_of(drv, struct mdev_driver, driver)
> >  
> > -extern void *mdev_get_drvdata(struct mdev_device *mdev);
> > -extern void mdev_set_drvdata(struct mdev_device *mdev, void *data);
> > -extern uuid_le mdev_uuid(struct mdev_device *mdev);
> > +void *mdev_get_drvdata(struct mdev_device *mdev);
> > +void mdev_set_drvdata(struct mdev_device *mdev, void *data);
> > +uuid_le mdev_uuid(struct mdev_device *mdev);
> >  
> >  extern struct bus_type mdev_bus_type;
> >  
> > -extern int  mdev_register_device(struct device *dev,
> > -				 const struct mdev_parent_ops *ops);
> > -extern void mdev_unregister_device(struct device *dev);
> > +int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops);
> > +void mdev_unregister_device(struct device *dev);
> >  
> > -extern int  mdev_register_driver(struct mdev_driver *drv, struct module *owner);
> > -extern void mdev_unregister_driver(struct mdev_driver *drv);
> > +int mdev_register_driver(struct mdev_driver *drv, struct module *owner);
> > +void mdev_unregister_driver(struct mdev_driver *drv);
> >  
> > -extern struct device *mdev_parent_dev(struct mdev_device *mdev);
> > -extern struct device *mdev_dev(struct mdev_device *mdev);
> > -extern struct mdev_device *mdev_from_dev(struct device *dev);
> > +struct device *mdev_parent_dev(struct mdev_device *mdev);
> > +struct device *mdev_dev(struct mdev_device *mdev);
> > +struct mdev_device *mdev_from_dev(struct device *dev);
> >  
> >  #endif /* MDEV_H */
> >   
> 
> Adding 'extern' to exported symbols is inline to other exported
> functions from device's core module like device_register(),
> device_unregister(), get_device(), put_device()

Right, I'd be inclined to leave this as a style choice, but...

commit 3fe5dbfef47e992b810cbe82af1df02d8255fb8c
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Thu Jan 3 15:26:16 2019 -0800

    Documentation/process/coding-style.rst: don't use "extern" with function prototypes
    
    `extern' with function prototypes makes lines longer and creates more
    characters on the screen.
    
    Do not bug people with checkpatch.pl warnings for now as fallout can be
    devastating.

So it's a new decision and rather weakly imposed new standard.  Thanks,

Alex
