Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3681D2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfC2ASm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:18:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59328 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfC2ASm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:18:42 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5789614D68888;
        Thu, 28 Mar 2019 17:18:41 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:18:40 -0700 (PDT)
Message-Id: <20190328.171840.536122682640768471.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: rds: force to destroy connection if t_sock is
 NULL in rds_tcp_kill_sock().
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190328091056.186547-1-maowenan@huawei.com>
References: <20190328091056.186547-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Mar 2019 17:18:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Thu, 28 Mar 2019 17:10:56 +0800

> When it is to cleanup net namespace, rds_tcp_exit_net() will call
> rds_tcp_kill_sock(), if t_sock is NULL, it will not call
> rds_conn_destroy(), rds_conn_path_destroy() and rds_tcp_conn_free() to free
> connection, and the worker cp_conn_w is not stopped, afterwards the net is freed in
> net_drop_ns(); While cp_conn_w rds_connect_worker() will call rds_tcp_conn_path_connect()
> and reference 'net' which has already been freed.
> 
> In rds_tcp_conn_path_connect(), rds_tcp_set_callbacks() will set t_sock = sock before
> sock->ops->connect, but if connect() is failed, it will call
> rds_tcp_restore_callbacks() and set t_sock = NULL, if connect is always
> failed, rds_connect_worker() will try to reconnect all the time, so
> rds_tcp_kill_sock() will never to cancel worker cp_conn_w and free the
> connections.
> 
> Therefore, the condition !tc->t_sock is not needed if it is going to do
> cleanup_net->rds_tcp_exit_net->rds_tcp_kill_sock, because tc->t_sock is always
> NULL, and there is on other path to cancel cp_conn_w and free
> connection. So this patch is to fix this.
> 
> rds_tcp_kill_sock():
> ...
> if (net != c_net || !tc->t_sock)
> ...
> ==================================================================
> BUG: KASAN: use-after-free in inet_create+0xbcc/0xd28
 ...
> ==================================================================
> 
> Fixes: 467fa15356ac("RDS-TCP: Support multiple RDS-TCP listen endpoints, one per netns.")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Applied and queued up for -stable.
