Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A055DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796C7206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbfCZRuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:50:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47442 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731571AbfCZRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:50:51 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C529E14C3C982;
        Tue, 26 Mar 2019 10:50:50 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:50:50 -0700 (PDT)
Message-Id: <20190326.105050.121748533477849393.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, colin.king@canonical.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: fjes: fix potential NULL pointer dereferences
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190323035223.23714-1-kjlu@umn.edu>
References: <20190311.161910.28459399773636110.davem@davemloft.net>
        <20190323035223.23714-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Mar 2019 10:50:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Fri, 22 Mar 2019 22:52:21 -0500

> @@ -1252,8 +1252,16 @@ static int fjes_probe(struct platform_device *plat_dev)
>  	adapter->open_guard = false;
>  
>  	adapter->txrx_wq = alloc_workqueue(DRV_NAME "/txrx", WQ_MEM_RECLAIM, 0);
> +	if (!adapter->txrx_wq) {
> +		err = -ENOMEM;
> +		goto err_free_netdev;
> +	}

These error paths have to undo the netif_napi_add() done by fjes_sw_init().
