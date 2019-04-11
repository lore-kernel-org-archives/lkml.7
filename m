Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FF2C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAA82084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uK8EGvlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfDKJuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:50:19 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44058 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfDKJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:50:19 -0400
Received: by mail-ua1-f65.google.com with SMTP id p13so1794324uaa.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pP8WXTGvgkneoOZI+Gv/I+zv6/Mip7lrA4QWYPjhxsc=;
        b=uK8EGvlrlKX6qTQ/Ki3ICclRC18L6BMezQDMEh/kKx5/l4oKd9Xq70TS3GPFNU8oNo
         tPs/fJOq6bx4HpuBTNQ2BJ1lsDsC890kOq3+5gh6LrUw6TCsouMsFAWbi8jvcOLFdZB0
         oS0qepl0dJa0vhnwijbXINOGOYgg3N5qRfWe26rnahrG/3hi5D3FGq+rqLSwwn94x5Us
         5W7ivxgvG9AvnyKvxFh06N11mTuvjw6KScQOM6s9eV9YKVd0q098P5/xnoOylTL2obdd
         CCEeYT9TGYchk8G8mBheG1t7D4KYtpGfBwhbeDOXgC8btTary9FBflx7UyLt6Fk+JqFw
         Z3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pP8WXTGvgkneoOZI+Gv/I+zv6/Mip7lrA4QWYPjhxsc=;
        b=MWxZCNhZlBz0QYQgSSjfCnog6Xhwt2U3Gsl5/itdTTurqCQ19rOvfW7e0zJi6GvCaj
         nauK1CqCwLbEIL+N9Aj3+KDNQtcVwNS1KnPUxx2TYe96g7p+A/xl+8LNv2lgLbHE4vG4
         AsWqCu9odKy+l5RU7jvuWqCLhoQ0MY+pAXalQ182twO38HbSkfLs4DkWSi0z+qW4VaZK
         J934MmSp+3bi0xQOhkKjUbeMAsjMOhESPtgxmOnXhFNX48hTO3afk+MBAUFysItX78Fq
         xmw9HNw3KhIKEdTMj4kXIBF4iNb1ssnA0ukNM2zxr+JpEXl82Fbd5pYWyMZ10aMhL4cj
         wf/A==
X-Gm-Message-State: APjAAAXs6R0tHibCln83fjLV3B5Ga8frBuU1kxNqG+HF5CyJf/ViOFyj
        /Y6iNcMy4YJOMFu1WY8vU4ksPjXhYcl/pRFEMZth3w==
X-Google-Smtp-Source: APXvYqx/zeYGh6clHItoNixnaFEJ/UG3uCly6intu0WUhzmJrnviRdX5O1+ub7XYTX0zHVCxV3n2T5BNrgWxhbvNhKM=
X-Received: by 2002:ab0:6947:: with SMTP id c7mr2964385uas.51.1554976218252;
 Thu, 11 Apr 2019 02:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190325122442.30644-1-ulf.hansson@linaro.org>
In-Reply-To: <20190325122442.30644-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 11:49:42 +0200
Message-ID: <CAPDyKFqNih3kEuRM9HHkmcVOzaT2RZLRjb=0ifq6hGB+OCxUug@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add section for MediaTek MMC/SD/SDIO driver
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chaotian,

On Mon, 25 Mar 2019 at 13:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Cc: Chaotian Jing <chaotian.jing@mediatek.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d263f29..b43e563b4c95 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9775,6 +9775,12 @@ F:       drivers/media/platform/mtk-vpu/
>  F:     Documentation/devicetree/bindings/media/mediatek-vcodec.txt
>  F:     Documentation/devicetree/bindings/media/mediatek-vpu.txt
>
> +MEDIATEK MMC/SD/SDIO DRIVER
> +M:     Chaotian Jing <chaotian.jing@mediatek.com>
> +S:     Maintained
> +F:     drivers/mmc/host/mtk-sd.c
> +F:     Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +

Are you fine with this, or do you have any other guys at your side
that can help with reviewing patches for the mtk-sd driver?

[...]

Kind regards
Uffe
