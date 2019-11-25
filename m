Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC09520740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XQYfeqnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfKYSJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:09:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33655 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfKYSJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:09:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id a24so13645487edt.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8k9NL1wzPDm3lyi5ftkOv0GY++AVKfR4SbL9MgMbNCg=;
        b=XQYfeqnqTmxDAu3JGyN9kyojY1pRl0Q3NusiT8XASycZxpFrtPd8ERwaV2X/Tr47M3
         qnjtiB6OhHdZjVuwfi08WAVjWzOM/wPG6/+nIBCvmln3bEQDbQgz2n63tLQx75HT8D27
         eDnvZPq1zk3vr57dDLdi6rkvciiyPWNK+3/zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8k9NL1wzPDm3lyi5ftkOv0GY++AVKfR4SbL9MgMbNCg=;
        b=lheOVcy0Hc8H6k7Flgr/y6ampEfN20ep3r2evKcLVd1B8OqBsQiFY1yIYyKmWv1AaU
         bLFcgyxYVuvxXn/Tc+UvorzhvRmADdpP5QG47dMuDf3v5veoLwZzToUR/qS+sCd0obP3
         4AZKy/OnXRXcQx8QoWWKrBk2RcDueSUTvD9CsJzllYqCvklBVpJ0uImR7UxhoQJyiKn9
         YaBQxNI+hgLM+NNn/O4wteedMhbN1Itx1yR5qQjxTCUx/7uPhZCGn2yWT49XM75XA6Oj
         CGfntS0cqetzbmQlHm/zovm49uGTdCupvWbcNsW1xEwOebjWo1A8qVpJSgLqb7/O8QSO
         yDWQ==
X-Gm-Message-State: APjAAAXWUrbS5OIgI1XE/1xqNnLKjcuv7mIAUW73+t/hdzuapkppIHU1
        /jHF1jLFfbkTFANT5PScDoocGCp0Cjo=
X-Google-Smtp-Source: APXvYqzycgZibLTN4TXAnFvRNiocQTCuV/T2IFPY4lA9i3y5m9SlvTZKez3xr5lBj7Vx8AMvSGr1Xg==
X-Received: by 2002:a17:906:4b10:: with SMTP id y16mr18181035eju.216.1574705365504;
        Mon, 25 Nov 2019 10:09:25 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id l9sm106240ejx.10.2019.11.25.10.09.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 10:09:23 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id b18so19305390wrj.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:09:22 -0800 (PST)
X-Received: by 2002:a5d:5224:: with SMTP id i4mr32928062wra.303.1574705362276;
 Mon, 25 Nov 2019 10:09:22 -0800 (PST)
MIME-Version: 1.0
References: <20191121090620.75569-1-akshu.agrawal@amd.com>
In-Reply-To: <20191121090620.75569-1-akshu.agrawal@amd.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 25 Nov 2019 11:09:11 -0700
X-Gmail-Original-Message-ID: <CAHQZ30DB4E3SY8QQdL=jTp+Zx2OvjW6ih6kCSBiaRpiy5Wcj6g@mail.gmail.com>
Message-ID: <CAHQZ30DB4E3SY8QQdL=jTp+Zx2OvjW6ih6kCSBiaRpiy5Wcj6g@mail.gmail.com>
Subject: Re: [PATCH] i2c: i2c-cros-ec-tunnel: Fix slave device enumeration
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 2:06 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>
> During adding of the adapter the slave device registration
> use to fail as the acpi companion field was not populated.
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> index c551aa96a2e3..aca8070393bd 100644
> --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> @@ -273,6 +273,7 @@ static int ec_i2c_probe(struct platform_device *pdev)
>         bus->adap.dev.parent = &pdev->dev;
>         bus->adap.dev.of_node = np;
>         bus->adap.retries = I2C_MAX_RETRIES;
> +       ACPI_COMPANION_SET(&bus->adap.dev, ACPI_COMPANION(&pdev->dev));
>
>         err = i2c_add_adapter(&bus->adap);
>         if (err)
> --
> 2.17.1
>

Acked-by: Raul E Rangel <rrangel@chromium.org>
