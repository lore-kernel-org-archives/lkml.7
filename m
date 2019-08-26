Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D880C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 02:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CD920815
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 02:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfHZCsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 22:48:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57936 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHZCsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 22:48:14 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A82AB14DDDEC1;
        Sun, 25 Aug 2019 19:48:13 -0700 (PDT)
Date:   Sun, 25 Aug 2019 19:48:11 -0700 (PDT)
Message-Id: <20190825.194811.1923451232916556610.davem@davemloft.net>
To:     loyou85@gmail.com
Cc:     edumazet@google.com, dsterba@suse.com, dbanerje@akamai.com,
        fw@strlen.de, davej@codemonkey.org.uk, tglx@linutronix.de,
        matwey@sai.msu.ru, sakari.ailus@linux.intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaojunzhao141@gmail.com
Subject: Re: [PATCH] net: fix skb use after free in netpoll_send_skb_on_dev
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1566577920-20956-1-git-send-email-loyou85@gmail.com>
References: <1566577920-20956-1-git-send-email-loyou85@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 25 Aug 2019 19:48:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Sun <loyou85@gmail.com>
Date: Sat, 24 Aug 2019 00:32:00 +0800

> After commit baeababb5b85d5c4e6c917efe2a1504179438d3b
> ("tun: return NET_XMIT_DROP for dropped packets"),
> when tun_net_xmit drop packets, it will free skb and return NET_XMIT_DROP,
> netpoll_send_skb_on_dev will run into two use after free cases:

I don't know what to do here.

Really, the intention of the design is that the only valid
->ndo_start_xmit() values are those with macro names fitting the
pattern NETDEV_TX_*, which means only NETDEV_TX_OK and NETDEV_TX_BUSY
are valid.

NET_XMIT_* values are for qdisc ->enqueue() methods.

Note, particularly, that when ->ndo_start_xmit() values are propagated
through ->enqueue() calls they get masked out with NET_XMIT_MASK.

However, I see that most of the code doing enqueueing and invocation
of ->ndo_start_xmit() use the dev_xmit_complete() helper to check this
condition.

So probably that is what netpoll should be using as well.

