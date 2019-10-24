Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A8DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E2920856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393011AbfJXJNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:13:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727653AbfJXJNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:13:05 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3BF70C2EBFE337937027;
        Thu, 24 Oct 2019 17:13:03 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 24 Oct
 2019 17:12:59 +0800
Subject: =?UTF-8?Q?Re:_[f2fs-dev]_[bug_report]_compiler_warning:_fs/f2fs/nod?=
 =?UTF-8?B?ZS5jOiBJbiBmdW5jdGlvbiDigJhfX3NldF9uYXRfY2FjaGVfZGlydHnigJk6IA==?=
 =?UTF-8?Q?=e2=80=98head=e2=80=99_may_be_used_uninitialized?=
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>
References: <fc71f3b73116115f78bcee2753e7bb3d5331731e.camel@analog.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e815981a-50ef-0f49-cab6-e510ea44ddc0@huawei.com>
Date:   Thu, 24 Oct 2019 17:12:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fc71f3b73116115f78bcee2753e7bb3d5331731e.camel@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/23 22:02, Ardelean, Alexandru wrote:
> Seems to have been introduced via:
> 
> ----------------------------------------------------------------
> 
> commit 780de47cf6cb5f524cd98ec8ffbffc3da5696e17
> Author: Chao Yu <yuchao0@huawei.com>
> Date:   Tue Mar 20 23:08:30 2018 +0800
> 
>     f2fs: don't track new nat entry in nat set
>     
>     Nat entry set is used only in checkpoint(), and during checkpoint() we
>     won't flush new nat entry with unallocated address, so we don't need to
>     add new nat entry into nat set, then nat_entry_set::entry_cnt can
>     indicate actual entry count we need to flush in checkpoint().
>     
>     Signed-off-by: Yunlei He <heyunlei@huawei.com>
>     Signed-off-by: Chao Yu <yuchao0@huawei.com>
>     Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ----------------------------------------------------------------
> 
> Compiler warning is:
> ----------------------------------------------------------------
> 
>   CC      fs/f2fs/node.o
> In file included from ./include/linux/wait.h:7:0,
>                  from ./include/linux/wait_bit.h:8,
>                  from ./include/linux/fs.h:6,
>                  from fs/f2fs/node.c:11:
> fs/f2fs/node.c: In function ‘__set_nat_cache_dirty’:
> ./include/linux/list.h:63:13: error: ‘head’ may be used uninitialized in
> this function [-Werror=maybe-uninitialized]
>   next->prev = new;
>              ^
> fs/f2fs/node.c:238:24: note: ‘head’ was declared here
>   struct nat_entry_set *head;

That's not correct, @head will only be assigned and used if new_ne equals NULL.

Thanks,

>                         ^
> cc1: all warnings being treated as errors
> ----------------------------------------------------------------
> 
> Thanks
> Alex
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
