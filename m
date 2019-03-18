Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3752FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000A12070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlmwK8ZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfCRK1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:27:34 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36955 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfCRK1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:27:34 -0400
Received: by mail-ua1-f68.google.com with SMTP id x1so5099506uaj.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lPyOpFuMDYq4nVQxiuoCiGmNqu8kfSEGuu3G7u9/04I=;
        b=ZlmwK8ZTedkD69h3AIUH3+6UQxc9c5+1UGdALtLAbHTb9xW/Rokv7istg6o12o1dM3
         gozk1Wo9DaR8VIR9c3PnYAImnjIr4fmYA10KRRFEKF/ZpfYq+nSHInGNx9YbjXvhKvYd
         unmICB7Z8Dfy/tgaFtMIOg6ajrcf5my73OC6evxhCBfyInlXRXBV+ToFhqks6RJOsUpe
         hIuVOezObYzpT4hziDqoqDZ+pWvyOJ6FdDiiR1sxhTIBdToUGMGSq4lPz4WqhHtXlIqF
         PPWSOE0KpC9yZCZi3YL7FV2k+gQuTiTD3RJQs8Tqds3fEf2t8ycGBiQWEbwMCBPZZLjs
         8ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPyOpFuMDYq4nVQxiuoCiGmNqu8kfSEGuu3G7u9/04I=;
        b=YDP64kaxruD8rnMK78yUKeTmdhpzEvkWvKG7q6INlIsU8jbaw84Qdmjw07T7R030/L
         URydznk6ermktI2a0jUKkFBj6WM7twKYsRRCS+Du8FQqc89vrmvVP+yOJq573Tc6BxWE
         OIZCulxvcc/so83CYBYMiPq9HRwZZiAz5rC0wO44wSfydLZMtgtewkRd/9+IIhhwZCDy
         iJHH3yrqoO/ZmcE54/If0H4tTuoXhz/ZrFIUfLcf1t7Jyo/0q54vYxWU0593qlphkxl1
         CXAFVzn0jYeNpyF4IKc/36vVCypR+uf/FSmfgTTyEO2KcD14ROBrfrbu0uvppdn+2KN5
         7VTw==
X-Gm-Message-State: APjAAAU2p5feYSxFvzg5C+sNoC4YxkxnVZVk7+nfwpZcLOh5u0wISIew
        l4WXQmOogoM6e6tcW6GU44kIkR14my6UArf6rvIDqw==
X-Google-Smtp-Source: APXvYqz4NUV0yEUGJvFAljzdalJQ3kRZfNv4ZY7YMUE0h1DYeEH4XaWl+YgSXusbE85cHZey+iZRC0OYn25rXC9+KWo=
X-Received: by 2002:ab0:7782:: with SMTP id x2mr5359252uar.120.1552904853345;
 Mon, 18 Mar 2019 03:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552510141.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1552510141.git.sean.wang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Mar 2019 11:26:57 +0100
Message-ID: <CAPDyKFrvZQBXYU3T=pPYYyx1TEu26U8Z3Nky+n5p8rfkxCqtKw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] add module_sdio_driver and enable a few users
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 at 22:02, <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> Add module_sdio_driver exactly like the function module_usb_drivear offers to
> and enable a few users to eliminate a few lines of boilerplate code per SDIO
> driver.
>
> Sean Wang (3):
>   mmc: sdio: Add helper macro for sdio_driver boilerplate
>   Bluetooth: mediatek: Use module_sdio_driver helper
>   Bluetooth: btsdio: Use module_sdio_driver helper
>
>  drivers/bluetooth/btmtksdio.c | 15 +--------------
>  drivers/bluetooth/btsdio.c    | 15 +--------------
>  include/linux/mmc/sdio_func.h | 12 ++++++++++++
>  3 files changed, 14 insertions(+), 28 deletions(-)
>
> --
> 2.18.0
>

For series:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
