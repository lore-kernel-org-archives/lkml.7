Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D586C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 23:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AED520873
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568589237;
	bh=Pv4ZoqOl04Js8kGfWzjqHlfBlZLxkRggaaEzQSoVQRc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=uFTcnOKipNvgBHynKM+l8LT/cRKV12/xEamtfg644uNwTTlfDJrxMKAdOyZJWpMAK
	 qyWaVBXN8rWAGZDqA0fV3lb5riCNbuj/DrUC7cAuPymgn7bi8hpUIglJ+UB14Pr2ND
	 dUE6JkKWJv5BCd9ipTt84OLyRLzI5eM+h6sBYoOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfIOXN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 19:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIOXNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 19:13:55 -0400
Received: from paulmck-ThinkPad-P72 (96-84-246-146-static.hfc.comcastbusiness.net [96.84.246.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6795F20692;
        Sun, 15 Sep 2019 23:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568589234;
        bh=Pv4ZoqOl04Js8kGfWzjqHlfBlZLxkRggaaEzQSoVQRc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YhP0D+bpxOaXtrQrZZHYgKJzEKZVmcJeDosmx5WMZ7sDY7tP9qRE3txRIBoyH1gVS
         v4vrn71s0VTDNw6Rd/HUVSGKXWwo+4hvDCZK3Kjej8OebLLhr5OZF/h4X/VVezgYzu
         Re7bpbb5xdldrgatMdwgjE0iiNuWByMiT07drdc0=
Date:   Sun, 15 Sep 2019 16:13:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Documentation for plain accesses and data races
Message-ID: <20190915231351.GS30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190912220126.GA14560@paulmck-ThinkPad-P72>
 <Pine.LNX.4.44L0.1909131509250.1466-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1909131509250.1466-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 03:13:26PM -0400, Alan Stern wrote:
> On Thu, 12 Sep 2019, Paul E. McKenney wrote:
> 
> > On Fri, Sep 06, 2019 at 02:11:29PM -0400, Alan Stern wrote:
> 
> > > To this end, the LKMM imposes three extra restrictions, together
> > > called the "plain-coherence" axiom because of their resemblance to the
> > > coherency rules:
> > > 
> > > 	If R and W conflict and it is possible to link R to W by one
> > > 	of the xb* sequences listed above, then W ->rfe R is not
> > > 	allowed (i.e., a load cannot read from a store that it
> > > 	executes before, even if one or both is plain).
> > > 
> > > 	If W and R conflict and it is possible to link W to R by one
> > > 	of the vis sequences listed above, then R ->fre W is not
> > > 	allowed (i.e., if a store is visible to a load then the load
> > > 	must read from that store or one coherence-after it).
> > > 
> > > 	If W and W' conflict and it is possible to link W to W' by one
> > > 	of the vis sequences listed above, then W' ->co W is not
> > > 	allowed (i.e., if one store is visible to another then it must
> > > 	come after in the coherence order).
> 
> > I will need to read this last section again.  Perhaps more than once.  ;-)
> 
> I decided this part could use some improvement.  Here is the updated
> text:
> 
> 
> To this end, the LKMM imposes three extra restrictions, together
> called the "plain-coherence" axiom because of their resemblance to the
> rules used by the operational model to ensure cache coherence (that
> is, the rules governing the memory subsystem's choice of a store to
> satisfy a load request and its determination of where a store will
> fall in the coherence order):
> 
> 	If R and W conflict and it is possible to link R to W by one
> 	of the xb* sequences listed above, then W ->rfe R is not
> 	allowed (i.e., a load cannot read from a store that it
> 	executes before, even if one or both is plain).
> 
> 	If W and R conflict and it is possible to link W to R by one
> 	of the vis sequences listed above, then R ->fre W is not
> 	allowed (i.e., if a store is visible to a load then the load
> 	must read from that store or one coherence-after it).
> 
> 	If W and W' conflict and it is possible to link W to W' by one
> 	of the vis sequences listed above, then W' ->co W is not
> 	allowed (i.e., if one store is visible to a second then the
> 	second must come after the first in the coherence order).

These look good to me!

							Thanx, Paul
