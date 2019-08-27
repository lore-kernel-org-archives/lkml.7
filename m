Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29178C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE90520828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfH0WDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:03:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51358 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfH0WDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:03:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B0EF915363D58;
        Tue, 27 Aug 2019 15:03:19 -0700 (PDT)
Date:   Tue, 27 Aug 2019 15:03:19 -0700 (PDT)
Message-Id: <20190827.150319.716294283021335199.davem@davemloft.net>
To:     olivier.tilmans@nokia-bell-labs.com
Cc:     eric.dumazet@gmail.com, stephen@networkplumber.org,
        olga@albisser.org, koen.de_schepper@nokia-bell-labs.com,
        research@bobbriscoe.net, henrist@henrist.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] sched: Add dualpi2 qdisc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190822080045.27609-1-olivier.tilmans@nokia-bell-labs.com>
References: <20190822080045.27609-1-olivier.tilmans@nokia-bell-labs.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 27 Aug 2019 15:03:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tilmans, Olivier (Nokia - BE/Antwerp)" <olivier.tilmans@nokia-bell-labs.com>
Date: Thu, 22 Aug 2019 08:10:48 +0000

> +static inline struct dualpi2_skb_cb *dualpi2_skb_cb(struct sk_buff *skb)

Please do not use the inline keyword in foo.c files, let the compiler decide.

> +static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
> +{
> +	struct dualpi2_sched_data *q = qdisc_priv(sch);
> +	struct sk_buff *skb;
> +	int qlen_c, credit_change;

Reverse christmas tree here, please.

> +static void dualpi2_timer(struct timer_list *timer)
> +{
> +	struct dualpi2_sched_data *q = from_timer(q, timer, pi2.timer);
> +	struct Qdisc *sch = q->sch;
> +	spinlock_t *root_lock; /* Lock to access the head of both queues. */

Likewise, and please remove this comment it makes the variable declarations
look odd.
