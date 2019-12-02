Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA8BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F322215E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfLBJKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:10:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfLBJKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:10:51 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 89C9D3186B0E22340C12;
        Mon,  2 Dec 2019 17:10:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Dec 2019
 17:10:40 +0800
From:   "Longpeng (Mike)" <longpeng2@huawei.com>
Subject: vfio_pin_map_dma cause synchronize_sched wait too long
To:     Alex Williamson <alex.williamson@redhat.com>, <pbonzini@redhat.com>
CC:     <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Longpeng(Mike)" <longpeng.mike@gmail.com>,
        Gonglei <arei.gonglei@huawei.com>,
        Huangzhichao <huangzhichao@huawei.com>
Message-ID: <2e53a9f0-3225-d416-98ff-55bd337330bc@huawei.com>
Date:   Mon, 2 Dec 2019 17:10:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Suppose there're two VMs: VM1 is bind to node-0 and calling vfio_pin_map_dma(),
VM2 is a migrate incoming VM which bind to node-1. We found the vm_start( QEMU
function) of VM2 will take too long occasionally, the reason is as follow.

- VM2 -
qemu: vm_start
        vm_start_notify
          virtio_vmstate_change
            virtio_pci_vmstate_change
              virtio_pci_start_ioeventfd
                virtio_device_start_ioeventfd_impl
                  event_notifier_init
                    eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC) <-- too long
kern: sys_eventfd2
        get_unused_fd_flags
          __alloc_fd
            expand_files
              expand_fdtable
                synchronize_sched <-- too long

- VM1 -
The VM1 is doing vfio_pin_map_dma at the same time.

The CPU must finish vfio_pin_map_dma and then rcu-sched grace period can be
elapsed, so synchronize_sched would wait for a long time.

Is there any solution to this ? Any suggestion would be greatly appreciated, thanks!

-- 
Regards,
Longpeng(Mike)

