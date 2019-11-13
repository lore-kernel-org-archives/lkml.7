Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E69C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 04:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA364222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 04:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pU86+m86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfKMEN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 23:13:27 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:40657 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfKMEN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 23:13:27 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191113041324epoutp02f9ae2ac44ec86db8a4c39d0f95045231~WnZn8U0ER2653526535epoutp02s
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 04:13:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191113041324epoutp02f9ae2ac44ec86db8a4c39d0f95045231~WnZn8U0ER2653526535epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573618404;
        bh=mJFA/njgmP4obhVAaTLVxm27YK22M38R7AAIgIdwODE=;
        h=Date:From:Reply-To:To:CC:Subject:In-Reply-To:References:From;
        b=pU86+m866MOt67BrCGH4n2oGel0AQuVz8It5Qdu6OKxG6/HezxJK8AHOJ2d9sCYQA
         9fUF59gVHOQSNNij9NjdFv9HG1JeKKYBOBWLMa4ZU4Q4zyJ5Ol/+NcTmfAlhQzcB0n
         T10iNBIGAIxhm5xuK9mxk1c7T8PRjcGoRGbPXp8A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191113041324epcas1p4fed4f63a3c2c8f2eb1aca61bb4446daf~WnZnm0RY30892708927epcas1p4j;
        Wed, 13 Nov 2019 04:13:24 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47CWSJ2YxPzMqYkc; Wed, 13 Nov
        2019 04:13:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.C6.04135.0E28BCD5; Wed, 13 Nov 2019 13:13:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191113041319epcas1p3869db73a60fe98be01c5c65149a709c9~WnZjXSql-0607606076epcas1p3Y;
        Wed, 13 Nov 2019 04:13:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113041319epsmtrp2d208b704cd4fe15d818169d1abc89a39~WnZjWqNuv1978319783epsmtrp2g;
        Wed, 13 Nov 2019 04:13:19 +0000 (GMT)
