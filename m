Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C650EC2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 01:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1A3206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 01:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfLZBcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 20:32:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726881AbfLZBcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 20:32:19 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C44EFEE8CA7C40A2CB7B;
        Thu, 26 Dec 2019 09:32:14 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 26 Dec
 2019 09:32:10 +0800
Subject: Re: f2fs compile problem in next-20191220 on x86-32
To:     Pavel Machek <pavel@ucw.cz>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        <sfr@canb.auug.org.au>, <david@ixit.cz>
References: <20191222154917.GA22964@amd> <20191225130456.GA18929@duo.ucw.cz>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0d067e7a-e301-0c1a-c651-33845ad2c333@huawei.com>
Date:   Thu, 26 Dec 2019 09:32:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191225130456.GA18929@duo.ucw.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/25 21:04, Pavel Machek wrote:
> On Sun 2019-12-22 16:49:17, Pavel Machek wrote:
>> Hi!
>>
>> I'm getting this:
>>
>>   LD      .tmp_vmlinux1
>>   ld: fs/f2fs/file.o: in function `f2fs_truncate_blocks':
>>   file.c:(.text+0x2968): undefined reference to `__udivdi3'
>>   make: *** [Makefile:1079: vmlinux] Error 1
>>
>> when attempting to compile kernel for x86-32.
> 
> David bisected it:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=205967
> 
> And the bug is actually easy to see:
> 
> +int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
> +{
> +       u64 free_from = from;
> +
> +       /*
> +        * for compressed file, only support cluster size
> +        * aligned truncation.
> +        */
> +       if (f2fs_compressed_file(inode)) {
> +               size_t cluster_size = PAGE_SIZE <<
> +                                       F2FS_I(inode)->i_log_cluster_size;
> +
> +               free_from = roundup(from, cluster_size);
> 
> #define roundup(x, y) (                                 \
> {                                                       \
>         typeof(y) __y = y;                              \
>         (((x) + (__y - 1)) / __y) * __y;                \
> }                                                       \
> 
> div64 is needed instead of div in the roundup macro. Or actually... It
> is quite stupid to use roundup like this on value that is power of
> two, right?

This has been fixed in dev branch, could you check that? People still saw this
issue because linux-next did not update after we fix this bug.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev

Thanks,

> 
> Best regards,
> 									Pavel
> 
