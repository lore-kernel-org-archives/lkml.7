Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDEEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C377206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b79GNytK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rmn596pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfDDLgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:36:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51714 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDLgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:36:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 172D460159; Thu,  4 Apr 2019 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554377778;
        bh=sx6A7fva0uVCeD5k9j0cqpkkXP+RZuCznvItWdJduuo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b79GNytKU+3omHUoVfclfnlvBNHRV2tO8SvdXW1m7wrAinPKqorYSC+r8GTIiZPCL
         HNuMMDccMtqQRKwkyOulqa3kryu23cW2Drm68BxktIH6MzJBOYP9DviWNZCjvkaNiC
         jLX6oYLcexrDScj3hvbkkeFvNU1K/jrY9HUniodY=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C106F602F2;
        Thu,  4 Apr 2019 11:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554377777;
        bh=sx6A7fva0uVCeD5k9j0cqpkkXP+RZuCznvItWdJduuo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Rmn596pjdFsdsL4g6AxMSQm+02PDBRWeu/CyamIVaxUfxmYa+3MfK50hEtsuEtQKc
         9VPv4q4bYUf4zuOaJzvCtq6u8AFUeD0C4kIgkLWZbD4et2IVdqwPwPBvCSSmrwspoy
         +CUzsz3rgD4ljL7b42Q0Ic/hZXPOA59EGuyc0VWA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C106F602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH][next] opa_vnic: fix check on record->event, incorrect
 operator used
To:     Colin King <colin.king@canonical.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190404100439.19696-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <4a9f82a4-b9d2-d8c7-1a61-9a3b3318ff49@codeaurora.org>
Date:   Thu, 4 Apr 2019 17:06:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404100439.19696-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 3:34 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The check on record->event is always true because the wrong operator
> is being used, used && instead of ||
>
> Addresses-Coverity: ("Constant expression result")
> Fixes: fae7a699a925 ("opa_vnic: Convert vport_idr to XArray")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
> index 76cd09410d9a..be5befd92d16 100644
> --- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
> +++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
> @@ -869,7 +869,7 @@ static void opa_vnic_event(struct ib_event_handler *handler,
>   	      record->event, dev_name(&record->device->dev),
>   	      record->element.port_num);
>   
> -	if (record->event != IB_EVENT_PORT_ERR ||
> +	if (record->event != IB_EVENT_PORT_ERR &&
>   	    record->event != IB_EVENT_PORT_ACTIVE)
>   		return;
>   
