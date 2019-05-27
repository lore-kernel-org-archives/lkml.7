Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A739CC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D65C2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S7Wnzx40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfE0QKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:10:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0QKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Uld6H3JrVxmYsW0FvI1LakKbPkrV6F+CRzlFk+Ay678=; b=S7Wnzx40jWRzxuYdrX3ExHijr
        ttcQPC2/xOa4bly15NVNRQTksQvE8x/xLlevoxPzq9hv/P4tzZPXUQukgzCtSSYEByXAHUSKLcLSt
        5bh37KkTxiFdYxek8o9Y0hyR/QM727OsS2xi3HbCeu9IC7xjIQAa59+SudhuSVvM2sczk1XpTxKjy
        9g15OSHiwCavUrw5Q6N2Hbuu6UZYccQM+Vv/PXtdHUxE4PHH1jbiEKKLfJAe8CGvBKn3h/cYS5XNS
        g/jL8JQ+/qpNybTVMD4eFZuO3bdLd0IRZcmCEbZpDOK2GK3F+GkcAVOGXP2VY/pMB3ezlMD+ODbdU
        r4LFMSivg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVICt-0006oi-98; Mon, 27 May 2019 16:10:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D482202BF3E0; Mon, 27 May 2019 18:10:37 +0200 (CEST)
Date:   Mon, 27 May 2019 18:10:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Imre Deak <imre.deak@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 2/2] lockdep: Fix merging of hlocks with non-zero
 references
Message-ID: <20190527161037.GG2623@hirez.programming.kicks-ass.net>
References: <20190524201509.9199-1-imre.deak@intel.com>
 <20190524201509.9199-2-imre.deak@intel.com>
 <20190527151438.GF2623@hirez.programming.kicks-ass.net>
 <20190527154429.GC24536@ideak-desk.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527154429.GC24536@ideak-desk.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 06:44:29PM +0300, Imre Deak wrote:
> On Mon, May 27, 2019 at 05:14:38PM +0200, Peter Zijlstra wrote:
> > On Fri, May 24, 2019 at 11:15:09PM +0300, Imre Deak wrote:

> > > -				if (DEBUG_LOCKS_WARN_ON(hlock->references == UINT_MAX))
> > 
> > What tree is this against?
> 
> I just used our
> 	git://anongit.freedesktop.org/drm-tip
> and the most recent upstream commit in that is:
> 

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/lockdep.h#n270
