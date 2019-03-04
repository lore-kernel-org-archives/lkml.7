Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C66BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758622082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfCDFPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:15:20 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57014 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfCDFPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:15:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B2BA514D42E33;
        Sun,  3 Mar 2019 21:15:18 -0800 (PST)
Date:   Sun, 03 Mar 2019 21:15:18 -0800 (PST)
Message-Id: <20190303.211518.1265133811120263144.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, shenjian15@huawei.com
Subject: Re: [PATCH net] net: hns3: add rmb() for rx description
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1551516570-1067-1-git-send-email-tanhuazhong@huawei.com>
References: <1551516570-1067-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Mar 2019 21:15:19 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Sat, 2 Mar 2019 16:49:30 +0800

> From: Jian Shen <shenjian15@huawei.com>
> 
> HW can not guarantee complete write desc->rx.size, even though
> HNS3_RXD_VLD_B has been set. Driver needs to add rmb() instruction
> to make sure desc->rx.size is always valid.
> 
> Fixes: e55970950556 ("net: hns3: Add handling of GRO Pkts not fully RX'ed in NAPI poll")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>

dma_rmb() is more appropriate here and more efficient.
