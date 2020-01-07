Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFBEC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663F12077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgAGL2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:28:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727273AbgAGL2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:28:15 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ECD2ACAFF8A55516728D;
        Tue,  7 Jan 2020 19:28:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 7 Jan 2020
 19:28:11 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix miscounted block limit in
 f2fs_statfs_project()
To:     Chengguang Xu <cgxu519@mykernel.net>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200104142004.12883-1-cgxu519@mykernel.net>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a3fd21e0-1f54-0f36-b016-e474ff50fdda@huawei.com>
Date:   Tue, 7 Jan 2020 19:28:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200104142004.12883-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/4 22:20, Chengguang Xu wrote:
> statfs calculates Total/Used/Avail disk space in block unit,
> so we should translate soft/hard prjquota limit to block unit
> as well.
> 
> Below testing result shows the block/inode numbers of
> Total/Used/Avail from df command are all correct afer
> applying this patch.
> 
> [root@localhost quota-tools]\# ./repquota -P /dev/sdb1
> *** Report for project quotas on device /dev/sdb1
> Block grace time: 7days; Inode grace time: 7days
>               Block limits                File limits
> Project   used soft    hard  grace  used  soft  hard  grace
> -----------------------------------------------------------
> \#0   --   4       0       0         1     0     0
> \#101 --   0       0       0         2     0     0
> \#102 --   0   10240       0         2    10     0
> \#103 --   0       0   20480         2     0    20
> \#104 --   0   10240   20480         2    10    20
> \#105 --   0   20480   10240         2    20    10
> 
> [root@localhost sdb1]\# lsattr -p t{1,2,3,4,5}
>   101 ----------------N-- t1/a1
>   102 ----------------N-- t2/a2
>   103 ----------------N-- t3/a3
>   104 ----------------N-- t4/a4
>   105 ----------------N-- t5/a5
> 
> [root@localhost sdb1]\# df -hi t{1,2,3,4,5}
> Filesystem     Inodes IUsed IFree IUse% Mounted on
> /dev/sdb1        2.4M    21  2.4M    1% /mnt/sdb1
> /dev/sdb1          10     2     8   20% /mnt/sdb1
> /dev/sdb1          20     2    18   10% /mnt/sdb1
> /dev/sdb1          10     2     8   20% /mnt/sdb1
> /dev/sdb1          10     2     8   20% /mnt/sdb1
> 
> [root@localhost sdb1]\# df -h t{1,2,3,4,5}
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sdb1        10G  489M  9.6G   5% /mnt/sdb1
> /dev/sdb1        10M     0   10M   0% /mnt/sdb1
> /dev/sdb1        20M     0   20M   0% /mnt/sdb1
> /dev/sdb1        10M     0   10M   0% /mnt/sdb1
> /dev/sdb1        10M     0   10M   0% /mnt/sdb1
> 
> Fixes: 909110c060f2 ("f2fs: choose hardlimit when softlimit is larger than hardlimit in f2fs_statfs_project()")
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
