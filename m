Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E009C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53D92084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbfDARYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:24:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731959AbfDARYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 716AEC05FBDD;
        Mon,  1 Apr 2019 17:24:48 +0000 (UTC)
Received: from gondolin (ovpn-117-29.ams2.redhat.com [10.36.117.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 056B760856;
        Mon,  1 Apr 2019 17:24:45 +0000 (UTC)
Date:   Mon, 1 Apr 2019 19:24:42 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com, cjia@nvidia.com
Subject: Re: [PATCHv1 5/7] vfio/mdev: Follow correct remove sequence
Message-ID: <20190401192442.4dc37bd9.cohuck@redhat.com>
In-Reply-To: <1553658345-43995-6-git-send-email-parav@mellanox.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-6-git-send-email-parav@mellanox.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 01 Apr 2019 17:24:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 22:45:43 -0500
Parav Pandit <parav@mellanox.com> wrote:

> mdev_remove_sysfs_files() should follow exact mirror sequence of a
> create, similar to what is followed in error unwinding path of
> mdev_create_sysfs_files().
> 
> Fixes: 6a62c1dfb5c7 ("vfio/mdev: Re-order sysfs attribute creation")
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
> index 5193a0e..cbf94b8 100644
> --- a/drivers/vfio/mdev/mdev_sysfs.c
> +++ b/drivers/vfio/mdev/mdev_sysfs.c
> @@ -280,7 +280,7 @@ int  mdev_create_sysfs_files(struct device *dev, struct mdev_type *type)
>  
>  void mdev_remove_sysfs_files(struct device *dev, struct mdev_type *type)
>  {
> +	sysfs_remove_files(&dev->kobj, mdev_device_attrs);
>  	sysfs_remove_link(&dev->kobj, "mdev_type");
>  	sysfs_remove_link(type->devices_kobj, dev_name(dev));
> -	sysfs_remove_files(&dev->kobj, mdev_device_attrs);
>  }

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
