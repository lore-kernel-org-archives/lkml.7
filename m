Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EADC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0C320693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fz1ecdnz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fz1ecdnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbfDRIFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:05:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRIFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:05:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A779260FEA; Thu, 18 Apr 2019 08:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555574753;
        bh=p+Nj2KDJKpPYMONkjYbQYbdoYpmFBC86DMuT+yxregk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fz1ecdnzcao1M9OQtvNMEflW+0EzdER7JGRJ73Ec89c1KpKgSQHSluCxvN+zyvCeb
         RlZRkm7ObL8gA/I0jgCnDqguyMWr77GOi6vhQ5tMAZJiayS5OxL76Le2SaB6i2zE39
         6BhmCibKgZV5V7XJaH23+cn7KWihXG02N7Z7i9vU=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A47960907;
        Thu, 18 Apr 2019 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555574753;
        bh=p+Nj2KDJKpPYMONkjYbQYbdoYpmFBC86DMuT+yxregk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fz1ecdnzcao1M9OQtvNMEflW+0EzdER7JGRJ73Ec89c1KpKgSQHSluCxvN+zyvCeb
         RlZRkm7ObL8gA/I0jgCnDqguyMWr77GOi6vhQ5tMAZJiayS5OxL76Le2SaB6i2zE39
         6BhmCibKgZV5V7XJaH23+cn7KWihXG02N7Z7i9vU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A47960907
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: stm class: Fix possible double free
To:     Pan Bian <bianpan2016@163.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1555572178-73786-1-git-send-email-bianpan2016@163.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6d629a30-0acb-803e-c6f3-978e2a32c12d@codeaurora.org>
Date:   Thu, 18 Apr 2019 13:35:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555572178-73786-1-git-send-email-bianpan2016@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2019 12:52 PM, Pan Bian wrote:
> The function stm_register_device() calls put_device(&stm->dev) to
> release allocated memory (in stm_device_release()) on error paths.
> However, after that, the freed memory stm is released again, resulting
> in a double free bug. There is a similar issue in the function
> stm_source_register_device. This patch fixes these issues.
>
> Signed-off-by: Pan Bian <bianpan2016@163.com>


Looks good to me.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/hwtracing/stm/core.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index c7ba8ac..cfb5c4d 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -886,8 +886,10 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
>   		return -ENOMEM;
>   
>   	stm->major = register_chrdev(0, stm_data->name, &stm_fops);
> -	if (stm->major < 0)
> -		goto err_free;
> +	if (stm->major < 0) {
> +		vfree(stm);
> +		return err;
> +	}
>   
>   	device_initialize(&stm->dev);
>   	stm->dev.devt = MKDEV(stm->major, 0);
> @@ -933,8 +935,6 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
>   
>   	/* matches device_initialize() above */
>   	put_device(&stm->dev);
> -err_free:
> -	vfree(stm);
>   
>   	return err;
>   }
> @@ -1277,7 +1277,6 @@ int stm_source_register_device(struct device *parent,
>   
>   err:
>   	put_device(&src->dev);
> -	kfree(src);
>   
>   	return err;
>   }
