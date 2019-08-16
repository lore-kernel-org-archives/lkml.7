Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822A6C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E1B206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RkdODmGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfHPGyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:54:00 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33432 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfHPGyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:54:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7G6rZOm004713;
        Fri, 16 Aug 2019 01:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565938415;
        bh=Gu7E7gqMococXfCNlEpS2YaEPFtnyWvUe/FmGZ/Bp7Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RkdODmGul5qq6uzQyBl7BRLIEWuS9ETqapW5FFHnzSQ/uivM0RhuB7qh7zBSFvpIK
         z0VK2GsXix0zUckD5p/4Zpr61KeSp4+0jBkVYpqC7ux6/YSXW0qzuyvB4cfOGyGLof
         j7bMBfevDPDNEuCaGbEn22hwmwMOB/XXgu0arvVw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7G6rZ9B053873
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Aug 2019 01:53:35 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 01:53:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 16 Aug 2019 01:53:35 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7G6rXDu088304;
        Fri, 16 Aug 2019 01:53:33 -0500
Subject: Re: [PATCH v2] dmaengine: ti: dma-crossbar: Fix a memory leak bug
To:     Wenwen Wang <wenwen@cs.uga.edu>
CC:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1565938136-7249-1-git-send-email-wenwen@cs.uga.edu>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a2eeda4d-0949-1d22-7b5a-275d72bd9130@ti.com>
Date:   Fri, 16 Aug 2019 09:53:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565938136-7249-1-git-send-email-wenwen@cs.uga.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2019 9.48, Wenwen Wang wrote:
> In ti_dra7_xbar_probe(), 'rsv_events' is allocated through kcalloc(). Then
> of_property_read_u32_array() is invoked to search for the property.
> However, if this process fails, 'rsv_events' is not deallocated, leading to
> a memory leak bug. To fix this issue, free 'rsv_events' before returning
> the error.

Thank you,

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/dma/ti/dma-crossbar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
> index ad2f0a4..f255056 100644
> --- a/drivers/dma/ti/dma-crossbar.c
> +++ b/drivers/dma/ti/dma-crossbar.c
> @@ -391,8 +391,10 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
>  
>  		ret = of_property_read_u32_array(node, pname, (u32 *)rsv_events,
>  						 nelm * 2);
> -		if (ret)
> +		if (ret) {
> +			kfree(rsv_events);
>  			return ret;
> +		}
>  
>  		for (i = 0; i < nelm; i++) {
>  			ti_dra7_xbar_reserve(rsv_events[i][0], rsv_events[i][1],
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
