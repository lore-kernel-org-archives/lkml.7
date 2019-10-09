Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEFAECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028BE206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfJIKBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:01:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbfJIKBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:01:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 252BB9A4CA4130BAA917;
        Wed,  9 Oct 2019 18:01:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 18:01:01 +0800
Subject: Re: [PATCH v3 00/10] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
To:     Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        "Elena Reshetova" <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jan Glauber <jglauber@marvell.com>
References: <20191007154703.5574-1-will@kernel.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <644616a9-ec05-1d2e-22fc-93890adb3324@huawei.com>
Date:   Wed, 9 Oct 2019 18:01:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20191007154703.5574-1-will@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/7 23:46, Will Deacon wrote:
> Hi all,
> 
> This is version three of the patches I previously posted here:
> 
>   v1: https://lkml.kernel.org/r/20190802101000.12958-1-will@kernel.org
>   v2: https://lkml.kernel.org/r/20190827163204.29903-1-will@kernel.org
> 
> Changes since v2 include:
> 
>   - Remove the x86 assembly version and enable this code unconditionally
>   - Move saturation warnings out-of-line to reduce image bloat
> 
> Cheers,
> 
> Will
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Jan Glauber <jglauber@marvell.com>
> 

I tested on top of 5.4-rc2 (with Jan's open-read-close file test case), on a 96 CPU
cores ARM64 server, I can see no much difference under 24 cores (each 24 core is
a NUMA node), but +5.9% performance improve on 48 cores and +8.4% for 96 cores.

For the ARM64 arch,

Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

