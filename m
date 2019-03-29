Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53647C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216122082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gm5LvvMO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SqlCTHZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfC2K3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:29:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38908 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfC2K3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:29:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 499D0608CC; Fri, 29 Mar 2019 10:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553855386;
        bh=U3uTSl5RCEQolHht9ozQu/WBcEZutHeBP74QRK4sRLs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gm5LvvMOuUWuJR9mecCIO+xJiFnMUayw9DVdXv7W7ualBzu8vGdos3SAR/Pz48YR9
         e//RSs/bMFef+PWnmXrG4fCHV3yzrLFnBTLkc8/szwei6lDGxmpJTsMxFtl6uWjpMX
         vDpXr3vcRJrzyY4iLe6DKiWocxnfL+4aYo9T08g0=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E1AB6063A;
        Fri, 29 Mar 2019 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553855385;
        bh=U3uTSl5RCEQolHht9ozQu/WBcEZutHeBP74QRK4sRLs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SqlCTHZ2KEIKFPqRbGQjdSb2nbZANwYFs1pybyBSlpb1lWIso/pv1ofzQeNDXOJ0R
         tzu8p46gS0wSvs1UA3V5O2E3pCVsxXbhegdlfOANK7a9R92xKkSIp5V3GTxZMWckkA
         J4wEJEWso895gERq1XGPu7UWufl+LIuoW0fN+0pI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E1AB6063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] scsi: pm8001: clean up structurally dead code when
 PM8001_USE_MSIX is defined
To:     Colin King <colin.king@canonical.com>,
        Jack Wang <jinpu.wang@profitbricks.com>, lindar_liu@usish.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190328234328.15860-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a038c561-9fe8-f58e-2a5a-e7e95aca9eee@codeaurora.org>
Date:   Fri, 29 Mar 2019 15:59:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328234328.15860-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 5:13 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> When macro PM8001_USE_MSIX is defined there are redundant dead code
> calls to pm8001_chip_intx_interrupt_{enable|disable}. Clean this up
> by compiling in the appropriate enable/disable handlers for the
> defined PM8001_USE_MSIX and undefined PM8001_USE_MSIX cases.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


This looks good.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


Not relevant to this patch but Can you do something about 
pm8001_chip_is_our_interupt() as well ?


Cheers,
-Mukesh
> ---
>   drivers/scsi/pm8001/pm8001_hwi.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index e4209091c1da..7d81246a432b 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -1204,6 +1204,7 @@ void pm8001_chip_iounmap(struct pm8001_hba_info *pm8001_ha)
>   	}
>   }
>   
> +#ifndef PM8001_USE_MSIX
>   /**
>    * pm8001_chip_interrupt_enable - enable PM8001 chip interrupt
>    * @pm8001_ha: our hba card information
> @@ -1225,6 +1226,8 @@ pm8001_chip_intx_interrupt_disable(struct pm8001_hba_info *pm8001_ha)
>   	pm8001_cw32(pm8001_ha, 0, MSGU_ODMR, ODMR_MASK_ALL);
>   }
>   
> +#else
> +
>   /**
>    * pm8001_chip_msix_interrupt_enable - enable PM8001 chip interrupt
>    * @pm8001_ha: our hba card information
> @@ -1256,6 +1259,7 @@ pm8001_chip_msix_interrupt_disable(struct pm8001_hba_info *pm8001_ha,
>   	msi_index += MSIX_TABLE_BASE;
>   	pm8001_cw32(pm8001_ha, 0,  msi_index, MSIX_INTERRUPT_DISABLE);
>   }
> +#endif
>   
>   /**
>    * pm8001_chip_interrupt_enable - enable PM8001 chip interrupt
> @@ -1266,10 +1270,9 @@ pm8001_chip_interrupt_enable(struct pm8001_hba_info *pm8001_ha, u8 vec)
>   {
>   #ifdef PM8001_USE_MSIX
>   	pm8001_chip_msix_interrupt_enable(pm8001_ha, 0);
> -	return;
> -#endif
> +#else
>   	pm8001_chip_intx_interrupt_enable(pm8001_ha);
> -
> +#endif
>   }
>   
>   /**
> @@ -1281,10 +1284,9 @@ pm8001_chip_interrupt_disable(struct pm8001_hba_info *pm8001_ha, u8 vec)
>   {
>   #ifdef PM8001_USE_MSIX
>   	pm8001_chip_msix_interrupt_disable(pm8001_ha, 0);
> -	return;
> -#endif
> +#else
>   	pm8001_chip_intx_interrupt_disable(pm8001_ha);
> -
> +#endif
>   }
>   
>   /**
