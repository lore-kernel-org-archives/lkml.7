Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BAAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B6F21906
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfDXG1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:27:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfDXG1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:27:51 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DCC82C35206E82B3FDEC;
        Wed, 24 Apr 2019 14:27:45 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Apr 2019
 14:27:38 +0800
Subject: Re: [PATCH net-next 00/12] code optimizations & bugfixes for HNS3
 driver
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>
References: <1556076127-61459-1-git-send-email-tanhuazhong@huawei.com>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <5fdcebca-296f-6943-ea4e-a19b19dfa45f@huawei.com>
Date:   Wed, 24 Apr 2019 14:27:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1556076127-61459-1-git-send-email-tanhuazhong@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this patchset. I will send V2 to fix something else.

On 2019/4/24 11:21, Huazhong Tan wrote:
> This patch-set includes code optimizations and bugfixes for the HNS3
> ethernet controller driver.
> 
> [patch 1/12 - 3/12] fixes some bugs about the IO path
> 
> [patch 4/12 - 6/12] includes some optimization and bugfixes
> about mailbox message handling
> 
> [patch 7/12 - 12/12] adds misc code optimizations and bugfixes.
> 
> Huazhong Tan (7):
>    net: hns3: stop sending keep alive msg when VF command queue needs
>      reinit
>    net: hns3: use atomic_t replace u32 for arq's count
>    net: hns3: use a reserved byte to identify need_resp flag
>    net: hns3: not reset TQP in the DOWN while VF resetting
>    net: hns3: stop schedule reset service while unloading driver
>    net: hns3: fix pause configure fail problem
>    net: hns3: prevent double free in hns3_put_ring_config()
> 
> Weihang Li (1):
>    net: hns3: remove reset after command send failed
> 
> Yunsheng Lin (3):
>    net: hns3: fix data race between ring->next_to_clean
>    net: hns3: fix for TX clean num when cleaning TX BD
>    net: hns3: handle the BD info on the last BD of the packet
> 
> liuzhongzhu (1):
>    net: hns3: extend the loopback state acquisition time
> 
>   drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  7 ++-
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 65 +++++++++++++---------
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  7 ++-
>   .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 10 ----
>   .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  8 ++-
>   .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  7 +--
>   .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  5 +-
>   .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |  2 +-
>   .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 12 ++--
>   .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  1 +
>   .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  9 ++-
>   11 files changed, 76 insertions(+), 57 deletions(-)
> 

