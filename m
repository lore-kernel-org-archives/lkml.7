Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E019C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCEA21993
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfFQIGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:06:20 -0400
Received: from mail5.windriver.com ([192.103.53.11]:43906 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfFQIGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:06:18 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x5H85FHc001907
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 01:06:08 -0700
Received: from [128.224.162.135] (128.224.162.135) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Jun
 2019 01:05:41 -0700
To:     <linux-kernel@vger.kernel.org>
From:   ddu <dengke.du@windriver.com>
Subject: call trace: WARNING: ttm_bo_vm_open on qemuarm64 when starting X
Message-ID: <1f9c87cc-ce0c-37c8-087d-3269c0d714e6@windriver.com>
Date:   Mon, 17 Jun 2019 16:05:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.135]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

When I build linux kernel 5.2-rc5

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tag/?h=v5.2-rc5

After start the X server, a warning call trace appear:

-----------------------------------------------------------------------

[   61.271345] -------------ttm_bo_mmap--------------
[   65.717991] WARNING: CPU: 0 PID: 241 at 
drivers/gpu/drm/ttm/ttm_bo_vm.c:308 ttm_bo_vm_open+0x44/0x60
[   65.721262] Modules linked in: openvswitch nsh nf_conncount nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
[   65.722608] CPU: 0 PID: 241 Comm: X Not tainted 
5.2.0-rc4-yoctodev-standard #1
[   65.722902] Hardware name: linux,dummy-virt (DT)
[   65.723491] pstate: 80000005 (Nzcv daif -PAN -UAO)
[   65.723728] pc : ttm_bo_vm_open+0x44/0x60
[   65.723924] lr : dup_mm+0x2b4/0x468
[   65.724112] sp : ffffff801233bbf0
[   65.724301] x29: ffffff801233bbf0 x28: ffffffc0185f0760
[   65.724568] x27: ffffffc0185f03e0 x26: ffffffc01871acf0
[   65.724775] x25: ffffffc01eb67d20 x24: ffffffc01871ad18
[   65.724977] x23: ffffffc01871ac38 x22: 0000000000000000
[   65.725177] x21: ffffffc0185f0380 x20: ffffffc0184e8958
[   65.725412] x19: ffffffc01871acf0 x18: 0000000000000000
[   65.725626] x17: 0000000000000000 x16: 0000000000000000
[   65.725832] x15: 0000000000000000 x14: 0000000000000009
[   65.726040] x13: 0000000000000000 x12: 003d090000000000
[   65.726238] x11: 00001e8480000000 x10: 0000000000000920
[   65.726485] x9 : ffffff801233ba10 x8 : ffffffc018638980
[   65.726704] x7 : 000057e6b8304adc x6 : 0000000000000010
[   65.726909] x5 : 000000001852d100 x4 : ffffff8010c99000
[   65.727119] x3 : ffffffc0185f09d0 x2 : ffffffc01e2cfae0
[   65.727323] x1 : ffffffc01eb67cf0 x0 : ffffffc01dc89c00
[   65.727686] Call trace:
[   65.727972]  ttm_bo_vm_open+0x44/0x60
[   65.728178]  dup_mm+0x2b4/0x468
[   65.728331]  copy_process.isra.0.part.0+0x1130/0x1540
[   65.728522]  _do_fork+0xe8/0x428
[   65.728674]  __arm64_sys_clone+0x2c/0x38
[   65.728844]  el0_svc_common.constprop.0+0x74/0x168
[   65.729024]  el0_svc_compat_handler+0x2c/0x38
[   65.729192]  el0_svc_compat+0x8/0x10
[   65.729529] ---[ end trace df1974ac6930916f ]---

-----------------------------------------------------------------------

ttm_bo_vm_open:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/ttm/ttm_bo_vm.c?h=v5.2-rc5#n308

That is to say that:

"bo->bdev->dev_mapping" not equal to "vma->vm_file->f_mapping"

But I am sure the ttm_bo_mmap was initial the vma and bdev in 
ttm_do_mmap, because I add a printk after

the :

vma->vm_private_data = bo;

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/ttm/ttm_bo_vm.c?h=v5.2-rc5#n458

and it print something, this means that the bo initial correctlly.

My question:

Where maybe change the bo or the vma when starting X server?

//dengke

