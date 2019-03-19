Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C91C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479B620857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCSN0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:26:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfCSN0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:26:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E07F94C5F12FDEC5882E;
        Tue, 19 Mar 2019 21:25:56 +0800 (CST)
Received: from [127.0.0.1] (10.57.56.75) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 21:25:47 +0800
To:     <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
From:   "Tangnianyao (ICT)" <tangnianyao@huawei.com>
Subject: [RFC] Question about enable doorbell irq and halt_poll process
CC:     <guoheyi@huawei.com>, <wanghaibin.wang@huawei.com>
Message-ID: <0fb3c9ba-8428-ea6c-2973-952624f601cc@huawei.com>
Date:   Tue, 19 Mar 2019 21:25:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.56.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

Using gicv4, when guest is waiting for irq, it sends wfi and traps to kvm.
When vlpi is forwarded to PE after its_vpe_deschedule, before halt_poll in
kvm_vcpu_block, halt_poll may increase latency for this vlpi getting to guest.
In halt_poll process, it checks if there's pending irq for vcpu using pending_last.
However, doorbell is not enable at this moment and vlpi or doorbell can not set
pending_last true, to stop halt_poll. It will run until halt_poll time ends, if
there's no other physical irq coming in the meantime. And then vcpu is scheduled out.
This pending vlpi has to wait for vcpu getting schedule in next time.

Should we enable doorbell before halt_poll process ?

