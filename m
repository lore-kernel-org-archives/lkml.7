Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C4CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A184B20882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kNhQ5etS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfG3Huo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:50:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34230 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfG3Hun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:50:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6U7oYXJ015633;
        Tue, 30 Jul 2019 02:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564473034;
        bh=+BrZNYx7jpQAy93Om4KvfpAASh10p0ehFPnIH5nQ/30=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kNhQ5etSg127sxr3mEg5c6P05n8EPbhr+cUWvLhmy+C4cQHs/dv399AsCFkimLonW
         l5wOI4l2P8gmkMob+FovzTZ34gCxKMl8GApLKRcqPIJ0mNi8Lm5I5z9YmP7yIZ2eKk
         5PjqrCzkxPxoRM4BIXbolZALqhRAscWyq/cg2FVE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6U7oYsu060302
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jul 2019 02:50:34 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Jul 2019 02:50:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Jul 2019 02:50:33 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6U7oWK8009954;
        Tue, 30 Jul 2019 02:50:32 -0500
Subject: Re: [PATCH] dma-mapping: remove dma_{alloc,free,mmap}_writecombine
To:     Christoph Hellwig <hch@lst.de>
CC:     <laurent.pinchart@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20190730061849.29686-1-hch@lst.de>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <5f73f400-eff2-6c7b-887d-c768642d8df1@ti.com>
Date:   Tue, 30 Jul 2019 10:50:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730061849.29686-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2019 09:18, Christoph Hellwig wrote:
> We can already use DMA_ATTR_WRITE_COMBINE or the _wc prefixed version,
> so remove the third way of doing things.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/gpu/drm/omapdrm/dss/dispc.c | 11 +++++------
>   include/linux/dma-mapping.h         |  9 ---------
>   2 files changed, 5 insertions(+), 15 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Which tree should this be applied to?

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
