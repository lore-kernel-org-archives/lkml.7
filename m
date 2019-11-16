Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9465CC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 20:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7280620733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 20:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfKPUxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 15:53:20 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53638 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfKPUxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 15:53:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5E8941518AA6D;
        Sat, 16 Nov 2019 12:53:17 -0800 (PST)
Date:   Sat, 16 Nov 2019 12:53:16 -0800 (PST)
Message-Id: <20191116.125316.1859622454319892445.davem@davemloft.net>
To:     wangxiaogang3@huawei.com
Cc:     dsahern@kernel.org, shrijeet@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hujunwei4@huawei.com,
        xuhanbing@huawei.com, ap420073@gmail.com
Subject: Re: [PATCH] vrf: Fix possible NULL pointer oops when delete nic
From:   David Miller <davem@davemloft.net>
In-Reply-To: <60e827cb-2bba-2b7e-55dc-651103e9905f@huawei.com>
References: <60e827cb-2bba-2b7e-55dc-651103e9905f@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 16 Nov 2019 12:53:17 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "wangxiaogang (F)" <wangxiaogang3@huawei.com>
Date: Fri, 15 Nov 2019 14:22:56 +0800

> From: XiaoGang Wang <wangxiaogang3@huawei.com>
> 
> Recently we get a crash when access illegal address (0xc0),
> which will occasionally appear when deleting a physical NIC with vrf.
> 
> [166603.826737]hinic 0000:43:00.4 eth-s3: Failed to cycle device eth-s3;
> route tables might be wrong!
> .....
> [166603.828018]WARNING: CPU: 135 PID: 15382at net/core/dev.c:6875
> __netdev_adjacent_dev_remove.constprop.40+0x1e0/0x1e8
> ......

Taehee-ssi, please take a look at this.

It is believed that this may be caused by the adjacency fixes you made
recently.

Thank you.
