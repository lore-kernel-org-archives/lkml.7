Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15A7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3207214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDDCDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:03:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfDDCDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:03:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [10.3.19.214])
        by Forcepoint Email with ESMTP id 2C7E43932CE4BFA18E0B;
        Thu,  4 Apr 2019 10:03:04 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 4 Apr 2019
 10:03:01 +0800
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, <linux@armlinux.org.uk>,
        <peterz@infradead.org>, <mingo@redhat.com>, <will.deacon@arm.com>,
        <arnd@arndb.de>, <longman@redhat.com>,
        <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>
CC:     <dave.dice@oracle.com>, <rahul.x.yadav@oracle.com>,
        <steven.sistare@oracle.com>, <daniel.m.jordan@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <5ac2fb0e-744b-3bb5-133a-ac684e061d17@huawei.com>
Date:   Thu, 4 Apr 2019 10:02:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190329152006.110370-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 2019/3/29 23:20, Alex Kogan wrote:
> +
> +static __always_inline void cna_init_node(struct mcs_spinlock *node, int cpuid,
> +					  u32 tail)
> +{
> +	if (decode_numa_node(node->node_and_count) == -1)
> +		store_numa_node(node, numa_cpu_node(cpuid));

How about using cpu_to_node() here and #include <linux/topology.h> in this
file, then the code can be reused for other architectures such as ARM64?

Thanks
Hanjun