X-AuditID: b6c32a36-7e3ff70000001027-08-5dcb82e0ca3f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.CC.25663.FD28BCD5; Wed, 13 Nov 2019 13:13:19 +0900 (KST)
Received: from [10.113.221.222] (unknown [10.113.221.222]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191113041319epsmtip251dbdd65ca070b8cdd09d837cdcbca9e~WnZjFf1qx1180111801epsmtip2Y;
        Wed, 13 Nov 2019 04:13:19 +0000 (GMT)
Message-ID: <5DCB8380.3070304@samsung.com>
Date:   Wed, 13 Nov 2019 13:16:00 +0900
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
Reply-To: sw0312.kim@samsung.com
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011
        Thunderbird/16.0.1
MIME-Version: 1.0
To:     Mark Rutland <mark.rutland@arm.com>
CC:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, sungguk.na@samsung.com
Subject: Re: [PATCH] arm64: perf: Report arm pc registers for compat perf
In-Reply-To: <20191112094037.GA32269@lakrids.cambridge.arm.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmvu6DptOxBrv3C1i8X9bDaLHp8TVW
        i8u75rBZLL1+kclix7yDjBYtd0wd2DzWzFvD6LFpVSebx+Yl9R59W1YxenzeJBfAGpVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
        kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQndGy/BRL
        wQSxin/bnzM3MB4T7GLk5JAQMJH40nibtYuRi0NIYAejxII706GcT4wSu/+vZYZwvjFK/L6/
        kAWmZdaBz1CJvYwSl7feY4Rw3jNKzFu9GKyKV0BL4vqh5WA2i4CqxPuWbewgNpuAjsT+Jb9Z
        QWwhAQWJC1tnsIHYogJhEjMO9jNC9ApKnJz5BKxXREBdomfXFxaQBcwCXYwSa9+/ZgJJCAt4
        Smzt3gNWxClgLzHl7CSwOLOAvETz1tlg50kI3GaTuDX7PzvE3S4Sbe9mQ9nCEq+Ob4GypSQ+
        v9vLBmFXS2yf8JMdormDUaKnvRHqaWOJ/UsnA23gANqgKbF+lz5EWFFi5++5jBCL+STefe1h
        BSmREOCV6GgTgihRkdh5dBIbRFhKYtaGYIiwh8Syg0tYJzAqzkLy8iwkH8xC2LWAkXkVo1hq
        QXFuemqxYYERchRvYgQnSC2zHYyLzvkcYhTgYFTi4ZVYeCpWiDWxrLgy9xCjBAezkgjvjooT
        sUK8KYmVValF+fFFpTmpxYcYTYGxM5FZSjQ5H5i880riDU2NjI2NLUwMzUwNDZXEeR2XL40V
        EkhPLEnNTk0tSC2C6WPi4JRqYFw6b3PteetrPysT4vJYpnD0F8rnKNsrfCnfyuXU2/z9HZ/Y
        x1NXMrL+yv8x350/USBBNVyhvca+uyBIxu/6kf2y69c289+PP7ZOtTrviaLLzSrPzrzSlYYd
        P5p/XeuYEL50839x5myFj6H89QLRkicCPl2x9vo/473dljNXm6ewHpnzus0tV4mlOCPRUIu5
        qDgRAIQzAsOmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO79ptOxBh+7ZC3eL+thtNj0+Bqr
        xeVdc9gsll6/yGSxY95BRouWO6YObB5r5q1h9Ni0qpPNY/OSeo++LasYPT5vkgtgjeKySUnN
        ySxLLdK3S+DKaFl+iqVggljFv+3PmRsYjwl2MXJySAiYSMw68Jm5i5GLQ0hgN6PEibVTmCAS
        UhJzv21n7GLkALKFJQ4fLoaoecso8eDdTUaQGl4BLYnrh5azgNgsAqoS71u2sYPYbAI6EvuX
        /GYFsYUEFCQubJ3BBmKLCoRI/Pp4hRWiV1Di5MwnYL0iAuoSPbu+sIAsYBboZpSY3/IVLCEs
        4CmxtXsPC8Tm04wSV6dtAOvmFLCXmHJ2EhPIdcxA3evnCYGEmQXkJZq3zmaewCg0C8mOWQhV
        s5BULWBkXsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwPWlo7GE+ciD/EKMDBqMTD
        e2DeqVgh1sSy4srcQ4wSHMxKIrw7Kk7ECvGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQ
        nliSmp2aWpBaBJNl4uCUamBMarrl/utGAGO/cm/+RGFWsdeLNa58r652ZOnK7yuRfipgGFJp
        /0yTmd1UROt32sKA8wee7dovw8tUsTaUU0zJ4AWvzzluITmN94LWWhPvq3iaHXt5+p370X7l
        07q6EzsivP6ExaZXdczS2HHgs8jNJeVhJiYhn7J3JMc63968U9xkkeVvcyWW4oxEQy3mouJE
        AEKcHMyDAgAA
X-CMS-MailID: 20191113041319epcas1p3869db73a60fe98be01c5c65149a709c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191112005902epcas1p2d9dfa6a29f2c57669b1c1eb58517016d
References: <CGME20191112005902epcas1p2d9dfa6a29f2c57669b1c1eb58517016d@epcas1p2.samsung.com>
        <1573520501-29195-1-git-send-email-sw0312.kim@samsung.com>
        <20191112094037.GA32269@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark Rutland,

On 2019년 11월 12일 18:40, Mark Rutland wrote:
> On Tue, Nov 12, 2019 at 10:01:41AM +0900, Seung-Woo Kim wrote:
>> If perf is built as arm 32-bit, it only reads 15 registers as arm
>> 32-bit register map and this breaks dwarf call-chain in compat
>> perf because pc register information is not filled.
>> Report arm pc registers for 32-bit compat perf.
>>
>> Without this, arm 32-bit perf dwarf call-graph shows below
>> verbose message:
>>   unwind: reg 15, val 0
>>   unwind: reg 13, val ffbc6360
>>   unwind: no map for 0
>>
>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>> ---
>>  arch/arm64/kernel/perf_regs.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
>> index 0bbac61..d4172e7 100644
>> --- a/arch/arm64/kernel/perf_regs.c
>> +++ b/arch/arm64/kernel/perf_regs.c
>> @@ -24,6 +24,8 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>  			return regs->compat_sp;
>>  		if ((u32)idx == PERF_REG_ARM64_LR)
>>  			return regs->compat_lr;
>> +		if ((u32)idx == 15) /* PERF_REG_ARM_PC */
>> +			return regs->pc;
>>  	}
> 
> This doesn't look quite right to me, since perf_regs_value() is
> consuming the arm64 index for all other registers (e.g. the LR, in the
> patch context).
> 
> i.e. this is designed for a native arm64 caller, and the fixup allows it
> to view a compat task's registers as-if it were native.
> 
> How does this work for a native arm64 perf invocation with a compat
> task? I assume it consumers regs->pc, and works as expected?

In native arm64 perf, compat task registers are set as arm64 register
map, and sp, lr, and pc are set properly. But compat_sp is from regs[13]
and compat_lr is from regs[14], so same register values are set for
regs[13]/egs->sp and regs[14]/regs->lr. With this change, it sets
regs[15] same with regs->pc, but the register is not use at least for
arm 32-bit compat binary callchain, so no issue as far as I understood
and tested.

> 
> I suspect we need separate native and compat forms of this function, but
> then it's not entirely clear how this should work -- how does this work
> for a compat perf analysing a native arm64 binary?

I didn't expect native arm64 binary callchain is possible to get from
arm 32-bit perf.

In my test with 32-bit compat perf, it sets perf
event->attr.sample_regs_user as 0xffff, which is matched with 32-bit
arm, but in arm64 perf part, it cannot be accessed. If there is way to
check it, it is possible to set difference register form. Anyway, in the
case, native arm64 register map is still not fully reported to 32-bit
compat perf.


Thanks,
- Seung-Woo Kim

> 
> Thanks,
> Mark.
> 
> 

-- 
Seung-Woo Kim
Samsung Research
--

