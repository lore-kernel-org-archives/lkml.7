Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FBEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8AB207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfCJG7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 01:59:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:54138 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfCJG7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 01:59:41 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 50BBC14C1FD66;
        Sat,  9 Mar 2019 22:59:40 -0800 (PST)
Date:   Sat, 09 Mar 2019 22:59:37 -0800 (PST)
Message-Id: <20190309.225937.1758549479086621930.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, shiju.jose@huawei.com
Subject: Re: [PATCH net] net: hns3: fix to stop multiple HNS reset due to
 the AER changes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1552200471-47492-1-git-send-email-tanhuazhong@huawei.com>
References: <1552200471-47492-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 09 Mar 2019 22:59:40 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Sun, 10 Mar 2019 14:47:51 +0800

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> The commit bfcb79fca19d
> ("PCI/ERR: Run error recovery callbacks for all affected devices")
> affected the non-fatal error recovery logic for the HNS and RDMA devices.
> This is because each HNS PF under PCIe bus receive callbacks
> from the AER driver when an error is reported for one of the PF.
> This causes unwanted PF resets because
> the HNS decides which PF to reset based on the reset type set.
> The HNS error handling code sets the reset type based on the hw error
> type detected.
> 
> This patch provides fix for the above issue for the recovery of
> the hw errors in the HNS and RDMA devices.
> 
> This patch needs backporting to the kernel v5.0+
> 
> Fixes: 332fbf576579 ("net: hns3: add handling of hw ras errors using new set of commands")
> Reported-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>

Applied and queued up for -stable, thanks.
