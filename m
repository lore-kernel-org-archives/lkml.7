Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23793C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D949D206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DHXlwt/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfDCVEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:04:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33742 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfDCVEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:04:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so206047pfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jYEWD9JmA34ubcDtsinJJ/0uLN/53FD9Qbx3BZ6sZOs=;
        b=DHXlwt/WfKRbNLYC0NFzcTIiE8tAe7yUuQhAeQyHet9lgS8ka30Vp2cTfOkUSOiqNt
         gWO6zZabIqD7za5VMNy4bkz3Qkadlf7FJNJNOas3e8pwD7IIlhx4AdMinJTYWzeqoebR
         dNe7cpnbinpOjNZ5FISquIV/UxGzXIVUkB+PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jYEWD9JmA34ubcDtsinJJ/0uLN/53FD9Qbx3BZ6sZOs=;
        b=rcIXBCBt14VIIeD/qaWR8iV/MYTV5kSHDVS8eYio9n27U0kixMe07/j+ufUoNp4A7y
         1MzapBJcq5Eo/MsG+cuhMou/vLB3Yj5vb0EvVVCWSYZXC78plyx9SNg09/3H1WtZmu7v
         y2p08XF737S0yQu4c8K/bL9NeCk7rQlinNlFWFeVVonj7wsaDahQLRhlHKsMApfEXABM
         UoFByFxch6X5RFxmVcnt2S9zBOKFbpRN1AzEP3oZKsulJ8z+Tora+i6psAtNwuwiD44Z
         9y4mL6tWJxzCbCWV2FTSv7yHQS0RQljKBcVUOTNB7dCQkQitoN3J7mdQnzhuoXGh+zcl
         YNMg==
X-Gm-Message-State: APjAAAVEG/W7PIzQzJFsPGlO3sD15JHSJ/ibX/W6LSfEBNY2AXAKbOWr
        7pmgDRu+G8TPT9aOKWIRa1QmHg==
X-Google-Smtp-Source: APXvYqw5JJ6OYI7B0wDCxbZHzz1y+6cdKgndVoKRbNXD60F0pD5phvFTNsT6rs2XUsRUg9u3ThjDzA==
X-Received: by 2002:a63:1d26:: with SMTP id d38mr1673509pgd.357.1554325477268;
        Wed, 03 Apr 2019 14:04:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id i24sm22959276pfo.85.2019.04.03.14.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 14:04:36 -0700 (PDT)
Date:   Wed, 3 Apr 2019 14:04:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        sjg@chromium.org, briannorris@chromium.org, groeck@chromium.org,
        broonie@kernel.org, ryandcase@chromium.org, rspangler@chromium.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
Message-ID: <20190403210436.GS112750@google.com>
References: <20190403203137.203582-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403203137.203582-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 01:31:37PM -0700, Douglas Anderson wrote:
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
> we accomplish this is by queuing the work on the system_highpri_wq.
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
> Changes in v3:
> - Use flush_work(), not a completion (Brian)
> 
> Changes in v2:
> - Use system_highpri_wq + completion (Matthias)
> - Avoid duplication by using a function pointer (Matthias)
> 
>  drivers/platform/chrome/cros_ec_spi.c | 79 +++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index ffc38f9d4829..29d2f7d24929 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -75,6 +75,27 @@ struct cros_ec_spi {
>  	unsigned int end_of_msg_delay;
>  };
>  
> +typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
> +				  struct cros_ec_command *ec_msg);
> +
> +/**
> + * struct cros_ec_xfer_work_params - params for our high priority workers
> + *
> + * @work: The work_struct needed to queue work
> + * @fn: The function to use to transfer
> + * @ec_dev: ChromeOS EC device
> + * @ec_msg: Message to transfer
> + * @ret: The return value of the function
> + */
> +
> +struct cros_ec_xfer_work_params {
> +	struct work_struct work;
> +	cros_ec_xfer_fn_t fn;
> +	struct cros_ec_device *ec_dev;
> +	struct cros_ec_command *ec_msg;
> +	int ret;
> +};
> +
>  static void debug_packet(struct device *dev, const char *name, u8 *ptr,
>  			 int len)
>  {
> @@ -350,13 +371,13 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
>  }
>  
>  /**
> - * cros_ec_pkt_xfer_spi - Transfer a packet over SPI and receive the reply
> + * do_cros_ec_pkt_xfer_spi - Transfer a packet over SPI and receive the reply
>   *
>   * @ec_dev: ChromeOS EC device
>   * @ec_msg: Message to transfer
>   */
> -static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
> -				struct cros_ec_command *ec_msg)
> +static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
> +				   struct cros_ec_command *ec_msg)
>  {
>  	struct ec_host_response *response;
>  	struct cros_ec_spi *ec_spi = ec_dev->priv;
> @@ -493,13 +514,13 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
>  }
>  
>  /**
> - * cros_ec_cmd_xfer_spi - Transfer a message over SPI and receive the reply
> + * do_cros_ec_cmd_xfer_spi - Transfer a message over SPI and receive the reply
>   *
>   * @ec_dev: ChromeOS EC device
>   * @ec_msg: Message to transfer
>   */
> -static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
> -				struct cros_ec_command *ec_msg)
> +static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
> +				   struct cros_ec_command *ec_msg)
>  {
>  	struct cros_ec_spi *ec_spi = ec_dev->priv;
>  	struct spi_transfer trans;
> @@ -611,6 +632,52 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
>  	return ret;
>  }
>  
> +static void cros_ec_xfer_high_pri_work(struct work_struct *work)
> +{
> +	struct cros_ec_xfer_work_params *params;
> +
> +	params = container_of(work, struct cros_ec_xfer_work_params, work);
> +	params->ret = params->fn(params->ec_dev, params->ec_msg);
> +}
> +
> +static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,

nit: the fact that a high priority workqueue is used is an
implementation detail, since the driver has no function to perform a
transfer with 'normal'/low priority there is no need to distinguish
between the two cases. In this sense I'd be inclined to remove the
'high_pri' from the function names.

Sorry for not mentioning this earlier, I focussed on other
details, anyway it's just a nit.

> +				 struct cros_ec_command *ec_msg,
> +				 cros_ec_xfer_fn_t fn)
> +{
> +	struct cros_ec_xfer_work_params params;
> +
> +	INIT_WORK(&params.work, cros_ec_xfer_high_pri_work);
> +	params.ec_dev = ec_dev;
> +	params.ec_msg = ec_msg;
> +	params.fn = fn;
> +
> +	/*
> +	 * This looks a bit ridiculous.  Why do the work on a
> +	 * different thread if we're just going to block waiting for
> +	 * the thread to finish?  The key here is that the thread is
> +	 * running at high priority but the calling context might not
> +	 * be.  We need to be at high priority to avoid getting
> +	 * context switched out for too long and the EC giving up on
> +	 * the transfer.
> +	 */
> +	queue_work(system_highpri_wq, &params.work);
> +	flush_work(&params.work);
> +
> +	return params.ret;
> +}
> +
> +static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
> +				struct cros_ec_command *ec_msg)
> +{
> +	return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_pkt_xfer_spi);
> +}
> +
> +static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
> +				struct cros_ec_command *ec_msg)
> +{
> +	return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
> +}
> +
>  static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
>  {
>  	struct device_node *np = dev->of_node;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
