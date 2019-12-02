Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FADC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992B520640
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfEK9ER1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfLBRhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:37:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33753 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfLBRhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:37:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id y206so10141pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lio+2kp4wy6jj0nVNYlYlFqccYHlkpvhpP9pJwIiJYw=;
        b=GfEK9ER1iXcxBhlq61EilfAMcKofLSDC9W2o85uPKvDzj9lH+stqhUMOQOJ5gPF7j/
         cPF+hvtuEiRrUt4xwz7VGxHt5dZvdf5DniPiIX81i6NaHt76te7FVpnRA10LnWUKLEb9
         PYmPOQ40EGdkTDZ1Q5xgwv+J9ymj0AJspngh74y4xTkmdH/N0KazI+edw5R4jfQcyYm2
         FT4Ll3kuF2oRIQmSfoXCkW9K2prYA0kxohCix2SB8eL9DGJnDyz98p3lzsDbm67nB/eX
         viGYnI0FJ0Iz7m7SHQnuyzH/ghctHJ3CvGNpm9tA7hM0tqLbz0sNyWDjo8Ji90v0Ourm
         8Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lio+2kp4wy6jj0nVNYlYlFqccYHlkpvhpP9pJwIiJYw=;
        b=BIyAI1j3OpCsf91oo3Y0sBJ1jOO3dBm3k0mZ1JPJ3iwRqTch53Vub2wDuDe/DMiVqL
         +X8n2Deobe0d4UFVDDRFVgZE6jZKBX7OH5J9ayMOdFISJRLwEaTghtmO5U7oW4drV3Ch
         VsVpvvRJz2+bLhbi9nDgxq+XDn/yMtlwZCC2YQjfTTxIf266y2KPofsXlEF/ZnZCrzJX
         iaYwMthZFOayPMF2P+YzKeumtK4PGhUBPiILjvrv39K5E62qqf1wmOCbVNXmpQyq0L/9
         KRPKg6EIsYsPBBE2J7Y0xohVITuUF6DIf1jBQvsdneZFPzwpwMkPVmaTcD+uFdnvKp2l
         Nrbg==
X-Gm-Message-State: APjAAAXnpzSCSIKw6O3sYTwD34Emrt51dSqKr2bjXd2l48QGC7xl5YUh
        Vk5gEqglWxn/A5a6pOV/PL96EQ==
X-Google-Smtp-Source: APXvYqz9r4TL/LW5o7Y4LjEsE7VzLNJdr8ao4lc34HY+hPGpbjc/bCcXvDhjs++dRCWI76xTBvh9fQ==
X-Received: by 2002:a63:fc09:: with SMTP id j9mr190881pgi.272.1575308244568;
        Mon, 02 Dec 2019 09:37:24 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f69sm37653pje.32.2019.12.02.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 09:37:23 -0800 (PST)
Date:   Mon, 2 Dec 2019 09:37:21 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] interconnect: qcom: qcs404: Walk the list safely
 on node removal
Message-ID: <20191202173721.GC133384@yoga>
References: <20191202162133.7089-1-georgi.djakov@linaro.org>
 <20191202162133.7089-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202162133.7089-2-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Dec 08:21 PST 2019, Georgi Djakov wrote:

> As we will remove items off the list using list_del(), we need to use the
> safe version of list_for_each_entry().
> 
> Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/interconnect/qcom/qcs404.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
> index 5e5843e6bd06..9064f6bdaa69 100644
> --- a/drivers/interconnect/qcom/qcs404.c
> +++ b/drivers/interconnect/qcom/qcs404.c
> @@ -405,7 +405,7 @@ static int qnoc_probe(struct platform_device *pdev)
>  	struct icc_provider *provider;
>  	struct qcom_icc_node **qnodes;
>  	struct qcom_icc_provider *qp;
> -	struct icc_node *node;
> +	struct icc_node *node, *tmp;
>  	size_t num_nodes, i;
>  	int ret;
>  
> @@ -485,7 +485,7 @@ static int qnoc_probe(struct platform_device *pdev)
>  
>  	return 0;
>  err:
> -	list_for_each_entry(node, &provider->nodes, node_list) {
> +	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
>  		icc_node_del(node);
>  		icc_node_destroy(node->id);
>  	}
> @@ -499,9 +499,9 @@ static int qnoc_remove(struct platform_device *pdev)
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
