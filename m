Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F818C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595E321E6B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbfGWBbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:31:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52638 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfGWBbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:31:08 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EF0E115305EB4;
        Mon, 22 Jul 2019 18:31:07 -0700 (PDT)
Date:   Mon, 22 Jul 2019 18:31:07 -0700 (PDT)
Message-Id: <20190722.183107.298639131733640783.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     dhowells@redhat.com, keescook@chromium.org,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH net-next] rxrpc: shut up -Wframe-larger-than= warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190722145828.1156135-1-arnd@arndb.de>
References: <20190722145828.1156135-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Jul 2019 18:31:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 Jul 2019 16:58:12 +0200

> rxkad sometimes triggers a warning about oversized stack frames
> when building with clang for a 32-bit architecture:
> 
> net/rxrpc/rxkad.c:243:12: error: stack frame size of 1088 bytes in function 'rxkad_secure_packet' [-Werror,-Wframe-larger-than=]
> net/rxrpc/rxkad.c:501:12: error: stack frame size of 1088 bytes in function 'rxkad_verify_packet' [-Werror,-Wframe-larger-than=]
> 
> The problem is the combination of SYNC_SKCIPHER_REQUEST_ON_STACK()
> in rxkad_verify_packet()/rxkad_secure_packet() with the relatively
> large scatterlist in rxkad_verify_packet_1()/rxkad_secure_packet_encrypt().
> 
> The warning does not show up when using gcc, which does not inline
> the functions as aggressively, but the problem is still the same.
> 
> Marking the inner functions as 'noinline_for_stack' makes clang
> behave the same way as gcc and avoids the warning.
> This may not be ideal as it leaves the underlying problem
> unchanged. If we want to actually reduce the stack usage here,
> the skcipher_request and scatterlist objects need to be moved
> off the stack.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

David H., I assume you will take this into your tree.
