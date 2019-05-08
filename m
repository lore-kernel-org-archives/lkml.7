Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DC2C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0933421530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfEHRQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:16:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbfEHRQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:16:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B456481F35;
        Wed,  8 May 2019 17:16:44 +0000 (UTC)
Received: from gondolin (ovpn-204-161.brq.redhat.com [10.40.204.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD2A7608A6;
        Wed,  8 May 2019 17:16:38 +0000 (UTC)
Date:   Wed, 8 May 2019 19:16:35 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com, cjia@nvidia.com
Subject: Re: [PATCHv2 09/10] vfio/mdev: Avoid creating sysfs remove file on
 stale device removal
Message-ID: <20190508191635.05a0f277.cohuck@redhat.com>
In-Reply-To: <20190430224937.57156-10-parav@mellanox.com>
References: <20190430224937.57156-1-parav@mellanox.com>
        <20190430224937.57156-10-parav@mellanox.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 08 May 2019 17:16:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019 17:49:36 -0500
Parav Pandit <parav@mellanox.com> wrote:

> If device is removal is initiated by two threads as below, mdev core
> attempts to create a syfs remove file on stale device.
> During this flow, below [1] call trace is observed.
> 
>      cpu-0                                    cpu-1
>      -----                                    -----
>   mdev_unregister_device()
>     device_for_each_child
>        mdev_device_remove_cb
>           mdev_device_remove
>                                        user_syscall
>                                          remove_store()
>                                            mdev_device_remove()
>                                         [..]
>    unregister device();
>                                        /* not found in list or
>                                         * active=false.
>                                         */
>                                           sysfs_create_file()
>                                           ..Call trace
> 
> Now that mdev core follows correct device removal system of the linux
> bus model, remove shouldn't fail in normal cases. If it fails, there is
> no point of creating a stale file or checking for specific error status.

Which error cases are left? Is there anything that does not indicate
that something got terribly messed up internally?

> 
> kernel: WARNING: CPU: 2 PID: 9348 at fs/sysfs/file.c:327
> sysfs_create_file_ns+0x7f/0x90
> kernel: CPU: 2 PID: 9348 Comm: bash Kdump: loaded Not tainted
> 5.1.0-rc6-vdevbus+ #6
> kernel: Hardware name: Supermicro SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b
> 08/09/2016
> kernel: RIP: 0010:sysfs_create_file_ns+0x7f/0x90
> kernel: Call Trace:
> kernel: remove_store+0xdc/0x100 [mdev]
> kernel: kernfs_fop_write+0x113/0x1a0
> kernel: vfs_write+0xad/0x1b0
> kernel: ksys_write+0x5a/0xe0
> kernel: do_syscall_64+0x5a/0x210
> kernel: entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_sysfs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
> index 9f774b91d275..ffa3dcebf201 100644
> --- a/drivers/vfio/mdev/mdev_sysfs.c
> +++ b/drivers/vfio/mdev/mdev_sysfs.c
> @@ -237,10 +237,8 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>  		int ret;
>  
>  		ret = mdev_device_remove(dev);
> -		if (ret) {
> -			device_create_file(dev, attr);
> +		if (ret)

Should you merge this into the previous patch?

>  			return ret;
> -		}
>  	}
>  
>  	return count;

