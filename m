Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB11FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCFE206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JahhLfLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390676AbfEXKjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:39:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48176 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390106AbfEXKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BriCFiVsvXiSB70hYfidU8VqORTyQEhK40fA2bRZURg=; b=JahhLfLypSqyFz1nlMEJrreDo
        3zwU9SAKwXFypEKOnmLTpx577riUPdcFXcLfxiXSji7/3qJkglkHQJ9S/ajcXtjPpEN34Y9am+jEy
        wGqCfu5wOl/CHLFzZmYtYQddiVqSw1FVLwpYpRdu9kZamS1j4c8qdy6T1yGj9MKPhlwk8JSN3MHP2
        aI43izaMyVjyjrPILaDT6yePtOw84wXW/A0V0bhfTwG8UusvU40KLO7Yr0vqmQZwyTW6fpIjaEhgo
        V8zPR/LibQJOzv3xCOXfI7kpYcWhw41YcHDnXngkLInrFAq3s/B1ArSyxx8+M4jRgDXaqa1g5u5qQ
        mF/kjCrpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hU7bt-0007ui-JC; Fri, 24 May 2019 10:39:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87D2F2029B0A3; Fri, 24 May 2019 12:39:34 +0200 (CEST)
Date:   Fri, 24 May 2019 12:39:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 1/2] vmw_vmci: Clean up uses of atomic*_set()
Message-ID: <20190524103934.GO2606@hirez.programming.kicks-ass.net>
References: <1558694136-19226-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1558694136-19226-2-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558694136-19226-2-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:35:35PM +0200, Andrea Parri wrote:
> The primitive vmci_q_set_pointer() relies on atomic*_set() being of
> type 'void', but this is a non-portable implementation detail.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jorgen Hansen <jhansen@vmware.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> ---
>  include/linux/vmw_vmci_defs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
> index 0c06178e4985b..eb593868e2e9e 100644
> --- a/include/linux/vmw_vmci_defs.h
> +++ b/include/linux/vmw_vmci_defs.h
> @@ -759,9 +759,9 @@ static inline void vmci_q_set_pointer(atomic64_t *var,
>  				      u64 new_val)
>  {
>  #if defined(CONFIG_X86_32)
> -	return atomic_set((atomic_t *)var, (u32)new_val);
> +	atomic_set((atomic_t *)var, (u32)new_val);
>  #else
> -	return atomic64_set(var, new_val);
> +	atomic64_set(var, new_val);
>  #endif
>  }

All that should just die a horrible death. That code is crap.

See:

  lkml.kernel.org/r/20190524103731.GN2606@hirez.programming.kicks-ass.net
