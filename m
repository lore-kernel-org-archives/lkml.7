Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BEEC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D91E21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfGEMdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:33:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbfGEMdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:33:14 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 02C3EBD676E72E9322B4;
        Fri,  5 Jul 2019 20:33:12 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 5 Jul 2019
 20:33:05 +0800
Subject: Re: [PATCH] time: compat settimeofday: Validate the values of tv from
 user
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <john.stultz@linaro.org>, <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
References: <1562318088-37669-1-git-send-email-zhengbin13@huawei.com>
 <alpine.DEB.2.21.1907051230340.1802@nanos.tec.linutronix.de>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <39dd218b-4fc1-83bd-df2a-3cd69cc90c72@huawei.com>
Date:   Fri, 5 Jul 2019 20:32:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907051230340.1802@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/5 20:14, Thomas Gleixner wrote:
> Zhengbin,
>
> On Fri, 5 Jul 2019, zhengbin wrote:
>
>> Similar to commit 6ada1fc0e1c4
>> ("time: settimeofday: Validate the values of tv from user"),
>> an unvalidated user input is multiplied by a constant, which can result
>> in an undefined behaviour for large values. While this is validated
>> later, we should avoid triggering undefined behaviour.
> I surely agree with the patch, but the argument that this is validated
> later and we just should avoid UB in general is just wrong.
>
> For a wide range of negative tv_usec values the multiplication overflow
> turns them in positive numbers. So the 'validated later' is not catching
> the invalid input.
>
> So 'should avoid ....' is just the wrong argument here.
>
> Validation _is_ required before the multiplication so UB won't turn an
> invalid value into a valid one.
>
> Thanks,
>
> 	tglx
Strongly agree with this, I send a v2 patch, modify the comment?
>
> .
>

