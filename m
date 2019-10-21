Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DFECA9EAC
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 03:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9752621897
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 03:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfJUDfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 23:35:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59038 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726835AbfJUDfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 23:35:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6D27770CA029068351AD;
        Mon, 21 Oct 2019 11:35:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 11:35:00 +0800
Subject: Re: [PATCH v7 00/12] implement KASLR for powerpc/fsl_booke/32
To:     Scott Wood <oss@buserror.net>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>, <zhaohongjiang@huawei.com>,
        <thunder.leizhen@huawei.com>, <yebin10@huawei.com>
References: <20190920094546.44948-1-yanaijie@huawei.com>
 <9c2dd2a8-83f2-983c-383e-956e19a7803a@huawei.com>
 <c4769b34-95f6-81b9-4856-50459630aa0d@huawei.com>
 <38141b946f3376ce471e46eaf065e357ac540354.camel@buserror.net>
 <90bb659a-bde4-3b8e-8f01-bf22d7534f44@huawei.com>
 <34ef1980887c8a6d635c20bdaf748bb0548e51b5.camel@buserror.net>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <0543af6f-df4a-81ff-41fe-c81959568859@huawei.com>
Date:   Mon, 21 Oct 2019 11:34:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <34ef1980887c8a6d635c20bdaf748bb0548e51b5.camel@buserror.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/10 2:46, Scott Wood wrote:
> On Wed, 2019-10-09 at 16:41 +0800, Jason Yan wrote:
>> Hi Scott,
>>
>> On 2019/10/9 15:13, Scott Wood wrote:
>>> On Wed, 2019-10-09 at 14:10 +0800, Jason Yan wrote:
>>>> Hi Scott,
>>>>
>>>> Would you please take sometime to test this?
>>>>
>>>> Thank you so much.
>>>>
>>>> On 2019/9/24 13:52, Jason Yan wrote:
>>>>> Hi Scott,
>>>>>
>>>>> Can you test v7 to see if it works to load a kernel at a non-zero
>>>>> address?
>>>>>
>>>>> Thanks,
>>>
>>> Sorry for the delay.  Here's the output:
>>>
>>
>> Thanks for the test.
>>
>>> ## Booting kernel from Legacy Image at 10000000 ...
>>>      Image Name:   Linux-5.4.0-rc2-00050-g8ac2cf5b4
>>>      Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>>>      Data Size:    7521134 Bytes = 7.2 MiB
>>>      Load Address: 04000000
>>>      Entry Point:  04000000
>>>      Verifying Checksum ... OK
>>> ## Flattened Device Tree blob at 1fc00000
>>>      Booting using the fdt blob at 0x1fc00000
>>>      Uncompressing Kernel Image ... OK
>>>      Loading Device Tree to 07fe0000, end 07fff65c ... OK
>>> KASLR: No safe seed for randomizing the kernel base.
>>> OF: reserved mem: initialized node qman-fqd, compatible id fsl,qman-fqd
>>> OF: reserved mem: initialized node qman-pfdr, compatible id fsl,qman-pfdr
>>> OF: reserved mem: initialized node bman-fbpr, compatible id fsl,bman-fbpr
>>> Memory CAM mapping: 64/64/64 Mb, residual: 12032Mb
>>
>> When boot from 04000000, the max CAM value is 64M. And
>> you have a board with 12G memory, CONFIG_LOWMEM_CAM_NUM=3 means only
>> 192M memory is mapped and when kernel is randomized at the middle of
>> this 192M memory, we will not have enough continuous memory for node map.
>>
>> Can you set CONFIG_LOWMEM_CAM_NUM=8 and see if it works?
> 
> OK, that worked.
> 

Hi Scott, any more cases should be tested or any more comments?
What else need to be done before this feature can be merged?

Thanks,
Jason

> -Scott
> 
> 
> 
> .
> 

