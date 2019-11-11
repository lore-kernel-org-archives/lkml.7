Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D235DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDD420679
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKKPuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:50:01 -0500
Received: from foss.arm.com ([217.140.110.172]:47304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfKKPuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:50:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C61B931B;
        Mon, 11 Nov 2019 07:50:00 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16A893F534;
        Mon, 11 Nov 2019 07:49:59 -0800 (PST)
Subject: Re: [PATCH] firmware: arm_scmi: Remove set but not used variable
 'val'
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20191110103010.117132-1-zhengyongjun3@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <64a46661-40a6-eb7e-d225-1085b86572d0@arm.com>
Date:   Mon, 11 Nov 2019 15:49:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191110103010.117132-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2019 10:30, Zheng Yongjun wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/firmware/arm_scmi/perf.c: In function scmi_perf_fc_ring_db:
> drivers/firmware/arm_scmi/perf.c:323:7: warning: variable val set but not used [-Wunused-but-set-variable]
> 
> val is never used, so remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>   drivers/firmware/arm_scmi/perf.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 4a8012e3cb8c..efa98d2ee045 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -319,10 +319,8 @@ static void scmi_perf_fc_ring_db(struct scmi_fc_db_info *db)
>   		SCMI_PERF_FC_RING_DB(64);
>   #else
>   	{
> -		u64 val = 0;
> -
>   		if (db->mask)
> -			val = ioread64_hi_lo(db->addr) & db->mask;
> +			ioread64_hi_lo(db->addr) & db->mask;
>   		iowrite64_hi_lo(db->set, db->addr);

FWIW, compared to the SCMI_PERF_FC_RING_DB() macro, this looks like the 
wrong "fix".

Robin.

>   	}
>   #endif
> 
