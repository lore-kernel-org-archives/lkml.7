Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A54C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FFD2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iPYqVWRQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BYQnByIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfC0Mrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:47:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39440 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0Mrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:47:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7FE5B60DB3; Wed, 27 Mar 2019 12:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690868;
        bh=4shmZlQkM2sPYWE/3Rr4bcasNWwXcXVIkYeo4nbIMdo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iPYqVWRQZhr6FBydaY16irFHiqCzxcacDXNVpCtQgcFyCdZ0goXueejACFFDCq369
         z0oDpeT/aQ0b4xXV74iCT06yYHnkj/Dko4dlqDVMhUaJXkolQPYtPcQRZrJUgZtchk
         d1QcRhrqkmgfBu0g+8sC325mMXCAlTSm/Ea0Aiic=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E42C60DB3;
        Wed, 27 Mar 2019 12:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690863;
        bh=4shmZlQkM2sPYWE/3Rr4bcasNWwXcXVIkYeo4nbIMdo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BYQnByINi6Cex/q4oO5kUaiJO05dc7i71bVbYlMQHOMiyhcNocsbIRGqn19OLQzC4
         YYrHXldOErS6GfaIXLKhxTk5dP4Gyr3wJP1hR36C/AeKi4r+3uRY0sv767tX6AjEfm
         GSxGsPpL9uBVgQ6fB1xV+SAxwVv24P8lyOIwW/ik=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E42C60DB3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] scsi: sun_esp: : Fix object reference leaks in
 esp_sbus_probe
To:     Huang Zijiang <huang.zijiang@zte.com.cn>, jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn
References: <1553644557-35817-1-git-send-email-huang.zijiang@zte.com.cn>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <8560b226-1f0b-e9c6-6a18-800e10111f65@codeaurora.org>
Date:   Wed, 27 Mar 2019 18:17:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553644557-35817-1-git-send-email-huang.zijiang@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the spam whosoever has got the last mail, as the last did not 
get to
the mailing list, and it bounced, so sending it again.

On 3/27/2019 5:25 AM, Huang Zijiang wrote:
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference whatever of_find_device_by_node
> reutrns.
s/reutrns/returns
>
> Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>



Take mine review tag once you make above change.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh



> ---
>   drivers/scsi/sun_esp.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
> index a11efbc..a74605a 100644
> --- a/drivers/scsi/sun_esp.c
> +++ b/drivers/scsi/sun_esp.c
> @@ -543,9 +543,8 @@ static int esp_sbus_probe(struct platform_device *op)
>   		return -ENODEV;
>   
>   	ret = esp_sbus_probe_one(op, dma_of, hme);
> -	if (ret)
> -		put_device(&dma_of->dev);
>   
> +	put_device(&dma_of->dev);
>   	return ret;
>   }
>   
