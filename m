Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C719AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0B820850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfCYTVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:21:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729473AbfCYTV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:21:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A246B227A5;
        Mon, 25 Mar 2019 19:21:28 +0000 (UTC)
Received: from x1.home (ovpn-116-33.phx2.redhat.com [10.3.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5974060C11;
        Mon, 25 Mar 2019 19:21:28 +0000 (UTC)
Date:   Mon, 25 Mar 2019 13:21:27 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] vfio/mdev: Fix to not do put_device on
 device_register failure
Message-ID: <20190325132127.7430864b@x1.home>
In-Reply-To: <2c096714-74cd-48ff-496f-b3919990e3e5@nvidia.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-2-git-send-email-parav@mellanox.com>
        <2c096714-74cd-48ff-496f-b3919990e3e5@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 25 Mar 2019 19:21:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 23:47:30 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 3/23/2019 4:50 AM, Parav Pandit wrote:
> > device_register() performs put_device() if device_add() fails.
> > This balances with device_initialize().
> > 
> > mdev core performing put_device() when device_register() fails,
> > is an error that puts already released device again.
> > Therefore, don't put the device on error.
> >   
> 
> device_add() on all errors doesn't call put_device(dev). It releases
> reference to its parent, put_device(parent), but not the device itself,
> put_device(dev).

Sort of, device_initialize() initializes the reference count to 1,
device_add() increments the reference count to 2 via the get_device()
and then drops it back to 1 on all exit paths.  The oddity is the
failure path of get_device() itself, but that can only happen if passed
a NULL device, where put_device() is a no-op and not relevant here.  So
in all cases device_register() returns with a reference count of 1 and
we need to call put_device() to free the allocated object.  The below
change would leak the mdev on error.  Thanks,

Alex

> > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > ---
> >  drivers/vfio/mdev/mdev_core.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> > index 0212f0e..3e5880a 100644
> > --- a/drivers/vfio/mdev/mdev_core.c
> > +++ b/drivers/vfio/mdev/mdev_core.c
> > @@ -318,10 +318,8 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
> >  	dev_set_name(&mdev->dev, "%pUl", uuid.b);
> >  
> >  	ret = device_register(&mdev->dev);
> > -	if (ret) {
> > -		put_device(&mdev->dev);
> > +	if (ret)
> >  		goto mdev_fail;
> > -	}
> >  
> >  	ret = mdev_device_create_ops(kobj, mdev);
> >  	if (ret)
> >   

