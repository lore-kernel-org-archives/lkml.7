Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8896C2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C4C206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfLWDgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 22:36:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbfLWDgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 22:36:54 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9596178A61233CC983FF;
        Mon, 23 Dec 2019 11:36:52 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 23 Dec
 2019 11:36:50 +0800
Subject: Re: [RFC PATCH v5] f2fs: support data compression
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <CAMuHMdVvqccd_iwdz8khxYKUjrD-pnBYggagVCYZyNmbZxB9Tw@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f8072007-94c9-6d37-b0ff-37538cf8bf98@huawei.com>
Date:   Mon, 23 Dec 2019 11:36:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVvqccd_iwdz8khxYKUjrD-pnBYggagVCYZyNmbZxB9Tw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/19 17:53, Geert Uytterhoeven wrote:
> On Mon, Dec 16, 2019 at 7:29 AM Chao Yu <yuchao0@huawei.com> wrote:
>> This patch tries to support compression in f2fs.
> 
>> +static int f2fs_write_raw_pages(struct compress_ctx *cc,
>> +                                       int *submitted,
>> +                                       struct writeback_control *wbc,
>> +                                       enum iostat_type io_type,
>> +                                       bool compressed)
>> +{
>> +       int i, _submitted;
>> +       int ret, err = 0;
>> +
>> +       for (i = 0; i < cc->cluster_size; i++) {
>> +               if (!cc->rpages[i])
>> +                       continue;
>> +retry_write:
>> +               BUG_ON(!PageLocked(cc->rpages[i]));
>> +
>> +               ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
>> +                                               NULL, NULL, wbc, io_type);
>> +               if (ret) {
>> +                       if (ret == AOP_WRITEPAGE_ACTIVATE) {
>> +                               unlock_page(cc->rpages[i]);
>> +                               ret = 0;
>> +                       } else if (ret == -EAGAIN) {
>> +                               ret = 0;
>> +                               cond_resched();
>> +                               congestion_wait(BLK_RW_ASYNC, HZ/50);
> 
> On some platforms, HZ can be less than 50.
> What happens if congestion_wait() is called with a zero timeout?

Thanks for the report, will fix in a separated patch.

Thanks,

> 
>> +                               lock_page(cc->rpages[i]);
>> +                               clear_page_dirty_for_io(cc->rpages[i]);
>> +                               goto retry_write;
>> +                       }
>> +                       err = ret;
>> +                       goto out_fail;
>> +               }
>> +
>> +               *submitted += _submitted;
>> +       }
>> +       return 0;
>> +
>> +out_fail:
>> +       /* TODO: revoke partially updated block addresses */
>> +       BUG_ON(compressed);
>> +
>> +       for (++i; i < cc->cluster_size; i++) {
>> +               if (!cc->rpages[i])
>> +                       continue;
>> +               redirty_page_for_writepage(wbc, cc->rpages[i]);
>> +               unlock_page(cc->rpages[i]);
>> +       }
>> +       return err;
>> +}
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
