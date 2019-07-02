Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E22C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DD4205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfGBCDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:03:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53814 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfGBCDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:03:11 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C0FC314DE9791;
        Mon,  1 Jul 2019 19:03:10 -0700 (PDT)
Date:   Mon, 01 Jul 2019 19:03:10 -0700 (PDT)
Message-Id: <20190701.190310.2238828290259478075.davem@davemloft.net>
To:     linyunsheng@huawei.com
Cc:     hkallweit1@gmail.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Subject: Re: [PATCH v3 net-next] net: link_watch: prevent starvation when
 processing linkwatch wq
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1561684399-235123-1-git-send-email-linyunsheng@huawei.com>
References: <1561684399-235123-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Jul 2019 19:03:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Fri, 28 Jun 2019 09:13:19 +0800

> When user has configured a large number of virtual netdev, such
> as 4K vlans, the carrier on/off operation of the real netdev
> will also cause it's virtual netdev's link state to be processed
> in linkwatch. Currently, the processing is done in a work queue,
> which may cause rtnl locking starvation problem and worker
> starvation problem for other work queue, such as irqfd_inject wq.
> 
> This patch releases the cpu when link watch worker has processed
> a fixed number of netdev' link watch event, and schedule the
> work queue again when there is still link watch event remaining.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> V2: use cond_resched and rtnl_unlock after processing a fixed
>     number of events
> V3: fall back to v1 and change commit log to reflect that.

Applied, thanks.
