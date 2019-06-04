Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF781C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59282147A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bwPYy4WK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfFDPZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:25:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36594 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfFDPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:25:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id u22so12903413pfm.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=Mrua8Se3/4ilWZJMy5h+Rrfq98YU9hLPDYoeq7tQAs0=;
        b=bwPYy4WKJZInqlQTDw1tRC2vfxgDnGkK0PChtQyEZsGS0topViNdNdWX6VaSl0HMrO
         qSz/UqMNTHg45ahUSDI9Xnc5tEuvAfrpjfMhBG14xZHMiUqJAKP4h78NdotF4VlIogzP
         UEi49SUP40Pyaut0+lMsfKNsgbjYpzHc2RCqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=Mrua8Se3/4ilWZJMy5h+Rrfq98YU9hLPDYoeq7tQAs0=;
        b=B0uNJkOH0xVm9UMP6EbBTC6xT15UPI42VEPYnDmzKcJNNyFmZGzzY6SgcEmOoH/8BI
         4AA42rGF1yNCCk7PJxWNs+9FhiArjCMlT3EREyGn+Ohvypo97t2ZvapofihB2B5geEgq
         0ZMVYN83E4myrRVqYYgXDP1BpRMjVfd+7CMjCq2QBOOE2OYFn18orFW5T9M6KxuPMWDt
         Yr3uN5kgnpWOfNJILjZbeHzcs5pTZcCsJF5Jrk2d16RLHGb+qIMex7XAXibJ4rH/IT4H
         PIi9yDeKSpC0qnYdO0XBl2jba07Aqz0pLVvjZWdtpwhzNYFZsFEhzMDHSSSbf8y93hAG
         tQrg==
X-Gm-Message-State: APjAAAXZzVJ4GKnWY6tKJXpaQn0XoQ/t+Fgh/OSxESYSB6mAlJhKQexi
        r0htPg+sZG3ZOwMcemarndHGRQ==
X-Google-Smtp-Source: APXvYqzFK80JeE50UcjFQyirswrvWFymO/ZMzI1vu12d2/0cwjZ7GI6ZIB2R/YBegZpgyFsXzUUQMw==
X-Received: by 2002:a62:5c84:: with SMTP id q126mr12951772pfb.247.1559661915912;
        Tue, 04 Jun 2019 08:25:15 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k6sm19398866pfi.86.2019.06.04.08.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 08:25:15 -0700 (PDT)
Message-ID: <5cf68d5b.1c69fb81.281cd.5f93@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190604072001.9288-3-bjorn.andersson@linaro.org>
References: <20190604072001.9288-1-bjorn.andersson@linaro.org> <20190604072001.9288-3-bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 2/3] scsi: ufs: Allow resetting the UFS device
User-Agent: alot/0.8.1
Date:   Tue, 04 Jun 2019 08:25:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-06-04 00:20:00)
> @@ -6104,6 +6105,25 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>         return err;
>  }
> =20
> +/**
> + ufshcd_device_reset() - toggle the (optional) device reset line
> + * @hba: per-adapter instance
> + *
> + * Toggles the (optional) reset line to reset the attached device.
> + */
> +static void ufshcd_device_reset(struct ufs_hba *hba)
> +{
> +       /*
> +        * The USB device shall detect reset pulses of 1us, sleep for 10u=
s to

This isn't usb though. Can we have a gpio reset driver and then
implement this in the reset framework instead? Or did that not work out
for some reason?

> +        * be on the safe side.
> +        */
> +       gpiod_set_value_cansleep(hba->device_reset, 1);
> +       usleep_range(10, 15);
> +
> +       gpiod_set_value_cansleep(hba->device_reset, 0);
> +       usleep_range(10, 15);
> +}
> +
>  /**
>   * ufshcd_host_reset_and_restore - reset and restore host controller
>   * @hba: per-adapter instance
