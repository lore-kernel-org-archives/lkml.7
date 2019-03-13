Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0552FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00CA2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfCMBRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 21:17:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfCMBRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 21:17:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 07C24267DD869F72A3E8;
        Wed, 13 Mar 2019 09:17:43 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Mar 2019
 09:17:41 +0800
Subject: Re: [PATCH v11] f2fs: guarantee journalled quota data by checkpoint
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Weichao Guo <guoweichao@huawei.com>
References: <20180920120500.21026-1-chao@kernel.org>
 <7a2b9277-acbf-eda4-d043-74463d7b61c7@huawei.com>
 <20190312182855.GA45421@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d87fbaf6-8291-0629-4555-f2687e1d890c@huawei.com>
Date:   Wed, 13 Mar 2019 09:17:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190312182855.GA45421@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/13 2:28, Jaegeuk Kim wrote:
> On 03/06, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2018/9/20 20:05, Chao Yu wrote:
>>> @@ -3456,3 +3477,16 @@
>>>
>>>  extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
>>>
>>> #endif
>>> #endif
>>> +
>>> +static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
>>> +{
>>> +#ifdef CONFIG_QUOTA
>>> + if (f2fs_sb_has_quota_ino(sbi->sb))
>>> + return true;
>>> + if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
>>> + F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
>>> + F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
>>> + return true;
>>> +#endif
>>> + return false;
>>> +}
>>
>> I checked dev branch, and found one patch we didn't send to mailing list,
>> could you please send it out?
>>
>> f2fs: fix wrong #endif
>>
>> I think my quota patch caused this 'wrong #endif' issue, could you add
>> single line comment to notice which #if the last #endif is corresponding
>> to? so that we can avoid same mistake as quota patch made.
> 
> Ah, I forgot to post the patch. It's quite late but obvious, and thus let me
> keep the patch as is in order to avoid messing up the commit history.

Okay, let me add one other patch for that. :)

Thanks,

> 
> Thanks,
> 
> .
> 

