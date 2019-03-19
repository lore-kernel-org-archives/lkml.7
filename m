Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A71C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753002146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCSUqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:46:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53312 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfCSUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:46:46 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CAF0214691762;
        Tue, 19 Mar 2019 13:46:45 -0700 (PDT)
Date:   Tue, 19 Mar 2019 13:46:45 -0700 (PDT)
Message-Id: <20190319.134645.1866261157636933653.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     idosch@mellanox.com, alexander.h.duyck@intel.com,
        tyhicks@canonical.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net-sysfs: call dev_hold if kobject_init_and_add
 success
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190319021653.2584-1-yuehaibing@huawei.com>
References: <20190319021653.2584-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Mar 2019 13:46:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Tue, 19 Mar 2019 10:16:53 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> In netdev_queue_add_kobject and rx_queue_add_kobject,
> if sysfs_create_group failed, kobject_put will call
> netdev_queue_release to decrease dev refcont, however
> dev_hold has not be called. So we will see this while
> unregistering dev:
> 
> unregister_netdevice: waiting for bcsh0 to become free. Usage count = -1
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: d0d668371679 ("net: don't decrement kobj reference count on init failure")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied and queued up for -stable.
