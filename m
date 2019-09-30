Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433F3C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A392053B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbfI3VqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:46:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfI3VqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:46:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E4D9154361F3;
        Mon, 30 Sep 2019 11:11:08 -0700 (PDT)
Date:   Mon, 30 Sep 2019 11:11:07 -0700 (PDT)
Message-Id: <20190930.111107.199335405812556676.davem@davemloft.net>
To:     yanhaishuang@cmss.chinamobile.com
Cc:     u9012063@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erspan: remove the incorrect mtu limit for erspan
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1569567500-20113-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1569567500-20113-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Sep 2019 11:11:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Date: Fri, 27 Sep 2019 14:58:20 +0800

> erspan driver calls ether_setup(), after commit 61e84623ace3
> ("net: centralize net_device min/max MTU checking"), the range
> of mtu is [min_mtu, max_mtu], which is [68, 1500] by default.
> 
> It causes the dev mtu of the erspan device to not be greater
> than 1500, this limit value is not correct for ipgre tap device.
> 
> Tested:
> Before patch:
> # ip link set erspan0 mtu 1600
> Error: mtu greater than device maximum.
> After patch:
> # ip link set erspan0 mtu 1600
> # ip -d link show erspan0
> 21: erspan0@NONE: <BROADCAST,MULTICAST> mtu 1600 qdisc noop state DOWN
> mode DEFAULT group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 0
> 
> Fixes: 61e84623ace3 ("net: centralize net_device min/max MTU checking")
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Applied and queued up for -stable.
