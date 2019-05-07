Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97B2C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3FC206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557249982;
	bh=VX7UaZpwHAuzT4Owlz249G0Ocaea71wJwNsipA/mdh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oIJPTxdcBs2nCgNBRZb4YPQKG5SJ8qQWVnHwrAauFcGIEe04qYluRQIm1M+82CjQD
	 8UKtqQ+pdScJFreaINA/d+NFHMvD/o1ABBlGXZFsVnwbKBZp/KcKY8dA2Wz7aCiEaY
	 j35r87VPTre/66WaqTcBim7znfpEZ6JW8DLPqSuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfEGR0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:26:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33170 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfEGR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:26:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so2664060pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7xUhKA1Djcc5MQIlR53po867qGPRwrbga/QPQ1LD+uo=;
        b=A4PHAo1wlZd7tFBxXnCEZ8/z/ylv3DoG24viFnJeuzZ89vv315vjpOQETkuoKNtUSF
         8PUP1mmQrqcT0ItwIABHY8vAWSONjzY5od9SftA9PxaUt6FxFp12Hv3d6c9P0qYhBAN4
         FtAhT0kWc7Nv9jjZYIaMnxSGZxlswWhtTKUEQ4BAX2Crz3gytilw5q+awj/VdrMu3DEz
         LTKs3yUesWWpPi+CS5qVZXyuXcYt9Bhz7DS3RiIJrQWfi+gAYAUqwQwjltc9jPTmSTWs
         Ejkl+C2N4sLYb39syY0+7xFq+QlsN7iimLFaezYreXLTe0aSBzSEz8qPRTObZvcOsW8J
         Q+4g==
X-Gm-Message-State: APjAAAU69lTBa2APKTymB4edzKmEDis3DFNeOpxbKR/J/fFZtTXZO1Kh
        6GsoMgfqNeIJ/1DGleQ89AKX58SmwTPEKQ==
X-Google-Smtp-Source: APXvYqwTXxGxLxNgRqbJh4k9xlUBPop/8tx0s1TxMCPXR+62DZUBh1S3aAKeQZ1/VXnSsdM7K3XLnw==
X-Received: by 2002:a63:90c7:: with SMTP id a190mr41979773pge.23.1557249980344;
        Tue, 07 May 2019 10:26:20 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id h13sm14867749pgk.55.2019.05.07.10.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:26:19 -0700 (PDT)
Date:   Tue, 7 May 2019 10:26:18 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2 02/18] fpga: dfl: fme: remove copy_to_user() in ioctl
 for PR
Message-ID: <20190507172545.GA26690@archbox>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556528151-17221-3-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 04:55:35PM +0800, Wu Hao wrote:
> This patch removes copy_to_user() code in partial reconfiguration
> ioctl, as it's useless as user never needs to read the data
> structure after ioctl.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: clean up code split from patch 2 in v1 patchset.
> ---
>  drivers/fpga/dfl-fme-pr.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index d9ca955..6ec0f09 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -159,9 +159,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  	mutex_unlock(&pdata->lock);
>  free_exit:
>  	vfree(buf);
> -	if (copy_to_user((void __user *)arg, &port_pr, minsz))
> -		return -EFAULT;
> -
>  	return ret;
>  }
>  
> -- 
> 1.8.3.1
> 
