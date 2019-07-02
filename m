Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D28C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A4821721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d5pCPnku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfGBLwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:52:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46576 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfGBLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KivUfw0UpPHi/jywdtXkWv/9JWzg9WItCIYSF+g/vcU=; b=d5pCPnkuIr/MGiRsHIvC3m9B/
        j0ikko+1BOJ4P/wXRn+oWRa1g8Ul3p1/TMy6hMPhJYWBuspL0py481eJWlc90ms4K2xYusOJs1gSB
        EYmTmqXwziaInnj18tcpZrn1vE+j7XoSBNrp1EVs/MFKTTRYT2GGhJ+57bVqJGDINSgzJE0zSpUFT
        rqfa7Ffw4oGzQXVM8hUAg5ZrKGbLN/ls79opT3+N8XL4n2oVOeR/AOWSlcTKA6HMLl5wCwVJ5wdAf
        XxoWFnHsjO6KRRJyhwfmvwtl3FU1LvixguVFwdM2Lbk4lscgIH99YwcHRXBNawuSlitHpUmpf009N
        9ez/2yNvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiHKn-0006aC-2u; Tue, 02 Jul 2019 11:52:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4F1820ADAEA0; Tue,  2 Jul 2019 13:52:25 +0200 (CEST)
Date:   Tue, 2 Jul 2019 13:52:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] augmented rbtree: rework the RB_DECLARE_CALLBACKS
 macro definition
Message-ID: <20190702115225.GB3419@hirez.programming.kicks-ass.net>
References: <20190702075819.34787-1-walken@google.com>
 <20190702075819.34787-4-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702075819.34787-4-walken@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 12:58:19AM -0700, Michel Lespinasse wrote:
> - Change the definition of the RBCOMPUTE function. The propagate
>   callback repeatedly calls RBCOMPUTE as it moves from leaf to root.
>   it wants to stop recomputing once the augmented subtree information
>   doesn't change. This was previously checked using the == operator,
>   but that only works when the augmented subtree information is a
>   scalar field. This commit modifies the RBCOMPUTE function so that
>   it now sets the augmented subtree information instead of returning it,
>   and returns a boolean value indicating if the propagate callback
>   should stop.

I suppose that makes sense and saves a copy over adding RBEQUAL() like I
proposed earlier.

> - Reorder the RB_DECLARE_CALLBACKS macro arguments, following the
>   style of the INTERVAL_TREE_DEFINE macro, so that RBSTATIC and RBNAME
>   are passed last.

That's, IMO, a weird change. C has storage type and name first, why
would you want to put that last. If anything, change
INTERVAL_TREE_DEFINE().

Also; this is two changes and one patch; ISTR we have rules about those
things :-)

> The motivation for this change is that I want to introduce augmented rbtree
> uses where the augmented data for the subtree is a struct instead of a scalar.

I'm not seeing how this justifies the second thing.
