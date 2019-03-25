Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A42C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D8D20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfCYLs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:48:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbfCYLs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:48:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B197C3099FD1;
        Mon, 25 Mar 2019 11:48:56 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D55576F62;
        Mon, 25 Mar 2019 11:48:52 +0000 (UTC)
Message-ID: <ed1b1fbf91abb5b2d6388df48079bf45244e2d94.camel@redhat.com>
Subject: Re: [PATCH 1/8] vfio/mdev: Fix to not do put_device on
 device_register failure
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Parav Pandit <parav@mellanox.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com
Date:   Mon, 25 Mar 2019 13:48:51 +0200
In-Reply-To: <1553296835-37522-2-git-send-email-parav@mellanox.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
         <1553296835-37522-2-git-send-email-parav@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 25 Mar 2019 11:48:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-22 at 18:20 -0500, Parav Pandit wrote:
> device_register() performs put_device() if device_add() fails.
> This balances with device_initialize().
> 
> mdev core performing put_device() when device_register() fails,
> is an error that puts already released device again.
> Therefore, don't put the device on error.
> 
> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 0212f0e..3e5880a 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -318,10 +318,8 @@ int mdev_device_create(struct kobject *kobj, struct
> device *dev, uuid_le uuid)
>  	dev_set_name(&mdev->dev, "%pUl", uuid.b);
>  
>  	ret = device_register(&mdev->dev);
> -	if (ret) {
> -		put_device(&mdev->dev);
> +	if (ret)
>  		goto mdev_fail;
> -	}
>  
>  	ret = mdev_device_create_ops(kobj, mdev);
>  	if (ret)

Very good catch! Thanks!

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

