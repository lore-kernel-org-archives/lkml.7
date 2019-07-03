Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C5EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC6721882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H84msxnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfGCHXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:23:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfGCHXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ypbH4/gcaNR6DaSyoAhBRclu4bzhJ/hRl1kqittSFa4=; b=H84msxnKTy6EG55p8uB0rfCtG
        xP7pV88sEDODHXPV7u+gnFaLZ97NCX2DLsJ9pJ0oGtI+yIzsRmgrENOYEpBvbu9JvX8i2gIyKzOoz
        yDQJA8fyS+wRitvpAdJ9G3Ku1pLcG8SSe0S5c6H3xqCAaGq0bUQw+/V9sXXcMP8haJSYf2LgQ1yLb
        caN1TZ+QlQpGoylctirXh2O7+/zYGW64WiYeihT+SV9llIwNr4lIWFIv7r+yQ1DuGNG3/iqOF+MQE
        sU3hsge3hpTkS5q9yXnipt1KaRlEEfnHsUKs8Ox5/r5B9nx7h6V45zDLSLCWT8AnWtNwtARObo2hW
        TdkE2lX8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiZbL-0002i3-70; Wed, 03 Jul 2019 07:22:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 006482013A3C4; Wed,  3 Jul 2019 09:22:44 +0200 (CEST)
Date:   Wed, 3 Jul 2019 09:22:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] make RB_DECLARE_CALLBACKS more generic
Message-ID: <20190703072244.GG3402@hirez.programming.kicks-ass.net>
References: <20190703040156.56953-1-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703040156.56953-1-walken@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 09:01:53PM -0700, Michel Lespinasse wrote:
> These changes are intended to make the RB_DECLARE_CALLBACKS macro
> more generic (allowing the aubmented subtree information to be a struct
> instead of a scalar).
> 
> Changes since v2: Left the RBSTATIC and RBNAME arguments first in the
> RB_DECLARE_CALLBACKS and RB_DECLARE_CALLBACKS_MAX macros as suggested
> by Peter Zijlstra.
> 
> Changes since v1: I have added a new RB_DECLARE_CALLBACKS_MAX macro,
> which generates augmented rbtree callbacks where the subtree information
> can be expressed as max(f(node)). This covers all current uses, and thus
> makes it easy to do the later RB_DECLARE_CALLBACKS definition change
> as it's only currently used in RB_DECLARE_CALLBACKS_MAX.
> 
> I have also verified the compiled lib/interval_tree.o and mm/mmap.o
> files to check that they didn't change. This held as expected for
> interval_tree.o; mmap.o did have some changes which could be reverted
> by marking __vma_link_rb as noinline. I did not add such a change to the
> patchset; I felt it was reasonable enough to let the inlining decision
> up to the compiler.
> 
> Michel Lespinasse (3):
>   augmented rbtree: add comments for RB_DECLARE_CALLBACKS macro
>   augmented rbtree: add new RB_DECLARE_CALLBACKS_MAX macro
>   augmented rbtree: rework the RB_DECLARE_CALLBACKS macro definition

Thanks Michel, looking good now!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
