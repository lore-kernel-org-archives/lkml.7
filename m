Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC7DCA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC29920717
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfJ3JdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:33:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:33:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A67A73E0A51CECA0DC52;
        Wed, 30 Oct 2019 17:33:20 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 30 Oct 2019
 17:33:14 +0800
Message-ID: <5DB958DA.7080305@huawei.com>
Date:   Wed, 30 Oct 2019 17:33:14 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE
 to define debugfs fops
References: <1572423581-59762-1-git-send-email-zhongjiang@huawei.com>         <1572423581-59762-2-git-send-email-zhongjiang@huawei.com> <fb8722ad2c1ef51944dc814a7b24433f4348721e.camel@analog.com>
In-Reply-To: <fb8722ad2c1ef51944dc814a7b24433f4348721e.camel@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/30 17:13, Ardelean, Alexandru wrote:
> On Wed, 2019-10-30 at 16:19 +0800, zhong jiang wrote:
>> [External]
>>
>> It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
>> operation rather than DEFINE_SIMPLE_ATTRIBUTE.
> Not sure if "more clear" is the word.
Should be more clearly. :-)
> But it is more correct to use DEFINE_DEBUGFS_ATTRIBUTE(), since they are
> debugfs attrs.
>
> In any case, this is no big deal.
> So:
>
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/iio/imu/adis16460.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
>> index 6aed9e8..2e7a582 100644
>> --- a/drivers/iio/imu/adis16460.c
>> +++ b/drivers/iio/imu/adis16460.c
>> @@ -87,7 +87,7 @@ static int adis16460_show_serial_number(void *arg, u64
>> *val)
>>  
>>  	return 0;
>>  }
>> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_serial_number_fops,
>> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_serial_number_fops,
>>  	adis16460_show_serial_number, NULL, "0x%.4llx\n");
>>  
>>  static int adis16460_show_product_id(void *arg, u64 *val)
>> @@ -105,7 +105,7 @@ static int adis16460_show_product_id(void *arg, u64
>> *val)
>>  
>>  	return 0;
>>  }
>> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_product_id_fops,
>> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_product_id_fops,
>>  	adis16460_show_product_id, NULL, "%llu\n");
>>  
>>  static int adis16460_show_flash_count(void *arg, u64 *val)
>> @@ -123,7 +123,7 @@ static int adis16460_show_flash_count(void *arg, u64
>> *val)
>>  
>>  	return 0;
>>  }
>> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_flash_count_fops,
>> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_flash_count_fops,
>>  	adis16460_show_flash_count, NULL, "%lld\n");
>>  
>>  static int adis16460_debugfs_init(struct iio_dev *indio_dev)


