Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01112C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4D920869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDLCFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 22:05:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:56102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbfDLCFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 22:05:54 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 7D6E785E20A520AADF64;
        Fri, 12 Apr 2019 10:05:50 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 12 Apr 2019 10:05:48 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 12 Apr 2019 10:05:48 +0800
Subject: Re: [PATCH v5] f2fs: fix to avoid accessing xattr across the boundary
To:     Randall Huang <huangrandall@google.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190411082646.169977-1-huangrandall@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0cef5922-c72a-2ce5-91ff-06b1b004451a@huawei.com>
Date:   Fri, 12 Apr 2019 10:05:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190411082646.169977-1-huangrandall@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/11 16:26, Randall Huang wrote:
> When we traverse xattr entries via __find_xattr(),
> if the raw filesystem content is faked or any hardware failure occurs,
> out-of-bound error can be detected by KASAN.
> Fix the issue by introducing boundary check.
> 
> [   38.402878] c7   1827 BUG: KASAN: slab-out-of-bounds in f2fs_getxattr+0x518/0x68c
> [   38.402891] c7   1827 Read of size 4 at addr ffffffc0b6fb35dc by task
> [   38.402935] c7   1827 Call trace:
> [   38.402952] c7   1827 [<ffffff900809003c>] dump_backtrace+0x0/0x6bc
> [   38.402966] c7   1827 [<ffffff9008090030>] show_stack+0x20/0x2c
> [   38.402981] c7   1827 [<ffffff900871ab10>] dump_stack+0xfc/0x140
> [   38.402995] c7   1827 [<ffffff9008325c40>] print_address_description+0x80/0x2d8
> [   38.403009] c7   1827 [<ffffff900832629c>] kasan_report_error+0x198/0x1fc
> [   38.403022] c7   1827 [<ffffff9008326104>] kasan_report_error+0x0/0x1fc
> [   38.403037] c7   1827 [<ffffff9008325000>] __asan_load4+0x1b0/0x1b8
> [   38.403051] c7   1827 [<ffffff90085fcc44>] f2fs_getxattr+0x518/0x68c
> [   38.403066] c7   1827 [<ffffff90085fc508>] f2fs_xattr_generic_get+0xb0/0xd0
> [   38.403080] c7   1827 [<ffffff9008395708>] __vfs_getxattr+0x1f4/0x1fc
> [   38.403096] c7   1827 [<ffffff9008621bd0>] inode_doinit_with_dentry+0x360/0x938
> [   38.403109] c7   1827 [<ffffff900862d6cc>] selinux_d_instantiate+0x2c/0x38
> [   38.403123] c7   1827 [<ffffff900861b018>] security_d_instantiate+0x68/0x98
> [   38.403136] c7   1827 [<ffffff9008377db8>] d_splice_alias+0x58/0x348
> [   38.403149] c7   1827 [<ffffff900858d16c>] f2fs_lookup+0x608/0x774
> [   38.403163] c7   1827 [<ffffff900835eacc>] lookup_slow+0x1e0/0x2cc
> [   38.403177] c7   1827 [<ffffff9008367fe0>] walk_component+0x160/0x520
> [   38.403190] c7   1827 [<ffffff9008369ef4>] path_lookupat+0x110/0x2b4
> [   38.403203] c7   1827 [<ffffff900835dd38>] filename_lookup+0x1d8/0x3a8
> [   38.403216] c7   1827 [<ffffff900835eeb0>] user_path_at_empty+0x54/0x68
> [   38.403229] c7   1827 [<ffffff9008395f44>] SyS_getxattr+0xb4/0x18c
> [   38.403241] c7   1827 [<ffffff9008084200>] el0_svc_naked+0x34/0x38
> 
> Bug: 126558260
> 
> Signed-off-by: Randall Huang <huangrandall@google.com>

Looks good to me now. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> +	unsigned int xattr_nid_size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;

Nitpick, xnode_size or xattr_node_size will be better than xattr_nid_size?

Maybe Jaegeuk can help to change this when merging this patch, no new version
patch needed.

Thanks,
