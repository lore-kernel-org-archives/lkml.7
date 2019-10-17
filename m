Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9638EFA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677822089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FHgaLqDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392815AbfJQH3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:29:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51506 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfJQH3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7wFvMRX5TjmoFzlFtCpVT79A1OWYMSfZ1xr6DoHurAY=; b=FHgaLqDuzNECct36pr4DbNDQP
        cR5oenemMl5KnQ+4YcOwPUe4ceiGkr751/GQYZx2vLWPUQmfHutK9OCWO3Di7eaS9gCX8PxBpHuTx
        oY84EGCL3F7c12O3AEZzU1+YbPf0Kn6ctG5TN4YbhiQFbMBalp0ITm3TH12v7a2YknLpXhhmsab3x
        tkp/3jiBq5vL+7kAHQvXRydh4LJMDWrxgPPesMHNPuPoXxY3K1Bq9xCu0P/VV4F4dxrSMlJlPP+3t
        jl7AotmrdXoclsnu2bvNhKXHmj8EzPo8vD2ThImHRTPMKL+I9ae89iWzuzrIThf0oXWRnyKRYRjen
        r4weYZWpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL0Dr-0003IB-Ia; Thu, 17 Oct 2019 07:29:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6FCC7304B4C;
        Thu, 17 Oct 2019 09:28:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2C1929E86617; Thu, 17 Oct 2019 09:29:20 +0200 (CEST)
Date:   Thu, 17 Oct 2019 09:29:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -tip v4 0/4] x86: kprobes: Prohibit kprobes on Xen/KVM
 emulate prefixes
Message-ID: <20191017072920.GU2328@hirez.programming.kicks-ass.net>
References: <156777561745.25081.1205321122446165328.stgit@devnote2>
 <20190917151403.60023814bda80304777a35e5@kernel.org>
 <20191009123106.GK2311@hirez.programming.kicks-ass.net>
 <20191017122655.6fae3c0e44417a0af30cd2d1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017122655.6fae3c0e44417a0af30cd2d1@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:26:55PM +0900, Masami Hiramatsu wrote:
> Hi Peter,
> 
> On Wed, 9 Oct 2019 14:31:06 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Sep 17, 2019 at 03:14:03PM +0900, Masami Hiramatsu wrote:
> > > Hi Peter,
> > > 
> > > Could you review this version?
> > 
> > These look good to me; shall I merge them or what was the plan?
> 
> Thanks for the review, yes, could you merge this series to support emulated prefixes correctly?

OK, I'll get them merged.
