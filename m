Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39801C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B59020693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfGaNxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:53:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726592AbfGaNxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:53:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 29BB07C62749BD52773B;
        Wed, 31 Jul 2019 21:53:10 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 21:52:59 +0800
Subject: Re: [PATCH v5 12/24] erofs: introduce tagged pointer
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Jan Kara <jack@suse.cz>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "David Sterba" <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190730071413.11871-1-gaoxiang25@huawei.com>
 <20190730071413.11871-13-gaoxiang25@huawei.com>
 <20190731130148.GE15806@quack2.suse.cz>
 <204b7fcc-a54b-ebd6-ff4c-2d5e2e6d4a8c@huawei.com>
Message-ID: <e2f2c550-8d1f-39f5-3bd9-b6de996da9ad@huawei.com>
Date:   Wed, 31 Jul 2019 21:52:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <204b7fcc-a54b-ebd6-ff4c-2d5e2e6d4a8c@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/31 21:20, Gao Xiang wrote:
>    struct b *ptr = tagptr_unfold_tags(tptr);
> vs
>    struct b *ptr = (struct b *)((unsigned long)tptr & ~2);

Sorry ... a too stupid typo issue, I mean....

struct b *ptr = tagptr_unfold_ptr(tptr);
vs
struct b *ptr = (struct b *)((unsigned long)tptr & ~3);

Thanks,
Gao Xiang
