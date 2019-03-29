Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6A3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07502184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfC2Rkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:40:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53430 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfC2Rka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:40:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BAEDA14EF8022;
        Fri, 29 Mar 2019 10:40:29 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:40:26 -0700 (PDT)
Message-Id: <20190329.104026.2135814725468775566.davem@davemloft.net>
To:     lifonghsu@synology.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: net: fix routing encapsulated packets when binding a socket to
 a tunnel interface
From:   David Miller <davem@davemloft.net>
In-Reply-To: <6143cbeaab4f37bc2314caa3690063d4@synology.com>
References: <1553236198-5955-1-git-send-email-lifonghsu@synology.com>
        <20190327.134454.1623767882107215644.davem@davemloft.net>
        <6143cbeaab4f37bc2314caa3690063d4@synology.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 29 Mar 2019 10:40:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lifonghsu <lifonghsu@synology.com>
Date: Thu, 28 Mar 2019 16:30:37 +0800

> Indeed, skb_iif is used as receive site indication to present "device
> the packet arrived on".
> This commit keeps the previous arrived device (similar to the concept
> of "device the packet arrived on") in skb_iif field to prevent kernel
> from referring sk_bound_dev_if again. Otherwise, we might need to add
> a new field to sk_buff structure for our purpose.

Therefore, you are deciding to arbitrarily repurpose an RX side piece
of state for TX purposes.

Do not do this.

It confuses anyone trying to understand how skb_iif works.

You must use something with a different name, and clear semantics, to
achieve this goal.

For example, you could use an anonymous union:

	union {
		int	skb_iif;
		bool	bound_dev_already_applied;
	};

You never actually _USE_ the value of skb_iif, it is just merely a
boolean indicating whether sk_bound_dev_if was applied already.
