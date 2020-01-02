Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC7CC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D14215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgr7ojvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgABHgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:36:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37118 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgABHgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:36:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so21673001pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 23:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9BZFCWByeFBQFg4ZpwRS8Ep8P4RYSRYVRbf7sq8YUn4=;
        b=vgr7ojvK1IpBjMrcuFNiAurp1izGXu8v7/Imtdb6mtTYZBlrX+xEzK0+/prqYuJvZi
         WRAUeI84rPPjrl2b15KK4FTmNBRvGIoFq7s7exbiy9n+82PZXEBGveUnsFnRDm5zO6hA
         m/k+R6DyPs3kaYeOBTQp0ONWpFmX2csttv42PjhTMqEsvXG/068gcqRMgpkesN9j/pcF
         1jfxPU7M43Ki6z63KdCdIwfOayDLGG1u8tznmWzrm+RiMd3u4/HP8I00vU57HDdEcuVv
         n3cHAT5JS5/c9DhWeKkQZmwoMzwgUG3A+TlX4fNehBy5O6r+60t/sAL1xOJypCiVYc3Z
         AGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9BZFCWByeFBQFg4ZpwRS8Ep8P4RYSRYVRbf7sq8YUn4=;
        b=tb1GPFOTiqlBbIMT4M0TBluUBLsEbCxvnYHKKgQpd9p4HPjAvLA9CbIP7bPcyOKO21
         lpJXxmcVPaEpXEe8/CruMF5xrFCGBN1F7HY/2Xfwl+1KHBXGotQ+h3gP2RLmZYvz4mFN
         KCpr+I+qwAT1zVoTZnqSfa2YGi8KFt28giW7PBFxkKMBWZXJlHO1OobYo69x1ZAXYKst
         e19dWxEuvwtXpdrVzAQSx/eoIEKOD0U0Z82b+w8SR3SszgAnG/JHPJ9yi78MtF6+zqEn
         l0wI2te/rrIFh33SeKAacFbygEWxs9l4XXr0kIqww/4bkOa8hbwKkIzvyxdMe/0KMCsk
         1+KA==
X-Gm-Message-State: APjAAAWCw/QaomWcRM29JoHzUWdpsk8GEnJLF11uuqN+CqJ3LZIzRbhY
        whV9FYqOFwV86/syQGPLQ5UlDg==
X-Google-Smtp-Source: APXvYqwST97ivxeEeCej8Jd+8HddEhoVJprknV1/YugYLwdhyqMzNoOEOQmeu+khAFhJ/ze/6cRsvg==
X-Received: by 2002:a62:a209:: with SMTP id m9mr77068574pff.16.1577950570999;
        Wed, 01 Jan 2020 23:36:10 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 207sm64170807pfu.88.2020.01.01.23.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 23:36:10 -0800 (PST)
Date:   Wed, 1 Jan 2020 23:36:07 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: scm: add 32 bit iommu page table support
Message-ID: <20200102073607.GS549437@yoga>
References: <20200101033704.32264-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101033704.32264-1-masneyb@onstation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31 Dec 19:37 PST 2019, Brian Masney wrote:

> Add 32 bit implmentations of the functions
> __qcom_scm_iommu_secure_ptbl_size() and
> __qcom_scm_iommu_secure_ptbl_init() that are required by the qcom_iommu
> driver.
> 

Hi Brian,

This looks good, but I was hoping to  hoping to reach a conclusion and
merge [1] - which in patch 16 squashes the argument filling boiler plate
code of the 32 and 64-bit version of scm and hence implements the same.

If you have time to take a peek at this series I would greatly
appreciate it (not a lot of people testing 32-bit these days...)

[1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=215943

Regards,
Bjorn

> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/firmware/qcom_scm-32.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
> index 48e2ef794ea3..f149a85d36b0 100644
> --- a/drivers/firmware/qcom_scm-32.c
> +++ b/drivers/firmware/qcom_scm-32.c
> @@ -638,13 +638,41 @@ int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
>  int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
>  				      size_t *size)
>  {
> -	return -ENODEV;
> +	int psize[2] = { 0, 0 };
> +	int ret;
> +
> +	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
> +			    QCOM_SCM_IOMMU_SECURE_PTBL_SIZE,
> +			    &spare, sizeof(spare), &psize, sizeof(psize));
> +	if (ret || psize[1])
> +		return ret ? ret : -EINVAL;
> +
> +	*size = psize[0];
> +
> +	return 0;
>  }
>  
>  int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr, u32 size,
>  				      u32 spare)
>  {
> -	return -ENODEV;
> +	struct msm_scm_ptbl_init {
> +		__le32 paddr;
> +		__le32 size;
> +		__le32 spare;
> +	} req;
> +	int ret, scm_ret = 0;
> +
> +	req.paddr = addr;
> +	req.size = size;
> +	req.spare = spare;
> +
> +	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
> +			    QCOM_SCM_IOMMU_SECURE_PTBL_INIT,
> +			    &req, sizeof(req), &scm_ret, sizeof(scm_ret));
> +	if (ret || scm_ret)
> +		return ret ? ret : -EINVAL;
> +
> +	return 0;
>  }
>  
>  int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr,
> -- 
> 2.21.0
> 
