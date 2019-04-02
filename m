Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21623C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDED120856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XxC1ZGNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDBXTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:19:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35125 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDBXTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:19:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so626782plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 16:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0zqkJY7jl0hJky97MNhfAD6Z1FUXXVe8V2mRRUXg8qk=;
        b=XxC1ZGNdW16Dfl5X9N7YRFmKbG4N+VC9NRUxEoibjOBu6bfie/gUCR+wUBkfYm/0q6
         t4z3c7E33j0mZsgf4OnTlXC+G9QOzFSoCE6fMJdWDNQuFm6nfsKjx6oVhrQR1CkOGW4f
         SR8wDJPvjElXaenl5l5LBjCKW7sPDvcT7rhM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0zqkJY7jl0hJky97MNhfAD6Z1FUXXVe8V2mRRUXg8qk=;
        b=g6U6bfW90Jz7z+61htuH/IyvyLkAFWA3HiiSYogdceC80VOT0nETfzbmkVmotoRwQD
         OoDAXIXalP45fkH7P5JyKc2nRgaG8w51TOMgbdfxbxY78r7ykNYIuuKyWBP9cBcIuEQA
         EZUW46iELkVw918aoqtR/dqMjOTFVvI/gx3fBGkEdkVI4Joh0XXGO7WzZWO7ivHeiS5U
         OJiPcoj06P3fJLNWKQ531ILYu3ec2L3btxAS5BQwWQz+3XDCFMn9vtg8Mb/4h6D9eSHv
         +ZvIXZqIJWkkZnpyAu9ozSR2xN+wXEE/nBa2Uss9ukNmTEKS7Te/HQrI70txwmnAEbeP
         qQFw==
X-Gm-Message-State: APjAAAWwIL2VJr9Hlhii2mVYz29Zfp2W1IjmBeTZOvDaRnA2t+Si79S/
        3P2NqsiTKf0I9nUnVSXXI5ptng==
X-Google-Smtp-Source: APXvYqzXvoS2GmevIQL7AWbe0vlPD9QkASPaJrD+esexwW+1JkkwN0mpFMVW2NT9/8A51wioRrnk3Q==
X-Received: by 2002:a17:902:7893:: with SMTP id q19mr11878822pll.154.1554247159042;
        Tue, 02 Apr 2019 16:19:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e126sm17472767pfh.35.2019.04.02.16.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 16:19:18 -0700 (PDT)
Date:   Tue, 2 Apr 2019 16:19:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        sjg@chromium.org, briannorris@chromium.org, groeck@chromium.org,
        broonie@kernel.org, ryandcase@chromium.org, rspangler@chromium.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_spi: Transfer messages at high
 priority
Message-ID: <20190402231917.GL112750@google.com>
References: <20190402224445.64823-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190402224445.64823-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Tue, Apr 02, 2019 at 03:44:44PM -0700, Douglas Anderson wrote:
> The software running on the Chrome OS Embedded Controller (cros_ec)
> handles SPI transfers in a bit of a wonky way.  Specifically if the EC
> sees too long of a delay in a SPI transfer it will give up and the
> transfer will be counted as failed.  Unfortunately the timeout is
> fairly short, though the actual number may be different for different
> EC codebases.
> 
> We can end up tripping the timeout pretty easily if we happen to
> preempt the task running the SPI transfer and don't get back to it for
> a little while.
> 
> Historically this hasn't been a _huge_ deal because:
> 1. On old devices Chrome OS used to run PREEMPT_VOLUNTARY.  That meant
>    we were pretty unlikely to take a big break from the transfer.
> 2. On recent devices we had faster / more processors.
> 3. Recent devices didn't use "cros-ec-spi-pre-delay".  Using that
>    delay makes us more likely to trip this use case.
> 4. For whatever reasons (I didn't dig) old kernels seem to be less
>    likely to trip this.
> 5. For the most part it's kinda OK if a few transfers to the EC fail.
>    Mostly we're just polling the battery or doing some other task
>    where we'll try again.
> 
> Even with the above things, this issue has reared its ugly head
> periodically.  We could solve this in a nice way by adding reliable
> retries to the EC protocol [1] or by re-designing the code in the EC
> codebase to allow it to wait longer, but that code doesn't ever seem
> to get changed.  ...and even if it did, it wouldn't help old devices.
> 
> It's now time to finally take a crack at making this a little better.
> This patch isn't guaranteed to make every cros_ec SPI transfer
> perfect, but it should improve things by a few orders of magnitude.
> Specifically you can try this on a rk3288-veyron Chromebook (which is
> slower and also _does_ need "cros-ec-spi-pre-delay"):
>   md5sum /dev/zero &
>   md5sum /dev/zero &
>   md5sum /dev/zero &
>   md5sum /dev/zero &
>   while true; do
>     cat /sys/class/power_supply/sbs-20-000b/charge_now > /dev/null;
>   done
> ...before this patch you'll see boatloads of errors.  After this patch I
> don't see any in the testing I did.
> 
> The way this patch works is by effectively boosting the priority of
> the cros_ec transfers.  As far as I know there is no simple way to
> just boost the priority of the current process temporarily so the way
> we accomplish this is by creating a "WQ_HIGHPRI" workqueue and doing
> the transfers there.
> 
> NOTE: this patch relies on the fact that the SPI framework attempts to
> push the messages out on the calling context (which is the one that is
> boosted to high priority).  As I understand from earlier (long ago)
> discussions with Mark Brown this should be a fine assumption.  Even if
> it isn't true sometimes this patch will still not make things worse.
> 
> [1] https://crbug.com/678675
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/platform/chrome/cros_ec_spi.c | 107 ++++++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index ffc38f9d4829..101f2deb7d3c 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
>
> ...
>
> +static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
> +				struct cros_ec_command *ec_msg)
> +{
> +	struct cros_ec_spi *ec_spi = ec_dev->priv;
> +	struct cros_ec_xfer_work_params params;
> +
> +	INIT_WORK(&params.work, cros_ec_pkt_xfer_spi_work);
> +	params.ec_dev = ec_dev;
> +	params.ec_msg = ec_msg;
> +
> +	queue_work(ec_spi->high_pri_wq, &params.work);
> +	flush_workqueue(ec_spi->high_pri_wq);

IIRC dedicated workqueues should be avoided unless they are needed. In
this case it seems you could use system_highpri_wq + a
completion. This would add a few extra lines to deal with the
completion, in exchange the code to create the workqueue could be
removed.

> +	return params.ret;
> +}
> +
> +static void cros_ec_cmd_xfer_spi_work(struct work_struct *work)
> +{
> +	struct cros_ec_xfer_work_params *params;
> +
> +	params = container_of(work, struct cros_ec_xfer_work_params, work);
> +	params->ret = do_cros_ec_cmd_xfer_spi(params->ec_dev, params->ec_msg);
> +}
> +
> +static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
> +				struct cros_ec_command *ec_msg)
> +{
> +	struct cros_ec_spi *ec_spi = ec_dev->priv;
> +	struct cros_ec_xfer_work_params params;
> +
> +	INIT_WORK(&params.work, cros_ec_cmd_xfer_spi_work);
> +	params.ec_dev = ec_dev;
> +	params.ec_msg = ec_msg;
> +
> +	queue_work(ec_spi->high_pri_wq, &params.work);
> +	flush_workqueue(ec_spi->high_pri_wq);
> +
> +	return params.ret;
> +}

This is essentially a copy of cros_ec_pkt_xfer_spi() above. You
could add a wrapper that receives the work function to avoid the
duplicate code.

Cheers

Matthias
