Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B6FC2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8E320643
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="uL3/M8VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLWUHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 15:07:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33674 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLWUHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 15:07:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so10833373lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 12:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jlswyEc6xIGtbVUwHi52dwuY4ajQKEt5NuNVOiiskgw=;
        b=uL3/M8VWDFlVkz/n3D6NfSRboQct3/dGTYUJkfrsxjqaSw+powfOuZNJS8Yisdolf3
         W7IdrXrcukkSoUTcbrjnTjyzvK3o32XmMoRRaBsXYUZEKO77cMrZyWnhupiTXMTkBU9k
         RonZlzpJd09zJbBr+QvizRpPOxIC5B3UTBFDz5NoI3PVi4CxnhnzcS5A9s8y3fBpCgqE
         rHP/9xDBTHCHsiRYa+8tweT2HmhoBWCfTHwA2a1tDrV6gybMJDoeixrLXigLp1U5LKRT
         RB3L2xh97Av0TbaI/9N3wkT2tJitiCzqLpiRuwEunA+jLbSKTOEozf2WVXdVB0cVrLAw
         R2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jlswyEc6xIGtbVUwHi52dwuY4ajQKEt5NuNVOiiskgw=;
        b=GxEa+sqhRtG3G35lY34hcyGfRZRHrgAt62F8jDJWShQZsvWhVGOeIdBij9c2480DTL
         sZKJdOAbFlrdLPj8boE/CTGPVwGXwu6Ck61qn5sJZPGgE2nKEZRsbJ1U3v04c8Rd6KXw
         tRNxOlepdkc8MwdxRgUpPedyxVOyDnCWtr8tIws60BAitb6CYjDDQJGab78L9tEGcVGC
         99qJP7nsQU+uEdM3BsiIlkdA34lXQxl1CF04hSuhd0Ty6co8IE/BDmFpubLJ1Grwh676
         5PnfP+JeOVFaa0lnT2olQGkrm40Db1yalI47Xdk+VSJ6G5A+HVV/HsgHm0dyHan9gVoq
         fT8g==
X-Gm-Message-State: APjAAAV1QMGbGpSMMikfH3ObrRnfADIsMmgdWp+1q/PyKEZEBLU8F4kV
        0Udiq/N8P6UoXgguvioJMG2zNA==
X-Google-Smtp-Source: APXvYqx5g4M0uhRd+Jgki+03Npwwmd4lXlZjXrbkgxQkR/xuSqUXP1tnYgb7OvSuShD1VKlGh6Jykw==
X-Received: by 2002:a2e:a486:: with SMTP id h6mr11540184lji.235.1577131635009;
        Mon, 23 Dec 2019 12:07:15 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:855:9d36:483b:5fb3:f1dd:f0d5])
        by smtp.gmail.com with ESMTPSA id i19sm8915307lfj.17.2019.12.23.12.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 12:07:14 -0800 (PST)
Subject: Re: [PATCH v17 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        lee.jones@linaro.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com
References: <1565060061-11588-1-git-send-email-masonccyang@mxic.com.tw>
 <1565060061-11588-2-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <0e65db61-00e5-73cc-347a-023abfd138ba@cogentembedded.com>
Date:   Mon, 23 Dec 2019 23:07:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1565060061-11588-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 08/06/2019 05:54 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

   Mark Brown did have some comments to my variant of the RPC-IF SPI driver,
which didn't get addressed in your SPI driver... Relaying his comments to you,
I'd appreciate if you could reply to them...

[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..52537b7
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,756 @@
[...]
> +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
> +				   struct spi_message *msg)
> +{
> +	struct spi_transfer *t, xfer[4] = { };

Don't mix initialized and non-initialized declarations in a single line
(as per coding style).

> +	u32 i, xfercnt, xferpos = 0;
> +
> +	rpc->totalxferlen = 0;
> +	rpc->xfer_dir = SPI_MEM_NO_DATA;
> +
> +	list_for_each_entry(t, &msg->transfers, transfer_list) {
> +		if (t->tx_buf) {
> +			xfer[xferpos].tx_buf = t->tx_buf;
> +			xfer[xferpos].tx_nbits = t->tx_nbits;

xfer is hard coded to 4 elements but I'm not seeing any validation that
we don't have more transfers than that in the message, and there's lots
of assumptions later on about the number of transfers.

[...]
> +		if (list_is_last(&t->transfer_list, &msg->transfers)) {
> +			if (xferpos > 1) {
> +				if (t->rx_buf) {
> +					rpc->xfer_dir = SPI_MEM_DATA_IN;
> +					rpc->smcr = RPC_SMCR_SPIRE;
> +				} else if (t->tx_buf) {
> +					rpc->xfer_dir = SPI_MEM_DATA_OUT;
> +					rpc->smcr = RPC_SMCR_SPIWE;
> +				}
> +			}

Transfers can be bidirectional...  if the device can't support that it
should set SPI_CONTROLLER_HALF_DUPLEX.

[...]
> +static inline int rpc_spi_xfer_message(struct rpc_spi *rpc,
> +				       struct spi_transfer *data_xfer)

This has exactly one caller and contains a single statement - why have a
separate function?

> +{
> +	int ret;
> +
> +	ret = rpc_spi_set_freq(rpc, data_xfer->speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	ret = rpc_spi_io_xfer(rpc,
> +			      rpc->xfer_dir == SPI_MEM_DATA_OUT ?
> +			      data_xfer->tx_buf : NULL,
> +			      rpc->xfer_dir == SPI_MEM_DATA_IN ?
> +			      data_xfer->rx_buf : NULL);

This is really hard to read.  Why are we abusing the ternery operator
here, especially when there's other places where we already set things
up based on the direction?

[...]
[...]
> +static int rpc_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	spi_unregister_controller(ctlr);
> +
> +	return 0;
> +}
> +

Shouldn't we unregister the controller before we disable the RPM?  The
probe was the other way around and this means that we might still be
processing messages while the hardware is disabled which doesn't seem
good.

[...]

MBR, Sergei
