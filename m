Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98680C43141
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8B020865
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7ZnUsqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfLBRgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:36:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37361 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfLBRgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:36:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id s18so4643269pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 09:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZLDRcf9R3qpOVnnwnDFldyhfXKXjt9qehVq6fkac+TY=;
        b=k7ZnUsqLGtyMK43KXkw21LCChUvZKCRkgQmJTN1l2FhAFa0MmfXvUV6NFy6oink1pt
         fhqa4JwnGPvlzCJss1OK8dTGuHesEgAca3jyhTzXXSWwVA4lBaMqwOMXRIOMV59wanD+
         x2pr9qm1++Z1mPm54Bfco8X1x/hJ0YTCzWXVBkZ3qGG6QzWvjastlvBXH399lo+Us5Hp
         WnVqcns9UZ+x/5MQ6fmUhzQpKQPkyUehy6oyz0BtLbOOpFfOsu32mzdgXKRrcsj9XQ56
         2GyiJyE0+RMrHanAWhSnmKH+yWqjTwje5X+G53OAQ9JLE59KI7oMv4ZzD2h0NMUex2O0
         86qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZLDRcf9R3qpOVnnwnDFldyhfXKXjt9qehVq6fkac+TY=;
        b=gvD1CJSJJc0zcem2U9GFPIWOSSCWBoZH7VaCrGOaiWEJhBl/8diyKe6zVzHTUe76/q
         DIbbx+pNHg6JbAXGfIZd2cPHeAZdLg/uprKaUWfJjQD+ipdjdIYhrGNzQx6tlH7Lfbm+
         G/3IovqJXbEDeu++1DmXq05vSE9nHRm8uqkKSunkf3G3uWIlS45Un/vH8ECOoMcQYF2S
         FmCOwYbx9Mn6xffwxe2ylyXDKaW1yFPBme4Bzo3raeP/rsPIUm9KUQDuKWBIgIL8lauD
         /qvkcCa33G5TnAbT84IRzaluqf+cBBxakFnadwhsx2OPAZQV4kn/1F7Y9NNTN1w4C10A
         sHlA==
X-Gm-Message-State: APjAAAW4FShmGH9XST9hm55YP0v7yCBpFP5hH2gdjBHMkCsUgrb/YeTN
        R7kxCC/jcpOdifm/359mTyLtKw==
X-Google-Smtp-Source: APXvYqzH2B3cv4DZxaTJNNjSW7RXGFthkitfYHL7fPc4rD4iXyh+c8EBIG6Z/q9X/VDJ7qmJn5mnjA==
X-Received: by 2002:a65:621a:: with SMTP id d26mr143832pgv.151.1575308214211;
        Mon, 02 Dec 2019 09:36:54 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r14sm99964pfh.10.2019.12.02.09.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 09:36:53 -0800 (PST)
Date:   Mon, 2 Dec 2019 09:36:50 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] interconnect: qcom: sdm845: Walk the list safely
 on node removal
Message-ID: <20191202173650.GB133384@yoga>
References: <20191202162133.7089-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202162133.7089-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Dec 08:21 PST 2019, Georgi Djakov wrote:

> As we will remove items off the list using list_del(), we need to use the
> safe version of list_for_each_entry().
> 
> Fixes: b5d2f741077a ("interconnect: qcom: Add sdm845 interconnect provider driver")
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> v2:
> - Fix the number of parameters that got messed up. (Bjorn)
> 
>  drivers/interconnect/qcom/sdm845.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index 502a6c22b41e..387267ee9648 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -868,9 +868,9 @@ static int qnoc_remove(struct platform_device *pdev)
>  {
>  	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
>  	struct icc_provider *provider = &qp->provider;
> -	struct icc_node *n;
> +	struct icc_node *n, *tmp;
>  
> -	list_for_each_entry(n, &provider->nodes, node_list) {
> +	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
>  		icc_node_del(n);
>  		icc_node_destroy(n->id);
>  	}
