Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E90C31E46
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DC521721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3LzXxLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408167AbfFKXej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:34:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42812 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405899AbfFKXej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:34:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id l19so5218841pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PYi7OJyyBe1ys/czqidCNW9f3WOQhYyPFZsHkuJXNPA=;
        b=G3LzXxLXAw4vYXKvHUWcRG/MhZ5fKb794eouDDluevhnI3x5qsmCIsy2XGINp1UVV3
         Ywe05klg0KGFEsOq0qyd1y8ftTeBG8PTczTdTxIdQo6/Zy1uYlxkadywpliXruv8IcMW
         ZQwbRVNgrcNHF0SQX/78SPsbEBUX4pAsRhheesUpYnamOy+4sO2Q0oFqJNHrmugZ8Rlg
         8pkzDM/LQ8R54O2W9XWud8Lzl67PnrJ/y9dIE3afbF2teAn3ETJQzO6MvAVxZZJXd45Q
         ZFiM7aPAdy3S80Uw8avTmR+SgwRqyNHc2/d/aLcrPe/GSrKt01m+nu25kOrtwzri0u+N
         X+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PYi7OJyyBe1ys/czqidCNW9f3WOQhYyPFZsHkuJXNPA=;
        b=aQNZjvsDu28MpR259KV4RrUhA1mBnDNpiHMI3rUSYntcm6TShopC8GWZW0vQd4YVH9
         uKikq7UdWnbv6YT2EmMtX7WmGH04tlACnqULbVaipNqcActsoDUo948nosdG7bfdG8QX
         XwYYHm6tY9q5rUs5x8sRSFtS9pNPElpCEzDUDWZfjmpKjamnu1WhNth0N9TQiCHYKMsc
         qakiBZ9699o092QqQXd3ubWcJ1B7MfKxmOScTY3QanfH8WR4+cAi/HB54QzwiQ5drXFL
         0sasGTmty0xfv9q6h/AdqJh0/mpfukn7v8us7LZ5BeNS9Zv9PJ629C90od2b0eR17TPV
         Vz9Q==
X-Gm-Message-State: APjAAAXS+si3QYIjvEwO+R8gM71xPW4Dh3PLWq/kCjKBUiEotJ2gH7Zl
        lW0ZIYpWCiRr3ksvbG3Y1UohbA==
X-Google-Smtp-Source: APXvYqyGxmXuXbklefwmpMUhJYp3BwPcmYTN6Qx9IPoaLvpooS+EkitLHXZagWetvR9Dir91GDYSzg==
X-Received: by 2002:aa7:9825:: with SMTP id q5mr45428166pfl.140.1560296078493;
        Tue, 11 Jun 2019 16:34:38 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z186sm15605935pfz.7.2019.06.11.16.34.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 16:34:37 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:34:35 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, vkoul@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] interconnect: qcom: Add QCS404 interconnect
 provider driver
Message-ID: <20190611233435.GW4814@minitux>
References: <20190611164157.24656-1-georgi.djakov@linaro.org>
 <20190611164157.24656-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611164157.24656-3-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11 Jun 09:41 PDT 2019, Georgi Djakov wrote:

This looks good, just two minor things.

> diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
> new file mode 100644
> index 000000000000..99be0928e2ad
> --- /dev/null
> +++ b/drivers/interconnect/qcom/qcs404.c
> @@ -0,0 +1,539 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Linaro Ltd
> + */
> +
> +#include <dt-bindings/interconnect/qcom,qcs404.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "smd-rpm.h"

This file and the two functions defined therein doesn't exist until
patch 4, so please move this patch later in the series.

[..]
> diff --git a/include/dt-bindings/interconnect/qcom,qcs404.h b/include/dt-bindings/interconnect/qcom,qcs404.h

I think the preferred way is to have the DT binding headers as part of
the DT binding patch.

Regards,
Bjorn
