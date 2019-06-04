Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B1FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3C42064A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFDFsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfFDFs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:48:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E1DC307D914;
        Tue,  4 Jun 2019 05:48:29 +0000 (UTC)
Received: from gondolin (ovpn-116-92.ams2.redhat.com [10.36.116.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE1BA60C67;
        Tue,  4 Jun 2019 05:48:23 +0000 (UTC)
Date:   Tue, 4 Jun 2019 07:48:20 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com, cjia@nvidia.com
Subject: Re: [PATCHv6 3/3] vfio/mdev: Synchronize device create/remove with
 parent removal
Message-ID: <20190604074820.71853cbb.cohuck@redhat.com>
In-Reply-To: <20190603185658.54517-4-parav@mellanox.com>
References: <20190603185658.54517-1-parav@mellanox.com>
        <20190603185658.54517-4-parav@mellanox.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 04 Jun 2019 05:48:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Jun 2019 13:56:58 -0500
Parav Pandit <parav@mellanox.com> wrote:

> In following sequences, child devices created while removing mdev parent
> device can be left out, or it may lead to race of removing half
> initialized child mdev devices.
> 
> issue-1:
> --------
>        cpu-0                         cpu-1
>        -----                         -----
>                                   mdev_unregister_device()
>                                     device_for_each_child()
>                                       mdev_device_remove_cb()
>                                         mdev_device_remove()
> create_store()
>   mdev_device_create()                   [...]
>     device_add()
>                                   parent_remove_sysfs_files()
> 
> /* BUG: device added by cpu-0
>  * whose parent is getting removed
>  * and it won't process this mdev.
>  */
> 
> issue-2:
> --------
> Below crash is observed when user initiated remove is in progress
> and mdev_unregister_driver() completes parent unregistration.
> 
>        cpu-0                         cpu-1
>        -----                         -----
> remove_store()
>    mdev_device_remove()
>    active = false;
>                                   mdev_unregister_device()
>                                   parent device removed.
>    [...]
>    parents->ops->remove()
>  /*
>   * BUG: Accessing invalid parent.
>   */
> 
> This is similar race like create() racing with mdev_unregister_device().
> 
> BUG: unable to handle kernel paging request at ffffffffc0585668
> PGD e8f618067 P4D e8f618067 PUD e8f61a067 PMD 85adca067 PTE 0
> Oops: 0000 [#1] SMP PTI
> CPU: 41 PID: 37403 Comm: bash Kdump: loaded Not tainted 5.1.0-rc6-vdevbus+ #6
> Hardware name: Supermicro SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
> RIP: 0010:mdev_device_remove+0xfa/0x140 [mdev]
> Call Trace:
>  remove_store+0x71/0x90 [mdev]
>  kernfs_fop_write+0x113/0x1a0
>  vfs_write+0xad/0x1b0
>  ksys_write+0x5a/0xe0
>  do_syscall_64+0x5a/0x210
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Therefore, mdev core is improved as below to overcome above issues.
> 
> Wait for any ongoing mdev create() and remove() to finish before
> unregistering parent device.
> This continues to allow multiple create and remove to progress in
> parallel for different mdev devices as most common case.
> At the same time guard parent removal while parent is being accessed by
> create() and remove() callbacks.
> create()/remove() and unregister_device() are synchronized by the rwsem.
> 
> Refactor device removal code to mdev_device_remove_common() to avoid
> acquiring unreg_sem of the parent.
> 
> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_core.c    | 71 ++++++++++++++++++++++++--------
>  drivers/vfio/mdev/mdev_private.h |  2 +
>  2 files changed, 55 insertions(+), 18 deletions(-)
> 

> @@ -265,6 +299,12 @@ int mdev_device_create(struct kobject *kobj,
>  
>  	mdev->parent = parent;
>  

Adding

/* Check if parent unregistration has started */

here as well might be nice, but no need to resend the patch for that.

> +	if (!down_read_trylock(&parent->unreg_sem)) {
> +		mdev_device_free(mdev);
> +		ret = -ENODEV;
> +		goto mdev_fail;
> +	}
> +
>  	device_initialize(&mdev->dev);
>  	mdev->dev.parent  = dev;
>  	mdev->dev.bus     = &mdev_bus_type;

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
