Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95B8C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02DA20865
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwIOVoNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfLBRkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:40:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46847 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfLBRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:40:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id y10so2892200pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 09:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hyAeLi8mzrAljg+oqlKweKC1x2LO84uDajOvbhKEc6o=;
        b=cwIOVoNj8BFAQnp6JkEeOfVeTVfoNVLdKQ1CTI59N9fU7j9SrPSvsQG2dmS6Roklsz
         zDHKDfgCImDnFN8XF0fkzU8+2ywFUDS8CDovjbvr4t+bacSts/Xzwi+F4oamgJFsK05d
         Hx/sF+MYP+1HUDj8YPmprAZNVaqQs3pffPlMLnh9K9Ggv+1iuxk8I0vNNADr1GDgZGEf
         QDi+vTkHKWfaNIWfuZwOBN0EC5gRzdCyBzNiNiJmvP0vcFhejyLTQDNxvoS8veZNVeL3
         QwIkbCcyqF3tGSS4RE26mEuMLwcvH5bxkhzyWl8Nx6ZF6pTSrhbViAq/+TIlt1Q4lxQ7
         vTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hyAeLi8mzrAljg+oqlKweKC1x2LO84uDajOvbhKEc6o=;
        b=fK3G1EuY7Fm/b7a493Xzvqfw5Sy44/lm2J+s2yZsM2lgDQYT5kWCwKf+MKvruY153k
         Y3YXVQx2KeJ0w10humWLfJWaqP1UCYCTegbACjO6y7/6MYVYmN5zye4yvCTUZ8j/DAio
         BB93nl+A64ctBFxXELyTuKcxJgtoag6Q/Pm7fMA1bi4R7j/r22EZ0GhWrgYZuWj7/O+W
         y4AvVNBp6VHdYntxv1Dxbxbsabt725UhnvPlTTDvbVQHLIZs7M/MntM4I+CcadYKK2og
         H419YKhCxdld3kLu1UBN+2VCrswv8w98e0OgwqDEKT+r9n4UgCNYGlS5l6/YieCs9cnj
         3eqQ==
X-Gm-Message-State: APjAAAXo9HsfoPzyKIgODbO9do/5uoYtcUOME8rlNk01AMm8gqbYzNjk
        xqjSGh6ZQHfsXA82eAFGgMXqEA==
X-Google-Smtp-Source: APXvYqw/2Be/C4XxVxo1CEdS6TiMz6AGfb519d+Ziji+JEmMMF5nHQW9dkec9gBcbb6VDLK7vvR1gg==
X-Received: by 2002:aa7:91d2:: with SMTP id z18mr48739048pfa.97.1575308423712;
        Mon, 02 Dec 2019 09:40:23 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w6sm180989pge.92.2019.12.02.09.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 09:40:22 -0800 (PST)
Date:   Mon, 2 Dec 2019 09:40:20 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] interconnect: qcom: Use the new common helper for
 node removal
Message-ID: <20191202174020.GE133384@yoga>
References: <20191202162133.7089-1-georgi.djakov@linaro.org>
 <20191202162133.7089-5-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202162133.7089-5-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Dec 08:21 PST 2019, Georgi Djakov wrote:

> There is a new helper function for removing all nodes. Let's use it instead
> of duplicating the code.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> v2:
> - Don't call qnoc_remove() directly from probe. (Dmitry)
> 
>  drivers/interconnect/qcom/msm8974.c | 17 ++++-------------
>  drivers/interconnect/qcom/qcs404.c  | 17 ++++-------------
>  drivers/interconnect/qcom/sdm845.c  | 16 +++-------------
>  3 files changed, 11 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
> index ca25f31e5f0b..3a313e11e73d 100644
> --- a/drivers/interconnect/qcom/msm8974.c
> +++ b/drivers/interconnect/qcom/msm8974.c
> @@ -643,7 +643,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct icc_onecell_data *data;
>  	struct icc_provider *provider;
> -	struct icc_node *node, *tmp;
> +	struct icc_node *node;
>  	size_t num_nodes, i;
>  	int ret;
>  
> @@ -723,10 +723,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_del_icc:
> -	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
> -		icc_node_del(node);
> -		icc_node_destroy(node->id);
> -	}
> +	icc_nodes_remove(provider);
>  	icc_provider_del(provider);
>  
>  err_disable_clks:
> @@ -738,16 +735,10 @@ static int msm8974_icc_probe(struct platform_device *pdev)
>  static int msm8974_icc_remove(struct platform_device *pdev)
>  {
>  	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
> -	struct icc_provider *provider = &qp->provider;
> -	struct icc_node *n, *tmp;
>  
> -	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
> -		icc_node_del(n);
> -		icc_node_destroy(n->id);
> -	}
> +	icc_nodes_remove(&qp->provider);
>  	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> -
> -	return icc_provider_del(provider);
> +	return icc_provider_del(&qp->provider);
>  }
>  
>  static const struct of_device_id msm8974_noc_of_match[] = {
> diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
> index 9064f6bdaa69..d4769a5ea182 100644
> --- a/drivers/interconnect/qcom/qcs404.c
> +++ b/drivers/interconnect/qcom/qcs404.c
> @@ -405,7 +405,7 @@ static int qnoc_probe(struct platform_device *pdev)
>  	struct icc_provider *provider;
>  	struct qcom_icc_node **qnodes;
>  	struct qcom_icc_provider *qp;
> -	struct icc_node *node, *tmp;
> +	struct icc_node *node;
>  	size_t num_nodes, i;
>  	int ret;
>  
> @@ -485,10 +485,7 @@ static int qnoc_probe(struct platform_device *pdev)
>  
>  	return 0;
>  err:
> -	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
> -		icc_node_del(node);
> -		icc_node_destroy(node->id);
> -	}
> +	icc_nodes_remove(provider);
>  	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
>  	icc_provider_del(provider);
>  
> @@ -498,16 +495,10 @@ static int qnoc_probe(struct platform_device *pdev)
>  static int qnoc_remove(struct platform_device *pdev)
>  {
>  	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> -	struct icc_provider *provider = &qp->provider;
> -	struct icc_node *n, *tmp;
>  
> -	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
> -		icc_node_del(n);
> -		icc_node_destroy(n->id);
> -	}
> +	icc_nodes_remove(&qp->provider);
>  	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> -
> -	return icc_provider_del(provider);
> +	return icc_provider_del(&qp->provider);
>  }
>  
>  static const struct of_device_id qcs404_noc_of_match[] = {
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index 387267ee9648..f078cf0fce56 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -855,11 +855,7 @@ static int qnoc_probe(struct platform_device *pdev)
>  
>  	return ret;
>  err:
> -	list_for_each_entry(node, &provider->nodes, node_list) {
> -		icc_node_del(node);
> -		icc_node_destroy(node->id);
> -	}
> -
> +	icc_nodes_remove(provider);
>  	icc_provider_del(provider);
>  	return ret;
>  }
> @@ -867,15 +863,9 @@ static int qnoc_probe(struct platform_device *pdev)
>  static int qnoc_remove(struct platform_device *pdev)
>  {
>  	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> -	struct icc_provider *provider = &qp->provider;
> -	struct icc_node *n, *tmp;
> -
> -	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
> -		icc_node_del(n);
> -		icc_node_destroy(n->id);
> -	}
>  
> -	return icc_provider_del(provider);
> +	icc_nodes_remove(&qp->provider);
> +	return icc_provider_del(&qp->provider);
>  }
>  
>  static const struct of_device_id qnoc_of_match[] = {
