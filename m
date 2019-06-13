Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE60C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E777E20644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfFMQl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:41:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730544AbfFMGwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:52:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 752E458E9C515F587F46;
        Thu, 13 Jun 2019 14:52:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 14:52:44 +0800
Subject: Re: [PATCH] f2fs: fix is_idle() check for discard type
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1559813893-23452-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d3b4b733-78ab-29bb-9441-c6e4e7efaea9@huawei.com>
Date:   Thu, 13 Jun 2019 14:52:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1559813893-23452-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/6 17:38, Sahitya Tummala wrote:
> The discard thread should issue upto dpolicy->max_requests at once
> and wait for all those discard requests at once it reaches
> dpolicy->max_requests. It should then sleep for dpolicy->min_interval
> timeout before issuing the next batch of discard requests. But in the
> current code of is_idle(), it checks for dcc_info->queued_discard and
> aborts issuing the discard batch of max_requests. This
> dcc_info->queued_discard will be true always once one discard command
> is issued.
> 
> It is thus resulting into this type of discard request pattern -
> 
> - Issue discard request#1
> - is_idle() returns false, discard thread waits for request#1 and then
>   sleeps for min_interval 50ms.
> - Issue discard request#2
> - is_idle() returns false, discard thread waits for request#2 and then
>   sleeps for min_interval 50ms.
> - and so on for all other discard requests, assuming f2fs is idle w.r.t
>   other conditions.
> 
> With this fix, the pattern will look like this -
> 
> - Issue discard request#1
> - Issue discard request#2
>   and so on upto max_requests of 8
> - Issue discard request#8
> - wait for min_interval 50ms.
> 

Fixes: fef4129ec2e6 ("f2fs: fix to be aware discard/preflush/dio command in
is_idle()")

> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Ah, thanks for fixing this bug.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
