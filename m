Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362A1C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C30D2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L72FmqY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgAGRbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:31:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41980 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgAGRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:31:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so192819pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6tbx6y0alCppo4JulU8ZX+Wq5gWxVblT3if0J5vpiqg=;
        b=L72FmqY7y9JcE1Hl8aVOS075lkg2C/pQlQl3XVkV9+o4hG12UWm6Z+RNU4UaowMX7l
         AzJI7/sOkWRixckpCz3sLqVPZ9Lmn0VMJOukcWmnoz0mlT/zeKG8T+7vtUMCBlLNLNmD
         C7TYuadNxUKRk5Jyrl5xgt4f5z004pCSe3P5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6tbx6y0alCppo4JulU8ZX+Wq5gWxVblT3if0J5vpiqg=;
        b=qD3LYnsRPtHr8u/sGzNBkvvYe9XG5dk48Qbcd6xRBbSXd80KpvrQj5GsAFd0VMB9wx
         XRZBzpX5pf0X9MMQsjiKIja+C5rgxJGnFwE03bwmNyppu4SCWoOOc9T3SIvBw5tt+TtW
         E89ojsppNhiAjg2chqtYYL+uOOw0WzTTr7nD6DjnqdbR4wRf6+NLSOqFv+ES2TLdZ3qh
         NzKVwZwk8Mz2OToxL5IIRht3z6fC+RXbz2gGBEEETZeeOI3j+3XXeWSbKOqWrcaub0kK
         RQE88sP7naivwABzXJGSAxpfK6vKNLQuFZzsbDfIyBhHWxuFH8LCaHbYC9dS5cMrL8gy
         ogyw==
X-Gm-Message-State: APjAAAUtbLQkA0su4lfll1GAwbh4n5F1kHoe5QzO56T/2NBzDwL22ds/
        CZ8Oo1mLNEkStoqGrZ2lnOtqVg==
X-Google-Smtp-Source: APXvYqxuZTRMvr2E0NVTDg27lnwD7H9kx+RE+QwcVmHID/+AUrQOH+CqDmCL6ILFL3+vIgX9QTQ34Q==
X-Received: by 2002:a63:8041:: with SMTP id j62mr551347pgd.41.1578418311104;
        Tue, 07 Jan 2020 09:31:51 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 80sm126769pfw.123.2020.01.07.09.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 09:31:50 -0800 (PST)
Date:   Tue, 7 Jan 2020 09:31:49 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Add qca_power_on() API to support
 both wcn399x and Rome power up
Message-ID: <20200107173149.GD89495@google.com>
References: <20200107052601.32216-1-rjliao@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107052601.32216-1-rjliao@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rocky,

On Tue, Jan 07, 2020 at 01:26:01PM +0800, Rocky Liao wrote:
> This patch adds a unified API qca_power_on() to support both wcn399x and
> Rome power on. For wcn399x it calls the qca_wcn3990_init() to init the
> regulators, and for Rome it pulls up the bt_en GPIO to power up the btsoc.
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 9392cc7f9908..f6555bd1adbc 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1532,6 +1532,27 @@ static int qca_wcn3990_init(struct hci_uart *hu)
>  	return 0;
>  }
>  
> +static int qca_power_on(struct hci_dev *hdev)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	enum qca_btsoc_type soc_type = qca_soc_type(hu);
> +	struct qca_serdev *qcadev;
> +	int ret = 0;

another option would be to return directly from the if/else branches,
but either way is fine.

> +
> +	if (qca_is_wcn399x(soc_type)) {
> +		ret = qca_wcn3990_init(hu);
> +	} else {
> +		if (hu->serdev) {
> +			qcadev = serdev_device_get_drvdata(hu->serdev);
> +			gpiod_set_value_cansleep(qcadev->bt_en, 1);
> +			/* Controller needs time to bootup. */
> +			msleep(150);
> +		}
> +	}
> +
> +	return ret;
> +}
> +

I expected qca_power_on() would be called from qca_open(), but as is
this would only work for ROME, and not WCN399x, which only enables
the regulators in qca_open(), qca_wcn3990_init() is called from
qca_setup(). Is there a particular reason for this assymmetry between
the ROME and WCN399x initialization (i.e. one is fully powered up after
open(), the other not)?
