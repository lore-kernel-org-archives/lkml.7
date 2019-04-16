Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DB7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2869920872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfDPGSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:18:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48244 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfDPGSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:18:30 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 52A84260C42;
        Tue, 16 Apr 2019 07:18:28 +0100 (BST)
Date:   Tue, 16 Apr 2019 08:18:25 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <vitor.soares@synopsys.com>
Cc:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        bbrezillon@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        joao.pinto@synopsys.com
Subject: Re: [PATCH 2/3] i3c: Add i3c_get_device_id helper
Message-ID: <20190416081825.2d17b771@collabora.com>
In-Reply-To: <33ba7e13816fcece0a2f7ec917c18807359c16c7.1555354268.git.vitor.soares@synopsys.com>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
        <33ba7e13816fcece0a2f7ec917c18807359c16c7.1555354268.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 21:19:40 +0200
Vitor Soares <vitor.soares@synopsys.com> wrote:

> This helper return the i3c_device_id structure in order the client
> have access to the driver data.
> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
>  drivers/i3c/device.c       | 8 ++++++++
>  include/linux/i3c/device.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index 472be99..8ab8e4c 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -235,6 +235,14 @@ struct i3c_device *dev_to_i3cdev(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_to_i3cdev);
>  
> +const struct i3c_device_id *i3c_get_device_id(struct i3c_device *i3cdev)
> +{
> +	const struct i3c_driver *i3cdrv = drv_to_i3cdrv(i3cdev->dev.driver);
> +
> +	return i3cdrv->id_table;
> +}
> +EXPORT_SYMBOL_GPL(i3c_get_device_id);

I think what you want is i3c_device_match_id(). Just move the function
to drivers/i3c/device.c, export it and define its prototype in
include/i3c/device.h.

> +
>  /**
>   * i3c_driver_register_with_owner() - register an I3C device driver
>   *
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> index 7ee7e30..ee48886 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -211,6 +211,7 @@ static inline struct i3c_driver *drv_to_i3cdrv(struct device_driver *drv)
>  
>  struct device *i3cdev_to_dev(struct i3c_device *i3cdev);
>  struct i3c_device *dev_to_i3cdev(struct device *dev);
> +const struct i3c_device_id *i3c_get_device_id(struct i3c_device *i3cdev);
>  
>  static inline void i3cdev_set_drvdata(struct i3c_device *i3cdev,
>  				      void *data)

