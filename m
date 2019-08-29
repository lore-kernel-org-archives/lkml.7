Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD92C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 02:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1282173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 02:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfH2Clc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 22:41:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40954 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbfH2Clb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 22:41:31 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6C2B397E212C635202B0;
        Thu, 29 Aug 2019 10:41:29 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 29 Aug 2019
 10:41:21 +0800
Subject: Re: [PATCH v6 00/12] implement KASLR for powerpc/fsl_booke/32
To:     Scott Wood <oss@buserror.net>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>, <zhaohongjiang@huawei.com>,
        <thunder.leizhen@huawei.com>, <fanchengyang@huawei.com>,
        <yebin10@huawei.com>
References: <20190809100800.5426-1-yanaijie@huawei.com>
 <a39b81562bcdeda7ffe0c2c29a60ff08c77047a6.camel@buserror.net>
 <143e5a85bc630d2bb0324114e78bedec8fbeb299.camel@buserror.net>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <30a034e9-898c-5734-cf8b-c8704cdb42c5@huawei.com>
Date:   Thu, 29 Aug 2019 10:41:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <143e5a85bc630d2bb0324114e78bedec8fbeb299.camel@buserror.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/28 12:59, Scott Wood wrote:
> On Tue, 2019-08-27 at 23:05 -0500, Scott Wood wrote:
>> On Fri, 2019-08-09 at 18:07 +0800, Jason Yan wrote:
>>>   Freescale Book-E
>>> parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1
>>> entries are not suitable to map the kernel directly in a randomized
>>> region, so we chose to copy the kernel to a proper place and restart to
>>> relocate.
>>>
>>> Entropy is derived from the banner and timer base, which will change every
>>> build and boot. This not so much safe so additionally the bootloader may
>>> pass entropy via the /chosen/kaslr-seed node in device tree.
>>
>> How complicated would it be to directly access the HW RNG (if present) that
>> early in the boot?  It'd be nice if a U-Boot update weren't required (and
>> particularly concerning that KASLR would appear to work without a U-Boot
>> update, but without decent entropy).
> 
> OK, I see that kaslr-seed is used on some other platforms, though arm64 aborts
> KASLR if it doesn't get a seed.  I'm not sure if that's better than a loud
> warning message (or if it was a conscious choice rather than just not having
> an alternative implemented), but silently using poor entropy for something
> like this seems bad.
> 

It can still make the attacker's cost higher with not so good entropy.
The same strategy exists in X86 when X86 KASLR uses RDTSC if without
X86_FEATURE_RDRAND supported. I agree that having a warning message
looks better for reminding people in this situation.

> -Scott
> 
> 
> 
> .
> 

