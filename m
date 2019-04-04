Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B59CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4E52075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aNp6+AH/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Em1TVFgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbfDDJSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:18:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387974AbfDDJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5387A61D01; Thu,  4 Apr 2019 09:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554369472;
        bh=70+klM7HkAHNKNJEJn15T8+408yDaacIKqZu5m9VSbc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aNp6+AH/UzhH/u/iS2vNEf+SgpXhVK2q9po4CxLLhxQGkDB0DMdvZLQyPPx80IXBh
         2it3+9fsdL/TDq1IQH/pa0HujSO+JENagd/7Wb7xz0Pm3J5OWPEVhrXRzfbTgHerWy
         H1hZ1HnJCPWjTYybwDhURxhVOpMcXOB0UE0LrgD8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75AEC61D8B;
        Thu,  4 Apr 2019 09:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554369467;
        bh=70+klM7HkAHNKNJEJn15T8+408yDaacIKqZu5m9VSbc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Em1TVFgxo5IplLHTbXiDnVMw5DAbCae0iYJrQ5AYzI5zW68eOZBGb5ynIyhdLPcQB
         R8pUsAGLBuTffo9prnFqwal9GB1E/wUov1muoq4X2yCfJI3rLL2rvgWC+YzQCHwfGW
         IzsJdXoIcCh0w3D44rO53+S24F/VCnecaTFh+bw0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75AEC61D8B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] remoteproc: silence an uninitialized variable warning
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Gross <andy.gross@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190404084204.GA20193@kadam>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a08db945-44d3-ff99-7a89-75367f314855@codeaurora.org>
Date:   Thu, 4 Apr 2019 14:47:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404084204.GA20193@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 2:12 PM, Dan Carpenter wrote:
> Smatch complains that "ret" might be uninitialized.  I can see why it
> generates the warning, but I don't know if it's actually possible.
> Anyway initializing "ret" here is harmless.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/soc/qcom/mdt_loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 1c488024c698..fc58d660692f 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -188,7 +188,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>   
>   	if (reloc_base)
>   		*reloc_base = mem_reloc;
> -
> +	ret = 0;


You are overriding the value here, better keep it at the start.
Thanks,
Mukesh

>   out:
>   	kfree(fw_name);
>   
