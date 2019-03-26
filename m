Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA66C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AA52070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfCZLer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:34:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34850 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbfCZLeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:34:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B8AA1596;
        Tue, 26 Mar 2019 04:34:45 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 444183F59C;
        Tue, 26 Mar 2019 04:34:44 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: check return value of idr_find
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pakki001@umn.edu
References: <225abd6e-4551-213d-367b-93d938789188@arm.com>
 <20190325204823.5428-1-kjlu@umn.edu>
From:   Steven Price <steven.price@arm.com>
Message-ID: <94d8e411-1eef-1450-4828-5faabb03a3d1@arm.com>
Date:   Tue, 26 Mar 2019 11:34:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325204823.5428-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 20:48, Kangjie Lu wrote:
> Thanks for Steven Price's review of this patch. In the current code,

There's no need to include a "thanks" message in the commit message -
the "Reviewed-by" tag is sufficient. Please also remember to include an
appropriate version tag in the subject - this should be "v2".

Thanks,

Steve

> idr_find won't return NULL because the SCMI_PROTOCOL_BASE id must 
> exist. However, it might return NULL in the future code if the check
> is on another node while processing the children in subsequent calls 
> to scmi_mbox_chan_setup().
> Therefore, the patch conservatively checks the return value and 
> returns -EINVAL when it indeed failed.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 8f952f2f1a29..35faa203d549 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -709,6 +709,8 @@ scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
>  
>  	if (scmi_mailbox_check(np)) {
>  		cinfo = idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
> +		if (!cinfo)
> +			return -EINVAL;
>  		goto idr_alloc;
>  	}
>  
> 

