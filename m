Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE6CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E33120848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cu2g+wKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfCATGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:06:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34152 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCATGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:06:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so11926516plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 11:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L88XtZxTe62or1D+YkPCGQLbuM6OCA6lGZWusHZ14yE=;
        b=cu2g+wKDEDWpMkUCQ9aFfNxVavxDibIGB2KMiO07m3MQYbvYb/Dwt5MTELq90CtD0O
         FLinlFxK/JV8wkjxVfTFSO6px0ycc4Mf1+zI/Pq6spofXqUIQAhIwIFDBQVgMxpdERcU
         dcv84HHa1r9r+wbwerklUH/OFoN4vRz2XZ1HfE3esbAKWlCFsbe/hzKOBPW88M/uwOUD
         BiJWdvh2xSR7QbVU9ybSewPpUQzE1LzNQ+PYwa+Eu4Xd+AkB3x3l/iVzuWei96ykOREC
         Ph+ozu7U9RUTx4P6qtEa8ofhEQksjaOQyo9Or4BsIuPeIYH9ut486YA+RT8TpKbj2Yuo
         cqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L88XtZxTe62or1D+YkPCGQLbuM6OCA6lGZWusHZ14yE=;
        b=KrA5FDX31+/WnrtkWGCcenoTkZiv53bJOJRWo8NC6jNDNbNq5EqgOrNhsr2G06TJ9E
         cHbKMfzNzT2QVOZDhilBnFNRmHmf+EjY2cOkXawh42lda/JvgC73cHNzX8b0IIpWhqaK
         UeQk2RMtLQQmN2rm1kkHpOEMIZNRl3oer1980WybOdqSg+fG0iHN6q4ghYin/1/4X65U
         YNGKnTEG8peByrNJaFEmkkev+2QmDYdBl4Qs3OP3X/Qnm4IxN4ATHW2D7higutT2TC53
         8YB0YmWv6Vxg04UvGVvI3N9PqysfJHhtcRzcKubThTzIRmKns5rqc+gJmgI3VdpayD2D
         jHsA==
X-Gm-Message-State: APjAAAXW+gQJwo8AUuG1kD1zuvbq5X+foCKvrY29hRMO6XtNA96TrMas
        z1FbVSTRgdEQYi3Zf3bk5iDw8dDT4R8=
X-Google-Smtp-Source: APXvYqwnaCPAUQekldpYzFlARRZ13oKWqY5xCV28Cl+Os9tJ3eK2crpZ94l6w/AwnaoXaBiqKvYlcA==
X-Received: by 2002:a17:902:7293:: with SMTP id d19mr6745140pll.29.1551467203023;
        Fri, 01 Mar 2019 11:06:43 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 23sm30948103pfn.2.2019.03.01.11.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 11:06:41 -0800 (PST)
Date:   Fri, 1 Mar 2019 11:07:21 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: cmd-db: Fix an error code in
 cmd_db_dev_probe()
Message-ID: <20190301190721.GA27005@builder>
References: <20190228054849.GD3253@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228054849.GD3253@kadam>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Feb 21:48 PST 2019, Dan Carpenter wrote:

> The memremap() function doesn't return error pointers, it returns NULL.
> This code is returning "ret = PTR_ERR(NULL);" which is success, but it
> should return -ENOMEM.
> 
> Fixes: 312416d9171a ("drivers: qcom: add command DB driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Thanks Dan, picking this up.

Regards,
Bjorn

>  drivers/soc/qcom/cmd-db.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index c701b3b010f1..f6c3d17b05c7 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -248,8 +248,8 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
>  	}
>  
>  	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
> -	if (IS_ERR_OR_NULL(cmd_db_header)) {
> -		ret = PTR_ERR(cmd_db_header);
> +	if (!cmd_db_header) {
> +		ret = -ENOMEM;
>  		cmd_db_header = NULL;
>  		return ret;
>  	}
> -- 
> 2.17.1
> 
