Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8D1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7846920693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfCUNeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:34:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55121 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727857AbfCUNeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:34:23 -0400
X-UUID: a5a4a611dc144ef8ab62805dde40f35d-20190321
X-UUID: a5a4a611dc144ef8ab62805dde40f35d-20190321
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1182047461; Thu, 21 Mar 2019 21:34:16 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Mar 2019 21:34:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01dr.mediatek.inc (172.21.101.111) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Mar 2019 21:34:14 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Mar 2019 21:34:14 +0800
Message-ID: <1553175254.30977.88.camel@mtkswgap22>
Subject: Re: [PATCH] scsi: ufs-mediatek: fix uninitialized variable
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Anders Roxell <anders.roxell@linaro.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <matthias.bgg@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 21 Mar 2019 21:34:14 +0800
In-Reply-To: <20190321131925.27421-1-anders.roxell@linaro.org>
References: <20190321131925.27421-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On Thu, 2019-03-21 at 14:19 +0100, Anders Roxell wrote:
> When building the ufs-mediatek driver variable 'ret' may be used
> uninitialized.
> 
> ../drivers/scsi/ufs/ufs-mediatek.c: In function ‘ufs_mtk_setup_clocks’:
> ../drivers/scsi/ufs/ufs-mediatek.c:96:6: warning: ‘ret’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   int ret;
>       ^~~
> 
> Rework to return directly instead of using a local variable 'ret'.
> 
> Fixes: ddd90623ce26 ("scsi: ufs-mediatek: Add UFS support for Mediatek SoC chips")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/scsi/ufs/ufs-mediatek.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
> index ce4767784937..330d68871b06 100644
> --- a/drivers/scsi/ufs/ufs-mediatek.c
> +++ b/drivers/scsi/ufs/ufs-mediatek.c
> @@ -93,7 +93,6 @@ static int ufs_mtk_setup_clocks(struct ufs_hba *hba, bool on,
>  				enum ufs_notify_change_status status)
>  {
>  	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
> -	int ret;
>  
>  	/*
>  	 * In case ufs_mtk_init() is not yet done, simply ignore.
> @@ -106,18 +105,18 @@ static int ufs_mtk_setup_clocks(struct ufs_hba *hba, bool on,
>  	switch (status) {
>  	case PRE_CHANGE:
>  		if (!on)
> -			ret = phy_power_off(host->mphy);
> +			return phy_power_off(host->mphy);
>  		break;
>  	case POST_CHANGE:
>  		if (on)
> -			ret = phy_power_on(host->mphy);
> +			return phy_power_on(host->mphy);
>  		break;
>  	default:
> -		ret = -EINVAL;
> +		return -EINVAL;
>  		break;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  /**

This was already fixed by Nathan Chancellor in below patch,
https://lkml.org/lkml/2019/3/20/784

Anyway thanks for sending this fix.

Stanley.


