Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB46CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDA32080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfJaCDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 22:03:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfJaCDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 22:03:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63DA9B70C12BC89C0E01;
        Thu, 31 Oct 2019 10:03:32 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 31 Oct
 2019 10:03:22 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: bio_alloc should never fail
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Gao Xiang <gaoxiang25@huawei.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20191030035518.65477-1-gaoxiang25@huawei.com>
 <20aa40bd-280d-d223-9f73-d9ed7dbe4f29@huawei.com>
 <20191030091542.GA24976@architecture4>
 <19a417e6-8f0e-564e-bc36-59bfc883ec16@huawei.com>
 <20191030104345.GB170703@architecture4> <20191030151444.GC16197@mit.edu>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <61fc6d47-1cb3-4646-d155-444cff0b5b3e@huawei.com>
Date:   Thu, 31 Oct 2019 10:03:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191030151444.GC16197@mit.edu>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/30 23:14, Theodore Y. Ts'o wrote:
> On Wed, Oct 30, 2019 at 06:43:45PM +0800, Gao Xiang wrote:
>>> You're right, in low memory scenario, allocation with bioset will be faster, as
>>> you mentioned offline, maybe we can add/use a priviate bioset like btrfs did
>>> rather than using global one, however, we'd better check how deadlock happen
>>> with a bioset mempool first ...
>>
>> Okay, hope to get hints from Jaegeuk and redo this patch then...
> 
> It's not at all clear to me that using a private bioset is a good idea
> for f2fs.  That just means you're allocating a separate chunk of
> memory just for f2fs, as opposed to using the global pool.  That's an
> additional chunk of non-swapable kernel memory that's not going to be
> available, in *addition* to the global mempool.  
> 
> Also, who else would you be contending for space with the global
> mempool?  It's not like an mobile handset is going to have other users
> of the global bio mempool.
> 
> On a low-end mobile handset, memory is at a premium, so wasting memory
> to no good effect isn't going to be a great idea.

You're right, it looks that the purpose that btrfs added private bioset is to
avoid abusing bio internal fields (via commit 9be3395bcd4a), f2fs has no such
reason to do that now.

Thanks,

> 
> Regards,
> 
> 						- Ted
> .
> 
