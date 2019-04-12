Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E0EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379A321872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDLJiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:38:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbfDLJiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:38:22 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9FDC115B402B7B235EFB;
        Fri, 12 Apr 2019 17:38:20 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 12 Apr
 2019 17:38:12 +0800
Subject: Re: [PATCH] staging: erofs: fix unexpected out-of-bound data access
To:     Chao Yu <yuchao0@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        "Fang Wei" <fangwei1@huawei.com>
References: <20190411105555.133551-1-gaoxiang25@huawei.com>
 <0332f6b3-9705-50d2-6e1e-639d3e8e915f@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <c5ff4170-f01b-809c-3d19-055293188ba6@huawei.com>
Date:   Fri, 12 Apr 2019 17:38:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0332f6b3-9705-50d2-6e1e-639d3e8e915f@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2019/4/12 17:28, Chao Yu wrote:
> On 2019/4/11 18:55, Gao Xiang wrote:
>> Unexpected out-of-bound data will be read in erofs_read_raw_page
>> after commit 07173c3ec276 ("block: enable multipage bvecs") since
>> one iovec could have multiple pages.
>>
>> Let's fix as what Ming's pointed out in the previous email.
> 
> It will be better to add link address of discussion thread in your commit
> message, since discussion includes more details about how this issue happens.

Thanks for your suggestion.
OK, I will send v2 and add the corresponding link :)

Thanks,
Gao Xiang

> 
>>
>> Suggested-by: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
>> ---
>>
>> It should be fixed from linux-5.1-rc after multi-page bvec feature.
>>
>> Thanks,
>> Gao Xiang
>>
>>  drivers/staging/erofs/data.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
>> index 0714061ba888..c64ec76643d4 100644
>> --- a/drivers/staging/erofs/data.c
>> +++ b/drivers/staging/erofs/data.c
>> @@ -304,7 +304,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>>  	*last_block = current_block;
>>  
>>  	/* shift in advance in case of it followed by too many gaps */
>> -	if (unlikely(bio->bi_vcnt >= bio->bi_max_vecs)) {
>> +	if (bio->bi_iter.bi_size >= bio->bi_max_vecs * PAGE_SIZE) {
>>  		/* err should reassign to 0 after submitting */
>>  		err = 0;
>>  		goto submit_bio_out;
>>
