Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7851C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878212189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfGXWq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:46:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53094 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbfGXWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:46:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5FBC11543C8CD;
        Wed, 24 Jul 2019 15:46:26 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:46:25 -0700 (PDT)
Message-Id: <20190724.154625.790572941356692025.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        Yuval.Mintz@qlogic.com, manishc@marvell.com,
        michal.kalderon@marvell.com, skalluru@marvell.com,
        denis.bolotin@cavium.com, rverma@marvell.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH net-next] qed: reduce maximum stack frame size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190722150133.1157096-1-arnd@arndb.de>
References: <20190722150133.1157096-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jul 2019 15:46:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 Jul 2019 17:01:23 +0200

> clang warns about an overly large stack frame in one function
> when it decides to inline all __qed_get_vport_*() functions into
> __qed_get_vport_stats():
> 
> drivers/net/ethernet/qlogic/qed/qed_l2.c:1889:13: error: stack frame size of 1128 bytes in function '_qed_get_vport_stats' [-Werror,-Wframe-larger-than=]
> 
> Use a noinline_for_stack annotation to prevent clang from inlining
> these, which keeps the maximum stack usage at around half of that
> in the worst case, similar to what we get with gcc.
> 
> Fixes: 86622ee75312 ("qed: Move statistics to L2 code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to net-next.
