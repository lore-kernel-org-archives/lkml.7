Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CAFC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C4620675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfCGNEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:04:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfCGNEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:04:39 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B6C61FC340259C57D88E;
        Thu,  7 Mar 2019 21:04:36 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 7 Mar 2019
 21:04:25 +0800
Subject: Re: [PATCH for-4.19] staging: erofs: fix mis-acted TAIL merging
 behavior
To:     Greg KH <greg@kroah.com>
CC:     Sasha Levin <sashal@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <stable@vger.kernel.org>
References: <20190301212203.5FE0C2084F@mail.kernel.org>
 <20190307053404.29108-1-gaoxiang25@huawei.com>
 <20190307122539.GD21325@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <5b7e1914-f8e5-da3d-4492-17d6afc00fb1@huawei.com>
Date:   Thu, 7 Mar 2019 21:04:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190307122539.GD21325@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2019/3/7 20:25, Greg KH wrote:
> On Thu, Mar 07, 2019 at 01:34:04PM +0800, Gao Xiang wrote:
>> commit a112152f6f3a2a88caa6f414d540bd49e406af60 upstream.
>>
>> EROFS has an optimized path called TAIL merging, which is designed
>> to merge multiple reads and the corresponding decompressions into
>> one if these requests read continuous pages almost at the same time.
>>
>> In general, it behaves as follows:
>>  ________________________________________________________________
>>   ... |  TAIL  .  HEAD  |  PAGE  |  PAGE  |  TAIL    . HEAD | ...
>>  _____|_combined page A_|________|________|_combined page B_|____
>>         1  ]  ->  [  2                          ]  ->  [ 3
>> If the above three reads are requested in the order 1-2-3, it will
>> generate a large work chain rather than 3 individual work chains
>> to reduce scheduling overhead and boost up sequential read.
>>
>> However, if Read 2 is processed slightly earlier than Read 1,
>> currently it still generates 2 individual work chains (chain 1, 2)
>> but it does in-place decompression for combined page A, moreover,
>> if chain 2 decompresses ahead of chain 1, it will be a race and
>> lead to corrupted decompressed page. This patch fixes it.
>>
>> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
>> Cc: <stable@vger.kernel.org> # 4.19+
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  drivers/staging/erofs/unzip_vle.c | 69 +++++++++++++++++++++++++--------------
>>  1 file changed, 44 insertions(+), 25 deletions(-)
>>
> 
> thanks for the backport, now applied.

Yes, it seems that Sasha's bot cannot cherry-pick it directly,
therefore I made this patch for 4.19 by hand...

BTW, there is another patch called "staging: erofs: compressed_pages should not be accessed again after freed"
in the same condition... And I also send 4.19 and 4.20 version to stable mailing list,
could you also kindly check them out?

Thanks,
Gao Xiang

> 
> greg k-h
> 
