Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D28C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC9A2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfF1IR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:17:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:19120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726632AbfF1IR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:17:59 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 634BE66BDE366B1C257B;
        Fri, 28 Jun 2019 16:17:51 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 28 Jun 2019
 16:17:47 +0800
Subject: Re: [PATCH 58/87] scsi: mvsas: remove memset after dma_alloc_coherent
To:     Fuqian Huang <huangfq.daxian@gmail.com>
References: <20190627174355.5252-1-huangfq.daxian@gmail.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        "Johannes Thumshirn" <jthumshirn@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cf7d2136-b298-ac4f-2264-5ceecf99175b@huawei.com>
Date:   Fri, 28 Jun 2019 09:17:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190627174355.5252-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2019 18:43, Fuqian Huang wrote:
> In commit af7ddd8a627c

That's a merge commit. I think that you maybe are thinking of 
specifically commit 518a2f1925c3.

> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),

nit: this can be spread of multiple lines at whitespace delimiters

> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/scsi/mvsas/mv_init.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index da719b0694dc..f2fae160691d 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -241,19 +241,16 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
>  				     &mvi->tx_dma, GFP_KERNEL);
>  	if (!mvi->tx)
>  		goto err_out;
> -	memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
>  	mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
>  					 &mvi->rx_fis_dma, GFP_KERNEL);
>  	if (!mvi->rx_fis)
>  		goto err_out;
> -	memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
>
>  	mvi->rx = dma_alloc_coherent(mvi->dev,
>  				     sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
>  				     &mvi->rx_dma, GFP_KERNEL);
>  	if (!mvi->rx)
>  		goto err_out;
> -	memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
>  	mvi->rx[0] = cpu_to_le32(0xfff);
>  	mvi->rx_cons = 0xfff;
>
> @@ -262,7 +259,6 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
>  				       &mvi->slot_dma, GFP_KERNEL);
>  	if (!mvi->slot)
>  		goto err_out;
> -	memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
>
>  	mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
>  				       TRASH_BUCKET_SIZE,
>


