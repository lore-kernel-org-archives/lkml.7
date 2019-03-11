Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50CEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABC72148D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfCKXTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:19:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43126 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfCKXTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:19:11 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7986D14C73B12;
        Mon, 11 Mar 2019 16:19:10 -0700 (PDT)
Date:   Mon, 11 Mar 2019 16:19:10 -0700 (PDT)
Message-Id: <20190311.161910.28459399773636110.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, colin.king@canonical.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fjes: fix potential NULL pointer dereferences
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190311071022.27610-1-kjlu@umn.edu>
References: <20190311071022.27610-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Mar 2019 16:19:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Mon, 11 Mar 2019 02:10:21 -0500

>  	adapter->control_wq = alloc_workqueue(DRV_NAME "/control",
>  					      WQ_MEM_RECLAIM, 0);
> +	if (!adapter->control_wq) {
> +		err = -ENOMEM;
> +		goto err_free_netdev;
> +	}

This error path leaks adapter->txrx_wq.

