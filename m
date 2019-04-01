Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC062C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728222084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dOLHWvqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfDAHae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:30:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731844AbfDAHad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zlmRYHfrH8QLFcu62W2LRbXcqRcaCsgij+LfXxQree4=; b=dOLHWvqWXGsYKeS13csH9OXwr
        mgaIce+1RCJBLhsF7Qa0DM3GJcMiA3g7NUj34LbRIN21RwsjPDv4t2SjR0E1rbJ3881S20qQ3mX0Q
        0RccOCRMHpYVvTA1wKovU0vyZpukT29+cb5KDMdtkGQEFmVNfGJrUUMWdvhJwIxNpoMNZKcOgA6vE
        Ip2tX+ReWWur5U0JI27ItoBzbROQQHC8QN1YuiXjm13RL8EkoeS99isGE429IiOLS5xy0ymocAWzT
        wCIY/+zLp0qGCKnnj1pRtnfgkWYs4G4qhl2ZKb+KZ7ejeCiyWRZIsXi2AYWw7RqMEmtG40QvILd/w
        DPiBye6dQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hArOm-00072e-6T; Mon, 01 Apr 2019 07:30:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D99EE202BC431; Mon,  1 Apr 2019 09:30:24 +0200 (CEST)
Date:   Mon, 1 Apr 2019 09:30:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch 04/14] x86/exceptions: Make IST index zero based
Message-ID: <20190401073024.GB11158@hirez.programming.kicks-ass.net>
References: <20190331214020.836098943@linutronix.de>
 <20190331215135.133741719@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331215135.133741719@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 11:40:24PM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/include/asm/page_64_types.h
> +++ b/arch/x86/include/asm/page_64_types.h
> @@ -25,11 +25,14 @@
>  #define IRQ_STACK_ORDER (2 + KASAN_STACK_ORDER)
>  #define IRQ_STACK_SIZE (PAGE_SIZE << IRQ_STACK_ORDER)
>  
> -#define DOUBLEFAULT_STACK 1
> -#define NMI_STACK 2
> -#define DEBUG_STACK 3
> -#define MCE_STACK 4
> -#define N_EXCEPTION_STACKS 4  /* hw limit: 7 */
> +/*
> + * The index for the tss.ist[] array. The hardware limit is 7 entries.
> + */
> +#define	DOUBLEFAULT_IST		0
> +#define	NMI_IST			1
> +#define	DEBUG_IST		2
> +#define	MCE_IST			3
> +#define	N_EXCEPTION_STACKS	4

Would it make sense to use an enum here?
