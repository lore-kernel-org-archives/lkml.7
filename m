Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC75520883
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfCKTRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:17:14 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40550 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfCKTRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:17:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E48F14631D8D;
        Mon, 11 Mar 2019 12:17:11 -0700 (PDT)
Date:   Mon, 11 Mar 2019 12:17:10 -0700 (PDT)
Message-Id: <20190311.121710.968693621648443243.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, dchickles@marvell.com, sburla@marvell.com,
        fmanlunas@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: liquidio: fix NULL pointer dereferences
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190311054615.11760-1-kjlu@umn.edu>
References: <20190311054615.11760-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Mar 2019 12:17:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Mon, 11 Mar 2019 00:46:15 -0500

> @@ -1960,6 +1966,12 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
>  		sc = (struct octeon_soft_command *)
>  			octeon_alloc_soft_command(octeon_dev, data_size,
>  						  resp_size, 0);
> +		if (!sc) {
> +			dev_err(&octeon_dev->pci_dev->dev,
> +				"Failed to allocate octeon_soft_command\n");
> +			return -ENOMEM;
> +		}

Again, very sloppy.  You have to branch to setup_nic_dev_free in this situation
otherwise you leak devices allocated and setup from previous iterations of the
loop this code is in.

