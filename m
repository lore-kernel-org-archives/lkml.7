Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC536C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983D920856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NR6iySCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfDAQEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:04:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfDAQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q45Jyl+bl7Seyz0zfQ1rrPMBi4uodQ7pEG9gOxMjQQ0=; b=NR6iySCwRpRicAnBoOEmguhyz
        S/70auSwVcCWZbFg1pTxftm+VOY8I7sMK5E0eWtiL9Va+HS3uqHLOO+px+a2tad2VUnYd/IZdrYg4
        gNdYm1HHxDcmXG9DHnGnovuYvWLo0LxVGLANov8nCqfw65mbXrygJcVFbMuEbKBAoBgA3YjE8NVeA
        3yce+lVg+MTCA0RUiOtRziEfJY8+dXoGtJx9tg4cCma9FLaLV6daOWg7iY2ie9bOG1giOUeu3YrdA
        wxLKJ5Ph2BFe5aXOBgP4csbDSpl5rHAyDfXBk2YEFZucDbwlESuWJc+0RvuEIuF0y+wy1v6cOzhKk
        BjUghdSYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAzPr-0007rz-Nu; Mon, 01 Apr 2019 16:04:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E33D2026BE97; Mon,  1 Apr 2019 18:04:06 +0200 (CEST)
Date:   Mon, 1 Apr 2019 18:04:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: Potentially missing "memory" clobbers in bitops.h for x86
Message-ID: <20190401160406.GE12232@hirez.programming.kicks-ass.net>
References: <CAG_fn=X9tpSW6jvJd_COk_RU8zvcr-cxSWuJ05qcV0LotTxEEQ@mail.gmail.com>
 <20190328162222.GO4102@linux.ibm.com>
 <CAG_fn=WKA_4Vzsh6yH+=5TFv-EMrX87pr+2c_ANoH_MOVpbe1w@mail.gmail.com>
 <8e32ab34-c14c-1ccb-76f9-0dcd729a0ef6@zytor.com>
 <20190329210918.GZ4102@linux.ibm.com>
 <8092b8aa-bb1c-0266-b308-5cebfb25e2ef@zytor.com>
 <20190329220554.GD4102@linux.ibm.com>
 <20190401105348.GL11158@hirez.programming.kicks-ass.net>
 <20190401154414.GM4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401154414.GM4102@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 08:44:14AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 01, 2019 at 12:53:48PM +0200, Peter Zijlstra wrote:
> > On Fri, Mar 29, 2019 at 03:05:54PM -0700, Paul E. McKenney wrote:

> > > From Documentation/core-api/atomic_ops.rst:
> > 
> > We should delete that file.
> 
> Only if all of its content is fully present elsewhere.  ;-)

Documentation/atomic_t.txt and Documentation/atomic_bitops.txt _should_
cover all of it I _think_. If there's anything mising, please tell and
we'll write more documents.

And I suppose we should ammend atomic_bitops.txt with a reference to
include/asm-generic/bitops/atomic.h which fully implements the atomic
bitops using atomic_t.
