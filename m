Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C7DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1367E206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLJGUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:20:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7655 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfLJGUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:20:18 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C5BBAE8131B8A882445F;
        Tue, 10 Dec 2019 14:20:15 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 10 Dec
 2019 14:20:11 +0800
Subject: Re: [f2fs-dev] [PATCH 2/6] f2fs: declare nested quota_sem and remove
 unnecessary sems
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
 <20191209222345.1078-2-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0668612e-678c-e434-277b-d393b9933250@huawei.com>
Date:   Tue, 10 Dec 2019 14:20:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191209222345.1078-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/10 6:23, Jaegeuk Kim wrote:
> 1.
> f2fs_quota_sync
>  -> down_read(&sbi->quota_sem)
>  -> dquot_writeback_dquots
>   -> f2fs_dquot_commit
>    -> down_read(&sbi->quota_sem)
> 
> 2.
> f2fs_quota_sync
>  -> down_read(&sbi->quota_sem)
>   -> f2fs_write_data_pages
>    -> f2fs_write_single_data_page
>     -> down_write(&F2FS_I(inode)->i_sem)
> 
> f2fs_mkdir
>  -> f2fs_do_add_link
>    -> down_write(&F2FS_I(inode)->i_sem)
>    -> f2fs_init_inode_metadata
>     -> f2fs_new_node_page
>      -> dquot_alloc_inode
>       -> f2fs_dquot_mark_dquot_dirty
>        -> down_read(&sbi->quota_sem)
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
