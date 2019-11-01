Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F09CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1447D217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfKAKFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:05:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728048AbfKAKFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:05:51 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 263B1D67FC4C1998E218;
        Fri,  1 Nov 2019 18:05:49 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 1 Nov 2019
 18:05:46 +0800
Subject: Re: [RFC PATCH v2] f2fs: support data compression
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20191029092730.109428-1-yuchao0@huawei.com>
 <20191031160105.GC60005@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <33c09ea0-b521-77b7-dd84-a3ede003a793@huawei.com>
Date:   Fri, 1 Nov 2019 18:05:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191031160105.GC60005@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/1 0:01, Jaegeuk Kim wrote:
>> +f2fs-$(CONFIG_FS_COMPRESSION) += compress.o
> CONFIG_F2FS_FS_COMPRESSION?

Fixed.

> 
>> +#ifdef F2FS_FS_COMPRESSION
> Do we need this?

Ditto.

> 
>> +bool f2fs_is_compress_backend_ready(struct inode *inode)
>> +{
>> +	if (!f2fs_compressed_file(inode))
>> +		return true;
> #ifdef F2FS_FS_COMPRESSION
>> +	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
> #else
> 	return -EOPNOTSUPP;
> #endif

Ditto, I kept return value as boolean.

> 
