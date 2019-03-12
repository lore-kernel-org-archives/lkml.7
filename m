Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32834C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097FB214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfCLG3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:29:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbfCLG3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:29:43 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BB2B5A0AFED7DD100E03;
        Tue, 12 Mar 2019 14:29:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Mar 2019
 14:29:35 +0800
Subject: Re: [PATCH net] staging: rtl8188eu: use is_zero_ether_addr() instead
 of memcmp()
To:     <Larry.Finger@lwfinger.net>, <gregkh@linuxfoundation.org>,
        <straube.linux@gmail.com>, <jananis37@gmail.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <davem@davemloft.net>
References: <20190309032600.98732-1-maowenan@huawei.com>
From:   maowenan <maowenan@huawei.com>
Message-ID: <951c83d2-fa0d-11ed-96a9-cee620c9c096@huawei.com>
Date:   Tue, 12 Mar 2019 14:29:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190309032600.98732-1-maowenan@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On 2019/3/9 11:26, Mao Wenan wrote:
> Using is_zero_ether_addr() instead of directly use
> memcmp() to determine if the ethernet address is all
> zeros.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_mlme.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> index 714f7a70ed64..beae367df93b 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> @@ -180,9 +180,8 @@ struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
>  {
>  	struct list_head *phead, *plist;
>  	struct wlan_network *pnetwork = NULL;
> -	u8 zero_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
>  
> -	if (!memcmp(zero_addr, addr, ETH_ALEN)) {
> +	if (is_zero_ether_addr(addr)) {
>  		pnetwork = NULL;
>  		goto exit;
>  	}
> 

