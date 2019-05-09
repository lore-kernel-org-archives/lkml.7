Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A67C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C81E21019
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEIQuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:50:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36998 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfEIQuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:50:16 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9367114D0873D;
        Thu,  9 May 2019 09:50:15 -0700 (PDT)
Date:   Thu, 09 May 2019 09:50:15 -0700 (PDT)
Message-Id: <20190509.095015.756311298864539257.davem@davemloft.net>
To:     wangkefeng.wang@huawei.com
Cc:     yana.esina@aquantia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hulkci@huawei.com
Subject: Re: [PATCH] net: aquantia: fix undefined
 devm_hwmon_device_register_with_info reference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190509153235.103441-1-wangkefeng.wang@huawei.com>
References: <20190509153235.103441-1-wangkefeng.wang@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 09 May 2019 09:50:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Thu, 9 May 2019 23:32:35 +0800

> drivers/net/ethernet/aquantia/atlantic/aq_drvinfo.o: In function `aq_drvinfo_init':
> aq_drvinfo.c:(.text+0xe8): undefined reference to `devm_hwmon_device_register_with_info'
> 
> Fix it by using #if IS_REACHABLE(CONFIG_HWMON).
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Applied.

It's a shame there isn't a dummy inline of this helper defined when HWMON is unset.
