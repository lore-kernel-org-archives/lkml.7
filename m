Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2691BC2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A7E206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AOhisjZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfLQHmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:42:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40366 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfLQHmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:42:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBH7g8Uf114724;
        Tue, 17 Dec 2019 01:42:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576568528;
        bh=9NUycoKNe/ucuDO59fc9sAUJ51QLJlEoUga8hlTvi9I=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=AOhisjZCqGQliRFUKW6sCymn6LdYmPcFjixI2DCnNKnAh2W86fISA0Lq9jeI14L52
         s7QiBSJELGN8oOipB13Ji4tJG0TqNNQn2XdUO+3ybTXzF/pWJh+9kU0KyLUT1OSGUq
         iWBO45w9hRPV6cJT01LIMU4oKlg0D3fAOuucVDuI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBH7g884034553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 01:42:08 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 01:42:06 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 01:42:06 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBH7g43r076809;
        Tue, 17 Dec 2019 01:42:05 -0600
Subject: Re: [PATCH] powerpc/512x: Use dma_request_chan() instead
 dma_request_slave_channel()
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <b.zolnierkie@samsung.com>, <axboe@kernel.dk>
CC:     <vkoul@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191217074019.21732-1-peter.ujfalusi@ti.com>
Message-ID: <9b54258f-8278-38f5-7682-db72ad0e7dc2@ti.com>
Date:   Tue, 17 Dec 2019 09:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191217074019.21732-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/12/2019 9.40, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.

I sent this patch to wrong participants... Forgot to change directory.
The correct (ata: pxa:) should be on it way.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/powerpc/platforms/512x/mpc512x_lpbfifo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
> index 13631f35cd14..04bf6ecf7d55 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
> @@ -434,9 +434,9 @@ static int mpc512x_lpbfifo_probe(struct platform_device *pdev)
>  	memset(&lpbfifo, 0, sizeof(struct lpbfifo_data));
>  	spin_lock_init(&lpbfifo.lock);
>  
> -	lpbfifo.chan = dma_request_slave_channel(&pdev->dev, "rx-tx");
> -	if (lpbfifo.chan == NULL)
> -		return -EPROBE_DEFER;
> +	lpbfifo.chan = dma_request_chan(&pdev->dev, "rx-tx");
> +	if (IS_ERR(lpbfifo.chan))
> +		return PTR_ERR(lpbfifo.chan);
>  
>  	if (of_address_to_resource(pdev->dev.of_node, 0, &r) != 0) {
>  		dev_err(&pdev->dev, "bad 'reg' in 'sclpc' device tree node\n");
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
