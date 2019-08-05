Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E0C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5302720880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfHER6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:58:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59952 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfHER6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:58:01 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1D8D7154086FA;
        Mon,  5 Aug 2019 10:58:01 -0700 (PDT)
Date:   Mon, 05 Aug 2019 10:58:00 -0700 (PDT)
Message-Id: <20190805.105800.1380680189003158228.davem@davemloft.net>
To:     mcroce@redhat.com
Cc:     netdev@vger.kernel.org, miquel.raynal@free-electrons.com,
        linux-kernel@vger.kernel.org, lorenzo@kernel.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH net] mvpp2: fix panic on module removal
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190731183116.4791-1-mcroce@redhat.com>
References: <20190731183116.4791-1-mcroce@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Aug 2019 10:58:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>
Date: Wed, 31 Jul 2019 20:31:16 +0200

> mvpp2 uses a delayed workqueue to gather traffic statistics.
> On module removal the workqueue can be destroyed before calling
> cancel_delayed_work_sync() on its works.
> Fix it by moving the destroy_workqueue() call after mvpp2_port_remove().

Please post a new version with the flush_workqueue() removed.
