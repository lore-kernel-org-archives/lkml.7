Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AB4C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B922086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDAMDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:03:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfDAMC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:02:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8339B495D87F065E23C8;
        Mon,  1 Apr 2019 20:02:57 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 1 Apr 2019
 20:02:48 +0800
Subject: Re: [PATCH for-4.19 1/2] staging: erofs: fix error handling when
 failed to read compresssed data
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190401065309.68109-1-gaoxiang25@huawei.com>
 <20190401114040.GC8156@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <c23f77c3-052e-5a96-752f-5664fc8afa34@huawei.com>
Date:   Mon, 1 Apr 2019 20:02:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190401114040.GC8156@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/1 19:40, Greg Kroah-Hartman wrote:
> On Mon, Apr 01, 2019 at 02:53:08PM +0800, Gao Xiang wrote:
>> commit b6391ac73400eff38377a4a7364bd3df5efb5178 upstream.
>>
>> Complete read error handling paths for all three kinds of
>> compressed pages:
>>
>>  1) For cache-managed pages, PG_uptodate will be checked since
>>     read_endio will unlock and SetPageUptodate for these pages;
>>
>>  2) For inplaced pages, read_endio cannot SetPageUptodate directly
>>     since it should be used to mark the final decompressed data,
>>     PG_error will be set with page locked for IO error instead;
>>
>>  3) For staging pages, PG_error is used, which is similar to
>>     what we do for inplaced pages.
>>
>> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
>> Cc: <stable@vger.kernel.org> # 4.19+
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>> This series resolves the following conflicts:
>> FAILED: patch "[PATCH] staging: erofs: fix error handling when failed to read" failed to apply to 4.19-stable tree
>> FAILED: patch "[PATCH] staging: erofs: keep corrupted fs from crashing kernel in" failed to apply to 4.19-stable tree
> 
> Thanks for both of these, now queued up.
> 
> greg k-h

It's my pleasure to backport related conflict bugfixes to stable kernels. :)

Thanks,
Gao Xiang


> 
