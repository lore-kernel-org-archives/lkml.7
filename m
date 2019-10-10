Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F204DC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC7A206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbfJJBc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 21:32:29 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:45488 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731134AbfJJBc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 21:32:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Teawj-t_1570671144;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Teawj-t_1570671144)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Oct 2019 09:32:24 +0800
Subject: Re: [PATCH] ocfs2:fix potential Null Ptr Dereference
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ChenGang <cg.chen@huawei.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jia Guo <guojia12@huawei.com>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20191010010752.25941-1-yzhai003@ucr.edu>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <76706fdf-6758-991c-de94-fe823251a3a3@linux.alibaba.com>
Date:   Thu, 10 Oct 2019 09:32:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010010752.25941-1-yzhai003@ucr.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/10/10 09:07, Yizhuo wrote:
> Inside function o2hb_region_blocks_store(), to_o2hb_region()
> could return NULL but there's no check before its dereference,
> which is potentially unsafe.

As I described before, this won't happen IMHO.
configfs item is initialized after loading module, so region should
be valid here.


Thanks,
Joseph

> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  fs/ocfs2/cluster/heartbeat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index a368350d4c27..93f2b540f245 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -1628,7 +1628,7 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
>  	unsigned long tmp;
>  	char *p = (char *)page;
>  
> -	if (reg->hr_bdev)
> +	if (!reg || reg->hr_bdev)
>  		return -EINVAL;
>  
>  	tmp = simple_strtoul(p, &p, 0);
> 
