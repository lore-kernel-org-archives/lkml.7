Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FF2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD73F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfCKSXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:23:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40112 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfCKSXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:23:34 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 37689144CAF82;
        Mon, 11 Mar 2019 11:23:33 -0700 (PDT)
Date:   Mon, 11 Mar 2019 11:23:32 -0700 (PDT)
Message-Id: <20190311.112332.2212718467104899802.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     deepa.kernel@gmail.com, willemb@google.com,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, labbott@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190311153857.563743-1-arnd@arndb.de>
References: <20190311153857.563743-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Mar 2019 11:23:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Mar 2019 16:38:17 +0100

> Referencing the __kernel_long_t type caused some user space applications
> to stop compiling when they had not already included linux/posix_types.h,
> e.g.
> 
> s/multicast.c -o ext/sockets/multicast.lo
> In file included from /builddir/build/BUILD/php-7.3.3/main/php.h:468,
>                  from /builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c:27:
> /builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c: In function 'zm_startup_sockets':
> /builddir/build/BUILD/php-7.3.3/ext/sockets/sockets.c:776:40: error: '__kernel_long_t' undeclared (first use in this function)
>   776 |  REGISTER_LONG_CONSTANT("SO_SNDTIMEO", SO_SNDTIMEO, CONST_CS | CONST_PERSISTENT);
> 
> It is safe to include that header here, since it only contains kernel
> internal types that do not conflict with other user space types.
> 
> It's still possible that some related build failures remain, but those
> are likely to be for code that is not already y2038 safe.
> 
> Reported-by: Laura Abbott <labbott@redhat.com>
> Fixes: a9beb86ae6e5 ("sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
