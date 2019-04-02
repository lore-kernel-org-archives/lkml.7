Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5786C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739C92075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554217645;
	bh=qA31ACN3B9Jv7zyj/UtiCgpgnTE98PFlUnB2pYzXh0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G/W7qOZ9RTS6PkvdAgzF3RaBYfWIUCxITmUQe5Yrfl0ObLkRo6U43nyo+pztoH/q2
	 t0xW3CfF58njsqZKZHXKt6Na9KaxkPLv2ylkqWo+z1jIwBjjK4OW7zntgTkejraXL7
	 1dbgDX0olpHBMLzV7+ZfPo1Bj8PvNhrGDHCfOkXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfDBPHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:07:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35668 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfDBPHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:07:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id m10so12416006otp.2;
        Tue, 02 Apr 2019 08:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w5CMHmhMeWTXXbeZMl06HEWjmEjDcB5sk0RH6cM/Y+c=;
        b=pE/WK3ju7SgpdW0pydyTTUBQ2pp53dbhhzhtKW48gZamlDXP6q7CYqa6IOe4VG3llf
         HphNo6XuZxFmQVBm2Kd1UOk6cjIU8Y07ss30ERUm0Tb42682O4FWMl2QIMDyciZ8z51E
         CbCvpCtHxX2lGCVqCYK/x2cQRTPrBfGBx19qysWRAKwBg72qgPKJhuy/P+97JURBeD9/
         W4Wz0ni7SqXCbW9ew/gNK7tRnsckrdUfmNyJX0V0PvUDHbmO4/YjunpXDEYNMkqCbu2j
         rntbqUkJAxMKVglxzLBSfE5tAKCoios5J4Hj2up4i465H5Zlc79e9nnFntMgonO8FJau
         M/JQ==
X-Gm-Message-State: APjAAAW5ltFyOuHpo/BPSUMWIRWGVlbB962WQxiO5Mcq7kO3RPwtcH9P
        zqMf10az/m3h66XZi3Esyt8SEV1v9hI=
X-Google-Smtp-Source: APXvYqwrFkOxQy1L9dI3zJJg42QCnFewjTDuYD750GmTCVfcpcP8QVPyYnLfPkcVXQjI6A4P1ohs+g==
X-Received: by 2002:a9d:3de5:: with SMTP id l92mr49527432otc.200.1554217641349;
        Tue, 02 Apr 2019 08:07:21 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id r25sm5394128otk.37.2019.04.02.08.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:07:20 -0700 (PDT)
Date:   Tue, 2 Apr 2019 08:07:19 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 12/17] fpga: dfl: afu: add STP (SignalTap) support
Message-ID: <20190402150719.GB15773@archbook>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-13-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553483264-5379-13-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wu,

On Mon, Mar 25, 2019 at 11:07:39AM +0800, Wu Hao wrote:
> STP (SignalTap) is one of the private features under the port for
> debugging. This patch adds private feature driver support for it
> to allow userspace applications to mmap related mmio region and
> provide STP service.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-afu-main.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 754729e..14970a4 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -518,6 +518,36 @@ static const struct dfl_feature_ops port_afu_ops = {
>  	.uinit = port_afu_uinit,
>  };
>  
> +static int port_stp_init(struct platform_device *pdev,
> +			 struct dfl_feature *feature)
> +{
> +	struct resource *res = &pdev->resource[feature->resource_index];
> +
> +	dev_dbg(&pdev->dev, "PORT STP Init.\n");
> +
> +	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
> +				   DFL_PORT_REGION_INDEX_STP,
> +				   resource_size(res), res->start,
> +				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
> +				   DFL_PORT_REGION_WRITE);
> +}
> +
> +static void port_stp_uinit(struct platform_device *pdev,
> +			   struct dfl_feature *feature)
> +{
> +	dev_dbg(&pdev->dev, "PORT STP UInit.\n");
> +}
> +
> +static const struct dfl_feature_id port_stp_id_table[] = {
> +	{.id = PORT_FEATURE_ID_STP,},
> +	{0,}
> +};
> +
> +static const struct dfl_feature_ops port_stp_ops = {
> +	.init = port_stp_init,
> +	.uinit = port_stp_uinit,
> +};
> +
>  static struct dfl_feature_driver port_feature_drvs[] = {
>  	{
>  		.id_table = port_hdr_id_table,
> @@ -532,6 +562,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
>  		.ops = &port_err_ops,
>  	},
>  	{
> +		.id_table = port_stp_id_table,
> +		.ops = &port_stp_ops,
> +	},
> +	{
>  		.ops = NULL,
>  	}
>  };
> -- 
> 2.7.4
> 

Thanks,
Moritz
