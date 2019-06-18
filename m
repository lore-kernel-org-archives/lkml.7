Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8973C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9968720B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfFRIAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:00:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfFRIAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:00:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 31443FBB816E552F36E2;
        Tue, 18 Jun 2019 16:00:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Jun 2019
 16:00:09 +0800
Subject: Re: [PATCH] irqchip/mbigen: stop printing kernel addresses
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
References: <20190618032202.11087-1-wangkefeng.wang@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7c3fc84d-79a7-fef7-94c9-1acccd90d660@huawei.com>
Date:   Tue, 18 Jun 2019 15:59:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190618032202.11087-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/18 11:22, Kefeng Wang wrote:
> After commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> it will print "____ptrval____" instead of actual addresses when mbigen
> create domain fails,
> 
>   Hisilicon MBIGEN-V2 HISI0152:00: Failed to create mbi-gen@(____ptrval____) irqdomain
>   Hisilicon MBIGEN-V2: probe of HISI0152:00 failed with error -12
> 
> Instead of changing the print to "%px", and leaking kernel addresses,
> just remove the print completely.

This is a little bit misleading, as the "base" was used for
identify which mbigen failed, so saying 'remove completely'
will make people think that we will miss some debug information.

In fact, we have HISI0152:00 stands for mbigen ACPI HID and
its UID, so we can identify the failing probed mbigen even
we remove the printing "mgn_chip->base". It's better to add
this clarify in the commit message as well.

Thanks
Hanjun

