Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67B6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A3B20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfDDLXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:23:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:13219 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfDDLXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:23:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 04:23:49 -0700
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="131397351"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.178]) ([10.254.204.178])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 04 Apr 2019 04:23:47 -0700
Subject: Re: [PATCH][next] opa_vnic: fix check on record->event, incorrect
 operator used
To:     Colin King <colin.king@canonical.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190404100439.19696-1-colin.king@canonical.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <fb140949-383e-731b-95b1-c75c2f85dadd@intel.com>
Date:   Thu, 4 Apr 2019 07:23:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404100439.19696-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/2019 6:04 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check on record->event is always true because the wrong operator
> is being used, used && instead of ||
> 
> Addresses-Coverity: ("Constant expression result")
> Fixes: fae7a699a925 ("opa_vnic: Convert vport_idr to XArray")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
> 

Missed this in code review. Thanks!

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
