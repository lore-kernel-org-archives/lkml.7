Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C94C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5076320863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a+3u+Mwh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iH+U4H/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfCZKXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:23:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZKXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:23:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD03661154; Tue, 26 Mar 2019 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553595798;
        bh=X6u/sYI+7dsjstLntcFvfZYdl2NkMbrF3N97k6hNR+4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a+3u+MwhVqpqgrrlDjNbXO/QVxj5Upk3HMsM+bb4R/I/sTv5p9qENcePHTMvbWMyY
         Q9cMnlrNuDu6FMeAeMZxVYgwbMn2UX0+BoP4Moo9725GrU5KHjOuZ/9LpNSLvyOi6+
         3q9j89I4qokIS77DZe53s86L6B5TFsaW5FgKVtkM=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7794360A60;
        Tue, 26 Mar 2019 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553595797;
        bh=X6u/sYI+7dsjstLntcFvfZYdl2NkMbrF3N97k6hNR+4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iH+U4H/rBDraEE3csc93IqTD+WX3dao2xhp86m39hOHSdOLWKc945rtWCAD9dMIzM
         07ijtiIP2Bkxt2q11sh2eMPP1wXCUlDAtur6N/Bb4V4e7rfiQqoaPGiuoPRLJjlVcl
         +eYIXEZcQOzoE5c+3iNIruWICOMJSij0oabkWNwM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7794360A60
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v4] nvdimm: btt_devs: fix a NULL pointer dereference
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
References: <20190325215527.12574-1-pakki001@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <5fa84f18-7253-2543-57e4-6a9e2b2da716@codeaurora.org>
Date:   Tue, 26 Mar 2019 15:53:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325215527.12574-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/2019 3:25 AM, Aditya Pakki wrote:
> In case kmemdup fails, the fix releases resources and returns to
> avoid the NULL pointer dereference.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>
> ---
> v3: Move kfree(nd_btt) to goto block.
> v2: Replace incorrect kfree with ida_simple_remove, suggested by
> Johannes Thumshirn
> v1: Free nd_btt->id in case of failure and avoid double free, suggested
> by Dan Williams
> ---
>   drivers/nvdimm/btt_devs.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
> index b72a303176c7..9486acc08402 100644
> --- a/drivers/nvdimm/btt_devs.c
> +++ b/drivers/nvdimm/btt_devs.c
> @@ -198,14 +198,15 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
>   		return NULL;
>   
>   	nd_btt->id = ida_simple_get(&nd_region->btt_ida, 0, 0, GFP_KERNEL);
> -	if (nd_btt->id < 0) {
> -		kfree(nd_btt);
> -		return NULL;
> -	}
> +	if (nd_btt->id < 0)
> +		goto out_nd_btt;
>   
>   	nd_btt->lbasize = lbasize;
> -	if (uuid)
> +	if (uuid) {
>   		uuid = kmemdup(uuid, 16, GFP_KERNEL);
> +		if (!uuid)
> +			goto out_put_id;
> +	}
>   	nd_btt->uuid = uuid;
>   	dev = &nd_btt->dev;
>   	dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
> @@ -220,6 +221,13 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
>   		return NULL;
>   	}
>   	return dev;
> +
> +out_put_id:
> +	ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
> +
> +out_nd_btt:
> +	kfree(nd_btt);
> +	return NULL;
>   }
>   
>   struct device *nd_btt_create(struct nd_region *nd_region)


you have to take care of this below if block(true) as well as you are 
touching the function.
  if (ndns && !__nd_attach_ndns(&nd_btt->dev, ndns, &nd_btt->ndns)) {

Thanks,
Mukesh

