Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D7FC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F9E2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfGLWeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 18:34:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34314 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfGLWet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:34:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0F25B14E03845;
        Fri, 12 Jul 2019 15:34:49 -0700 (PDT)
Date:   Fri, 12 Jul 2019 15:34:48 -0700 (PDT)
Message-Id: <20190712.153448.2014775769142835466.davem@davemloft.net>
To:     chris.packham@alliedtelesis.co.nz
Cc:     jon.maloy@ericsson.com, eric.dumazet@gmail.com,
        ying.xue@windriver.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH v2] tipc: ensure head->lock is initialised
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190711224115.21499-1-chris.packham@alliedtelesis.co.nz>
References: <20190711224115.21499-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 12 Jul 2019 15:34:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Fri, 12 Jul 2019 10:41:15 +1200

> tipc_named_node_up() creates a skb list. It passes the list to
> tipc_node_xmit() which has some code paths that can call
> skb_queue_purge() which relies on the list->lock being initialised.
> 
> The spin_lock is only needed if the messages end up on the receive path
> but when the list is created in tipc_named_node_up() we don't
> necessarily know if it is going to end up there.
> 
> Once all the skb list users are updated in tipc it will then be possible
> to update them to use the unlocked variants of the skb list functions
> and initialise the lock when we know the message will follow the receive
> path.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.
