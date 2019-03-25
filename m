Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F922C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A5B20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfCYLux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:50:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730789AbfCYLux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:50:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 462DE30018F4;
        Mon, 25 Mar 2019 11:50:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B52C06EA3F;
        Mon, 25 Mar 2019 11:50:49 +0000 (UTC)
Message-ID: <6522eaf89e86534167d3b91046f7aaab16fb38a8.camel@redhat.com>
Subject: Re: [PATCH 3/8] vfio/mdev: Removed unused kref
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Parav Pandit <parav@mellanox.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com
Date:   Mon, 25 Mar 2019 13:50:48 +0200
In-Reply-To: <1553296835-37522-4-git-send-email-parav@mellanox.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
         <1553296835-37522-4-git-send-email-parav@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 25 Mar 2019 11:50:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-22 at 18:20 -0500, Parav Pandit wrote:
> Remove unused kref from the mdev_device structure.
> 
> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_core.c    | 1 -
>  drivers/vfio/mdev/mdev_private.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 4f213e4d..3d91f62 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -311,7 +311,6 @@ int mdev_device_create(struct kobject *kobj, struct device
> *dev, uuid_le uuid)
>  	mutex_unlock(&mdev_list_lock);
>  
>  	mdev->parent = parent;
> -	kref_init(&mdev->ref);
>  
>  	mdev->dev.parent  = dev;
>  	mdev->dev.bus     = &mdev_bus_type;
> diff --git a/drivers/vfio/mdev/mdev_private.h
> b/drivers/vfio/mdev/mdev_private.h
> index b5819b7..84b2b6c 100644
> --- a/drivers/vfio/mdev/mdev_private.h
> +++ b/drivers/vfio/mdev/mdev_private.h
> @@ -30,7 +30,6 @@ struct mdev_device {
>  	struct mdev_parent *parent;
>  	uuid_le uuid;
>  	void *driver_data;
> -	struct kref ref;
>  	struct list_head next;
>  	struct kobject *type_kobj;
>  	bool active;

When develping my nvme-mdev driver, I'll seen that unused kref too.
Dead code has to go.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

