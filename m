Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3985DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1597921783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfJVGNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 02:13:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:43462 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfJVGNQ (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Tue, 22 Oct 2019 02:13:16 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iMnPl-0001JZ-Ha; Tue, 22 Oct 2019 14:13:05 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iMnPd-00024y-Qr; Tue, 22 Oct 2019 14:12:57 +0800
Date:   Tue, 22 Oct 2019 14:12:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Rix <trix@redhat.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm : lock input tasklet skb queue
Message-ID: <20191022061257.jft26bvvh24olihs@gondor.apana.org.au>
References: <CACVy4SVuw0Qbjiv6PLRn1symoxGzyBMZx2F5O23+jGZG6WHuYA@mail.gmail.com>
 <20191021083731.GK15862@gauss3.secunet.de>
 <CACVy4SV3K257XfFkR_ahkU2yy9mzJD-9LrSiQPCnespB3k_0XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVy4SV3K257XfFkR_ahkU2yy9mzJD-9LrSiQPCnespB3k_0XQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:31:13AM -0700, Tom Rix wrote:
> When preempt rt is full, softirq and interrupts run in kthreads. So it
> is possible for the tasklet to sleep and for its queue to get modified
> while it sleeps.

This is ridiculous.  The network stack is full of assumptions
like this.  So I think we need to fix preempt rt instead because
you can't make a major change like this without auditing the entire
kernel first rather than relying on a whack-a-mole approach.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
