Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC73C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F8321019
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfETTxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:53:44 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:20880
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbfETTxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:53:43 -0400
X-IronPort-AV: E=Sophos;i="5.60,492,1549926000"; 
   d="scan'208";a="306653735"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 21:53:41 +0200
Date:   Mon, 20 May 2019 21:53:40 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Sasha Levin <sashal@kernel.org>
cc:     Pavel Machek <pavel@ucw.cz>, wen.yang99@zte.com.cn,
        Markus.Elfring@web.de, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        nicolas.palix@imag.fr
Subject: Re: Coccinelle: semantic patch for missing of_node_put
In-Reply-To: <20190520172041.GH11972@sasha-vm>
Message-ID: <alpine.DEB.2.21.1905202151140.2561@hadrien>
References: <201905171432571474636@zte.com.cn> <alpine.DEB.2.20.1905170912590.4014@hadrien> <20190520093303.GA9320@atrey.karlin.mff.cuni.cz> <alpine.DEB.2.21.1905201152040.2543@hadrien> <20190520172041.GH11972@sasha-vm>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 May 2019, Sasha Levin wrote:

> On Mon, May 20, 2019 at 11:52:37AM +0200, Julia Lawall wrote:
> >
> >
> > On Mon, 20 May 2019, Pavel Machek wrote:
> >
> > > Hi!
> > >
> > > > A semantic patch has no access to comments.  The only thing I can see to
> > > > do is to use python to interact with some external tools.  For example,
> > > > you could write some code to collect the comments in a file and the
> > > lines
> > > > on which they occur, and then get the comment that most closely precedes
> > > > the start of the function.
> > >
> > > How dangerous is missing of_node_put? AFAICT it will only result into
> > > very small, one-time memory leak, right?
> > >
> > > Could we make sure these patches are _not_ going to stable? Leaking
> > > few bytes once per boot is not really a serious bug.
> >
> > Sasha,
> >
> > Probably patches that add only of_node_put should not be auto selected for
> > stable.
>
> I can filter them out, but those are fixes, right? Why are we concerned
> about them making it into -stable?

One of them may have introduced a crash.  If there is a bad reference
count manipulation elsewhere, then fixing one could cause a later
incorrect one to make a double free.

On the other hand, I don't know if the one that seemed to cause a crash
really caused a crash.  It was detected by syzkaller, and it is also
possible that git bisect ended up at the wrong place.

In any case, forgetting an of_node_put will normally just waste a little
memory, so probably stable kernels don't care.

julia
