Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1F8C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC15A20896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 14:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555251313;
	bh=fK2vGpFSbUJzlCwZ6B42IpYzTqlphNu9vuH6GH0k7Kg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mrxEdi4pD1uM6tzOYofW3Fj8Du6hRc1oOQA84zebdC//YqzZFKNRn4sCD31uc94xp
	 4NtlMc/PKxiw7YMZ7gKwZ5YIl/ZLDMisMWeiN41qdTULih7ep02AmlhvgS1oEh4ZJu
	 Nk9gxoBjUadWVgs7MTRbDVYpNjfjdllWI/GM6P8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfDNOPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 10:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfDNOPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 10:15:12 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A134420880;
        Sun, 14 Apr 2019 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555251311;
        bh=fK2vGpFSbUJzlCwZ6B42IpYzTqlphNu9vuH6GH0k7Kg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NYSI9ZM0y4gqvDmMPZeV+pGvCyL1cRl/Q7dD87mS4FCDrrQ4imcWPN1I/yktTKwOF
         MNzsZuaKs3ysyQrIz/fZACZjbE4UmQkQmL7GA7tNvyABmGiZqDNTS4rwoM9mKIlQOT
         vNtuR8C2GJsj9caq1qyKLiorWX/rQ8VOXPJBeCjw=
Date:   Sun, 14 Apr 2019 15:15:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     linus.walleij@linaro.org, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/iio/gyro/mpu3050-core.c: This patch fix the
 following checkpatch warning.
Message-ID: <20190414151506.6d8c671d@archlinux>
In-Reply-To: <1555063763-2328-1-git-send-email-mohankumar718@gmail.com>
References: <1555063763-2328-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 13:09:23 +0300
Mohan Kumar <mohankumar718@gmail.com> wrote:

> As per Documentation/timers/timers-howto.txt Msleep < 20ms can sleep for
> up to 20ms. so use usleep_range.
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>

Please resend, ccing the linux-iio@vger.kernel.org mailing list.

Thanks,

Jonathan
> ---
>  drivers/iio/gyro/mpu3050-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 85b7ac4..0a40616 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -865,7 +865,7 @@ static int mpu3050_power_up(struct mpu3050 *mpu3050)
>  		dev_err(mpu3050->dev, "error setting power mode\n");
>  		return ret;
>  	}
> -	msleep(10);
> +	usleep_range(10000, 20000);
>  
>  	return 0;
>  }

