Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36ADC47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B311E20650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfJNGNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:13:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfJNGNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:13:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 92DBC18C626919661A6C;
        Mon, 14 Oct 2019 14:13:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 14:13:03 +0800
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org>
 <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
 <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
 <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com>
 <CAK8P3a0kBz1-i-3miCo1vMuoM39ivXa3oxOE9VnCqDO-nfNOxw@mail.gmail.com>
 <20191011102747.lpbaur2e4nqyf7sw@willie-the-truck>
 <73701e9f-bee1-7ae8-2277-7a3576171cd4@huawei.com>
 <CAK8P3a1C8cFB6DS9eVXTEiTQu1kPzy65JvL=BxqEe5MTkds8sQ@mail.gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e6df09ba-a016-65c0-5b56-f7b91a7c9dd8@huawei.com>
Date:   Mon, 14 Oct 2019 14:12:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1C8cFB6DS9eVXTEiTQu1kPzy65JvL=BxqEe5MTkds8sQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2019/10/12 22:05, Arnd Bergmann wrote:
> On Sat, Oct 12, 2019 at 9:33 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>>
>> On 2019/10/11 18:27, Will Deacon wrote:
>> [...]
>>>
>>> Does anybody use BIG_ENDIAN? If we're not even building it then maybe we
>>> should get rid of it altogether on arm64. I don't know of any supported
>>> userspace that supports it or any CPUs that are unable to run little-endian
>>> binaries.
>>
>> FWIW, massive telecommunication products (based on ARM64) form Huawei are using
>> BIG_ENDIAN, and will use BIG_ENDIAN in the near future as well.
> 
> Ok, thanks for the information -- that definitely makes it clear that
> it cannot go
> away anytime soon (though it doesn't stop us from change the
> allmodconfig default
> if we decide that's a good idea).

I agree with you.

> 
> Do you know if there are currently any patches against mainline to
> make big-endian
> work in products, or is everything working out of the box?

We are not using mainline kernel for product, but LTS 4.4 is working
fine, and also we tested LTS 4.19 kernel without any other big-endian
patches, the latest big-endian bug we found is this:

a6002ec5a8c6 arm64: opcodes.h: Add arm big-endian config options before including arm header

The running kernel code covered but Huawei's telecommunication products
is limited, but I think ARM64 arch code is working fine for big-endian.

Thanks
Hanjun

