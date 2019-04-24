Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E960C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14AE20878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="HDTvYV3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfDXJ1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:27:40 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58822 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbfDXJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:27:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O9MOwQ020109;
        Wed, 24 Apr 2019 11:27:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=Np/3S0I0cy9sOf0bpvtPMHGI+KAGlta3TBJOf7x9EAc=;
 b=HDTvYV3WstZzVIUD4AnnuGVudDgMOIuigIoHWCpZ6BVQD4xPk+22iPVlJOJ0ocCdAvEb
 RunryB13s0OsJ6ckAfZhCpZYRm2Rc7vXf3y7YDpPRDUpbimOvL9//rOg7K7VyjtaiZdj
 G3dNdXExGirggJN4G3FQkoERw0/DlN3S2NfvntBGKHBlEQbpXEajMgwepU6d+8dM5IPM
 pL/crnQwk2Q2pOyhj9YlzN0XUEYNPFQ+OXNH1c/1yICeXbuU3OetNdWZ5Sx4bT2KP6ZG
 XE9tD8nrdZObRjE3ItpV+8a5rj+cpdaaQ6PMSP4tDe5CBLLMxDVYr2/C3hmF+Vwv41Wu Ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxckck-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 11:27:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6E7CD34;
        Wed, 24 Apr 2019 09:27:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4CB691578;
        Wed, 24 Apr 2019 09:27:21 +0000 (GMT)
Received: from [10.48.1.93] (10.75.127.47) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Apr
 2019 11:27:20 +0200
Subject: Re: [PATCH] dmaengine: stm32-dma: dmaengine: stm32-dma: use
 platform_get_irq()
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1556097685-7236-1-git-send-email-fabien.dessenne@st.com>
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <20f014c3-0511-2b43-bcd2-1ca8cc700d54@st.com>
Date:   Wed, 24 Apr 2019 11:27:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556097685-7236-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thanks

On 4/24/19 11:21 AM, Fabien Dessenne wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ) is not recommended for
> requesting IRQ's resources, as they can be not ready yet. Using
> platform_get_irq() instead is preferred for getting IRQ even if it was
> not retrieved earlier.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  drivers/dma/stm32-dma.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
> index ba239b5..3306818 100644
> --- a/drivers/dma/stm32-dma.c
> +++ b/drivers/dma/stm32-dma.c
> @@ -1302,13 +1302,14 @@ static int stm32_dma_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < STM32_DMA_MAX_CHANNELS; i++) {
>  		chan = &dmadev->chan[i];
> -		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> -		if (!res) {
> -			ret = -EINVAL;
> -			dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
> +		chan->irq = platform_get_irq(pdev, i);
> +		if (chan->irq < 0)  {
> +			ret = chan->irq;
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(&pdev->dev,
> +					"No irq resource for chan %d\n", i);
>  			goto err_unregister;
>  		}
> -		chan->irq = res->start;
>  		ret = devm_request_irq(&pdev->dev, chan->irq,
>  				       stm32_dma_chan_irq, 0,
>  				       dev_name(chan2dev(chan)), chan);
> 
