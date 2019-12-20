Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC50C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4097206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGomQ9fF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLTTEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:04:31 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52865 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTTEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:04:30 -0500
Received: by mail-pj1-f68.google.com with SMTP id w23so4504884pjd.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 11:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qGjb7eWoCkZSqsMkOMbh0emAlLhfNF+XZ0Dr2/fwtoA=;
        b=TGomQ9fFTiqX2VOyWk437Wi8Jo5ypgF7XDqRU+xa96kpKduPCd6PaJsmUCnNrz/wXX
         FRHkyWn2qIhKM5nIuGM3ctTolrpcNhhMNYuzDl1kzW6UBYupI8DnJVGdEEcAFeDXFtP6
         T1qCJwjEc31LWZWPuiPQJOr/mLInHC+UXSLY7rBWrdZc8eQ1NRIu1Uugog/4KhfwJ58u
         akT5RL2PCWMxASEyobnHn9/hOxXoIn2SLvJR3RMadPTP9QpyQNllsZ/A03FW0fkHqRCu
         SzSihvCIAzAWnH0m3XlMZskEUM+Ced6YWCQSrbrOc6fUva4ICP3C6/z5a+PtTW2By8wr
         KavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qGjb7eWoCkZSqsMkOMbh0emAlLhfNF+XZ0Dr2/fwtoA=;
        b=j2hKvkAzNfdCOSj8YzSb27Bj/Vz+AV80Xjyj4IJHslP+bNDd6dN9Wz9d0k0YqZDtmj
         7g5dQ3Nw3lGL4XLai3j/WcBFhdws465xK5KI8p6tuDkrh6gfm09d+nHmqHeK8Xp3jHV2
         Ec19nv5cJsKF4k8hrGvt1sDx4t04JMBshbWZ8f1jZlrZd1ueZJKPsSxUT5hgGKnTFIqi
         WyzJopoyF6iGHl4pJh5+F8A26IvL/G0EYt5ruEBCkdr+va9S+4KvW16/yqIOnMe1UDJD
         0i4hkY4ts55UWQl/u0YVLrgyTCSzacSPPYNBJE4jBGux3oBZgsDdOXSBhY+mjyAppumF
         HlmA==
X-Gm-Message-State: APjAAAUDjwYIApy0aaD4d+r/rD1c35gyYMvjpvGikZMcPrMsfVMSFZDB
        3REfB+VAXCN0//ec0dCGmdQuxA==
X-Google-Smtp-Source: APXvYqzj/ieFQoyLUA0Oa0WPwtOBqCvbXDqpN+HBNirj9Qp2WbSOWzuFCEJ2uvBjwxdDq5q2WV103Q==
X-Received: by 2002:a17:902:7c0d:: with SMTP id x13mr16807903pll.85.1576868669546;
        Fri, 20 Dec 2019 11:04:29 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m22sm13172633pgn.8.2019.12.20.11.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 11:04:28 -0800 (PST)
Date:   Fri, 20 Dec 2019 11:04:26 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        jcrouse@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Check for valid path in icc_set_bw()
Message-ID: <20191220190426.GE549437@yoga>
References: <20191220171310.24169-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220171310.24169-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Dec 09:13 PST 2019, Georgi Djakov wrote:

> Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 63c164264b73..14a6f7ade44a 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -498,6 +498,11 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  	if (!path || !path->num_nodes)
>  		return 0;
>  
> +	if (IS_ERR(path)) {

This is a sign of a logical error, and the print is likely to be
ignored/lost in the noise. So I think the response should aid to help
the developer hitting this to resolve the issue.

So I think this is more visible and more useful as:

	if (WARN_ON(IS_ERR(path)))
		return -EINVAL;


PS. Doesn't path->num_nodes == 0 fall in this category as well? When
would you have a path object with no nodes passed to this function?

Regards,
Bjorn

> +		pr_err("%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> +		return -EINVAL;
> +	}
> +
>  	mutex_lock(&icc_lock);
>  
>  	old_avg = path->reqs[0].avg_bw;
