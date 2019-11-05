Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7A3C49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4F320869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbfKEJvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:51:03 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730692AbfKEJvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:51:02 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 470D6B654043089EFB02;
        Tue,  5 Nov 2019 09:51:01 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 Nov 2019 09:51:00 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Tue, 5 Nov 2019
 09:51:00 +0000
Subject: Re: [PATCH v3 3/5] bus: hisi_lpc: Clean some types
To:     Joe Perches <joe@perches.com>, <xuwei5@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>
References: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
 <1572888139-47298-4-git-send-email-john.garry@huawei.com>
 <a391e4df7c080c6a4d7eac58708967d02f0449fa.camel@perches.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d6c8521c-30c0-7a2c-b658-8734f7b180d3@huawei.com>
Date:   Tue, 5 Nov 2019 09:50:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a391e4df7c080c6a4d7eac58708967d02f0449fa.camel@perches.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2019 18:39, Joe Perches wrote:
> On Tue, 2019-11-05 at 01:22 +0800, John Garry wrote:
>> Sparse complains of these:
>> drivers/bus/hisi_lpc.c:82:38: warning: incorrect type in argument 1 (different address spaces)
>> drivers/bus/hisi_lpc.c:82:38:    expected void const volatile [noderef] <asn:2>*addr
>> drivers/bus/hisi_lpc.c:82:38:    got unsigned char *
>> drivers/bus/hisi_lpc.c:131:35: warning: incorrect type in argument 1 (different address spaces)
>> drivers/bus/hisi_lpc.c:131:35:    expected unsigned char *mbase
>> drivers/bus/hisi_lpc.c:131:35:    got void [noderef] <asn:2>*membase
>> drivers/bus/hisi_lpc.c:186:35: warning: incorrect type in argument 1 (different address spaces)
>> drivers/bus/hisi_lpc.c:186:35:    expected unsigned char *mbase
>> drivers/bus/hisi_lpc.c:186:35:    got void [noderef] <asn:2>*membase
>> drivers/bus/hisi_lpc.c:228:16: warning: cast to restricted __le32
>> drivers/bus/hisi_lpc.c:251:13: warning: incorrect type in assignment (different base types)
>> drivers/bus/hisi_lpc.c:251:13:    expected unsigned int [unsigned] [usertype] val
>> drivers/bus/hisi_lpc.c:251:13:    got restricted __le32 [usertype] <noident>
>>
>> Clean them up.
> 
> OK, it might also be good to change the _in and _out functions
> to use void * and not unsigned char * for buf

Hi Joe,

In fact, using unsigned char * is the right thing to do, and really the 
upper layer prob should not be passing void *. I'll look at this as a 
follow up.

Cheers,
John

> 
> ---
>   drivers/bus/hisi_lpc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 20c9571..ec2bfb 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -100,7 +100,7 @@ static int wait_lpc_idle(unsigned char *mbase, unsigned int waitcnt)
>    */
>   static int hisi_lpc_target_in(struct hisi_lpc_dev *lpcdev,
>   			      struct lpc_cycle_para *para, unsigned long addr,
> -			      unsigned char *buf, unsigned long opcnt)
> +			      void *buf, unsigned long opcnt)
>   {
>   	unsigned int cmd_word;
>   	unsigned int waitcnt;
> @@ -153,7 +153,7 @@ static int hisi_lpc_target_in(struct hisi_lpc_dev *lpcdev,
>    */
>   static int hisi_lpc_target_out(struct hisi_lpc_dev *lpcdev,
>   			       struct lpc_cycle_para *para, unsigned long addr,
> -			       const unsigned char *buf, unsigned long opcnt)
> +			       const void *buf, unsigned long opcnt)
>   {
>   	unsigned int waitcnt;
>   	unsigned long flags;
> 
> 
> .
> 

