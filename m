Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF155218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfCUU76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:59:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53240 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCUU75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:59:57 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5015B133E9775;
        Thu, 21 Mar 2019 13:59:56 -0700 (PDT)
Date:   Thu, 21 Mar 2019 13:59:55 -0700 (PDT)
Message-Id: <20190321.135955.1938105690350887430.davem@davemloft.net>
To:     linyunsheng@huawei.com
Cc:     huangdaode@hisilicon.com, xuwei5@hisilicon.com,
        liguozhu@hisilicon.com, Yisen.Zhuang@huawei.com,
        john.garry@huawei.com, linuxarm@huawei.com, salil.mehta@huawei.com,
        lipeng321@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: hns3: fix for not calculating tx bd num
 correctly
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1553138923-122549-1-git-send-email-linyunsheng@huawei.com>
References: <1553138923-122549-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Mar 2019 13:59:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: l00371289 <linyunsheng@huawei.com>
Date: Thu, 21 Mar 2019 11:28:43 +0800

> From: Yunsheng Lin <linyunsheng@huawei.com>
> 
> When there is only one byte in a frag, the current calculation
> using "(size + HNS3_MAX_BD_SIZE - 1) >> HNS3_MAX_BD_SIZE_OFFSET"
> will return zero, because HNS3_MAX_BD_SIZE is 65535 and
> HNS3_MAX_BD_SIZE_OFFSET is 16. So it will cause tx error when
> a frag's size is one byte.
> 
> This patch fixes it by using DIV_ROUND_UP.
> 
> Fixes: 3fe13ed95dd3 ("net: hns3: avoid mult + div op in critical data path")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

Applied.
