Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCA7C04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698A82081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfE1CJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 22:09:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbfE1CJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 22:09:48 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7FD15975CEE8A2494546;
        Tue, 28 May 2019 10:09:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 10:09:42 +0800
Subject: =?UTF-8?Q?Re:_[PATCH_-next_v2]_staging:_kpc2000:_Remove_set_but_not?=
 =?UTF-8?B?IHVzZWQgdmFyaWFibGUg4oCYc3RhdHVz4oCZ?=
To:     <gregkh@linuxfoundation.org>, <jeremy@azazel.net>
References: <20190525042642.78482-1-maowenan@huawei.com>
 <20190525081321.121294-1-maowenan@huawei.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>
From:   maowenan <maowenan@huawei.com>
Message-ID: <69398d9c-68e1-e4c5-35f9-4bf09627e48a@huawei.com>
Date:   Tue, 28 May 2019 10:09:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190525081321.121294-1-maowenan@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please ignore v2 version.
I will send v3 later according to Sven Van Asbroeck 's comments.

On 2019/5/25 16:13, Mao Wenan wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/staging/kpc2000/kpc_spi/spi_driver.c: In function
> ‘kp_spi_transfer_one_message’:
> drivers/staging/kpc2000/kpc_spi/spi_driver.c:282:9: warning: variable
> ‘status’ set but not used [-Wunused-but-set-variable]
>      int status = 0;
>          ^~~~~~
> The variable 'status' is not used any more, remve it.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  v2: change the subject of the patch.
> ---
>  drivers/staging/kpc2000/kpc_spi/spi_driver.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc_spi/spi_driver.c b/drivers/staging/kpc2000/kpc_spi/spi_driver.c
> index 86df16547a92..16f9518f8d63 100644
> --- a/drivers/staging/kpc2000/kpc_spi/spi_driver.c
> +++ b/drivers/staging/kpc2000/kpc_spi/spi_driver.c
> @@ -279,7 +279,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
>      struct kp_spi       *kpspi;
>      struct spi_transfer *transfer;
>      union kp_spi_config sc;
> -    int status = 0;
>      
>      spidev = m->spi;
>      kpspi = spi_master_get_devdata(master);
> @@ -332,7 +331,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
>      /* do the transfers for this message */
>      list_for_each_entry(transfer, &m->transfers, transfer_list) {
>          if (transfer->tx_buf == NULL && transfer->rx_buf == NULL && transfer->len) {
> -            status = -EINVAL;
>              break;
>          }
>          
> @@ -370,7 +368,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
>              m->actual_length += count;
>              
>              if (count != transfer->len) {
> -                status = -EIO;
>                  break;
>              }
>          }
> 

