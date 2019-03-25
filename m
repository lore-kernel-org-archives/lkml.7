Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A4BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB4E20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfCYL4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:56:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbfCYL4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:56:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77A737BDDA;
        Mon, 25 Mar 2019 11:56:46 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1D9D786A8;
        Mon, 25 Mar 2019 11:56:42 +0000 (UTC)
Message-ID: <36fb897248c241489f880933551276d23471ecf7.camel@redhat.com>
Subject: Re: [PATCH 4/8] vfio/mdev: Drop redundant extern for exported
 symbols
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Parav Pandit <parav@mellanox.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com
Date:   Mon, 25 Mar 2019 13:56:41 +0200
In-Reply-To: <1553296835-37522-5-git-send-email-parav@mellanox.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
         <1553296835-37522-5-git-send-email-parav@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 25 Mar 2019 11:56:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-22 at 18:20 -0500, Parav Pandit wrote:
> There is no need use 'extern' for exported functions.
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  include/linux/mdev.h | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
> index b6e048e..0924c48 100644
> --- a/include/linux/mdev.h
> +++ b/include/linux/mdev.h
> @@ -118,21 +118,20 @@ struct mdev_driver {
>  
>  #define to_mdev_driver(drv)	container_of(drv, struct mdev_driver, driver)
>  
> -extern void *mdev_get_drvdata(struct mdev_device *mdev);
> -extern void mdev_set_drvdata(struct mdev_device *mdev, void *data);
> -extern uuid_le mdev_uuid(struct mdev_device *mdev);
> +void *mdev_get_drvdata(struct mdev_device *mdev);
> +void mdev_set_drvdata(struct mdev_device *mdev, void *data);
> +uuid_le mdev_uuid(struct mdev_device *mdev);
>  
>  extern struct bus_type mdev_bus_type;
>  
> -extern int  mdev_register_device(struct device *dev,
> -				 const struct mdev_parent_ops *ops);
> -extern void mdev_unregister_device(struct device *dev);
> +int mdev_register_device(struct device *dev, const struct mdev_parent_ops
> *ops);
> +void mdev_unregister_device(struct device *dev);
>  
> -extern int  mdev_register_driver(struct mdev_driver *drv, struct module
> *owner);
> -extern void mdev_unregister_driver(struct mdev_driver *drv);
> +int mdev_register_driver(struct mdev_driver *drv, struct module *owner);
> +void mdev_unregister_driver(struct mdev_driver *drv);
>  
> -extern struct device *mdev_parent_dev(struct mdev_device *mdev);
> -extern struct device *mdev_dev(struct mdev_device *mdev);
> -extern struct mdev_device *mdev_from_dev(struct device *dev);
> +struct device *mdev_parent_dev(struct mdev_device *mdev);
> +struct device *mdev_dev(struct mdev_device *mdev);
> +struct mdev_device *mdev_from_dev(struct device *dev);
>  
>  #endif /* MDEV_H */

I honestly didn't knew/paid attention to that nice bit of C.
Indeed 'extern' is already kind of a default for function declarations.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



