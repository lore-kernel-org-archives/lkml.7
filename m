Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B079C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B55A2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfDDEnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 00:43:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35300 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfDDEnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 00:43:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DE078144E3E02;
        Wed,  3 Apr 2019 21:43:14 -0700 (PDT)
Date:   Wed, 03 Apr 2019 21:43:14 -0700 (PDT)
Message-Id: <20190403.214314.643123707100892779.davem@davemloft.net>
To:     hujunwei4@huawei.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingfangsen@huawei.com, liuzhiqiang26@huawei.com
Subject: Re: [PATCH v4 net] ipv6: Fix dangling pointer when ipv6 fragment
From:   David Miller <davem@davemloft.net>
In-Reply-To: <aaccfa09-8acf-e247-ab71-3d6ec3803f55@huawei.com>
References: <aaccfa09-8acf-e247-ab71-3d6ec3803f55@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 03 Apr 2019 21:43:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: hujunwei <hujunwei4@huawei.com>
Date: Tue, 2 Apr 2019 19:38:04 +0800

> From: Junwei Hu <hujunwei4@huawei.com>
> 
> At the beginning of ip6_fragment func, the prevhdr pointer is
> obtained in the ip6_find_1stfragopt func.
> However, all the pointers pointing into skb header may change
> when calling skb_checksum_help func with
> skb->ip_summed = CHECKSUM_PARTIAL condition.
> The prevhdr pointe will be dangling if it is not reloaded after
> calling __skb_linearize func in skb_checksum_help func.
> 
> Here, I add a variable, nexthdr_offset, to evaluate the offset,
> which does not changes even after calling __skb_linearize func.
> 
> Fixes: 405c92f7a541 ("ipv6: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
> Signed-off-by: Junwei Hu <hujunwei4@huawei.com>
> Reported-by: Wenhao Zhang <zhangwenhao8@huawei.com>
> Reported-by: syzbot+e8ce541d095e486074fc@syzkaller.appspotmail.com
> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> ---
> V3->V4:
> - fix build warning

Applied and queued up for -stable.
