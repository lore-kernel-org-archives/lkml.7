Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E613FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06F820675
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfENI34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:29:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3009 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbfENI34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:29:56 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 2A642CAC562BAF98E832;
        Tue, 14 May 2019 16:29:54 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 May 2019 16:29:53 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 14 May 2019 16:29:53 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: issue discard commands proactively in
 high fs utilization
To:     Ju Hyung Park <qkrwngud825@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180529205048.39694-1-jaegeuk@kernel.org>
 <CAD14+f154_t1-TbbSDb9xV_ikDAWfF+8H7aOSK4VF8UmqWRDAQ@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <73fc6da8-7b89-3b02-8856-bd6876c50259@huawei.com>
Date:   Tue, 14 May 2019 16:29:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD14+f154_t1-TbbSDb9xV_ikDAWfF+8H7aOSK4VF8UmqWRDAQ@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
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

On 2019/5/14 13:39, Ju Hyung Park wrote:
> On Wed, May 30, 2018 at 5:51 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>>
>> In the high utilization like over 80%, we don't expect huge # of large discard
>> commands, but do many small pending discards which affects FTL GCs a lot.
>> Let's issue them in that case.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 6e40e536dae0..8c1f7a6bf178 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -915,6 +915,38 @@ static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
>> +                       dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> 
> Isn't this way too aggressive?
> 
> Discard thread will wake up on 50ms interval just because the user has
> used 80% of space.
> 60,000ms vs 50ms is too much of a stark difference.
> 
> I feel something like 10 seconds(10,000ms) could be a much more
> reasonable choice than this.

Hmm.. I agree that current hard code method is not flexible enough, and I
proposed below patch last year to adjust interval according to space usage, it
looks Jaegeuk partially agreed with that, and pointed out we need to distinguish
low/high-end storage to decide interval. And also you point out that btrfs
introduces mount option "ssd" to let user give the device type, and we can
distinguish with that. :P

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=009f548e37ca5d9b4cad9e3c15c2164c53eff1df

But I pended below patch based on Jaegeuk's and your idea due to other work...

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=47a992c12398c98e739e3eedc2743824459df943

Thanks,

> 
> Thanks.
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
