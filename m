Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E5FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613C021019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440248AbfFLQZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:25:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37692 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437944AbfFLQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:25:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BCC581513DD13;
        Wed, 12 Jun 2019 09:25:14 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:25:07 -0700 (PDT)
Message-Id: <20190612.092507.915453305221203158.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        edumazet@google.com
Subject: Re: [PATCH net v2] tcp: avoid creating multiple req socks with the
 same tuples
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190612035715.166676-1-maowenan@huawei.com>
References: <20190612035715.166676-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Jun 2019 09:25:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Wed, 12 Jun 2019 11:57:15 +0800

> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index c4503073248b..b6a1b5334565 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -477,6 +477,7 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk)
>  	struct inet_ehash_bucket *head;
>  	spinlock_t *lock;
>  	bool ret = true;
> +	struct sock *reqsk = NULL;

Please preserve the reverse christmas tree local variable ordering here.

Thank you.
