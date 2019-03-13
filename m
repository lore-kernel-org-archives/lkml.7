Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AE7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E92C206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfCMVD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:03:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38386 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfCMVD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:03:26 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 79D6414D3C77E;
        Wed, 13 Mar 2019 14:03:25 -0700 (PDT)
Date:   Wed, 13 Mar 2019 14:03:24 -0700 (PDT)
Message-Id: <20190313.140324.1217171685315730689.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     joe@perches.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] appletalk: Fix potential NULL pointer dereference in
 unregister_snap_client
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190312020426.4824-1-yuehaibing@huawei.com>
References: <20190312020426.4824-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 Mar 2019 14:03:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Tue, 12 Mar 2019 10:04:26 +0800

>  	timer_setup(&aarp_timer, aarp_expire_timeout, 0);
>  	aarp_timer.expires  = jiffies + sysctl_aarp_expiry_time;
>  	add_timer(&aarp_timer);
> -	register_netdevice_notifier(&aarp_notifier);
> +	rc = register_netdevice_notifier(&aarp_notifier);
> +	if (rc)
> +		unregister_snap_client(aarp_dl);
> +	return rc;

You've left the timer running in this error path.
