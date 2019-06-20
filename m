Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232B1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021BA21537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfFTBqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 21:46:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfFTBqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 21:46:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0996FF91209E76EABC8A;
        Thu, 20 Jun 2019 09:46:40 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 20 Jun
 2019 09:46:35 +0800
Subject: Re: [PATCH 4.19 33/75] f2fs: fix to avoid accessing xattr across the
 boundary
To:     Pavel Machek <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>,
        Randall Huang <huangrandall@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
References: <20190617210752.799453599@linuxfoundation.org>
 <20190617210754.076823433@linuxfoundation.org>
 <20190619123210.GA14477@xo-6d-61-c0.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d77e58a9-561d-7fbd-bee8-592c7d21df64@huawei.com>
Date:   Thu, 20 Jun 2019 09:46:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190619123210.GA14477@xo-6d-61-c0.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 2019/6/19 20:32, Pavel Machek wrote:
> Hi!
> 
>> When we traverse xattr entries via __find_xattr(),
>> if the raw filesystem content is faked or any hardware failure occurs,
>> out-of-bound error can be detected by KASAN.
>> Fix the issue by introducing boundary check.
> 
> Ok, so this prevents fs corruption from causing problems,
> 
>> @@ -340,7 +347,11 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>>  	else
>>  		cur_addr = txattr_addr;
>>  
>> -	*xe = __find_xattr(cur_addr, index, len, name);
>> +	*xe = __find_xattr(cur_addr, last_txattr_addr, index, len, name);
>> +	if (!*xe) {
>> +		err = -EFAULT;
>> +		goto out;
>> +	}
> 
> Is -EFAULT suitable here? We do not have userspace passing pointers to us, we
> have fs corruption. -EUNCLEAN?

Oh, right, f2fs uses -EFAULT as error number to indicate filesystem is corrupted
all the time, we need to fix it to follow other generic fs.

> 
> Should it do some kind of printk to let the user know fs is corrupted, and mark
> it as needing fsck?

Agreed, let me add it. :)

Thanks,

> 
> Thanks,
> 									Pavel
> .
> 
