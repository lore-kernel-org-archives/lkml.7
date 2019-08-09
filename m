Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9C2C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B482166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405447AbfHIFRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 01:17:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56042 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfHIFRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 01:17:09 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 951B31428D99E;
        Thu,  8 Aug 2019 22:17:08 -0700 (PDT)
Date:   Thu, 08 Aug 2019 22:17:08 -0700 (PDT)
Message-Id: <20190808.221708.1683611820360022260.davem@davemloft.net>
To:     huangfq.daxian@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tundra: tsi108: use spin_lock_irqsave instead of
 spin_lock_irq in IRQ context
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190807074300.23135-1-huangfq.daxian@gmail.com>
References: <20190807074300.23135-1-huangfq.daxian@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Aug 2019 22:17:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuqian Huang <huangfq.daxian@gmail.com>
Date: Wed,  7 Aug 2019 15:43:00 +0800

> @@ -372,8 +372,9 @@ static void tsi108_stat_carry(struct net_device *dev)
>  {
>  	struct tsi108_prv_data *data = netdev_priv(dev);
>  	u32 carry1, carry2;
> +	unsigned long flags;

Please preserve reverse christmas tree ordering of local variables.

Thank you.
