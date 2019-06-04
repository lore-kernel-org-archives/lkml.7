Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4C2C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB8024B36
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfFDJ4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:56:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727075AbfFDJ4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:56:37 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7D02DE4F6DB8E951CA4C;
        Tue,  4 Jun 2019 17:48:55 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019
 17:48:53 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add a rw_sem to cover quota flag
 changes
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190530033115.16853-1-jaegeuk@kernel.org>
 <20190530175714.GB28719@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c4348b1c-02ba-44e7-598c-e2435e53077d@huawei.com>
Date:   Tue, 4 Jun 2019 17:48:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190530175714.GB28719@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/31 1:57, Jaegeuk Kim wrote:
> thread 1:                        thread 2:
> writeback                        checkpoint
> set QUOTA_NEED_FLUSH
>                                  clear QUOTA_NEED_FLUSH
> f2fs_dquot_commit
> dquot_commit
> clear_dquot_dirty
>                                  f2fs_quota_sync
>                                  dquot_writeback_dquots
> 				 nothing to commit
> commit_dqblk
> quota_write
> f2fs_quota_write
> waiting for f2fs_lock_op()
> 				 pass __need_flush_quota
>                                  (no F2FS_DIRTY_QDATA)
> 
> -> up-to-date quota is not written
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
