Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED362C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B383420823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcDIpWgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfCYVKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:10:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35914 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfCYVKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:10:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id r124so7174908pgr.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qopcgsVUd5ssY+n+hvqgdW7SDAg5pHr/Qm0Sgeo6Pr0=;
        b=bcDIpWgL9K1dUH1jXmT3fVasyTpQ7fxfhLBI0Vmb/lDY/5ZKyINRIKhFEy0F9eL91R
         rW2mIXEdesMZ0SwzlxpK/UnHxNyn3xrnqUxSu+hu+/W727Pv9bmxxzSfN2U57uq4nk9v
         7gSAbB4HOuPfHrpH3hP7dKxwQiQKNv8CvoIL/E+cdOmOKX931naCoyMFDLB06odpDm1x
         gAt+/cmA7xG10wB7ur68CXnjwzrtTZCHroMS5uUOJjUuF1Uk5A75+DjAtJvgdwNyCCby
         kA8gz07Blfss7eu2laghmGeWtuVjGMVaaeXmJlONwoQl4MsQGvJFtomErc0yDuWs1fh7
         2Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qopcgsVUd5ssY+n+hvqgdW7SDAg5pHr/Qm0Sgeo6Pr0=;
        b=brRcTJM9bKDJfNLysTBNGABUVKz1jHJvYB76UWgKEwKQ0V4/lkHS810ja1GKnchRUK
         vV5h0fIiEKW5+DWt3ZlCQpevGTeHk+YLYcx5Rpjpkp7hyjy1zSD67UHSIN54ODC9wFbB
         isfYfdLBdvi2IlwBLtBq39d5HqeFytB+qTDGFg6GEMi1wztbWP0KcL4zScQ7omctGTT4
         VOrsma8ht2iE/M7mZGdPib4wt7FU2oSbPxaCv1vDH5R8CaYZUYreOFGLf/5xdA6fR8M5
         GqZWfdp01t/EmhKucW3Cb33CjG6o+AoAFYKZTbS1ZrtMfy6+Pj67Ytc4nxdnt1gPN+VG
         rt4g==
X-Gm-Message-State: APjAAAXs3NA6KAFJPFFZ2uQUmbmEJ9W6B58mTqVGCcKYSeQ29o/QFd8M
        FIMOWHDczIgbdfB0viB3aELPmg==
X-Google-Smtp-Source: APXvYqzHMBAOUsIdSYY/UulX3THsIrCOKLrTmno6p5EXN/6/JBajMEOPl5vQuGVSLFI1P6Tmz0ClCA==
X-Received: by 2002:a62:121c:: with SMTP id a28mr25734989pfj.58.1553548199703;
        Mon, 25 Mar 2019 14:09:59 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k72sm46194475pfb.122.2019.03.25.14.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:09:58 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:09:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, david.brown@linaro.org,
        tfiga@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com
Subject: Re: [PATCH v2 2/4] firmware/qcom_scm: Add atomic version of io
 read/write APIs
Message-ID: <20190325210956.GB2899@builder>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
 <20180910062551.28175-3-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910062551.28175-3-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09 Sep 23:25 PDT 2018, Vivek Gautam wrote:

> Add atomic versions of qcom_scm_io_readl/writel to enable
> reading/writing secure registers from atomic context.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/firmware/qcom_scm-32.c | 12 ++++++++++++
>  drivers/firmware/qcom_scm-64.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/firmware/qcom_scm.c    | 12 ++++++++++++
>  drivers/firmware/qcom_scm.h    |  4 ++++
>  include/linux/qcom_scm.h       |  4 ++++
>  5 files changed, 64 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
> index 4e24e591ae74..7293e5efad69 100644
> --- a/drivers/firmware/qcom_scm-32.c
> +++ b/drivers/firmware/qcom_scm-32.c
> @@ -627,3 +627,15 @@ int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val)
>  	return qcom_scm_call_atomic2(QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
>  				     addr, val);
>  }
> +
> +int __qcom_scm_io_readl_atomic(struct device *dev, phys_addr_t addr,
> +			       unsigned int *val)
> +{
> +	return -ENODEV;
> +}
> +
> +int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
> +				unsigned int val)
> +{
> +	return -ENODEV;
> +}
> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
> index 3a8c867cdf51..6bf55403f6e3 100644
> --- a/drivers/firmware/qcom_scm-64.c
> +++ b/drivers/firmware/qcom_scm-64.c
> @@ -558,3 +558,35 @@ int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val)
>  	return qcom_scm_call(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
>  			     &desc, &res);
>  }
> +
> +int __qcom_scm_io_readl_atomic(struct device *dev, phys_addr_t addr,
> +			       unsigned int *val)
> +{
> +	struct qcom_scm_desc desc = {0};
> +	struct arm_smccc_res res;
> +	int ret;
> +
> +	desc.args[0] = addr;
> +	desc.arginfo = QCOM_SCM_ARGS(1);
> +
> +	ret = qcom_scm_call_atomic(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_READ,
> +				   &desc, &res);
> +	if (ret >= 0)
> +		*val = res.a1;
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
> +				unsigned int val)
> +{
> +	struct qcom_scm_desc desc = {0};
> +	struct arm_smccc_res res;
> +
> +	desc.args[0] = addr;
> +	desc.args[1] = val;
> +	desc.arginfo = QCOM_SCM_ARGS(2);
> +
> +	return qcom_scm_call_atomic(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
> +				    &desc, &res);
> +}
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index e778af766fae..36da0000b37f 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -365,6 +365,18 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val)
>  }
>  EXPORT_SYMBOL(qcom_scm_io_writel);
>  
> +int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val)
> +{
> +	return __qcom_scm_io_readl_atomic(__scm->dev, addr, val);
> +}
> +EXPORT_SYMBOL(qcom_scm_io_readl_atomic);
> +
> +int qcom_scm_io_writel_atomic(phys_addr_t addr, unsigned int val)
> +{
> +	return __qcom_scm_io_writel_atomic(__scm->dev, addr, val);
> +}
> +EXPORT_SYMBOL(qcom_scm_io_writel_atomic);
> +
>  static void qcom_scm_set_download_mode(bool enable)
>  {
>  	bool avail;
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index dcd7f7917fc7..bb176107f51e 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -37,6 +37,10 @@ extern void __qcom_scm_cpu_power_down(u32 flags);
>  #define QCOM_SCM_IO_WRITE		0x2
>  extern int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr, unsigned int *val);
>  extern int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val);
> +extern int __qcom_scm_io_readl_atomic(struct device *dev, phys_addr_t addr,
> +				      unsigned int *val);
> +extern int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
> +				       unsigned int val);
>  
>  #define QCOM_SCM_SVC_INFO		0x6
>  #define QCOM_IS_CALL_AVAIL_CMD		0x1
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index 5d65521260b3..6a5d0c98b328 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -64,6 +64,8 @@ extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
>  extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
>  extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>  extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
> +extern int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val);
> +extern int qcom_scm_io_writel_atomic(phys_addr_t addr, unsigned int val);
>  #else
>  static inline
>  int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
> @@ -100,5 +102,7 @@ static inline int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size) { ret
>  static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare) { return -ENODEV; }
>  static inline int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
>  static inline int qcom_scm_io_writel(phys_addr_t addr, unsigned int val) { return -ENODEV; }
> +static inline int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
> +static inline int qcom_scm_io_writel_atomic(phys_addr_t addr, unsigned int val) { return -ENODEV; }
>  #endif
>  #endif
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
