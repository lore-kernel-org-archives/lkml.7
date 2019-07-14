Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110CBC74A44
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE77220644
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563116016;
	bh=9lEDg8pDrn3NzFE+2guK2xUQXP4S4iIrw7eghHplUuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PGX48th9gR2AOce1hXuhC4KLB44iE7+Hc8yiQDftI3PgMgjy2Kl3CHJSyG6RP6wsZ
	 RRmi/HKZsj3DV81YnvAPU3HnB0qlEiW+uzzQdibHvkGkYh+iuftPIgloI8iO89tKU6
	 i3ZjVlXjZSF6ZFF49ZvyQoH2ZKifZjMhTjIieMR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfGNOxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 10:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfGNOxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 10:53:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 407BE20644;
        Sun, 14 Jul 2019 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563116014;
        bh=9lEDg8pDrn3NzFE+2guK2xUQXP4S4iIrw7eghHplUuw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IIw4TYIldcHSt5NZWQ3zSHnl0WcGqXk/tIP1bXETG7Ab8DD9CZ9Sf3GeQmcsgt7rH
         u37S7UIWRK5hKXNW+LzqcqOmc35QgshMkzEF5IURYxsa/tnZoSfU83Ds6eI+My23qU
         jxMF0yUP/OrSQhRXC0ysoeskvqO0e1ho/YC+/oF0=
Date:   Sun, 14 Jul 2019 15:53:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] iio: imu: mpu6050: Replace devm_add_action()
 followed by failure action with devm_add_action_or_reset()
Message-ID: <20190714155318.380a0f77@archlinux>
In-Reply-To: <20190708123341.12035-1-huangfq.daxian@gmail.com>
References: <20190708123341.12035-1-huangfq.daxian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Jul 2019 20:33:41 +0800
Fuqian Huang <huangfq.daxian@gmail.com> wrote:

> devm_add_action_or_reset() is introduced as a helper function which 
> internally calls devm_add_action(). If devm_add_action() fails 
> then it will execute the action mentioned and return the error code.
> This reduce source code size (avoid writing the action twice) 
> and reduce the likelyhood of bugs.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we missed anything.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 53a59957cc54..e067927317bd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1096,10 +1096,9 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	if (result)
>  		return result;
>  
> -	result = devm_add_action(dev, inv_mpu_core_disable_regulator_action,
> +	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_action,
>  				 st);
>  	if (result) {
> -		inv_mpu_core_disable_regulator_action(st);
>  		dev_err(dev, "Failed to setup regulator cleanup action %d\n",
>  			result);
>  		return result;

