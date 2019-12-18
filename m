Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0652C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB7721D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KKs0xRh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfLRTQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:16:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLRTQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HOc9f2rP1hnTczx9VP167UEkDBFIJUQPJwBvAEmplec=; b=KKs0xRh/g0/h+4hVPxkThIaxr
        jqNcOLxCbOackiNJj3mu3/1D0PKUiIJUh/D8aWGTJGBj6vDll906I1Ay4/gm2h2lh8sU2jV1HDJbc
        8c7iGfdpI6CqRJcmKCITX2YfnoKbtJTnpKQZWSpeXGA7NbzTy0DtyTMd83ondlC/46fNOjxxVY1Sa
        6a7kgBeKxnCiJ6t+kG1/dYIONgdJBiCPmpSfCwTdZ52v5FLcZZkzb0bTD2qkHYd2WIoF6LsJqPWVF
        G6M/RSxMeWlXtZ879x8lcRNaapwKaWsm3n30UCO/vpiUrMHMnAl1289yd/vZPmzTxR6alcgSOqdjU
        NCeEU3ZeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihenq-0004dy-6L; Wed, 18 Dec 2019 19:16:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 174F6980E35; Wed, 18 Dec 2019 20:16:08 +0100 (CET)
Date:   Wed, 18 Dec 2019 20:16:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rxrpc: Don't take call->user_mutex in
 rxrpc_new_incoming_call()
Message-ID: <20191218191608.GG11457@worktop.programming.kicks-ass.net>
References: <157669169065.21991.15207045893761573624.stgit@warthog.procyon.org.uk>
 <157669169826.21991.16708899415880562587.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157669169826.21991.16708899415880562587.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 05:54:58PM +0000, David Howells wrote:
> Standard kernel mutexes cannot be used in any way from interrupt or softirq
> context, so the user_mutex which manages access to a call cannot be a mutex
> since on a new call the mutex must start off locked and be unlocked within
> the softirq handler to prevent userspace interfering with a call we're
> setting up.
> 
> Commit a0855d24fc22d49cdc25664fb224caee16998683 ("locking/mutex: Complain
> upon mutex API misuse in IRQ contexts") causes big warnings to be splashed
> in dmesg for each a new call that comes in from the server.  Whilst it
> *seems* like it should be okay, since the accept path uses trylock, there
> are issues with PI boosting and marking the wrong task as the owner.
> 
> Fix this by not taking the mutex in the softirq path at all.  It's not
> obvious that there should be any need for it as the state is set before the
> first notification is generated for the new call.
> 
> There's also no particular reason why the link-assessing ping should be
> triggered inside the mutex.  It's not actually transmitted there anyway,
> but rather it has to be deferred to a workqueue.
> 
> Further, I don't think that there's any particular reason that the socket
> notification needs to be done from within rx->incoming_lock, so the amount
> of time that lock is held can be shortened too and the ping prepared before
> the new call notification is sent.
> 

Assuming this works, this is the best solution possible! Excellent work.

(I was about to suggest something based on wait_var_event() inside each
mutex_lock(), but this is _much_ nicer)

Thanks!
