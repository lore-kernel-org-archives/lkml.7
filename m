Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3CEC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8502E2067C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="G6ptwH5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfD0Ub7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:31:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37443 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfD0Ub7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:31:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id b12so4750225lji.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O8Yn7rSqSWzJGEK90Lsepo7xnz0psLgDKoYMEPt0f+I=;
        b=G6ptwH5cQK8gyQQBjLAO0A6t3tRHNZHtJBq+mPC2leXHWTWzfGvtomGLjo9OtR1gc5
         HPYHPaXTkXSvthv9H3mdSFhLI8CJV0iyu3nxYn89okYEcynAqAEDx1Qfyi0mgEIFS3cB
         dklbElANUeUmlyNoyU/yLxIkreWZnvPkwOC3/lw7YHdYgDhNihRmjxAHlYaUWuR975dj
         3IF5XMjXqAcshY+h+fGHisvx6GHk5xtzqyvmNXM3uJ9iTXk8KzNv2sdzECymZBxlC8hD
         mSERJt6kTdFr9KXkpn0IIZcTW8G7y489yZETvy6py90/C9wQXf/lxdYMbZU0WB6Z9KkG
         V/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=O8Yn7rSqSWzJGEK90Lsepo7xnz0psLgDKoYMEPt0f+I=;
        b=aKCzpQyqjluj66C28zTu/QKWl0s69SY8dQoOq9ikOi3AiodnG/ixER0qyOd3dE1OZ4
         CGCr1nb0wFZxoJ2d7kEjbraBZhawscNgK4GMlk00pL5jOER/5VGrTj1r8eHvaPPdhgUt
         BSbuAVsETr/Y4i+i9IlWenmKzE5nWM9dGTqQT+2qDwpqSrcnP2+EiJ6AHOaAb7vXNXAH
         fAceP67r5HU5CHx3VpP0h48V7B4XhxjWvfHS8JKDwsqV4jyfP9M2sXwo+xU5UpHOQL+y
         +bN7Wfm8k0rQ/fd4jm+25krSIiVTHRLQPhoIOHHgqJ3K7UEAx44KUXDZbp74nrsRLyIm
         FABw==
X-Gm-Message-State: APjAAAUfGlfDfOiDUlGhJ1wSMYVpJe76llpRSQQPVk6ezTVmWfywyzzD
        pE2RZRvf4jIsHyB5HxwvciTuKw==
X-Google-Smtp-Source: APXvYqzh1bdAD38MjP/J5rMLGVKNYbnVhRbsJX0POxHShzdSlQUCNYildYReq2IzntSwcVh964tq3w==
X-Received: by 2002:a2e:99d2:: with SMTP id l18mr14141923ljj.27.1556397117063;
        Sat, 27 Apr 2019 13:31:57 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.185])
        by smtp.gmail.com with ESMTPSA id o3sm6498817lfn.41.2019.04.27.13.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 13:31:56 -0700 (PDT)
Subject: Re: [PATCH v4 5/5] mtd: hyperbus: Add driver for TI's HyperBus memory
 controller
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <20190423104814.5762-1-vigneshr@ti.com>
 <20190423104814.5762-6-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <281a479d-3cfb-b9e1-23ee-c8e3acc37abe@cogentembedded.com>
Date:   Sat, 27 Apr 2019 23:31:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190423104814.5762-6-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/2019 01:48 PM, Vignesh Raghavendra wrote:

> Add driver for HyperBus memory controller on TI's AM654 SoC. Programming
> IP is pretty simple and provides direct memory mapped access to
> connected Flash devices.
> 
> Add basic support for the IP without DMA. Second chipSelect is not
> supported for now.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[...]
> diff --git a/drivers/mtd/hyperbus/hbmc-am654.c b/drivers/mtd/hyperbus/hbmc-am654.c
> new file mode 100644
> index 000000000000..f458d7226df9
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/hbmc-am654.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +// Author: Vignesh Raghavendra <vigneshr@ti.com>
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mtd/hyperbus.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mux/consumer.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/types.h>
> +
> +struct am654_hbmc_priv {
> +	struct hyperbus_ctlr ctlr;
> +	struct hyperbus_device hbdev;
> +	void __iomem	*regbase;

   You don't seem to use this field.

[...]

MBR, Sergei
