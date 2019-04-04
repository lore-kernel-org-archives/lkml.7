Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612F5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306D72075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHXx3hu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfDDI0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:26:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33498 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDI0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:26:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so873499pgh.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=07GUcg6u37H31MakG6LkKFyVbiLp3/8iKS3hn8Y8K+g=;
        b=uHXx3hu+2oYTVoJdrDwVJ+vtK7x/NVsde/gGJrkCfsFMCNW7RMOuGphVB6+gpUVdqR
         saDGO6041Fm+KFxqQbD8lTxQFyD9AUdmwgtGfn81gB1oBreGQUH5rsvvwN1S05cvHM6B
         FZ2K2u4mLU/+O75KzI5MCtz2tshgDegwRUskhVGpIMLO6WXI+ddtjUIKCgumo3ayMVD0
         tyAebympGzKPDsIJeQ7X1VBCoZTg+Gt63xJclYEKuZXP1LhhleAeVSIXy31Z3O/D8VaD
         awUDzFKrXE8x4RYEOx6uIVCkXTu8zy/DPj1Xi1ygbpI2QhAk+msP7099U5v2YCSrqan6
         Tq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=07GUcg6u37H31MakG6LkKFyVbiLp3/8iKS3hn8Y8K+g=;
        b=cjtAwnNhYBqNFwP3oHgEMAE7z5sG8RypNCebQrrMcfO4WeiZ4UxlD23LsXfgyN6jnE
         KRG2OSViuXx0byGbHQyYm+QRYZbxSKfnfFhtS2Vn/1A7rB3Kr5Ypgagq3V0x9ldFxR1k
         ViVcpL8h58C9vXTNUyUlYpXR9FbMe4FU+kSirrXV6INmUBokGeXhNtGrFoi99vKITL9T
         JrSgQIIduBrhleZOgC6HIuGV26Y6LOeYlb6bslPb17SsRTOCwk3o5B2263tUm9n7HOA5
         vYJ2C98EdQmq4BJUlnLfY6bG5WeJypx0JXKi0XTYNB7i7rLR3e9WQUQdXvJ1Kj6YjWHn
         r7Fg==
X-Gm-Message-State: APjAAAXc1weMbLnedS6nt44ijJ3SCfOnEwt3mgSzlxVpAniJ6iVGU3Xd
        qYiDMQViT4JRGTFj5k2PSXFaQQ==
X-Google-Smtp-Source: APXvYqwVLns0PXRYAtDRFM0qk4myOF2Mf03OXBwGeKAd+UbXHlRolmWVVloXCmeR+HMstRgM88MvHg==
X-Received: by 2002:a62:6504:: with SMTP id z4mr4518782pfb.202.1554366411677;
        Thu, 04 Apr 2019 01:26:51 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id i79sm38615482pfj.28.2019.04.04.01.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 01:26:50 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:26:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 2/2] platform/chrome: Add support for v1 of host sleep
 event
Message-ID: <20190404082645.GR6830@dell>
References: <20190403213428.89920-1-evgreen@chromium.org>
 <20190403213428.89920-3-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403213428.89920-3-evgreen@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Apr 2019, Evan Green wrote:

> Add support in code for the new forms of the host sleep event.
> Detects the presence of this version of the command at runtime,
> and use whichever form the EC supports. At this time, always
> request the default timeout, and only report the failing response
> via a WARN_ONCE(). Future versions could accept the sleep parameter
> from outside the driver, and return the response information to
> usermode or elsewhere.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---
> 
> Changes in v3:
> - Consolidated boolean logic for host_sleep_v1 (Guenter)
> 
> Changes in v2:
> - Removed unnecessary version assignment (Guenter)
> - Changed WARN to WARN_ONCE (Guenter)
> - Fixed C code to use anonymous unions
> - insize is only bigger for resume events.
> 
>  drivers/mfd/cros_ec.c                   | 39 +++++++++++++++++++++----
>  drivers/platform/chrome/cros_ec_proto.c |  6 ++++
>  include/linux/mfd/cros_ec.h             |  2 ++
>  3 files changed, 42 insertions(+), 5 deletions(-)

Looks okay in principle.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
