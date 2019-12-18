Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E40C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160AA218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f2IvZqZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfLRTKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:10:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRTKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=712IVLKSNni0jTo1/5v0Y+uyGFY5uc8OLjbiwsLBT0E=; b=f2IvZqZNVOEj1pJX6pSnGK2jO
        0MFF18HSbsqJPEm1OAacBljBFhoIldtBTrPGnhEX8ErlbhTVUS+SiUhS3YOJE21PjRuzjk0dVtrvw
        DjFP8AWS9j8fOiRr68S8TlQpHHfMdUM+l9Sr5EVilz0i9EHx1M63mdRYxbOFA1DMnGbm/ylVvk71b
        Sl3LmUNjIapDhCPWFCJYZLlTg63CuhJmInT9ACvC4TTMlcIeTgmTNTm6WDh3QghPHFsM6Sde+aSyu
        zFp/kqF4EgplWaN4BXIje0q93nZpXckZge3JSo2fHG/RmdXoy3aiqVmdKqZcNnfdv124BZ/HBMl0L
        sWWz73NwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihei1-00089U-HS; Wed, 18 Dec 2019 19:10:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0122A980E35; Wed, 18 Dec 2019 20:10:06 +0100 (CET)
Date:   Wed, 18 Dec 2019 20:10:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rxrpc: Unlock new call in rxrpc_new_incoming_call()
 rather than the caller
Message-ID: <20191218191006.GF11457@worktop.programming.kicks-ass.net>
References: <157669169065.21991.15207045893761573624.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157669169065.21991.15207045893761573624.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 05:54:50PM +0000, David Howells wrote:
> Move the unlock and the ping transmission for a new incoming call into
> rxrpc_new_incoming_call() rather than doing it in the caller.  This makes
> it clearer to see what's going on.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Will Deacon <will@kernel.org>
> cc: Davidlohr Bueso <dave@stgolabs.net>

Thanks, that looks much nicer!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
