Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1710FC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF17A216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUrTPTpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfGBG1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:27:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38517 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfGBG1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:27:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so7173617pgz.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EuejUuvkcT0encYrvFlmXEqjXG50bA0a3JTt1nvk284=;
        b=SUrTPTpxZQWzoc8xTD8MV2EteX90mj48aZsU+pGX5yAGF16EQHrZQDK/GBKw3jOg92
         1SltWro5BRtXqRDHomNrtTRJ2oZiBRrcCOwyg0aIlmrqWCmamn/de4sTTkqz3wZwUzRw
         R6etkEFn4ZdfTuIAUnnVcR/5Sug0HdzBfRieNTsr1y4BqAhBL6Z+P/7beZC50k2P4Mvv
         dQkgsT/FzLFzuDl6hGrJYVnkXlxwFRt4vxDqUSO9SmBhllum7KPE8d1U02FF+ThVYkT3
         Tgii0iXStS3K6tuNl/Q3wX4FFk/5GzDN/CeQAq1pVbhJYIdY4pQsknE0xgHpcj0o5btW
         eyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EuejUuvkcT0encYrvFlmXEqjXG50bA0a3JTt1nvk284=;
        b=mHWTFO0onAuZVT8GWvH7Vj9TBrzxV2O8+WQoaU7dD3FT0zMqm5mKnEsuylRsJbsAh0
         s9J3T1clVO2frzcqEypjO/fdONYMYyj69tfmcqaJkOCO51WCDzYr645Np+wSx4kfBWNL
         oTokxPWu99bgwjwhB5KAmE+Xf2/E17XzI/OHXElYOSH/9BaoxTsHEtYdBpyaw32zPTdX
         rj1+kXv/v0nE9i0gh15pKfYf4LvFXALOyNo/cJtCYdjVEj6b+mTrOHMSsuo5FOOzcG/2
         qT+OJva8dndfPR4tCHHnzaDTd+4MmwIn85K+48srn2xAE/Xo3wTYthz9dr9/Dl8MfVSQ
         xITg==
X-Gm-Message-State: APjAAAX3FLk/VvFwso0O2HNEcg2F78SNlHBO7mr7aYxEbflXNQqhbg4O
        HQ/Hy00Zx+6Q0wWZ5eSKqumYBg==
X-Google-Smtp-Source: APXvYqzn990jfIj5vkMAV1wfDm7OU+D+4BFoi7MQmUCzx2hStv2aQET+Y2RagVAIh/1G1I9NwHthRQ==
X-Received: by 2002:a63:6089:: with SMTP id u131mr29778864pgb.314.1562048828621;
        Mon, 01 Jul 2019 23:27:08 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a10sm5644142pgq.2.2019.07.01.23.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 23:27:07 -0700 (PDT)
Date:   Mon, 1 Jul 2019 23:27:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Clement Leger <cleger@kalray.eu>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Loic Pallardy <loic.pallardy@st.com>
Subject: Re: [PATCH v2] remoteproc: copy parent dma_pfn_offset for vdev
Message-ID: <20190702062705.GG1263@builder>
References: <20190612095521.4703-1-cleger@kalray.eu>
 <20190701070245.32083-1-cleger@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701070245.32083-1-cleger@kalray.eu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Jul 00:02 PDT 2019, Clement Leger wrote:

> When preparing the subdevice for the vdev, also copy dma_pfn_offset
> since this is used for sub device dma allocations. Without that, there
> is incoherency between the parent dma settings and the childs one,
> potentially leading to dma_alloc_coherent failure (due to phys_to_dma
> using dma_pfn_offset for translation).
> 
> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
> Signed-off-by: Clement Leger <cleger@kalray.eu>
> Acked-by: Loic Pallardy <loic.pallardy@st.com>

Thanks for the update. Applied

Regards,
Bjorn

> ---
> Changes in v2:
>  - Fix typo in commit message
>  - Add "Fixes" in commit message
>  - Add Signed-off
>  - Add Acked-by Loic Pallardy
> 
> ---
>  drivers/remoteproc/remoteproc_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 48feebd6d0a2..06837b1f2d60 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -520,6 +520,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>  	/* Initialise vdev subdevice */
>  	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
>  	rvdev->dev.parent = rproc->dev.parent;
> +	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
>  	rvdev->dev.release = rproc_rvdev_release;
>  	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
>  	dev_set_drvdata(&rvdev->dev, rvdev);
> -- 
> 2.15.0.276.g89ea799
> 
