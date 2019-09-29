Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C04C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F052146E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfI2CFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 22:05:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37384 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728569AbfI2CFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 22:05:12 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CF3A645BA623D5B0E6AA;
        Sun, 29 Sep 2019 10:05:09 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sun, 29 Sep 2019
 10:04:59 +0800
Subject: Re: [RFC PATCH] scripts: Fix coccicheck failed
To:     Julia Lawall <julia.lawall@lip6.fr>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
CC:     Gilles Muller <Gilles.Muller@lip6.fr>, <nicolas.palix@imag.fr>,
        <michal.lkml@markovi.net>, <maennich@google.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <cocci@systeme.lip6.fr>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
Date:   Sun, 29 Sep 2019 10:04:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909280542490.2168@hadrien>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/28 20:43, Julia Lawall wrote:
> 
> 
> On Sat, 28 Sep 2019, YueHaibing wrote:
> 
>> Run make coccicheck, I got this:
>>
>> spatch -D patch --no-show-diff --very-quiet --cocci-file
>>  ./scripts/coccinelle/misc/add_namespace.cocci --dir .
>>  -I ./arch/x86/include -I ./arch/x86/include/generated
>>  -I ./include -I ./arch/x86/include/uapi
>>  -I ./arch/x86/include/generated/uapi -I ./include/uapi
>>  -I ./include/generated/uapi --include ./include/linux/kconfig.h
>>  --jobs 192 --chunksize 1
>>
>> virtual rule patch not supported
>> coccicheck failed
>>
>> It seems add_namespace.cocci cannot be called in coccicheck.
> 
> Could you explain the issue better?  Does the current state cause make
> coccicheck to fail?  Or is it just silently not being called?

Yes, it cause make coccicheck failed like this:

...
./drivers/xen/xenbus/xenbus_comms.c:290:2-8: preceding lock on line 243
./fs/fuse/dev.c:1227:2-8: preceding lock on line 1206
./fs/fuse/dev.c:1232:3-9: preceding lock on line 1206
coccicheck failed
make[1]: *** [coccicheck] Error 255
make: *** [sub-make] Error 2


> 
> thanks,
> julia
> 
>>
>> Fixes: eb8305aecb95 ("scripts: Coccinelle script for namespace dependencies.")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  scripts/{coccinelle/misc => }/add_namespace.cocci | 0
>>  scripts/nsdeps                                    | 2 +-
>>  2 files changed, 1 insertion(+), 1 deletion(-)
>>  rename scripts/{coccinelle/misc => }/add_namespace.cocci (100%)
>>
>> diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/add_namespace.cocci
>> similarity index 100%
>> rename from scripts/coccinelle/misc/add_namespace.cocci
>> rename to scripts/add_namespace.cocci
>> diff --git a/scripts/nsdeps b/scripts/nsdeps
>> index ac2b6031dd13..0f743b76e501 100644
>> --- a/scripts/nsdeps
>> +++ b/scripts/nsdeps
>> @@ -23,7 +23,7 @@ fi
>>
>>  generate_deps_for_ns() {
>>  	$SPATCH --very-quiet --in-place --sp-file \
>> -		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
>> +		$srctree/scripts/add_namespace.cocci -D ns=$1 $2
>>  }
>>
>>  generate_deps() {
>> --
>> 2.20.1
>>
>>
>>
> 
> .
> 

