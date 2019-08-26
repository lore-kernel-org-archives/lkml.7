Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54D9C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80D22070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zjnqd7uO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfHZJpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:45:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfHZJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tqKAB5NDADbp+Tgxt1UcAoDKY99sad5JCF67iqeryGs=; b=Zjnqd7uOrI1nTbBomz2wr3iuK
        Y5eTFydWJbaIBHlNazgKflEsR4LkmDuyywzTAQM/SBwh/bKzBKWZ1HVnG7tdjViEyqxd+WUR/sQDk
        rtHx2HM1SaKJZKwjU1/epydHQQKMUrEb5arcD2pO6VSXluNU+7yC6uwLDr6vwNelUu04KCRdSII5r
        8NhbBuaTCEOiPP9r888aLw7aUbRkfewR6yIE+seHnZghI5gK2ip7rhdO9U5J8/jNSCxP9XSZ0uHP7
        qJLDWXmdBYqhy56bId25vB4t7OGgyfbvivaLpSNwroXSM2GacSqimiLtwGIrJ0OSqMXIWVViX8jSA
        XUqIQUsXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2BZE-0006KX-OO; Mon, 26 Aug 2019 09:45:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5824130759B;
        Mon, 26 Aug 2019 11:45:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9FA92022F84E; Mon, 26 Aug 2019 11:45:38 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:45:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 4/5] x86/intel: Aggregate microserver naming
Message-ID: <20190826094538.GQ2369@hirez.programming.kicks-ass.net>
References: <20190822102306.109718810@infradead.org>
 <20190822102411.337145504@infradead.org>
 <20190826092750.GA56543@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826092750.GA56543@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 11:27:50AM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Currently big microservers have _XEON_D while small microservers have
> > _X, Make it uniformly: _D.
> > 
> > for i in `git grep -l "INTEL_FAM6_.*_\(X\|XEON_D\)"`
> > do
> > 	sed -i -e 's/\(INTEL_FAM6_ATOM_.*\)_X/\1_D/g' \
> >                -e 's/\(INTEL_FAM6_.*\)_XEON_D/\1_D/g' ${i}
> > done
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: x86@kernel.org
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/events/intel/core.c          |   20 ++++++++++----------
> >  arch/x86/events/intel/cstate.c        |   12 ++++++------
> >  arch/x86/events/intel/pt.c            |    2 +-
> >  arch/x86/events/intel/rapl.c          |    4 ++--
> >  arch/x86/events/intel/uncore.c        |    4 ++--
> >  arch/x86/events/msr.c                 |    6 +++---
> >  arch/x86/include/asm/intel-family.h   |   10 +++++-----
> >  arch/x86/kernel/apic/apic.c           |    2 +-
> >  arch/x86/kernel/cpu/intel.c           |    4 ++--
> >  arch/x86/kernel/cpu/mce/intel.c       |    2 +-
> >  arch/x86/kernel/tsc.c                 |    2 +-
> >  drivers/cpufreq/intel_pstate.c        |    6 +++---
> >  drivers/edac/i10nm_base.c             |    4 ++--
> >  drivers/edac/pnd2_edac.c              |    2 +-
> >  tools/power/x86/turbostat/turbostat.c |   22 +++++++++++-----------
> >  15 files changed, 51 insertions(+), 51 deletions(-)
> 
> I've added the additional renames below, accounting for recent changes in 
> cpu/common.c.

Thanks, I've respun these patches (they didn't actually build), and I'll
make sure to include that one when I repost.
