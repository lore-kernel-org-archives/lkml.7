Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EF3C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE32214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbfDYBgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:36:53 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:33014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728775AbfDYBgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:36:52 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id AD685A898FA635AAC9C9;
        Thu, 25 Apr 2019 09:36:49 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 09:36:49 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 25 Apr 2019 09:36:48 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: relocate chksum_offset for
 large_nat_bitmap feature
To:     Ju Hyung Park <qkrwngud825@gmail.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190422093353.61014-1-yuchao0@huawei.com>
 <20190422093353.61014-2-yuchao0@huawei.com>
 <CAD14+f0D9CVmBZGmbMcKB7xAHvBrbGAgVxR4W8Fiu0Vo6czDYQ@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cd4b13a5-9b59-aa53-5859-f52275b4d9d7@huawei.com>
Date:   Thu, 25 Apr 2019 09:36:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD14+f0D9CVmBZGmbMcKB7xAHvBrbGAgVxR4W8Fiu0Vo6czDYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ju Hyung,

On 2019/4/24 19:43, Ju Hyung Park wrote:
> Hi Chao,
> 
> On Mon, Apr 22, 2019 at 6:34 PM Chao Yu <yuchao0@huawei.com> wrote:
>> +       if (__is_set_ckpt_flags(*cp_block, CP_LARGE_NAT_BITMAP_FLAG)) {
>> +               if (crc_offset != CP_MIN_CHKSUM_OFFSET) {
>> +                       f2fs_put_page(*cp_page, 1);
>> +                       f2fs_msg(sbi->sb, KERN_WARNING,
>> +                               "layout of large_nat_bitmap is deprecated, "
>> +                               "run fsck to repair, chksum_offset: %zu",
>> +                               crc_offset);
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
> 
> I try not to be a Grammar Nazi and a jerk on every patches, but since
> this is a message a user would directly encounter, I'd like to see a
> bit less ambiguous message.

Please feel free to give us your opinion or suggestion. :)

> 
> How about "using deprecated layout of large_nat_bitmap, please run
> fsck v1.13.0 or higher to repair, chksum_offset: %zu"?
> The original message seems to suggest that large_nat_bitmap is
> deprecated outright.
> 
> Also, I'd like to suggest to write down an actual version of
> f2fs-tools here as we've seen older versions of fsck doing even more
> damage and the users might not have the latest f2fs-tools installed.

Agreed, user should be told which version of fsck can repair that problem, will
update the message in next version.

> 
> Btw, what happens if we use the latest fsck to fix the corrupted image
> and use the older kernel to mount it?
> Would it even mount?

No, since fixed image is using a new layout, how about giving the detailed
information about which version of kernel user should update to, once we detect
such issue and trigger the repairing?

Thanks,

> 
> Thanks.
> .
> 
