Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86771C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AE820823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j0E5sn0Q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JEJMT1KA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfCZHXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:23:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZHXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:23:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 307E860ACE; Tue, 26 Mar 2019 07:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553585032;
        bh=b7KQ0YiaBzeJFbXUEL2PXvBMIJErVldxSWcZfURah3A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j0E5sn0QX844UdxSh7U1vrw07BGzrSdQeE+d96qC/mnTKGqSsKfOO/mQQ/JIUVDKJ
         Tal2xVqdqq32rQSLQRihvAsmnlc0LfAoXPZAubuZHI5RoqGELYvsDUyBRxbrRYWvWq
         iC47NS9wBTI0MJTgNGhhR/+PyAMmhASVCTO4tVB8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E7F5607C3;
        Tue, 26 Mar 2019 07:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553585031;
        bh=b7KQ0YiaBzeJFbXUEL2PXvBMIJErVldxSWcZfURah3A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JEJMT1KAwxsGJ29A06b4mdW6cw6L6GdF0fpQVgKgoCZS3Nu29r46GqQ0L8ia2PYhV
         NRLERYYA3hiyQN2NChJPW+4OPu0eCdca88tmkNdGGUZYNo3+7z4y07wj1hxNjOiGto
         n1hfA/oHOmgJFmC8qlOLQYgzU+9jWAgWW5D5Qg2o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E7F5607C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] firmware: arm_scmi: Fix leak in scmi_mailbox_check
To:     Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20190325173722.49414-1-steven.price@arm.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <dcf27d87-e72f-3892-f982-941c91f95102@codeaurora.org>
Date:   Tue, 26 Mar 2019 12:53:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325173722.49414-1-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2019 11:07 PM, Steven Price wrote:
> of_parse_phandle_with_args() requires the caller to call of_node_put() on
> the returned args->np pointer. Otherwise the reference count will remain
> incremented.
>
> However, in this case, since we don't actually use the returned pointer,
> we can simply pass in NULL.
>
> Fixes: aa4f886f3893f ("firmware: arm_scmi: add basic driver infrastructure for SCMI")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   drivers/firmware/arm_scmi/driver.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 8f952f2f1a29..dd967d675c08 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -654,9 +654,7 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
>   
>   static int scmi_mailbox_check(struct device_node *np)
>   {
> -	struct of_phandle_args arg;
> -
> -	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
> +	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, NULL);

Although, it is not used but it is better to put arg->np instead of 
passing NULL.
Here, you are making the driver not to fill arguement which is 
customised solution, that may change in future.


Thanks.
Mukesh


>   }
>   
>   static int scmi_mbox_free_channel(int id, void *p, void *data)
