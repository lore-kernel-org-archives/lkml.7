Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D45C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4C720850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfCYLzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:55:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46066 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbfCYLzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:55:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED09080D;
        Mon, 25 Mar 2019 04:55:00 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F30363F575;
        Mon, 25 Mar 2019 04:54:59 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: check return value of idr_find
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pakki001@umn.edu
References: <20190309040239.32431-1-kjlu@umn.edu>
From:   Steven Price <steven.price@arm.com>
Message-ID: <225abd6e-4551-213d-367b-93d938789188@arm.com>
Date:   Mon, 25 Mar 2019 11:54:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190309040239.32431-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2019 04:02, Kangjie Lu wrote:
> idr_find may return NULL, so check its return value and return an
> error code.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
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

I don't believe this situation can ever actually occur. The
SCMI_PROTOCOL_BASE id is reserved just after the IDR is created in
scmi_probe() in the first call to scmi_mbox_chan_setup(). That first
call can't enter the above if() block because the scmi_mailbox_check()
call has already been checked in scmi_probe(). It is only when
processing the children in subsequent calls to scmi_mbox_chan_setup()
that the check is on another node and so might fail. But by this time
the SCMI_PROTOCOL_BASE id must exist.

So there shouldn't be any way of reaching the situation where the IDR
doesn't contain SCMI_PROTOCOL_BASE and idr_find() returns NULL.

Having said that it did take me a while to understand the code well
enough to reason that, and the above return should be handled
appropriately, so you can add my Reviewed-by. But it would be worth
expanding the commit message pointing out that there isn't actually a
bug (yet).

Steve
