Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8798C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A610A207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dRCMPRmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390337AbfFJN2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:28:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36322 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389624AbfFJN2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:28:51 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so5516081qkl.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QuNGikApppPlg0NjWKKrBOd/y46mu13TvQokHY9jymY=;
        b=dRCMPRmC4+wostK1DLkuHVBJYkHjafHfZyRDoauespSItE5FxreYUh5iJ4zrJNYE/s
         knM+UwfJmj4GQfOa9BSME1zKsqYtD1sa/Y6Ud7giKFp1StdGQDTLbD3n8VPshrHMnEA0
         AK+QgF3y7Z0XAz+xCC3ddz3b+WtcpFneogqYuq1NmW1fHOPeATrqTaFnTGhmdeunVGo5
         ouVQOTzLrIDjHSwasVdcx+fd8e6jdXy60K0blnK9H5rdMKRlof13acfz6EvA52YHUdTd
         gHodtboDZ6WulBSLFdAZLcjjX/UZZtR+AqfqCpoJ872IjCZDE49jWI47okyhXLbf1EZu
         2ZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QuNGikApppPlg0NjWKKrBOd/y46mu13TvQokHY9jymY=;
        b=IxRnZpw+iIoSGwMlyjWqi7gr+6RDk0k8o8HVSRrviVQPeMHwvM14VKF8nJPcRlUkKN
         RoH78TcqRVS1XGo8zDE9p/fwVXbhqQfkG+GV8zbP5Q0waVycpMTyD/N6hPq0mqZBsaVr
         m1u5Q9sKOHvHXgf5Rz1fYRcoO2M5XTwmbRE13yaMroa3y474/KR5pOsUFXo5+46ScinT
         YK+PV05wyk11R745h4gSsuJxcKi2zXmoZqghlhtm2PWlJOo6jmYknHtxYCEtZR8uOoQk
         GIuO8LLIaZSaXDLvAtQQSPYkaLXJLGDiZA6XzLLQcOb145ShEEEEaxssWya+ILpjelHq
         C0qQ==
X-Gm-Message-State: APjAAAXgqOdo/DyTEEDe7duQuB9c18wVg4koxLQDMtOb7t85CoHrc2JE
        Vy/jWvl8f3N9bET50hDdVsMUug==
X-Google-Smtp-Source: APXvYqw9KHhM3oHMB8yDNq7/Zm1qKpKlNMxma8Rlg6pAIXhuhNWj8ray+L0bOOV4P9zgblFWFYvlnw==
X-Received: by 2002:a37:9a50:: with SMTP id c77mr55972280qke.12.1560173330662;
        Mon, 10 Jun 2019 06:28:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j9sm4706582qkg.30.2019.06.10.06.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 06:28:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1haKLx-0001qn-Sk; Mon, 10 Jun 2019 10:28:49 -0300
Date:   Mon, 10 Jun 2019 10:28:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: prevent undefined shift in set_user_sq_size()
Message-ID: <20190610132849.GD18468@ziepe.ca>
References: <20190608092231.GA28890@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608092231.GA28890@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 12:22:31PM +0300, Dan Carpenter wrote:
> The ucmd->log_sq_bb_count is a u8 that comes from the user.  If it's
> larger than the number of bits in an int then that's undefined behavior.
> It turns out this doesn't really cause an issue at runtime but it's
> still nice to clean it up.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> index 5221c0794d1d..9f6eb23e8044 100644
> --- a/drivers/infiniband/hw/mlx4/qp.c
> +++ b/drivers/infiniband/hw/mlx4/qp.c
> @@ -439,7 +439,8 @@ static int set_user_sq_size(struct mlx4_ib_dev *dev,
>  			    struct mlx4_ib_create_qp *ucmd)
>  {
>  	/* Sanity check SQ size before proceeding */
> -	if ((1 << ucmd->log_sq_bb_count) > dev->dev->caps.max_wqes	 ||
> +	if (ucmd->log_sq_bb_count > 31					 ||
> +	    (1 << ucmd->log_sq_bb_count) > dev->dev->caps.max_wqes	 ||

Surely this should use check_shl_overflow() ?

Jason
