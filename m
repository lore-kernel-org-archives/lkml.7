Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5069AC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2651720870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfHXVff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 17:35:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47882 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfHXVff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 17:35:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 23F5115253B18;
        Sat, 24 Aug 2019 14:35:34 -0700 (PDT)
Date:   Sat, 24 Aug 2019 14:35:33 -0700 (PDT)
Message-Id: <20190824.143533.1547411490171696760.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix lack of conn cleanup when local
 endpoint is cleaned up
From:   David Miller <davem@davemloft.net>
In-Reply-To: <156647679816.11606.13713532963081370001.stgit@warthog.procyon.org.uk>
References: <156647679816.11606.13713532963081370001.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 24 Aug 2019 14:35:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 22 Aug 2019 13:26:38 +0100

> +	spin_lock(&rxnet->client_conn_cache_lock);
> +	nr_active = rxnet->nr_active_client_conns;
> +
> +	list_for_each_entry_safe(conn, tmp, &rxnet->idle_client_conns,
> +				 cache_link) {
> +		if (conn->params.local == local) {
> +			ASSERTCMP(conn->cache_state, ==, RXRPC_CONN_CLIENT_IDLE);
> +
> +			trace_rxrpc_client(conn, -1, rxrpc_client_discard);
> +			if (!test_and_clear_bit(RXRPC_CONN_EXPOSED, &conn->flags))
> +				BUG();
> +			conn->cache_state = RXRPC_CONN_CLIENT_INACTIVE;
> +			list_move(&conn->cache_link, &graveyard);
> +			nr_active--;
> +		}
> +	}
> +
> +	rxnet->nr_active_client_conns = nr_active;
> +	spin_unlock(&rxnet->client_conn_cache_lock);
> +	ASSERTCMP(nr_active, >=, 0);
> +
> +	spin_lock(&rxnet->client_conn_cache_lock);
> +	while (!list_empty(&graveyard)) {
> +		conn = list_entry(graveyard.next,
> +				  struct rxrpc_connection, cache_link);
> +		list_del_init(&conn->cache_link);
> +		spin_unlock(&rxnet->client_conn_cache_lock);
> +
> +		rxrpc_put_connection(conn);
> +
> +		spin_lock(&rxnet->client_conn_cache_lock);
> +	}
> +	spin_unlock(&rxnet->client_conn_cache_lock);
> +
> +	_leave(" [culled]");

Once you've removed the entries from the globally visible idle_client_comms
list, and put them on the local garbage list, they cannot be seen in any way
by external threads of control outside of this function.

Therefore, you don't need to take the client_conn_cache_lock at all in the
second while loop.
