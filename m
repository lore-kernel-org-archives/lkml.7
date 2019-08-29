Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81ABC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B565C208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfH2KlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:41:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59580 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfH2KlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:41:23 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 34DE028626E;
        Thu, 29 Aug 2019 11:41:20 +0100 (BST)
Date:   Thu, 29 Aug 2019 12:41:15 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org, bbrezillon@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, Joao.Pinto@synopsys.com,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH 1/4] i3c: master: detach and free device if
 pre_assign_dyn_addr() fails
Message-ID: <20190829124115.482cd8ec@collabora.com>
In-Reply-To: <e26948eaaf765f683d8fe0618a31a98e2ecc0e65.1567071213.git.vitor.soares@synopsys.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
        <e26948eaaf765f683d8fe0618a31a98e2ecc0e65.1567071213.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Przemek

Please try to Cc active I3C contributors so they get a chance to
comment on your patches.

On Thu, 29 Aug 2019 12:19:32 +0200
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> On pre_assing_dyn_addr() the devices that fail:
>   i3c_master_setdasa_locked()
>   i3c_master_reattach_i3c_dev()
>   i3c_master_retrieve_dev_info()
> 
> are kept in memory and master->bus.devs list. This makes the i3c devices
> without a dynamic address are sent on DEFSLVS CCC command. Fix this by
> detaching and freeing the devices that fail on pre_assign_dyn_addr().

I don't think removing those entries is a good strategy, as one might
want to try to use a different dynamic address if the requested one
is not available. Why not simply skipping entries that have ->dyn_addr
set to 0 when preparing a DEFSLVS frame

> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
>  drivers/i3c/master.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 5f4bd52..4d29e1f 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1438,7 +1438,7 @@ static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
>  	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
>  					dev->boardinfo->init_dyn_addr);
>  	if (ret)
> -		return;
> +		goto err_detach_dev;
>  
>  	dev->info.dyn_addr = dev->boardinfo->init_dyn_addr;
>  	ret = i3c_master_reattach_i3c_dev(dev, 0);
> @@ -1453,6 +1453,10 @@ static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
>  
>  err_rstdaa:
>  	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
> +
> +err_detach_dev:
> +	i3c_master_detach_i3c_dev(dev);
> +	i3c_master_free_i3c_dev(dev);

We certainly shouldn't detach/free the i3c_dev_desc from here. If it
has to be done somewhere (which I'd like to avoid), it should be done
in i3c_master_bus_init() (i3c_master_pre_assign_dyn_addr() should be
converted to return an int in that case).

>  }
>  
>  static void
> @@ -1647,7 +1651,7 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  	enum i3c_addr_slot_status status;
>  	struct i2c_dev_boardinfo *i2cboardinfo;
>  	struct i3c_dev_boardinfo *i3cboardinfo;
> -	struct i3c_dev_desc *i3cdev;
> +	struct i3c_dev_desc *i3cdev, *i3ctmp;
>  	struct i2c_dev_desc *i2cdev;
>  	int ret;
>  
> @@ -1746,7 +1750,8 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  	 * Pre-assign dynamic address and retrieve device information if
>  	 * needed.
>  	 */
> -	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
> +	list_for_each_entry_safe(i3cdev, i3ctmp, &master->bus.devs.i3c,
> +				 common.node)
>  		i3c_master_pre_assign_dyn_addr(i3cdev);
>  
>  	ret = i3c_master_do_daa(master);

