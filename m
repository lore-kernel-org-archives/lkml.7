Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BB7C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835732184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqS301R6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfGQQ4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:56:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42209 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGQQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:56:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so11434530pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eRdvNNXf680pv7D/wawCnGMGaTK8ArdDiNd3rmgruSA=;
        b=OqS301R6mRNRehR4uGTXv0VV1/d8X2+7vTjX40IJdztlF7CzIMf3gdlKs4Pw1YDka6
         ozi9wO9oZxUUrRGTzGu8Whn2pSDRIlKEGO2+krx+DRpJZCgP5HzdMRUQ0NbWIB416Yse
         PI6925mzzQHd1KpPXXFlWZbOgeN/4tsS1S/8ri6Nch+UPiWm+olERXNItaZK3AMI6gZa
         qAl2TeWVJuzYoOrbiBe2iYE3JaALmHSv3AKG0QQ6dxIUNqWCquBedCQfcfg0XPQgU88P
         OSsw1MypUZry4HI6b4AlYcPflWFVtpxhVp2/Wb9x5NhQd0PcJ3pKEX5QJ2MWssneAp8g
         jLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eRdvNNXf680pv7D/wawCnGMGaTK8ArdDiNd3rmgruSA=;
        b=XYA5lk48Dnc104gE1vGn3vLO+t0Djm1Odut57z9keskxexd1FuOPsPOtkm1s+nkzSW
         Qw5xNkO2ndlldyrOdOIDPshByyf9HSYAMDAi3VH7DTPHo2t5OmetXxQrvOf/I5HLQ4/A
         x4NlYRMwpJ+D+ewZiEcggDW+deb0ps32GAfdjVZxNi3SVoA0dZ/E5lpTBe66wEoxRDUz
         9Z/2N0SsKNHQH4PdWcLOV4c5OIQ5gfS14w6MyqY0pxd56chRUh0DSPMNOeKJjAkGm226
         jN9os4cIXTW2n61pS/fnL7+LqTIAM4dDMH/bJhv1l8kbD+XBRl6PnMVM36dDpPg4Oqwi
         340g==
X-Gm-Message-State: APjAAAVmriq/mXxesQ8Dw6q6KJf2m3e6Ph4g81y1pXAxk4lkZBRPa5Dx
        Y/QHoT58UF93Thtg+pUlaCsvmw==
X-Google-Smtp-Source: APXvYqzTrYLK7QiA/TroDZIzFbso2uhc7uRFGpTDcKT52ivkJaDvr5D6L6k0GVFbmjbz8somUyeSIw==
X-Received: by 2002:a63:4846:: with SMTP id x6mr5659707pgk.332.1563382565821;
        Wed, 17 Jul 2019 09:56:05 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e5sm30815070pfd.56.2019.07.17.09.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 09:56:05 -0700 (PDT)
Date:   Wed, 17 Jul 2019 10:56:02 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCHv8 5/5] coresight: cpu-debug: Add support for Qualcomm Kryo
Message-ID: <20190717165602.GA4271@xps15>
References: <cover.1562940244.git.saiprakash.ranjan@codeaurora.org>
 <e2c4cc7c6ccaa5695f25af20c8e487ac53b39955.1562940244.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c4cc7c6ccaa5695f25af20c8e487ac53b39955.1562940244.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 07:46:27PM +0530, Sai Prakash Ranjan wrote:
> Add support for coresight CPU debug module on Qualcomm
> Kryo CPUs. This patch adds the UCI entries for Kryo CPUs
> found on MSM8996 which shares the same PIDs as ETMs.
> 
> Without this, below error is observed on MSM8996:
> 
> [    5.429867] OF: graph: no port node found in /soc/debug@3810000
> [    5.429938] coresight-etm4x: probe of 3810000.debug failed with error -22
> [    5.435415] coresight-cpu-debug 3810000.debug: Coresight debug-CPU0 initialized
> [    5.446474] OF: graph: no port node found in /soc/debug@3910000
> [    5.448927] coresight-etm4x: probe of 3910000.debug failed with error -22
> [    5.454681] coresight-cpu-debug 3910000.debug: Coresight debug-CPU1 initialized
> [    5.487765] OF: graph: no port node found in /soc/debug@3a10000
> [    5.488007] coresight-etm4x: probe of 3a10000.debug failed with error -22
> [    5.493024] coresight-cpu-debug 3a10000.debug: Coresight debug-CPU2 initialized
> [    5.501802] OF: graph: no port node found in /soc/debug@3b10000
> [    5.512901] coresight-etm4x: probe of 3b10000.debug failed with error -22
> [    5.513192] coresight-cpu-debug 3b10000.debug: Coresight debug-CPU3 initialized
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  .../hwtracing/coresight/coresight-cpu-debug.c | 33 +++++++++----------
>  drivers/hwtracing/coresight/coresight-priv.h  | 10 +++---
>  2 files changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 2463aa7ab4f6..96544b348c27 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -646,24 +646,23 @@ static int debug_remove(struct amba_device *adev)
>  	return 0;
>  }
>  
> +static const struct amba_cs_uci_id uci_id_debug[] = {
> +	{
> +		/*  CPU Debug UCI data */
> +		.devarch	= 0x47706a15,
> +		.devarch_mask	= 0xfff0ffff,
> +		.devtype	= 0x00000015,
> +	}
> +};
> +
>  static const struct amba_id debug_ids[] = {
> -	{       /* Debug for Cortex-A53 */
> -		.id	= 0x000bbd03,
> -		.mask	= 0x000fffff,
> -	},
> -	{       /* Debug for Cortex-A57 */
> -		.id	= 0x000bbd07,
> -		.mask	= 0x000fffff,
> -	},
> -	{       /* Debug for Cortex-A72 */
> -		.id	= 0x000bbd08,
> -		.mask	= 0x000fffff,
> -	},
> -	{       /* Debug for Cortex-A73 */
> -		.id	= 0x000bbd09,
> -		.mask	= 0x000fffff,
> -	},
> -	{ 0, 0 },
> +	CS_AMBA_ID(0x000bbd03),				/* Cortex-A53 */
> +	CS_AMBA_ID(0x000bbd07),				/* Cortex-A57 */
> +	CS_AMBA_ID(0x000bbd08),				/* Cortex-A72 */
> +	CS_AMBA_ID(0x000bbd09),				/* Cortex-A73 */
> +	CS_AMBA_UCI_ID(0x000f0205, uci_id_debug),	/* Qualcomm Kryo */
> +	CS_AMBA_UCI_ID(0x000f0211, uci_id_debug),	/* Qualcomm Kryo */
> +	{},
>  };
>  
>  static struct amba_driver debug_driver = {
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 7d401790dd7e..41ae5863104d 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -185,11 +185,11 @@ static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
>  	}
>  
>  /* coresight AMBA ID, full UCI structure: id table entry. */
> -#define CS_AMBA_UCI_ID(pid, uci_ptr)	\
> -	{				\
> -		.id	= pid,		\
> -		.mask	= 0x000fffff,	\
> -		.data	= uci_ptr	\
> +#define CS_AMBA_UCI_ID(pid, uci_ptr)		\
> +	{					\
> +		.id	= pid,			\
> +		.mask	= 0x000fffff,		\
> +		.data	= (void *)uci_ptr	\
>  	}

I will pickup this patch - it will show up in my next tree when rc1 comes out.

Thanks,
Mathieu

>  
>  /* extract the data value from a UCI structure given amba_id pointer. */
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
