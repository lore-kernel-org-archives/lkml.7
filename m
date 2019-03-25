Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E28F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v75AVoA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfCYVKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:10:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39746 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfCYVKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:10:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so7026040pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2quxIf0d8yN8ghhKJunX2F62MmANycmOrivVTAc8TGc=;
        b=v75AVoA6DH0fYtNVdVIRkkqCbHKSuVJxP8DiLSq/1hi+rGxDxr17XBGG3oBDVKHxKU
         cXKs8EruqucDy2yE3CfZ7CZhKcJXK/YNw/pK0OTitpGHJfD9XRUJGE+Rf6bsbdvQlDE2
         6GsN9Hnp9CNzrc6EixlSnBz3T8hT363yCzinRggjg8zneE5UfIXS301WLcOYDlLcrOnl
         NZiBhnck6WknJ5txOxoqNQel9tLw9ZOdk+OPZKzV2z611YvE21Bkx0dMi8VtPqfOsOUd
         BBxF0liQrQRRdrE1m/ubhODUtA9hrXYR3LwZHa5NnztqZI6ov3xmdALNXcUE5m7K3pEp
         OHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2quxIf0d8yN8ghhKJunX2F62MmANycmOrivVTAc8TGc=;
        b=gfMEe/tbWo23dyJdnWIrVBti7rO6j2YOnF9QlIccnAg7MUU475CTzU+XnU9yIKV3do
         HVydvFU2fCCfHaA5NZn5eGQF5t5s8CAiCMqk31hCxIo4EwuO49y64ddkUype50lAzxai
         onL+cTB2V8Xj1TaaVA30tsX4WAeq32aUx6vsfoCKoZ5UR5E1wnYSuCPXP35KZaITBDdR
         Z1jMrP8fxwA6wQ0QPYct9rehx4WAaWHEt/ZM8JCY8i59kiOQxlUEn2mrsO3toK4apUMN
         x3ce7n3zv92L9K9zmWO587FDVQuiN7CLBgr/Fx5ANkSK2Bt4AUFZHrj0XPb3+YV4cD1V
         YfSg==
X-Gm-Message-State: APjAAAVzQqasxjbYpdH9FYpiHtq5UEEZcCf5mZ9//up+5BC/NuQIfAAP
        TatLy5kkWX6E39yOs95CcI0nQ5FzDqA=
X-Google-Smtp-Source: APXvYqyLzKxhAlWOnswDExGgxbvY5pYjcbh3sQKrBU+XV9FtTQiZjml55g5KtkdYUjMW/+cF8u3AWg==
X-Received: by 2002:a63:28c:: with SMTP id 134mr20191244pgc.278.1553548213761;
        Mon, 25 Mar 2019 14:10:13 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i64sm24658741pfb.112.2019.03.25.14.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:10:12 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:10:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, david.brown@linaro.org,
        tfiga@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com
Subject: Re: [PATCH v2 3/4] firmware/qcom_scm: Add scm call to handle smmu
 errata
Message-ID: <20190325211010.GC2899@builder>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
 <20180910062551.28175-4-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910062551.28175-4-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09 Sep 23:25 PDT 2018, Vivek Gautam wrote:

> Qcom's smmu-500 needs to toggle wait-for-safe sequence to
> handle TLB invalidation sync's.
> Few firmwares allow doing that through SCM interface.
> Add API to toggle wait for safe from firmware through a
> SCM call.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/firmware/qcom_scm-32.c |  5 +++++
>  drivers/firmware/qcom_scm-64.c | 13 +++++++++++++
>  drivers/firmware/qcom_scm.c    |  6 ++++++
>  drivers/firmware/qcom_scm.h    |  5 +++++
>  include/linux/qcom_scm.h       |  2 ++
>  5 files changed, 31 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
> index 7293e5efad69..2d301ad053f8 100644
> --- a/drivers/firmware/qcom_scm-32.c
> +++ b/drivers/firmware/qcom_scm-32.c
> @@ -639,3 +639,8 @@ int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
>  {
>  	return -ENODEV;
>  }
> +
> +int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool enable)
> +{
> +	return -ENODEV;
> +}
> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
> index 6bf55403f6e3..f13bcabc5d78 100644
> --- a/drivers/firmware/qcom_scm-64.c
> +++ b/drivers/firmware/qcom_scm-64.c
> @@ -590,3 +590,16 @@ int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
>  	return qcom_scm_call_atomic(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
>  				    &desc, &res);
>  }
> +
> +int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool en)
> +{
> +	struct qcom_scm_desc desc = {0};
> +	struct arm_smccc_res res;
> +
> +	desc.args[0] = QCOM_SCM_CONFIG_ERRATA1_CLIENT_ALL;
> +	desc.args[1] = en;
> +	desc.arginfo = QCOM_SCM_ARGS(2);
> +
> +	return qcom_scm_call_atomic(dev, QCOM_SCM_SVC_SMMU_PROGRAM,
> +				    QCOM_SCM_CONFIG_ERRATA1, &desc, &res);
> +}
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 36da0000b37f..5f15cc2e9f69 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -353,6 +353,12 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
>  }
>  EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_init);
>  
> +int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
> +{
> +	return __qcom_scm_qsmmu500_wait_safe_toggle(__scm->dev, en);
> +}
> +EXPORT_SYMBOL(qcom_scm_qsmmu500_wait_safe_toggle);
> +
>  int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val)
>  {
>  	return __qcom_scm_io_readl(__scm->dev, addr, val);
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index bb176107f51e..89a822c23e33 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -103,10 +103,15 @@ extern int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
>  				      u32 spare);
>  #define QCOM_SCM_IOMMU_SECURE_PTBL_SIZE	3
>  #define QCOM_SCM_IOMMU_SECURE_PTBL_INIT	4
> +#define QCOM_SCM_SVC_SMMU_PROGRAM	0x15
> +#define QCOM_SCM_CONFIG_ERRATA1		0x3
> +#define QCOM_SCM_CONFIG_ERRATA1_CLIENT_ALL	0x2
>  extern int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
>  					     size_t *size);
>  extern int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr,
>  					     u32 size, u32 spare);
> +extern int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev,
> +						bool enable);
>  #define QCOM_MEM_PROT_ASSIGN_ID	0x16
>  extern int  __qcom_scm_assign_mem(struct device *dev,
>  				  phys_addr_t mem_region, size_t mem_sz,
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index 6a5d0c98b328..46e6b1692998 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -62,6 +62,7 @@ extern int qcom_scm_set_remote_state(u32 state, u32 id);
>  extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
>  extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
>  extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
> +extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
>  extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>  extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
>  extern int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val);
> @@ -100,6 +101,7 @@ qcom_scm_set_remote_state(u32 state,u32 id) { return -ENODEV; }
>  static inline int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare) { return -ENODEV; }
>  static inline int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size) { return -ENODEV; }
>  static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare) { return -ENODEV; }
> +static inline int qcom_scm_qsmmu500_wait_safe_toggle(bool en) { return -ENODEV; }
>  static inline int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
>  static inline int qcom_scm_io_writel(phys_addr_t addr, unsigned int val) { return -ENODEV; }
>  static inline int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
