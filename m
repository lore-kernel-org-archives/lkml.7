Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC22C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5D2206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfGZDTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:19:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfGZDTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:19:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 273C2B958C07B3984965;
        Fri, 26 Jul 2019 11:19:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 26 Jul
 2019 11:19:43 +0800
Subject: Re: [BUG] fs: f2fs: Possible null-pointer dereferences in
 update_general_status()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <f577be2f-fc2f-9ef8-2c6c-9c247123b1ad@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2d66cd56-eccf-9086-c5db-118acce717a6@huawei.com>
Date:   Fri, 26 Jul 2019 11:19:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f577be2f-fc2f-9ef8-2c6c-9c247123b1ad@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaju,

Thanks for the report, I checked the code, and found it doesn't need to check
SM_I(sbi) pointer, this is because in fill_super() and put_super(), we will call
f2fs_destroy_stats() in prior to f2fs_destroy_segment_manager(), so if current
sbi can still be visited in global stat list, SM_I(sbi) should be released yet.
So anyway, let's remove unneeded check in line 70/78. :)

Thanks,

On 2019/7/25 17:49, Jia-Ju Bai wrote:
> In update_general_status(), there are two if statements to
> check whether SM_I(sbi) is NULL:
> LINE 70:     if (SM_I(sbi) && SM_I(sbi)->fcc_info)
> LINE 78:     if (SM_I(sbi) && SM_I(sbi)->dcc_info)
> 
> When SM_I(sbi) is NULL, it is used at some places, such as:
> LINE 88: reserved_segments(sbi)
>                    return SM_I(sbi)->reserved_segments;
> LINE 89: overprovision_segments(sbi)
>                    return SM_I(sbi)->ovp_segments;
> LINE 112: MAIN_SEGS(sbi)
>                      (SM_I(sbi)->main_segments)
> 
> Thus, possible null-pointer dereferences may occur.
> 
> These bugs are found by a static analysis tool STCheck written by us.
> 
> I do not know how to correctly fix these bugs, so I only report them.
> 
> 
> Best wishes,
> Jia-Ju Bai
> .
> 
