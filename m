Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE72C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927FC2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWtyLPCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKKXK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:10:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39714 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfKKXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:10:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id o9so8473122plk.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tWeesDpDIKQpiy9KR8LKYyLg9H0SvGAo1V8+RtWjNIQ=;
        b=rWtyLPCIGyCdKarivLzqhQAJ+Hfooyus39lh21jI8xk1IYdM21EMyAhyCiMAj6XU88
         YHLkNv8fVvIZ3efdtCk8MC9ENjAuY75QGb92jJ9eWgZzeVmOmV6etIloPQOvhoKPytwU
         tdOsNkLLNnRJK7Yn8Glfv43FVt5EhmxeNqWuKKWoAjcQdRMMcJbNiRh0EcraR6vw7s+i
         KHwWFP2ROBBWbeDY/9Ub0aQ29J4YyF5s7sjGRMoHM4ItZh5loT9UqfcfTH1o7CLuFfzx
         lTdWaY6ydbeL1yhm2XLyeaVjzDiaoTGPeIDVV/PMsf2zuXu1ITVhz4muProW2lYrqDPq
         L1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tWeesDpDIKQpiy9KR8LKYyLg9H0SvGAo1V8+RtWjNIQ=;
        b=ZwSrysUNNzlUplM/nXiJnwbb49w5m2071dOupvIYhzBxicxnCVe6AWoTz86I82zU+E
         fcVevNUyGsIK1lXuHwnCaE5bluYJNGumFOfyRHjNFA+bzQBS6pXdXS+RL03Q814ae4iz
         o0r4FmEL4kaA3WwukzuiuDTJy3GA02tW0V//8iyyRZ0t/eV5HzZ6O2gXZQYuUxCgcn6z
         wXSPrA59U/kbcGbeJtRbpY6hbexlXJVLUgWebv8nME4c6HoYGGp3E6OEH6l1Xq3gGwR7
         mVPfH7ymoCLqzT7X3KXjvRgO3qlaWDVJQZR3QYq+Z9U+e55S506AXwZcmfKtPGFp+VPC
         6bzA==
X-Gm-Message-State: APjAAAVUAD2mTJ1tq1kHXarwXI3J3XLeYpDVbAsWEDQS5lqHkUcIfFWV
        6TT9jcqxlb30U+toASU+F0jeEQ==
X-Google-Smtp-Source: APXvYqxVslTCSWygyPseQoAhgUug6WvxHkgXjnEMOZD0F6D5+Rt7ew8BNgRcm46QVtnCEjQ90fs3Mg==
X-Received: by 2002:a17:902:bf4b:: with SMTP id u11mr2843807pls.40.1573513826584;
        Mon, 11 Nov 2019 15:10:26 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q4sm7296199pgp.30.2019.11.11.15.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 15:10:25 -0800 (PST)
Date:   Mon, 11 Nov 2019 15:10:23 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v20 3/4] rpmsg: add rpmsg support for mt8183 SCP.
Message-ID: <20191111231023.GD3108315@builder>
References: <20191014075812.181942-1-pihsun@chromium.org>
 <20191014075812.181942-4-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014075812.181942-4-pihsun@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Oct 00:58 PDT 2019, Pi-Hsun Shih wrote:

> Add a simple rpmsg support for mt8183 SCP, that use IPI / IPC directly.
> 

Hi Pi-Hsun,

Sorry for not reviewing this in a timely manner! This looks good, just
some very minor comments below.

> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
[..]
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index f2e5e70a58f2..7896cefb2dc0 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>  #include <linux/remoteproc/mtk_scp.h>
> +#include <linux/rpmsg/mtk_rpmsg.h>
>  
>  #include "mtk_common.h"
>  #include "remoteproc_internal.h"
> @@ -407,6 +408,31 @@ static void scp_unmap_memory_region(struct mtk_scp *scp)
>  	of_reserved_mem_device_release(scp->dev);
>  }
>  
> +static struct mtk_rpmsg_info mtk_scp_rpmsg_info = {
> +	.send_ipi = scp_ipi_send,
> +	.register_ipi = scp_ipi_register,
> +	.unregister_ipi = scp_ipi_unregister,

These are exported symbols, so unless you see a need to support
alternative implementations in the near future just skip the function
pointers and call them directly.

> +	.ns_ipi_id = SCP_IPI_NS_SERVICE,
> +};
> +
[..]
> diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
[..]
> +static void __ept_release(struct kref *kref)

Please make this __mtk_ept_release() to make it clear that this is
not a framework function.

> +{
> +	struct rpmsg_endpoint *ept = container_of(kref, struct rpmsg_endpoint,
> +						  refcount);
> +	kfree(to_mtk_rpmsg_endpoint(ept));
> +}
> +
> +static void mtk_rpmsg_ipi_handler(void *data, unsigned int len, void *priv)
> +{
> +	struct mtk_rpmsg_endpoint *mept = priv;
> +	struct rpmsg_endpoint *ept = &mept->ept;
> +	int ret;
> +
> +	ret = (*ept->cb)(ept->rpdev, data, len, ept->priv, ept->addr);
> +	if (ret)
> +		dev_warn(&ept->rpdev->dev, "rpmsg handler return error = %d",
> +			 ret);
> +}
> +
> +static struct rpmsg_endpoint *
> +__rpmsg_create_ept(struct mtk_rpmsg_rproc_subdev *mtk_subdev,

__mtk_create_ept()

> +		   struct rpmsg_device *rpdev, rpmsg_rx_cb_t cb, void *priv,
> +		   u32 id)
> +{

Regards,
Bjorn
