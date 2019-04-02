Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A7CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F1420883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554211894;
	bh=XySw+1wJLIrjguyl+srVIl8HemosN0z8qub7N+t8+Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hD0rkl5yTQgyiS9gsat1KpBmEqaTYAG1rHUbhAwKF/zjzFFkh1aNErQq8y4B+onrz
	 QqoKD4Akd5zblLyfSfMzoYjhLJ+cLTVDz7R6v0VOvihEvfDjgjikvd91+QKIez3n2x
	 cljOp+FROVZRbVwmPRoeaNisNbPx1jb4WyRZxrhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfDBNbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:31:33 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38355 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfDBNbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:31:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id e80so11989453ote.5;
        Tue, 02 Apr 2019 06:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXmfkcg6xDIBfN/TTphCFGlH2CQvn3O0YGQqVKTVE/g=;
        b=AAMpgewmEyQyAFqvmWD6AIDWxSb5S08e3CBbqJYczC1HlLfX54qhzUuBCH4enM8buy
         w1XZ1pSsO7xWKeAhAQWDPUy6hgse2dzeRjMW/TP6/kv3Uy/edSKLlrzJ0ypTsrp3wLra
         /DVxJGJTVoQooI7Qho9VyMrB4lps7EIbfVszzANWCk+VovuUcgIlluqjMpw4IKuM3D6d
         tINo13jxLqFrS6PVcbt75K2nq/F/Khgo+Ytk4oWSeocbjnY05a2jhmDtHjgJAjgcqg39
         /3Fx8fjdoCZQmeAbBw204a8Zu5W80uVSN1DYUl/OQQHOg5OWOfqqmTn2DyAWD2uLUAUe
         vqNA==
X-Gm-Message-State: APjAAAWyD/t3BfTU9e2GzBfg29JUGKn6+7E+rYpAU7KP8F3oPeIG9QuB
        KG+uWE/SesadpGfv5R2jwNI=
X-Google-Smtp-Source: APXvYqyHaTg6OnFKF1QRQcxVpTWy4N4ZM7/nLP8m2ALIewnf2MTGZG4qvp+97g5W/sdDaYQvGQVGkw==
X-Received: by 2002:a9d:7f03:: with SMTP id j3mr47241231otq.249.1554211891654;
        Tue, 02 Apr 2019 06:31:31 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id l5sm5637076otr.53.2019.04.02.06.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 06:31:31 -0700 (PDT)
Date:   Tue, 2 Apr 2019 06:31:30 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com,
        jollys@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Message-ID: <20190402133130.GA14646@archbook>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402123123.915-4-nava.manne@xilinx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nava,

looks mostly good to me. One minor nit below:

On Tue, Apr 02, 2019 at 06:01:23PM +0530, Nava kishore Manne wrote:

[..]
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> new file mode 100644
> index 000000000000..f6e35fe95adb
> --- /dev/null
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Xilinx, Inc.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/string.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +
> +/* Constant Definitions */
> +#define IXR_FPGA_DONE_MASK	0X00000008U

You could use the BIT(x) macro here.
> +
> +/**
> + * struct zynqmp_fpga_priv - Private data structure
> + * @dev:	Device data structure
> + * @flags:	flags which is used to identify the bitfile type
> + */
> +struct zynqmp_fpga_priv {
> +	struct device *dev;
> +	u32 flags;
> +};
> +

[..]

Reviewed-by: Moritz Fischer <mdf@kernel.org>

Thanks,

Moritz
