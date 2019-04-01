Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AA921473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfDAQ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:58:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfDAQ6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:58:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F79C51EE8;
        Mon,  1 Apr 2019 16:58:54 +0000 (UTC)
Received: from gondolin (ovpn-117-29.ams2.redhat.com [10.36.117.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF50360260;
        Mon,  1 Apr 2019 16:58:50 +0000 (UTC)
Date:   Mon, 1 Apr 2019 18:58:47 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com, cjia@nvidia.com
Subject: Re: [PATCHv1 1/7] vfio/mdev: Avoid release parent reference during
 error path
Message-ID: <20190401185847.0e45cad7.cohuck@redhat.com>
In-Reply-To: <1553658345-43995-2-git-send-email-parav@mellanox.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-2-git-send-email-parav@mellanox.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 01 Apr 2019 16:58:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 22:45:39 -0500
Parav Pandit <parav@mellanox.com> wrote:

> During mdev parent registration in mdev_register_device(),
> if parent device is duplicate, it releases the reference of existing
> parent device.
> This is incorrect. Existing parent device should not be touched.
> 
> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Reviewed By: Kirti Wankhede <kwankhede@nvidia.com>

Should probably be changed to the canonical Reviewed-by:.

> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index b96fedc..1299d2e 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -181,6 +181,7 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
>  	/* Check for duplicate */
>  	parent = __find_parent_device(dev);
>  	if (parent) {
> +		parent = NULL;
>  		ret = -EEXIST;
>  		goto add_dev_err;
>  	}

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
