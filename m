Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391E4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1328520854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfCYUUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:20:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfCYUUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:20:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 017383082A51;
        Mon, 25 Mar 2019 20:20:53 +0000 (UTC)
Received: from x1.home (ovpn-116-33.phx2.redhat.com [10.3.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA961619AA;
        Mon, 25 Mar 2019 20:20:52 +0000 (UTC)
Date:   Mon, 25 Mar 2019 14:20:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com
Subject: Re: [PATCH 6/8] vfio/mdev: Follow correct remove sequence
Message-ID: <20190325142052.423badda@x1.home>
In-Reply-To: <1553296835-37522-7-git-send-email-parav@mellanox.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-7-git-send-email-parav@mellanox.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 25 Mar 2019 20:20:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 18:20:33 -0500
Parav Pandit <parav@mellanox.com> wrote:

> mdev_remove_sysfs_files() should follow exact mirror sequence of a
> create, similar to what is followed in error unwinding path of
> mdev_create_sysfs_files().
> 
> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
> index ce5dd21..c782fa9 100644
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

Ok, I agree this is good practice, but what qualifies a "Fixes:" tag
here?  The fixes reference is incorrect in any case, 6a62c1dfb5c7
changed the creation ordering and didn't update the remove ordering to
match, but I still don't see an actual problem with the remove ordering
that necessitates the tag.  Please clarify.  Thanks,

Alex
