Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA802C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 07:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F5E23697
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 07:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfHaHXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 03:23:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46324 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfHaHXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 03:23:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 487D385FE885572E61D9;
        Sat, 31 Aug 2019 15:23:10 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 31 Aug
 2019 15:23:07 +0800
Subject: Re: [PATCH v4] f2fs: add bio cache for IPU
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190219081529.5106-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d2b3c101-0399-4e85-5765-7b6504aaca74@huawei.com>
Date:   Sat, 31 Aug 2019 15:23:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190219081529.5106-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/19 16:15, Chao Yu wrote:
> @@ -1976,10 +2035,13 @@ static int __write_data_page(struct page *page, bool *submitted,
>  	}
>  
>  	unlock_page(page);
> -	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode))
> +	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode)) {
> +		f2fs_submit_ipu_bio(sbi, bio, page);
>  		f2fs_balance_fs(sbi, need_balance_fs);
> +	}

Above bio submission was added to avoid below deadlock:

- __write_data_page
 - f2fs_do_write_data_page
  - set_page_writeback        ---- set writeback flag
  - f2fs_inplace_write_data
 - f2fs_balance_fs
  - f2fs_gc
   - do_garbage_collect
    - gc_data_segment
     - move_data_page
      - f2fs_wait_on_page_writeback
       - wait_on_page_writeback  --- wait writeback

However, it breaks the merge of IPU IOs, to solve this issue, it looks we need
to add global bio cache for such IPU merge case, then later
f2fs_wait_on_page_writeback can check whether writebacked page is cached or not,
and do the submission if necessary.

Jaegeuk, any thoughts?

Thanks,
