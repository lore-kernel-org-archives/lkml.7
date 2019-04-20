Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12208C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D477F208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfDTDsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 23:48:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfDTDsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 23:48:25 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DBC377E5CE5585331887;
        Sat, 20 Apr 2019 11:48:22 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Sat, 20 Apr 2019
 11:48:12 +0800
Subject: Re: [PATCH] lib: scatterlist: Fix to support no mapped sg
To:     Robert Jarzmik <robert.jarzmik@free.fr>
References: <1555581006-153458-1-git-send-email-wangzhou1@hisilicon.com>
 <871s1ymg1k.fsf@belgarion.home>
CC:     <axboe@fb.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5CBA967C.5010502@hisilicon.com>
Date:   Sat, 20 Apr 2019 11:48:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <871s1ymg1k.fsf@belgarion.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/19 18:43, Robert Jarzmik wrote:
> Zhou Wang <wangzhou1@hisilicon.com> writes:
> 
>> In function sg_split, the second sg_calculate_split will return -EINVAL
>> when in_mapped_nents is 0.
>>
>> Indeed there is no need to do second sg_calculate_split and sg_split_mapped
>> when in_mapped_nents is 0, as in_mapped_nents indicates no mapped entry in
>> original sgl.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> That's right. May I know what is the usecase which led you to this fix ?

I posted a patchset to support HiSilicon compression engine:
https://lkml.org/lkml/2019/1/23/358. As Herber Xu suggested, it should use
new crypto acomp API which uses sgl as data input and output. However, our
hardware can not handle compress head for input/output data, so I need split
input/output sgl firstly which is not mapped sgl.

New version of HiSilicon compression engine driver has not been posted to
community yet. I will do this later.

> 
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Many thanks for your review,
Zhou

> 
> --
> Robert
> 
> .
> 

