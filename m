Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8836C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7297204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfG3Rcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:32:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52554 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731017AbfG3Rcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:32:48 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A7ACA126598EE;
        Tue, 30 Jul 2019 10:32:47 -0700 (PDT)
Date:   Tue, 30 Jul 2019 10:32:45 -0700 (PDT)
Message-Id: <20190730.103245.831770564486791326.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        arnd@arndb.de, keescook@chromium.org
Subject: Re: [PATCH net-next] rxrpc: Fix -Wframe-larger-than= warnings from
 on-stack crypto
From:   David Miller <davem@davemloft.net>
In-Reply-To: <156449861697.10315.4666924841804740487.stgit@warthog.procyon.org.uk>
References: <156449861697.10315.4666924841804740487.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Jul 2019 10:32:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Tue, 30 Jul 2019 15:56:57 +0100

> rxkad sometimes triggers a warning about oversized stack frames when
> building with clang for a 32-bit architecture:
> 
> net/rxrpc/rxkad.c:243:12: error: stack frame size of 1088 bytes in function 'rxkad_secure_packet' [-Werror,-Wframe-larger-than=]
> net/rxrpc/rxkad.c:501:12: error: stack frame size of 1088 bytes in function 'rxkad_verify_packet' [-Werror,-Wframe-larger-than=]
> 
> The problem is the combination of SYNC_SKCIPHER_REQUEST_ON_STACK() in
> rxkad_verify_packet()/rxkad_secure_packet() with the relatively large
> scatterlist in rxkad_verify_packet_1()/rxkad_secure_packet_encrypt().
> 
> The warning does not show up when using gcc, which does not inline the
> functions as aggressively, but the problem is still the same.
> 
> Allocate the cipher buffers from the slab instead, caching the allocated
> packet crypto request memory used for DATA packet crypto in the rxrpc_call
> struct.
> 
> Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> cc: Herbert Xu <herbert@gondor.apana.org.au>

Applied.
