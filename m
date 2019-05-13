Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C2C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEE321019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JdfUvZvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfEMQSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:18:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34310 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbfEMQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:18:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id w7so6741349plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6+MQaTsVJQJSSNxT2mZEbP74D/A7peyG2T/rPYLLsDo=;
        b=JdfUvZvYGDdVocnng1PLH23mptubsZoncwQugjqyn/7BY7LJI/ttP0jmsTDZv6twWn
         DwHP3Hh2ytvh6KsT/ThvEHQ/1b4NKEzTklv1Y/5YeElkwnqIankILMWHyXhCU3vGq0mN
         XBe6vvP0ztLSxaIm0V1N7qOYgICInr51AhSDDYtNwyEBc78dJYFmDUdPctVYH1CoJmXF
         n7Mt/DiytbF9mK3VKZoYKDpA/2D1ktIi30rxm3A6ZnIoIdcVX+ywAIQtbimWFPMuZVV1
         0cKujqi8SyaxV4HrCmn9c4Il4ADy6PLmNa//x7nzHnfqG1VcVoXrxx/5AsDk1skcTFZ2
         PtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6+MQaTsVJQJSSNxT2mZEbP74D/A7peyG2T/rPYLLsDo=;
        b=q6oaR7PvSiu8v1MycozDc/a632iVcNclngq/++m6V2D4bLDqDbsF5gZk7lnHkxyE9/
         ujBbYA0My5dx9ptsxmUbCCw8WOk4til+45LpDSDmcoppOm79IZ0WPH0AIhEq1XVYV85o
         8AmDpyJNhk9VJG3uifXyMrXw4GhG7tVMpUNea6JhQmAWpCFfPEtv7pJgz3cRwMxpgukX
         6mEXzCE0zsopw11/CQmWyTV8R8x4Raf84QG6O/pGoynUGmsxUIX3Ks/9cK37RAZwC/bZ
         ue+PPwCZyI0foZavx9o2MFhrREMB51HCqDYSiyYgoxtSdIF8Ck/z3+0hc7iKPOljIVQK
         KYOQ==
X-Gm-Message-State: APjAAAVJrasitFZN4TD/AdZlzfPpbIvw/1m5ip3/6fSLQXbGTeX/ouTM
        ixusxSItJVYxlJzZw7eE92615yg8ab4=
X-Google-Smtp-Source: APXvYqxVd4aJV+d2m1lSilccmVOCeC9ZR8invejgr27Q9HyJZ6lw1fGD46Qe7pX39DCQBBxfwNebDA==
X-Received: by 2002:a17:902:7241:: with SMTP id c1mr31608992pll.326.1557764315552;
        Mon, 13 May 2019 09:18:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n9sm17553093pff.59.2019.05.13.09.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 09:18:34 -0700 (PDT)
Date:   Mon, 13 May 2019 10:18:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, rjw@rjwysocki.net,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v3 15/30] coresight: Make sure device uses DT for
 obsolete compatible check
Message-ID: <20190513161832.GA16162@xps15>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
 <1557226378-10131-16-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557226378-10131-16-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:52:42AM +0100, Suzuki K Poulose wrote:
> As we prepare to add support for ACPI bindings, let us make sure we do
> the compatible check only if we are sure we are dealing with a DT based
> system.
> 
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-funnel.c     | 3 ++-
>  drivers/hwtracing/coresight/coresight-replicator.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 6236a84..3423042 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -196,7 +196,8 @@ static int funnel_probe(struct device *dev, struct resource *res)
>  		dev->platform_data = pdata;
>  	}
>  
> -	if (of_device_is_compatible(np, "arm,coresight-funnel"))
> +	if (is_of_node(dev_fwnode(dev)) &&
> +	    of_device_is_compatible(dev->of_node, "arm,coresight-funnel"))
>  		pr_warn_once("Uses OBSOLETE CoreSight funnel binding\n");
>  
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index ee6ad34..7e05145 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -187,7 +187,8 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  		dev->platform_data = pdata;
>  	}
>  
> -	if (of_device_is_compatible(np, "arm,coresight-replicator"))
> +	if (is_of_node(dev_fwnode(dev)) &&
> +	    of_device_is_compatible(dev->of_node, "arm,coresight-replicator"))
>  		pr_warn_once("Uses OBSOLETE CoreSight replicator binding\n");

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> -- 
> 2.7.4
> 
